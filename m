Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353FA2FA99F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437032AbhARTGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:06:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407913AbhARTEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:04:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5547720756;
        Mon, 18 Jan 2021 19:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610996631;
        bh=n6ZqPSvHwOtagI+O+dxOJ2Lau8vm7rGXzdL32UD9bbI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HK6YJfEucQ7G+/yLCb02/WXEJhblwMXqa6LsyYTuIDOtHzOhThANjlv/GGeHV8aQg
         Yc4/o9DKCyBru3zWVi27k+ZwA3na+OtXFnTuj440ssHH0RisJkifDQIwQgiIhIqMcX
         ryUkUbc7dfk/paSGCMbx4ntr/iHhSnMJ8muT4bcRwqRcpuF70GnNo7i+p1TtHNnqev
         HIi+QwttdyYrqBv+W3909lcRVyeHGK3G5ERZcdW8IgayfAm59Ivy/CuqHrSimOX8iX
         kguRqly4dYhqVvVT+1Nigqpob6nCOOiHf0uPiLlT5c34UZAEjTEGxyJpmHXDt+H2Om
         vc/Em01BazbJg==
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        keescook@chromium.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
References: <20210116220950.47078-1-timur@kernel.org>
 <20210118182635.GD2260413@casper.infradead.org>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
Date:   Mon, 18 Jan 2021 13:03:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210118182635.GD2260413@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/21 12:26 PM, Matthew Wilcox wrote:
> Don't make it easy.  And don't make it look like they're doing
> something innocent.  DUMP_PREFIX_SECURITY_HOLE would be OK
> by me.  DUMP_PREFIX_LEAK_INFORMATION would work fine too.
> DUMP_PREFIX_MAKE_ATTACKERS_LIFE_EASY might be a bit too far.

It's already extremely easy to replace %p with %px in your own printks, 
so I don't really understand your argument.

Seriously, this patch should not be so contentious.  If you want hashed 
addresses, then nothing changes.  If you need unhashed addresses while 
debugging, then use DUMP_PREFIX_UNHASHED.  Just like you can use %px in 
printk.  I never use %p in my printks, but then I never submit code 
upstream that prints addresses, hashed or unhashed.
