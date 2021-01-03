Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FD12E8EB1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 23:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbhACWdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 17:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbhACWdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 17:33:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90240C061573
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 14:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Pq+5Z6ozvBaQ5iA++kASTFfnI1AQK5+3BrIASqR75x4=; b=lWEr/RahzQuRqv+Y6uMeYoNOsc
        PZH+y1eOiRJ5/96iK7tIFKwvyqYxCOlwEGocSIZ84eZiEN1LtBxkb+7+Jpuwd6UsjXMXoSGot4P8R
        le2InaegxJPb6xC0gIy0fpZJeW7aluHkgHKSG07VmmE6Pwgk5KIE8UKVU17JPnHOvxeXlcu7gCvoo
        3fBlV8tAOWMNnMqb82niB2LKagYKfi6y65dcPOsjCJRJfF0We/9uddMNNM5pZPnUm1iwZGoiMDZbz
        BA09yeWOVbFDmuhf1G8WMNBqok2iJfa1XqOo1PvjEmZbVgDiMALjWr0Qtv8oordqSt7uxuKPeW27R
        JVs0Tv4g==;
Received: from [2601:1c0:6280:3f0::2c43]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kwBvT-000QEX-59; Sun, 03 Jan 2021 22:32:45 +0000
Subject: Re: [PATCH -mm] mm: readahead: apply a default readahead size
To:     =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org
References: <20201229212634.31307-1-rdunlap@infradead.org>
 <20201229222311.GD28221@casper.infradead.org>
 <ec3030fd-d549-99cf-fe47-703b1fbd678d@infradead.org>
 <361416d6-756d-e652-224d-03b56934030a@gmx.de>
 <c891a27c-5d9e-6673-e508-aa62d6461892@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dbc7a727-90b5-d0cb-c4a3-23baa63f1a7a@infradead.org>
Date:   Sun, 3 Jan 2021 14:32:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <c891a27c-5d9e-6673-e508-aa62d6461892@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/21 1:40 PM, Toralf Förster wrote:
> On 12/30/20 10:05 AM, Toralf Förster wrote:
>> On 12/29/20 11:55 PM, Randy Dunlap wrote:
>>>> No, this is wrong.  'size' in this case is the size of the read.
>>>> And it's zero.  Is this fixed by commit
>>>> 3644e2d2dda78e21edd8f5415b6d7ab03f5f54f3
>>>>
>>> Toralf, can you test with 5.11-rc1 (or later)?
>>>
>>> thanks.
>>
>> My plan was to apply that commit on top of the upcoming 5.10.4 and test
>> that, just waiting in moment for Greg to release the stable version.
>>
> I commit 3644e2d2dda on top of 5.10.4 at my server - no issue so far. I
> did NOT patched my desktop (same stable hardened Gentoo Linux, same
> software and kernel versions) - and there it happened under 5.10.4 too:
> 
> Jan  3 20:54:59 t44 kernel: [126159.494365] UBSAN: shift-out-of-bounds
> in ./include/linux/log2.h:57:13
> Jan  3 20:54:59 t44 kernel: [126159.494371] shift exponent 64 is too
> large for 64-bit type 'long unsigned int'
> Jan  3 20:54:59 t44 kernel: [126159.494378] CPU: 0 PID: 16651 Comm: cc1
> Tainted: G        W       T 5.10.4 #5
> Jan  3 20:54:59 t44 kernel: [126159.494381] Hardware name: LENOVO
> 20AQCTO1WW/20AQCTO1WW, BIOS GJETA4WW (2.54 ) 03/27/2020
> Jan  3 20:54:59 t44 kernel: [126159.494383] Call Trace:
> Jan  3 20:54:59 t44 kernel: [126159.494397]  dump_stack+0x57/0x6a
> Jan  3 20:54:59 t44 kernel: [126159.494402]  ubsan_epilogue+0x5/0x40
> Jan  3 20:54:59 t44 kernel: [126159.494408]
> __ubsan_handle_shift_out_of_bounds.cold+0x61/0x10e
> Jan  3 20:54:59 t44 kernel: [126159.494419]
> ondemand_readahead.cold+0x16/0x21
> Jan  3 20:54:59 t44 kernel: [126159.494427]
> generic_file_buffered_read+0x43d/0x880
> Jan  3 20:54:59 t44 kernel: [126159.494437]  new_sync_read+0x15d/0x1f0
> Jan  3 20:54:59 t44 kernel: [126159.494442]  vfs_read+0xf5/0x190
> Jan  3 20:54:59 t44 kernel: [126159.494447]  ksys_read+0x65/0xe0
> Jan  3 20:54:59 t44 kernel: [126159.494453]  do_syscall_64+0x33/0x40
> Jan  3 20:54:59 t44 kernel: [126159.494460]
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Jan  3 20:54:59 t44 kernel: [126159.494466] RIP: 0033:0x7feace476dfe
> Jan  3 20:54:59 t44 kernel: [126159.494472] Code: c0 e9 c6 fe ff ff 50
> 48 8d 3d de d6 09 00 e8 89 e4 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04
> 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f
> 84 00 00 00 00 00 48 83 ec 28
> Jan  3 20:54:59 t44 kernel: [126159.494476] RSP: 002b:00007ffe122f4318
> EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> Jan  3 20:54:59 t44 kernel: [126159.494483] RAX: ffffffffffffffda RBX:
> 0000000000000000 RCX: 00007feace476dfe
> Jan  3 20:54:59 t44 kernel: [126159.494486] RDX: 0000000000000000 RSI:
> 00000000047971a0 RDI: 0000000000000008
> Jan  3 20:54:59 t44 kernel: [126159.494489] RBP: 00000000047ba600 R08:
> 00000000047971a0 R09: 000000000470d010
> Jan  3 20:54:59 t44 kernel: [126159.494492] R10: 00007feace543a00 R11:
> 0000000000000246 R12: 0000000004721610
> Jan  3 20:54:59 t44 kernel: [126159.494495] R13: 00000000047971a0 R14:
> 0000000000000000 R15: 0000000000000000
> Jan  3 20:54:59 t44 kernel: [126159.494499]
> ================================================================================

OK, thanks for testing that commit and letting us know.

-- 
~Randy

