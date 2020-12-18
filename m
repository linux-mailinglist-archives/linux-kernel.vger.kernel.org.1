Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1B22DDEC2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 07:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbgLRGzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 01:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgLRGzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 01:55:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE00C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 22:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=eVSNY9beUisrR6DjTzyXH++4TmxxcaQeUDEUADAgt1U=; b=Xh9i/7r3Q7CTC43D9D6U4TBeLw
        zbsXVO3dGc/0kXabTzkzBxWo6nkH4P+9vqohUSsYuuEEyrTc29TMPeJqPfYDN9MGaND6J6JN/Zudn
        0+BVcxITXS+1/+mIMlg/AnljIuS0yDuEQeQNGZXjz3sh1j1VcQbRAsDNQfG56w8tCePWoKwX1KzJN
        dNHkVtlOS36acsz1CwafDFRdmcKXur3zgvz3r70kfhQUi4uANuKi26r/YxxGCExy8/oxr55YpcQnO
        m6X8yxxLstkn7d+VibZhl4mT/VnThtX5Z6zvukWe66Wx0t4R1ogIsm5QbWam6Bwk+C1q6L83TqiyJ
        DxDJL9Sg==;
Received: from [2601:1c0:6280:3f0::64ea]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kq9ex-0005O4-Fu; Fri, 18 Dec 2020 06:54:39 +0000
Subject: Re: 5.10.1: UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:1
To:     =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>,
        jgg@ziepe.ca
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <c6e5eb81-680f-dd5c-8a81-62041a5ce50c@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5c172fad-a9cf-c29d-0a27-f2b0505dc33d@infradead.org>
Date:   Thu, 17 Dec 2020 22:54:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <c6e5eb81-680f-dd5c-8a81-62041a5ce50c@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[adding linux-mm]

On 12/16/20 1:54 AM, Toralf Förster wrote:
> Hi,
> 
> I got this recently at this hardened Gentoo Linux server:
> 
> Linux mr-fox 5.10.1 #1 SMP Tue Dec 15 22:09:42 CET 2020 x86_64 Intel(R)
> Xeon(R) CPU E5-1650 v3 @ 3.50GHz GenuineIntel GNU/Linux
> 
> 
> Dec 15 23:31:51 mr-fox kernel: [ 1974.206972]
> ================================================================================
> Dec 15 23:31:51 mr-fox kernel: [ 1974.206977] UBSAN: shift-out-of-bounds
> in ./include/linux/log2.h:57:13
> Dec 15 23:31:51 mr-fox kernel: [ 1974.206980] shift exponent 64 is too
> large for 64-bit type 'long unsigned int'
> Dec 15 23:31:51 mr-fox kernel: [ 1974.206982] CPU: 11 PID: 21051 Comm:
> cc1 Tainted: G                T 5.10.1 #1
> Dec 15 23:31:51 mr-fox kernel: [ 1974.206984] Hardware name: ASUSTeK
> COMPUTER INC. Z10PA-U8 Series/Z10PA-U8 Series, BIOS 3703 08/02/2018
> Dec 15 23:31:51 mr-fox kernel: [ 1974.206985] Call Trace:
> Dec 15 23:31:51 mr-fox kernel: [ 1974.206993]  dump_stack+0x57/0x6a
> Dec 15 23:31:51 mr-fox kernel: [ 1974.206996]  ubsan_epilogue+0x5/0x40
> Dec 15 23:31:51 mr-fox kernel: [ 1974.206999]
> __ubsan_handle_shift_out_of_bounds.cold+0x61/0x10e
> Dec 15 23:31:51 mr-fox kernel: [ 1974.207002]
> ondemand_readahead.cold+0x16/0x21
> Dec 15 23:31:51 mr-fox kernel: [ 1974.207007]
> generic_file_buffered_read+0x452/0x890
> Dec 15 23:31:51 mr-fox kernel: [ 1974.207011]  new_sync_read+0x156/0x200
> Dec 15 23:31:51 mr-fox kernel: [ 1974.207014]  vfs_read+0xf8/0x190
> Dec 15 23:31:51 mr-fox kernel: [ 1974.207016]  ksys_read+0x65/0xe0
> Dec 15 23:31:51 mr-fox kernel: [ 1974.207018]  do_syscall_64+0x33/0x40
> Dec 15 23:31:51 mr-fox kernel: [ 1974.207021]
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Dec 15 23:31:51 mr-fox kernel: [ 1974.207024] RIP: 0033:0x7f01b2df198e
> Dec 15 23:31:51 mr-fox kernel: [ 1974.207026] Code: c0 e9 b6 fe ff ff 50
> 48 8d 3d 66 c3 09 00 e8 59 e2 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04
> 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f
> 84 00 00 00 00 00 48 83 ec 28
> Dec 15 23:31:51 mr-fox kernel: [ 1974.207028] RSP: 002b:00007fff2167e998
> EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> Dec 15 23:31:51 mr-fox kernel: [ 1974.207030] RAX: ffffffffffffffda RBX:
> 0000000000000000 RCX: 00007f01b2df198e
> Dec 15 23:31:51 mr-fox kernel: [ 1974.207032] RDX: 0000000000000000 RSI:
> 00000000054dcc50 RDI: 0000000000000004
> Dec 15 23:31:51 mr-fox kernel: [ 1974.207033] RBP: 00000000054dcc50 R08:
> 00000000054dcc50 R09: 0000000000000000
> Dec 15 23:31:51 mr-fox kernel: [ 1974.207034] R10: 0000000000000000 R11:
> 0000000000000246 R12: 00000000054dc3b0
> Dec 15 23:31:51 mr-fox kernel: [ 1974.207035] R13: 0000000000008000 R14:
> 00000000054c9800 R15: 0000000000000000
> Dec 15 23:31:51 mr-fox kernel: [ 1974.207037]
> ================================================================================
> 
> 
> Known issue ?

Not that I have heard about, but that's not conclusive.

Looks to me like this is in mm/readahead.c:

static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
{
	unsigned long newsize = roundup_pow_of_two(size);


What filesystem?  What workload?

thanks.
-- 
~Randy
