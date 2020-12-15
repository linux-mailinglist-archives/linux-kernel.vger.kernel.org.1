Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499652DB048
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbgLOPlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:41:47 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:48466 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730242AbgLOPlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:41:36 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 0BFFekxC005572;
        Tue, 15 Dec 2020 16:40:46 +0100
Date:   Tue, 15 Dec 2020 16:40:46 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/mtd/tests/subpagetest.c:426:1: error: could not split
 insn
Message-ID: <20201215154046.GA5262@1wt.eu>
References: <202012152318.bHtYzSWJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202012152318.bHtYzSWJ-lkp@intel.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 15, 2020 at 11:05:28PM +0800, kernel test robot wrote:
> Hi Willy,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   148842c98a24e508aecb929718818fbf4c2a6ff3
> commit: 3744741adab6d9195551ce30e65e726c7a408421 random32: add noise from network and scheduling activity
(...)

not sure why I'm assigned this, but the root cause is a compiler bug:
>    drivers/mtd/tests/subpagetest.c: In function 'mtd_subpagetest_init':
> >> drivers/mtd/tests/subpagetest.c:426:1: error: could not split insn
>      426 | }
>          | ^
>    (insn:TI 453 2652 455 (set (reg/v:SI 3 a3 [orig:304 a ] [304])
>            (xor:SI (reg:SI 1 a1 [orig:717 net_rand_noise ] [717])
>                (const:SI (plus:SI (symbol_ref:SI ("*.LANCHOR0") [flags 0x182])
>                        (const_int 12 [0xc]))))) "include/linux/prandom.h":66:4 152 {cskyv2_xorsi3}
>         (expr_list:REG_DEAD (reg:SI 1 a1 [orig:717 net_rand_noise ] [717])
>            (nil)))
>    during RTL pass: final
>    drivers/mtd/tests/subpagetest.c:426:1: internal compiler error: in final_scan_insn_1, at final.c:3074
                                            ^^^^^^^^^^^^^^^^^^^^^^^

>    0x510da0 _fatal_insn(char const*, rtx_def const*, char const*, int, char const*)
>    	/tmp/build-crosstools-xh-9.3.0-2.34/gcc/gcc-9.3.0/gcc/rtl-error.c:108
>    0x503d22 final_scan_insn_1
>    	/tmp/build-crosstools-xh-9.3.0-2.34/gcc/gcc-9.3.0/gcc/final.c:3074
>    0x73f8bf final_scan_insn(rtx_insn*, _IO_FILE*, int, int, int*)
>    	/tmp/build-crosstools-xh-9.3.0-2.34/gcc/gcc-9.3.0/gcc/final.c:3153
>    0x73fbac final_1
>    	/tmp/build-crosstools-xh-9.3.0-2.34/gcc/gcc-9.3.0/gcc/final.c:2021
>    0x740618 rest_of_handle_final
>    	/tmp/build-crosstools-xh-9.3.0-2.34/gcc/gcc-9.3.0/gcc/final.c:4659
>    0x740618 execute
>    	/tmp/build-crosstools-xh-9.3.0-2.34/gcc/gcc-9.3.0/gcc/final.c:4737
>    Please submit a full bug report,
>    with preprocessed source if appropriate.
>    Please include the complete backtrace with any bug report.
>    See <https://gcc.gnu.org/bugs/> for instructions.
          ^^^^^^^^^^^^^^^^^^^^^^^^^

That's totally out of my scope. I suspect it might have broken a bisect
operation.

Regards,
Willy
