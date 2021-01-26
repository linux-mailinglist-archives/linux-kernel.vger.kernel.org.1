Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D5D304E64
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390735AbhA0A3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:29:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:40312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389583AbhAZRPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:15:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64A15B913;
        Tue, 26 Jan 2021 17:14:52 +0000 (UTC)
To:     Timur Tabi <timur@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
 <09c70d6b-c989-ca23-7ee8-b404bb0490f0@suse.cz>
 <cd9e7a31-e4f6-69d3-0648-c6228108b592@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
Message-ID: <083dd940-60c1-4cc8-fc89-8815b253d5c5@suse.cz>
Date:   Tue, 26 Jan 2021 18:14:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <cd9e7a31-e4f6-69d3-0648-c6228108b592@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 5:59 PM, Timur Tabi wrote:
> On 1/26/21 10:47 AM, Vlastimil Babka wrote:
>> Given Linus' current stance later in this thread, could we revive the idea of a
>> boot time option, or at least a CONFIG (I assume a runtime toggle would be too
>> much, even if limited to !kernel_lockdown:)  , that would disable all hashing?
>> It would be really useful for a development/active debugging, as evidenced
>> below. Thanks.
> 
> So you're saying:
> 
> if CONFIG_PRINTK_NEVER_HASH is disabled, then %p prints hashed addresses and %px
> prints unhashed.
> 
> If CONFIG_PRINTK_NEVER_HASH is enabled, then %p and %px both print unhashed
> addresses.

Minimally, yes. KASLR is configurable like this, so why not printing of kernel
pointers?

> I like this idea, and I would accept it as a solution if I had to, but I still
> would also like for an option for print_hex_dump() to print unhashed addresses
> even when CONFIG_PRINTK_NEVER_HASH is disabled.  I can't always recompile the
> entire kernel for my testing purposes.

Yeah, obviously a boot option would be nicer. The discussion Kees pointed to [1]
seemed to be about papering over problems with entropy? Not about making
development/debugging easier. But I understand it was not the first time and I
didn't check the older ones.

> The only drawback to this idea is: what happens if distros start enabling
> CONFIG_PRINTK_NEVER_HASH by default, just because it makes debugging easier?

There's tons of other options already where the choice is between security and
performance, and distros make their choice (including, again, KASLR itself).
Pointer hashing would be just another one.

If it was a boot option, I would personally be for leaving hashing enabled by
default, with opt-in boot option to disable it. Then if I'm instructing a user
to boot the distro kernel (without recompile) with e.g. slub_debug or
debug_pagealloc or page_owner in order to debug some issue, I would additionally
instruct them to add the 'no_pointer_hashing' parameter.

[1]
https://lore.kernel.org/lkml/CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com/
