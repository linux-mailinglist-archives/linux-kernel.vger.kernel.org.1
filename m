Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E56729980D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732575AbgJZUeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:34:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43880 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732551AbgJZUeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:34:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id d24so11788462ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 13:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ACP42UCPZC0vmZHAXGjbnSsMTmLOQ+k7BANgbzBdmHc=;
        b=JDFEz1Z+CsmWTeME3clWFGO+2+dJW7zjxmL+2uh6H7ZlR+OWpH9MIc1pezLVSRon7B
         55j1VaDTLlR2dn4klq6PgExMzdUQcYV4fNVnEc9K9fMooZT4kQAStIpTWH02GLqeI4Sj
         sJOVLzOeikIBBjAv+vQgoIlo0hUH30twNOQf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACP42UCPZC0vmZHAXGjbnSsMTmLOQ+k7BANgbzBdmHc=;
        b=NB6R8lPzelN7lzsMBUeyKKuXjEAVw5fi0wvJLtRt4ifZ4fVT7lVBUdJoPM8aZ+xq+Z
         Hbke1LdtwlVGBXXM6TbS3X85kk9hNc2cuhryq2NcIgw2tsUFMf3Y42R6vBpWQ7c7opNx
         FAsojB9JtHvm+Lz2nYsFXcbsrq4j8oFCm3x/Y1HvDDbZRRkxZ0f0FxR2bW2HrV+Clpzu
         u1hU7kRGEihuGFhiybWMfeS/DvVqWhRerfb5P8WwldGaI8drrNorle2ixa6ShLa0w/uu
         gs6JEq8C4jGJJzceKsr1uOU2g8oYzuPnLqjOMMP77NONcSpEcapXyLf9IndPYDouDTZ5
         muWA==
X-Gm-Message-State: AOAM533f3LX9RNXljQY6eaqrLZcGXwpaEp6OBm+6A2IlVimkChMP10PT
        +l5HCZ9nqO7v8mLE4hma/Kqxcg6bci0AmQ==
X-Google-Smtp-Source: ABdhPJzMpiAofD4gyI4/Th2NZbfK+s2X3y4NQ2SnKL9eSdJPJQlUGHOywDBB+422io1aaDo0lJbrBg==
X-Received: by 2002:a2e:8750:: with SMTP id q16mr6263368ljj.53.1603744446899;
        Mon, 26 Oct 2020 13:34:06 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id x27sm1150874lfc.273.2020.10.26.13.34.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 13:34:05 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id i2so11803887ljg.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 13:34:05 -0700 (PDT)
X-Received: by 2002:a2e:a16b:: with SMTP id u11mr234204ljl.421.1603744445140;
 Mon, 26 Oct 2020 13:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <fe8abcc88cff676ead8ee48db1e993e63b0611c7.1603327264.git.joe@perches.com>
 <20201026194127.GA106214@roeck-us.net>
In-Reply-To: <20201026194127.GA106214@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Oct 2020 13:33:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjhHuwANGerJLJyn7jXCfMQMiaBAW+o2r_T+n=Ki+New@mail.gmail.com>
Message-ID: <CAHk-=whjhHuwANGerJLJyn7jXCfMQMiaBAW+o2r_T+n=Ki+New@mail.gmail.com>
Subject: Re: [PATCH] treewide: Convert macro and uses of __section(foo) to __section("foo")
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/mixed; boundary="000000000000f6c96705b298d94b"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f6c96705b298d94b
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 26, 2020 at 12:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> make ARCH=um SUBARCH=x86_64 defconfig:
>
> Building um:defconfig ... failed
> --------------
> Error log:
> arch/um/kernel/skas/clone.c:24:16: error: expected declaration specifiers or '...' before string constant
> arch/x86/um/stub_segv.c:11:16: error: expected declaration specifiers or '...' before string constant

Weird. Is __section() not defined somehow for those files?

It does look like they have very minimal headers, so undoing that
patch just for those two files is likely the right thing to do.

> As with s390, reverting this patch fixes the problem.

s390 should be fixed already.

Is the attached minimal patch sufficient for um to get back to working
order, or is there something else hiding there too?

                   Linus

--000000000000f6c96705b298d94b
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kgr00tti0>
X-Attachment-Id: f_kgr00tti0

IGFyY2gvdW0va2VybmVsL3NrYXMvY2xvbmUuYyB8IDIgKy0KIGFyY2gveDg2L3VtL3N0dWJfc2Vn
di5jICAgICB8IDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBiL2FyY2gvdW0va2VybmVsL3NrYXMvY2xvbmUuYyBhL2FyY2gv
dW0va2VybmVsL3NrYXMvY2xvbmUuYwppbmRleCA5NWMzNTUxODFkY2QuLmJmYjcwYzQ1NmIzMCAx
MDA2NDQKLS0tIGIvYXJjaC91bS9rZXJuZWwvc2thcy9jbG9uZS5jCisrKyBhL2FyY2gvdW0va2Vy
bmVsL3NrYXMvY2xvbmUuYwpAQCAtMjEsNyArMjEsNyBAQAogICogb24gc29tZSBzeXN0ZW1zLgog
ICovCiAKLXZvaWQgX19zZWN0aW9uKCIuX19zeXNjYWxsX3N0dWIiKQordm9pZCBfX2F0dHJpYnV0
ZV9fICgoX19zZWN0aW9uX18gKCIuX19zeXNjYWxsX3N0dWIiKSkpCiBzdHViX2Nsb25lX2hhbmRs
ZXIodm9pZCkKIHsKIAlzdHJ1Y3Qgc3R1Yl9kYXRhICpkYXRhID0gKHN0cnVjdCBzdHViX2RhdGEg
KikgU1RVQl9EQVRBOwpkaWZmIC0tZ2l0IGIvYXJjaC94ODYvdW0vc3R1Yl9zZWd2LmMgYS9hcmNo
L3g4Ni91bS9zdHViX3NlZ3YuYwppbmRleCBmZGNkNThhZjcwN2EuLjI3MzYxY2JiN2NhOSAxMDA2
NDQKLS0tIGIvYXJjaC94ODYvdW0vc3R1Yl9zZWd2LmMKKysrIGEvYXJjaC94ODYvdW0vc3R1Yl9z
ZWd2LmMKQEAgLTgsNyArOCw3IEBACiAjaW5jbHVkZSA8c3lzZGVwL21jb250ZXh0Lmg+CiAjaW5j
bHVkZSA8c3lzL3Vjb250ZXh0Lmg+CiAKLXZvaWQgX19zZWN0aW9uKCIuX19zeXNjYWxsX3N0dWIi
KQordm9pZCBfX2F0dHJpYnV0ZV9fICgoX19zZWN0aW9uX18gKCIuX19zeXNjYWxsX3N0dWIiKSkp
CiBzdHViX3NlZ3ZfaGFuZGxlcihpbnQgc2lnLCBzaWdpbmZvX3QgKmluZm8sIHZvaWQgKnApCiB7
CiAJdWNvbnRleHRfdCAqdWMgPSBwOwo=
--000000000000f6c96705b298d94b--
