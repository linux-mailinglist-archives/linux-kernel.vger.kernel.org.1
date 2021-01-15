Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AF32F70C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 03:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbhAOC5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 21:57:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730528AbhAOC5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 21:57:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A0D623AC6;
        Fri, 15 Jan 2021 02:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610679399;
        bh=gVsYalf7CrnQWYli9+w4MJODH5TBXQrYG70lmtMUJYE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W6mjLhLFQdL+2nItQ8QbQVUl8f6fScYdHk5VgMRwmXeqTKpmVk/24yI4q5TAIJtdC
         bk/j+Dstdna7Kk69dkzg/G873hS2v19vvFgCIW4yHV7tpZXtEBWSY+G0N5ApFzLbeF
         Bfk9V5vwSZ51vMM7u44o0AToRPkmpcb8O78JEJQh6pYr/5UA43bWElX/yI98+SHR+p
         Myegb7Fx83q7QVCNVZPDASyDILDioC8wnXk5xpJUVWHiqHGWVuoU2SVT2Y2zd61E5/
         bk2CzTw3pjV7x7XZEbchvmmRj6dzvpYNdJjvd6mfMNPOGbmivSxJSOtEbqAJc43Z5V
         NxfQWV9Er6PDA==
Subject: Re: [PATCH] lib/hexdump: introduce DUMP_PREFIX_UNHASHED for unhashed
 addresses
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Roman Fietze <roman.fietze@magna.com>,
        Kees Cook <keescook@chromium.org>
References: <20210106213547.1077789-1-timur@tabi.org> <X/wkMMiPPBAJb9+A@alley>
 <20210111173009.fe2383539e5ca2c23b135262@linux-foundation.org>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <d067f15a-8816-8879-e575-b610707c5189@kernel.org>
Date:   Thu, 14 Jan 2021 20:56:36 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210111173009.fe2383539e5ca2c23b135262@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/21 7:30 PM, Andrew Morton wrote:
> I doubt if Kees (or I or anyone else) can review this change because
> there are no callers which actually use the new DUMP_PREFIX_UNHASHED.
> Is it intended that some other places in the kernel be changed to use
> this?  If so, please describe where and why, so that others can better
> understand both the requirement and the security implications.

In my opinion, hashed addresses make no sense in a hexdump, so I would 
say that ALL callers should change.  But none of the drivers I've 
written call print_hex_dump(), so I can't make those changes myself.

> If it is intended that this be used mainly for developer debug and not
> to be shipped in the mainline kernel then let's get this info into the
> changelog as well.

I definitely want this patch included in the mainline kernel.  Just 
because there aren't any users today doesn't mean that there won't be. 
In fact, I suspect that most current users haven't noticed that the 
addresses have changed or don't care any more, but if they were to write 
the code today, they would use unhashed addresses.

If you want, I can include a patch that changes a few callers of 
print_hex_dump() to use DUMP_PREFIX_UNHASHED, based on what I think 
would be useful.
