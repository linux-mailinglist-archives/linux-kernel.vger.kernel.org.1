Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDCC2FC193
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404371AbhASUvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:51:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:36692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404229AbhASUuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:50:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9DF9206EC;
        Tue, 19 Jan 2021 20:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611089360;
        bh=aQvH+CokW/N5q182SWRi53sWBG0uq9qv+iB35zwrgzc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=n5laPgjOC6Mxorc1pEKnXT3xjslLDIqcX/m4L28QSGfWIVh0AL6dAqBGT7VtQmP84
         AD4egdJlnfeA1KbkVpHCrvT16+x0BW3/M/xczZCYoSW2g6hxckFIBaTts55kBufMlk
         /jPA2CPbABZMmxy21EPEzR96BAYmGR5J658p395Oxtww981ZBVa7LRQqmJmutCiysR
         0efXhfIoi5NlY4Infb/Zfez45B92MWZFzZ01GbACIr76wndvh+DoxsxzddmlbtpIYB
         ObkVofxqj2a+YB7AGCXek/ZpqKpSFRo0pRO5Azz2HKFrg6jqgjckCiatDykgTxTpUJ
         BongQRYtb/W8A==
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
From:   Timur Tabi <timur@kernel.org>
Message-ID: <184ab5eb-2508-0761-36c6-061d509fe104@kernel.org>
Date:   Tue, 19 Jan 2021 14:49:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119151045.15c1fee3@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/21 2:10 PM, Steven Rostedt wrote:
> I'm curious, what is the result if you replaced %p with %pS?
> 
> That way you get a kallsyms offset version of the output, which could still
> be very useful depending on what you are dumping.

	%pS	versatile_init+0x0/0x110

The address is question is often not related to any symbol, so it 
wouldn't make sense to use %pS.

Maybe you meant %pK?  I'm okay with that instead of %px.
