Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF752F0CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 07:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbhAKGby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 01:31:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:56750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbhAKGbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 01:31:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F0864AB3E;
        Mon, 11 Jan 2021 06:31:11 +0000 (UTC)
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Guenther <rguenther@suse.de>,
        "H.J. Lu" <hjl.tools@gmail.com>
From:   Jiri Slaby <jslaby@suse.cz>
Subject: perf does not resolve plt symbols from libstdc++ right (.plt.sec
 problem)
Message-ID: <d6980662-bf74-1d48-831e-ca1d7209ca2f@suse.cz>
Date:   Mon, 11 Jan 2021 07:31:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII;
        format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this e-mails is a follow-up of my report at:
https://bugzilla.suse.com/show_bug.cgi?id=1180681

There is a problem with *@plt symbols in some libraries, they are 
unresolved by perf (memcmp@plt in this case):
 >     0.26%  main2    /usr/lib64/libstdc++.so.6.0.28            0xa51a0 
            l [.] 0x00000000000a51a0

On the other hand, plt symbols in other libraries are fine (memset@plt 
in this case):
 >     0.17%  main2    /usr/lib64/libantlr4-runtime.so.4.8       0x4ed10 
            l [.] memset@plt

I dumped memcmp's .plt.rela entries in perf:
/usr/lib64/libantlr4-runtime.so.4.8: 154th addr=4e9d0 plt_off=4e020 
hdr=10 entry=10
/usr/lib64/libstdc++.so.6.0.28: 772th addr=a1070 plt_off=9e020 hdr=10 
entry=10

The difference (offset) of stdc++'s memcmp is 0xa51a0 (correct) - 
0xa1070 (perf's computed) = 0x4130.

The problem is perf assumes nth entry of .plt.rela to correspond to nth 
function in .plt, but memcmp is in .plt.sec in libstdc++.so:

 > Relocation section '.rela.plt' at offset 0x97900 contains 1018 entries:
 >     Offset             Info             Type               Symbol's 
Value  Symbol's Name + Addend
 > ...
 > 00000000001dc838  0000007800000007 R_X86_64_JUMP_SLOT 
0000000000000000 memcmp@GLIBC_2.2.5 + 0

Perf does this with the rela entries:
https://github.com/torvalds/linux/blob/f5e6c330254ae691f6d7befe61c786eb5056007e/tools/perf/util/symbol-elf.c#L385

It takes a symbol index from sym.r_info. Then it resolves its name from 
.dynsym, appending "@plt" to it. Then this name is added to perf's 
symbol table along with address which is computed as .rela.plt index 
multiplied by entry size (shdr_plt.sh_entsize) plus plt header 
(shdr_plt.sh_entsize on x86_64 too).

And from this comes (almost) the offset above:
 > $ objdump -h /usr/lib64/libstdc++.so.6|grep -E ' .plt(\.sec)? '
 >  12 .plt          00003fb0  000000000009e020  000000000009e020 
0009e020  2**4
 >  14 .plt.sec      00003fa0  00000000000a2160  00000000000a2160 
000a2160  2**4

0xa2160-0x9e020 = 0x4140. I assume the 0x10 difference is that perf adds 
shdr_plt.sh_entsize (0x10) to the offset to skip the first .plt entry 
(header).

Richard writes:
======
.plt.sec is IIRC the "second" (sec) PLT entry - the one that will be 
used on the second call (and on).  This is used / emitted for ELF object 
instrumented for Intel CET.  The details escape me for the moment but I 
hope the x86 ABI documents this (and the constraints) in detail.
======

How should perf find out whether to consider .plt or .plt.sec? Or 
generally, how to properly find an address of *@plt symbols like 
memcmp@plt above?

thanks,
-- 
js
suse labs
