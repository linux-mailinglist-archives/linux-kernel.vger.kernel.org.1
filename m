Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2E41D9EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 20:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgESSNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 14:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgESSM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:12:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD6F220674;
        Tue, 19 May 2020 18:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589911979;
        bh=N7DRKm3rp+MzcDn49dUPoPcqJb/laTPZQeRIAO0h6d8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQMXC10XZP9euUWntn1r34yUp6GaM10pqUR0Nvd2RrbZJVYqEwArnowXkLkh9AVWn
         YKFOjwciVTmsIL3FdPi+qX6kn9wrVjJFdwugmxQCbgZL+82htarrQNnvqkmT93plMC
         996LaWxaQ+d11jbV/lGtnA6V6AeMN+RJaH1pzsUg=
Date:   Tue, 19 May 2020 20:12:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Dave Airlie <airlied@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        manivannan.sadhasivam@linaro.org, bjorn.andersson@linaro.org,
        wufan@codeaurora.org, pratanan@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/8] Qualcomm Cloud AI 100 driver
Message-ID: <20200519181256.GA1215993@kroah.com>
References: <1589465266-20056-1-git-send-email-jhugo@codeaurora.org>
 <CAPM=9txXskVu_yD3DNuR0HgSUsE2v1Pv98dm=AHGvv_z2XKTAQ@mail.gmail.com>
 <93238096-5861-c140-b94f-6137977c3d65@codeaurora.org>
 <20200519174120.GC1158284@kroah.com>
 <ce0e69ef-116c-df95-c136-d4714e02e96e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce0e69ef-116c-df95-c136-d4714e02e96e@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 12:07:03PM -0600, Jeffrey Hugo wrote:
> On 5/19/2020 11:41 AM, Greg Kroah-Hartman wrote:
> > On Tue, May 19, 2020 at 08:57:38AM -0600, Jeffrey Hugo wrote:
> > > On 5/18/2020 11:08 PM, Dave Airlie wrote:
> > > > On Fri, 15 May 2020 at 00:12, Jeffrey Hugo <jhugo@codeaurora.org> wrote:
> > > > > 
> > > > > Introduction:
> > > > > Qualcomm Cloud AI 100 is a PCIe adapter card which contains a dedicated
> > > > > SoC ASIC for the purpose of efficently running Deep Learning inference
> > > > > workloads in a data center environment.
> > > > > 
> > > > > The offical press release can be found at -
> > > > > https://www.qualcomm.com/news/releases/2019/04/09/qualcomm-brings-power-efficient-artificial-intelligence-inference
> > > > > 
> > > > > The offical product website is -
> > > > > https://www.qualcomm.com/products/datacenter-artificial-intelligence
> > > > > 
> > > > > At the time of the offical press release, numerious technology news sites
> > > > > also covered the product.  Doing a search of your favorite site is likely
> > > > > to find their coverage of it.
> > > > > 
> > > > > It is our goal to have the kernel driver for the product fully upstream.
> > > > > The purpose of this RFC is to start that process.  We are still doing
> > > > > development (see below), and thus not quite looking to gain acceptance quite
> > > > > yet, but now that we have a working driver we beleive we are at the stage
> > > > > where meaningful conversation with the community can occur.
> > > > 
> > > > 
> > > > Hi Jeffery,
> > > > 
> > > > Just wondering what the userspace/testing plans for this driver.
> > > > 
> > > > This introduces a new user facing API for a device without pointers to
> > > > users or tests for that API.
> > > 
> > > We have daily internal testing, although I don't expect you to take my word
> > > for that.
> > > 
> > > I would like to get one of these devices into the hands of Linaro, so that
> > > it can be put into KernelCI.  Similar to other Qualcomm products. I'm trying
> > > to convince the powers that be to make this happen.
> > > 
> > > Regarding what the community could do on its own, everything but the Linux
> > > driver is considered proprietary - that includes the on device firmware and
> > > the entire userspace stack.  This is a decision above my pay grade.
> > 
> > Ok, that's a decision you are going to have to push upward on, as we
> > really can't take this without a working, open, userspace.
> 
> Fair enough.  I hope that your position may have made things easier for me.
> 
> I hope this doesn't widen the rift as it were, but what is the "bar" for
> this userspace?
> 
> Is a simple test application that adds two numbers on the hardware
> acceptable?

Make it the real library that you use for your applications that anyone
can then also use as well if they have the hardware.  Why would you want
something "crippled"?

> What is the bar "working"?  I intend to satisfy this request in good faith,
> but I wonder, if no one has the hardware besides our customers, and possibly
> KernelCI, can you really say that I've provided a working userspace?

How do you know who your customers really are, or who they sell the
chips to?  I could end up with one of these... :)

> > Especially given the copyright owner of this code, that would be just
> > crazy and foolish to not have open userspace code as well.  Firmware
> > would also be wonderful as well, go poke your lawyers about derivative
> > work issues and the like for fun conversations :)
> 
> Those are the kind of conversations I try to avoid  :)

Sounds like you are going to now have to have them, have fun!

greg k-h
