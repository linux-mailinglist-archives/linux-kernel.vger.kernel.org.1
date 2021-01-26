Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD14304E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbhAZXwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:52:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbhAZQ74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 11:59:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB71B229C9;
        Tue, 26 Jan 2021 16:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611680356;
        bh=gRAls07DrECuk0X0leeEk0d93d6mXj1Kwan1fuByVy4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KnsAUeIzrJGXRzJY+SVSVSHHly5KZhwzKAKGXMOQbNrc25Rf4hcm8Y3aKAWQePl/Q
         wK7AoNr5g1J9hj6sXlI1UbimdA3jPsBFvAvpcpBlfg3VoTBBGLZkXyNIvfhtYuKJUi
         B+ZaiJzg2TcYC78+tx2kQHFsLWgvSz3QNUILUKK6278zNms2bXei6lBLzylxT4rCL5
         0vUK9RCVSvwL0bNBU/cKIjGn88iKuzL+TMPC3uq2uzqWkAPt5F0bUCFnKURybuvoCP
         Ow47Xqgnoib42p33vuyp2KIPpIQ2EuFzYXuT5Fv/Shu5T+rCCgRZs6420ck63l/iTm
         hqqZ9ftMU7Yeg==
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
To:     Vlastimil Babka <vbabka@suse.cz>,
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
From:   Timur Tabi <timur@kernel.org>
Message-ID: <cd9e7a31-e4f6-69d3-0648-c6228108b592@kernel.org>
Date:   Tue, 26 Jan 2021 10:59:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <09c70d6b-c989-ca23-7ee8-b404bb0490f0@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 10:47 AM, Vlastimil Babka wrote:
> Given Linus' current stance later in this thread, could we revive the idea of a
> boot time option, or at least a CONFIG (I assume a runtime toggle would be too
> much, even if limited to !kernel_lockdown:)  , that would disable all hashing?
> It would be really useful for a development/active debugging, as evidenced
> below. Thanks.

So you're saying:

if CONFIG_PRINTK_NEVER_HASH is disabled, then %p prints hashed addresses 
and %px prints unhashed.

If CONFIG_PRINTK_NEVER_HASH is enabled, then %p and %px both print 
unhashed addresses.

I like this idea, and I would accept it as a solution if I had to, but I 
still would also like for an option for print_hex_dump() to print 
unhashed addresses even when CONFIG_PRINTK_NEVER_HASH is disabled.  I 
can't always recompile the entire kernel for my testing purposes.

The only drawback to this idea is: what happens if distros start 
enabling CONFIG_PRINTK_NEVER_HASH by default, just because it makes 
debugging easier?
