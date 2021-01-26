Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2813A304E29
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390121AbhA0APX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:15:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:32984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730107AbhAZRFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:05:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7A4DAC97;
        Tue, 26 Jan 2021 16:47:33 +0000 (UTC)
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Timur Tabi <timur@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        keescook@chromium.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
References: <20210116220950.47078-1-timur@kernel.org>
 <20210118182635.GD2260413@casper.infradead.org>
 <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
 <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
 <20210119014725.GH2260413@casper.infradead.org>
 <YAa2oCNWjExWlQTu@jagdpanzerIV.localdomain>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
Message-ID: <09c70d6b-c989-ca23-7ee8-b404bb0490f0@suse.cz>
Date:   Tue, 26 Jan 2021 17:47:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAa2oCNWjExWlQTu@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/21 11:38 AM, Sergey Senozhatsky wrote:
> On (21/01/19 01:47), Matthew Wilcox wrote:
> [..]
>> 
>> > So maybe DUMP_PREFIX_UNHASHED can do the unhashed dump only when
>> > CONFIG_DEBUG_KERNEL=y and fallback to DUMP_PREFIX_ADDRESS otherwise?
>> 
>> Distros enable CONFIG_DEBUG_KERNEL.
> 
> Oh, I see.
> 
>> If you want to add CONFIG_DEBUG_LEAK_ADDRESSES, then that's great,
>> and you won't even have to change users, you can just change how %p
>> behaves.
> 
> I like the name. config dependent behaviour of %p wouldn't be new,
> well, to some extent, e.g. XFS does something similar (see below).
> I don't think Linus will be sold on this, however.

Given Linus' current stance later in this thread, could we revive the idea of a
boot time option, or at least a CONFIG (I assume a runtime toggle would be too
much, even if limited to !kernel_lockdown :) , that would disable all hashing?
It would be really useful for a development/active debugging, as evidenced
below. Thanks.

> fs/xfs/xfs_linux.h:
> 
> /*
>  * Starting in Linux 4.15, the %p (raw pointer value) printk modifier
>  * prints a hashed version of the pointer to avoid leaking kernel
>  * pointers into dmesg.  If we're trying to debug the kernel we want the
>  * raw values, so override this behavior as best we can.
>  */
> #ifdef DEBUG
> # define PTR_FMT "%px"
> #else
> # define PTR_FMT "%p"
> #endif
> 
> And then they just use it as
> 
> 	xfs_alert(mp, "%s: bad inode magic number, dip = "ptr_fmt",
> 		  dino bp = "ptr_fmt", ino = %ld",
> 		  __func__, dip, bp, in_f->ilf_ino);
> 
> 	-ss
> 

