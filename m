Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DF72B0B20
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgKLRQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:16:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgKLRQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:16:18 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 176B421D40;
        Thu, 12 Nov 2020 17:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605201377;
        bh=hUutc+xkmCQTHHg4mnwiJhzqEBjxoar2XE3VYmIcBEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c8GOR5DjHkcXyTB/hXNqJPBDmnNlE5rTAAzZnMpOreSc0lJj9hY3BUxzewV2IPKo9
         u9Equs2qldK1+8tWbXKwe5rneGbSW1PVx5mube3nO4aiReFu/hkIdilaQ+wXf8/8eX
         qgPzx3Gn2PfKtPAVDfm4kMvH8bADBBb1srNneZa4=
Date:   Thu, 12 Nov 2020 18:17:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     sunjunyong <sunjy516@gmail.com>
Cc:     arnd@arndb.de, sunjunyong@xiaomi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ttyprintk: optimize tpk_close flush code
Message-ID: <X61uGxi32JqMsGWl@kroah.com>
References: <1604469744-8708-1-git-send-email-sunjunyong@xiaomi.com>
 <X6zptw9Fbd3AKbPy@kroah.com>
 <20201112134122.GA20821@mi-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112134122.GA20821@mi-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Nov 12, 2020 at 09:41:22PM +0800, sunjunyong wrote:
> Hi Greg:
> It have no logic that handles NULL in tpk_flush() but tpk_printk().

Sorry, yes, that is what I mean.

> Do you mean that if i understand correctly?!I think we should not remove 
> the logic that handles NULL in tpk_printk() as we don't know if the buf 
> from parent caller is null or not.

Yes you do, you control that buffer right?  This is a static function,
you know what is happening here.

> But we transfer a null buf to tpk_printk()
>  for previous version of tpk_close, i think it's redundant.
> 
> The comment is a hitory tip for other guys to understand.I suggest to 
> keep it as before if you like.

The call to flush makes it obvious, no need to keep it.  And we have git
history for people to look at if they are curious about past versions.

thanks,

greg k-h
