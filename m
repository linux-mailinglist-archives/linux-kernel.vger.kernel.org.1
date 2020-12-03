Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075BF2CD84F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 14:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbgLCN5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 08:57:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgLCN5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 08:57:06 -0500
X-Gm-Message-State: AOAM5302kb/ljAGV1BW2mZVH+J1W7wunoF9+t/LH2IwgmIN8iEXrXzFD
        WGVYqjZgt/HBt1BFSe9vt6luYnQbHt2Pt5bJ4P4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607003785;
        bh=SzLHBJpAHuHrXn0+hQf5Nq+hpLvEsV2HnB2QFidHmT8=;
        h=From:Date:Subject:To:From;
        b=JtkIcsXMGat2sYH+Zx4WPMcPh/9vJupqujLi1dnzoQBEpnJcrlLXlCqLD+VnsgdAT
         3ydkD5+uHVkTg3RUpApfG6gev56wqxlcTNzxgX4BFyN4xLCveJrXdFziF9GRrd7KIA
         NLivaPtkRo1fgDztQESSyKSPGfXpAAFe0syhxNZKNsvH6SWVKkdPsJ/v200BlJrSQK
         zgNUdpSthpLXvX669pJZr0bca+tQRVLyqZVfgnjHNwszV+voGshW9tCS7jlt73kpvX
         r3PcRgYXDYJcqREK4nglhyH4EqVAnP4eyyqUKGfc0nFGQ+/SqjGGcdsLcIpdqktugr
         7Xcp41wB52ibg==
X-Google-Smtp-Source: ABdhPJzYjrn+qqLboUkw+x3nO6VYMin9jU5iPUEcPj8ZzwEueQ/dniJvQ/Ax93yEP/0edzTbbkrznBa1TNutWTdpRSE=
X-Received: by 2002:a9d:be1:: with SMTP id 88mr2155198oth.210.1607003784111;
 Thu, 03 Dec 2020 05:56:24 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 3 Dec 2020 14:56:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a20LXgEQkYSpbFFrJs1mdg19W72dp3pbebH9Pkpib2g-g@mail.gmail.com>
Message-ID: <CAK8P3a20LXgEQkYSpbFFrJs1mdg19W72dp3pbebH9Pkpib2g-g@mail.gmail.com>
Subject: objtool crashes with some clang produced .o files
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: multipart/mixed; boundary="000000000000b4881805b58fb9a2"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b4881805b58fb9a2
Content-Type: text/plain; charset="UTF-8"

I see occasional randconfig builds failing on x86 with clang-11
and clang-12 when objtool crashes with a segmentation fault.

The simplest test case I managed to create is

$ echo "__SCK__tp_func_cdev_update() { __SCT__tp_func_cdev_update(); }" > file.c
$ clang-12 -c file.c -O2 -fno-asynchronous-unwind-tables
$ ./tools/objtool/objtool orc generate  file.o
Segmentation fault (core dumped)
$ clang-12 -S file.c -O2 -fno-asynchronous-unwind-tables -o-
.text
.file "file.c"
.globl __SCK__tp_func_cdev_update      # -- Begin function
__SCK__tp_func_cdev_update
.p2align 4, 0x90
.type __SCK__tp_func_cdev_update,@function
__SCK__tp_func_cdev_update:             # @__SCK__tp_func_cdev_update
# %bb.0:
xorl %eax, %eax
jmp __SCT__tp_func_cdev_update      # TAILCALL
.Lfunc_end0:
.size __SCK__tp_func_cdev_update, .Lfunc_end0-__SCK__tp_func_cdev_update
                                        # -- End function
.ident "Ubuntu clang version
12.0.0-++20201129052612+ce134da4b18-1~exp1~20201129163253.238"
.section ".note.GNU-stack","",@progbits
.addrsig

The behavior seems to depend on the specific symbol names, and it only happens
for the integrated assembler, not the GNU assembler.

Attaching both .o files for reference.

        Arnd

--000000000000b4881805b58fb9a2
Content-Type: application/x-object; name="integrated-as.o"
Content-Disposition: attachment; filename="integrated-as.o"
Content-Transfer-Encoding: base64
Content-ID: <f_ki8wjdxl0>
X-Attachment-Id: f_ki8wjdxl0

