Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454812FC244
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbhASV1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:27:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbhASV0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 16:26:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8626122D08;
        Tue, 19 Jan 2021 21:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611091536;
        bh=m2NmUkVbZFqNYxEiipm2cSpkCjD68PKieK6nRK/uEZE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hyHE3pqxSgelS0zn5RME0voJ8QHAzxRaFLzY5H30Qpa7kCxG8OyBg8cMEvw/dSC1V
         I+7XvCxsxvsMt/r49nMHePxICOVfl+sTdBrEK4KzAv15ae+3LlK7HWRu6FpGi6Muph
         VNgBRx3D7rxt46XRREE0gqQ21cZsnBQqOrzJCYPWXsovAN6JOC3o0TAETdAFT63+iS
         hzW37fS/n9cPCu2v3hW/p0YTmEs4TzgEksy0nSp9HovD8fsWwIcC/iCrvbZoOyivga
         gzH3qvOlHvhq714BJga/FrHb67LBnLnftKtcOHSA4n/7QJC44vk4nNp7MWi1AY+DvL
         +wCZkRL/WjvMw==
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
References: <20210116220950.47078-1-timur@kernel.org>
 <20210118182635.GD2260413@casper.infradead.org>
 <ed7e0656-9271-3ccf-ef88-153da1ee31c9@kernel.org>
 <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
 <20210119014725.GH2260413@casper.infradead.org>
 <202101191135.A78A570@keescook>
 <29122c86-bfea-2f25-d111-00641cc660ba@kernel.org>
 <20210119151045.15c1fee3@gandalf.local.home>
 <184ab5eb-2508-0761-36c6-061d509fe104@kernel.org>
 <20210119161524.31c695d3@gandalf.local.home>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <db57e59c-5b15-9428-5daa-5dfa4a1d2be9@kernel.org>
Date:   Tue, 19 Jan 2021 15:25:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119161524.31c695d3@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/21 3:15 PM, Steven Rostedt wrote:
> When it's not related to any symbol, doesn't it still produce an offset
> with something close by, that could still give you information that's
> better than a hashed number.

No.  I often need the actual unhashed address in the hex dump so that I 
can see if some other pointer is correct.

For example, I could be doing pointer math to calculate the address of 
some data inside a block.  In this case, I would %px the pointer, and 
then hex_dump the block.  I can then see not only where inside the block 
the pointer is pointing to, but what data it points to.
