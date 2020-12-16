Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A3F2DBBEA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 08:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgLPHUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 02:20:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:32829 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgLPHUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 02:20:49 -0500
IronPort-SDR: ZIMiSQelpvyvDcW8e6IFH20yG+HTTvoPTB+L9vp/bo0m8FcLUqQFnd+XLC+SrsehbkpYFXDkzz
 EjRBJu+UbVUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="236600814"
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="236600814"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 23:20:08 -0800
IronPort-SDR: 4LbRgW0uLRbjBDXBgHNNl0XrbaxDOKRrZfPWeP+WFl4aDGdSpp3mBkNmOIZ9qywRWMBRRFhIk/
 hCUH3s3nPc5w==
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="338157464"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.117]) ([10.239.13.117])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 23:20:07 -0800
Subject: Re: [kbuild-all] Re: drivers/mtd/tests/subpagetest.c:426:1: error:
 could not split insn
To:     Willy Tarreau <w@1wt.eu>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202012152318.bHtYzSWJ-lkp@intel.com>
 <20201215154046.GA5262@1wt.eu>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <87896508-f281-8ab9-2de2-855d6c4be698@intel.com>
Date:   Wed, 16 Dec 2020 15:19:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20201215154046.GA5262@1wt.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/20 11:40 PM, Willy Tarreau wrote:
> Hi,
>
> On Tue, Dec 15, 2020 at 11:05:28PM +0800, kernel test robot wrote:
>> Hi Willy,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   148842c98a24e508aecb929718818fbf4c2a6ff3
>> commit: 3744741adab6d9195551ce30e65e726c7a408421 random32: add noise from network and scheduling activity
> (...)
>
> not sure why I'm assigned this, but the root cause is a compiler bug:
>>     drivers/mtd/tests/subpagetest.c: In function 'mtd_subpagetest_init':
>>>> drivers/mtd/tests/subpagetest.c:426:1: error: could not split insn
>>       426 | }
>>           | ^
>>     (insn:TI 453 2652 455 (set (reg/v:SI 3 a3 [orig:304 a ] [304])
>>             (xor:SI (reg:SI 1 a1 [orig:717 net_rand_noise ] [717])
>>                 (const:SI (plus:SI (symbol_ref:SI ("*.LANCHOR0") [flags 0x182])
>>                         (const_int 12 [0xc]))))) "include/linux/prandom.h":66:4 152 {cskyv2_xorsi3}
>>          (expr_list:REG_DEAD (reg:SI 1 a1 [orig:717 net_rand_noise ] [717])
>>             (nil)))
>>     during RTL pass: final
>>     drivers/mtd/tests/subpagetest.c:426:1: internal compiler error: in final_scan_insn_1, at final.c:3074
>                                              ^^^^^^^^^^^^^^^^^^^^^^^
>
>>     0x510da0 _fatal_insn(char const*, rtx_def const*, char const*, int, char const*)
>>     	/tmp/build-crosstools-xh-9.3.0-2.34/gcc/gcc-9.3.0/gcc/rtl-error.c:108
>>     0x503d22 final_scan_insn_1
>>     	/tmp/build-crosstools-xh-9.3.0-2.34/gcc/gcc-9.3.0/gcc/final.c:3074
>>     0x73f8bf final_scan_insn(rtx_insn*, _IO_FILE*, int, int, int*)
>>     	/tmp/build-crosstools-xh-9.3.0-2.34/gcc/gcc-9.3.0/gcc/final.c:3153
>>     0x73fbac final_1
>>     	/tmp/build-crosstools-xh-9.3.0-2.34/gcc/gcc-9.3.0/gcc/final.c:2021
>>     0x740618 rest_of_handle_final
>>     	/tmp/build-crosstools-xh-9.3.0-2.34/gcc/gcc-9.3.0/gcc/final.c:4659
>>     0x740618 execute
>>     	/tmp/build-crosstools-xh-9.3.0-2.34/gcc/gcc-9.3.0/gcc/final.c:4737
>>     Please submit a full bug report,
>>     with preprocessed source if appropriate.
>>     Please include the complete backtrace with any bug report.
>>     See <https://gcc.gnu.org/bugs/> for instructions.
>            ^^^^^^^^^^^^^^^^^^^^^^^^^
>
> That's totally out of my scope. I suspect it might have broken a bisect
> operation.

Hi Willy,

Thanks for the feedback, I have created a issue in GCC Bugzilla:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=98310

Best Regards,
Rong Chen

>
> Regards,
> Willy
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