f0VMRgIBAQAAAAAAAAAAAAEAPgABAAAAAAAAAAAAAAAAAAAAAAAAAJgBAAAAAAAAAAAAAEAAAAAA
AEAACAABADHA6QAAAAAAVWJ1bnR1IGNsYW5nIHZlcnNpb24gMTIuMC4wLSsrMjAyMDExMjkwNTI2
MTIrY2UxMzRkYTRiMTgtMX5leHAxfjIwMjAxMTI5MTYzMjUzLjIzOAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAGkAAAAEAPH/AAAAAAAAAAAAAAAAAAAAAE4AAAASAAIAAAAAAAAAAAAHAAAA
AAAAADMAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAMAAAAAAAAABAAAAAMAAAD8/////////wAucmVs
YS50ZXh0AC5jb21tZW50AC5ub3RlLkdOVS1zdGFjawAubGx2bV9hZGRyc2lnAF9fU0NUX190cF9m
dW5jX2NkZXZfdXBkYXRlAF9fU0NLX190cF9mdW5jX2NkZXZfdXBkYXRlAGZpbGUuYwAuc3RydGFi
AC5zeW10YWIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAHAAAAADAAAAAAAAAAAAAAAAAAAAAAAAABgBAAAAAAAAgAAAAAAAAAAA
AAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAGAAAAAQAAAAYAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAcA
AAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAQAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAEA
AAAAAAAYAAAAAAAAAAcAAAACAAAACAAAAAAAAAAYAAAAAAAAAAwAAAABAAAAMAAAAAAAAAAAAAAA
AAAAAEcAAAAAAAAAVAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAQAAAAAAAAAVAAAAAQAAAAAAAAAA
AAAAAAAAAAAAAACbAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAJQAAAANM
/28AAACAAAAAAAAAAAAAAAAAGAEAAAAAAAAAAAAAAAAAAAcAAAAAAAAAAQAAAAAAAAAAAAAAAAAA
AHgAAAACAAAAAAAAAAAAAAAAAAAAAAAAAKAAAAAAAAAAYAAAAAAAAAABAAAAAgAAAAgAAAAAAAAA
GAAAAAAAAAA=
--000000000000b4881805b58fb9a2
Content-Type: application/x-object; name="gnu-as.o"
Content-Disposition: attachment; filename="gnu-as.o"
Content-Transfer-Encoding: base64
Content-ID: <f_ki8wjdya1>
X-Attachment-Id: f_ki8wjdya1

f0VMRgIBAQAAAAAAAAAAAAEAPgABAAAAAAAAAAAAAAAAAAAAAAAAACACAAAAAAAAAAAAAEAAAAAA
AEAACgAJADHA6QAAAAAAVWJ1bnR1IGNsYW5nIHZlcnNpb24gMTIuMC4wLSsrMjAyMDExMjkwNTI2
MTIrY2UxMzRkYTRiMTgtMX5leHAxfjIwMjAxMTI5MTYzMjUzLjIzOAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAEAAAAEAPH/AAAAAAAAAAAAAAAAAAAAAAAAAAADAAEAAAAAAAAAAAAAAAAA
AAAAAAAAAAADAAMAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAD
AAYAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAUAAAAAAAAAAAAAAAAAAAAAAAgAAAASAAEAAAAAAAAA
AAAHAAAAAAAAACMAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAABmaWxlLmMAX19TQ0tfX3RwX2Z1bmNf
Y2Rldl91cGRhdGUAX19TQ1RfX3RwX2Z1bmNfY2Rldl91cGRhdGUAAAADAAAAAAAAAAQAAAAIAAAA
/P////////8ALnN5bXRhYgAuc3RydGFiAC5zaHN0cnRhYgAucmVsYS50ZXh0AC5kYXRhAC5ic3MA
LmNvbW1lbnQALm5vdGUuR05VLXN0YWNrAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAQAAAAYAAAAAAAAAAAAA
AAAAAABAAAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAGwAAAAQAAABAAAAA
AAAAAAAAAAAAAAAAuAEAAAAAAAAYAAAAAAAAAAcAAAABAAAACAAAAAAAAAAYAAAAAAAAACYAAAAB
AAAAAwAAAAAAAAAAAAAAAAAAAEcAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAA
AAAsAAAACAAAAAMAAAAAAAAAAAAAAAAAAABHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAA
AAAAAAAAAAAAMQAAAAEAAAAwAAAAAAAAAAAAAAAAAAAARwAAAAAAAABUAAAAAAAAAAAAAAAAAAAA
AQAAAAAAAAABAAAAAAAAADoAAAABAAAAAAAAAAAAAAAAAAAAAAAAAJsAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAEAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAAAAAAAAAAAAAAAAAAAAACgAAAAAAAAANgA
AAAAAAAACAAAAAcAAAAIAAAAAAAAABgAAAAAAAAACQAAAAMAAAAAAAAAAAAAAAAAAAAAAAAAeAEA
AAAAAAA+AAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAABEAAAADAAAAAAAAAAAAAAAAAAAA
AAAAANABAAAAAAAASgAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAA=
--000000000000b4881805b58fb9a2--
