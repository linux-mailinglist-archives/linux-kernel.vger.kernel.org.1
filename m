Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17FE28C83E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 07:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbgJMFV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 01:21:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732320AbgJMFV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 01:21:56 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4C4020872;
        Tue, 13 Oct 2020 05:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602566514;
        bh=OwXE0mUrRwYdSzEBDK6eQZjP0OakM/fXBcxny4Xq+7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=deU+CRa4uzH8T+zyXk7acVOs8sL0fHLlYQBijZGWwn5C6mWkwygTdPaqY1h6KEIt4
         sYsHg5rqB23ZQ6tL5O1rlczJc+yEOYaDtowSPqG14ZAonH8p6pP3Xx2tWfDukOJsM1
         RNt/BV220toadS89VgomzvXmjXQRT/l5bOBS/75g=
Date:   Tue, 13 Oct 2020 07:21:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-usb@vger.kernel.org
Subject: Re: [linux-safety] [PATCH] usb: host: ehci-sched: add comment about
 find_tt() not returning error
Message-ID: <20201013052150.GA330398@kroah.com>
References: <20201011205008.24369-1-sudipm.mukherjee@gmail.com>
 <alpine.DEB.2.21.2010121550300.6487@felia>
 <20201012145710.GA631710@rowland.harvard.edu>
 <alpine.DEB.2.21.2010121659040.6487@felia>
 <20201012160013.GA632789@rowland.harvard.edu>
 <alpine.DEB.2.21.2010122008370.17866@felia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2010122008370.17866@felia>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 08:17:34PM +0200, Lukas Bulwahn wrote:
> > If you are suggesting some sort of special code annotation that the tool 
> > would understand, I am open to that.  But I'm not aware of any even 
> > vaguely standard way of marking up a particular function call to 
> > indicate it will not return an error.
> 
> I cannot yet say if some annotation would work, we, Sudip and me, need to 
> investigate. It could be that something like, assert(!IS_ERR(tt)), is 
> sufficient to let the tools know that they can safely assume that the 
> path they are complaining about is not possible.
> 
> We could make the assert() a nop, so it would not effect the resulting 
> object code in any way.

Things like assert() have been rejected numberous times in the past in
the kernel, good luck with that :)

greg k-h
