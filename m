Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529EA28C972
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 09:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390370AbgJMHeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 03:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390018AbgJMHes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 03:34:48 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DEAC205CA;
        Tue, 13 Oct 2020 07:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602574486;
        bh=GhAG0J+vJgd9zGq/7S2yLWnSWEl+GQ9Gt6oedI60JpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fGAqznVbGa+EmEekK8WeEnc/qlcLTCEzLJHirBZmtROeXU6ZOm8ndMqttj1tdD0YG
         w8bEdAiGO/UBFmrTsjaItMERglAGVSIu69KkiKj6OZUoW2W6fj7Nqpa9BG+pM5+j02
         ZkXvbV2FlUwjBQXdI4kFAY/OfKMbDQnAZnRHfmnM=
Date:   Tue, 13 Oct 2020 09:35:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-usb@vger.kernel.org
Subject: Re: [linux-safety] [PATCH] usb: host: ehci-sched: add comment about
 find_tt() not returning error
Message-ID: <20201013073524.GA1674118@kroah.com>
References: <20201011205008.24369-1-sudipm.mukherjee@gmail.com>
 <alpine.DEB.2.21.2010121550300.6487@felia>
 <20201012145710.GA631710@rowland.harvard.edu>
 <alpine.DEB.2.21.2010121659040.6487@felia>
 <20201012151816.GA1559916@kroah.com>
 <alpine.DEB.2.21.2010122022250.17866@felia>
 <20201013052317.GB330398@kroah.com>
 <alpine.DEB.2.21.2010130725370.14590@felia>
 <20201013063636.GA1663576@kroah.com>
 <alpine.DEB.2.21.2010130850410.14590@felia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2010130850410.14590@felia>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 09:16:27AM +0200, Lukas Bulwahn wrote:
> Some others actually believe that the use of static analysis tools 
> increase software quality and ONLY IF a static analysis tool is used, a 
> specific level of software quality is achieved and they want to prove 
> that the software reaches a certain level that way. (I do not 
> understand that argument but some have been repeating it quite often 
> around me. This argument seems to come from a specific interpretation of 
> safety standards that claim to have methods to predict the absense of 
> bugs up to a certain confidence.)

So do those others also audit the static analysis tools to ensure that
they actually work as they "think" they do?  If not, then their
requirement is pretty pointless :)

> I am doing it for the fun and learning about tools, and I am not such a 
> believer but those others would be forced by their beliefs until they 
> understand what static analysis tools and their janitors really already 
> contribute to the kernel development and where the real gaps might be.
> 
> I hope that helps to get a bit of the motivation. Consider us 
> kernel newbies :)

Watch out, sending patches to subsystems to "fix" issues that really
are not real problems is a sure way to get your patches rejected and
make maintainers grumpy.

I recommend starting out with code that we all "know" needs help, in
drivers/staging/ for stuff like this, so you can learn the process
better, as well as start to understand the limitations of your tools
better.

good luck!

greg k-h
