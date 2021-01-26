Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59E03043D3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 17:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392896AbhAZQ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 11:27:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:53504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405368AbhAZQ1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 11:27:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 099D42073C;
        Tue, 26 Jan 2021 16:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611678387;
        bh=JCjAPE8ug3WSp9UDc2ln8+T9VoZO6/IylryIblgM7CY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ONA29Moi3PVGprJZYRhlFc16COTpCKRF3EgjgdrYzzShW4MLskk6aMy1M8bnmFHq2
         rATfaucKk1withUfolD07+DcAwjz5Ksx7Ip/t/GC5wKc1klUK3LynBbz7y4/V35m/f
         VOhgZQ6a1gLKpwc4Bqr4jLB62mVBkaOUlUcYyQwdgjqSOkaJnmSoZZlxXFOEUtS58w
         RCTwSqH8RsmATihExUl6xmevfvT10/IlpsI4clTTK8uzKOyffBiYmtg+fOOXen7V/Y
         cTDWdyNT5oUXVW721j39fcX7OIUPvgi9HfaTIMC+IBnY6XnE5SbsD+uAQG268h0n85
         mSs6xwXN7QwAw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l4RAq-0000yG-KU; Tue, 26 Jan 2021 17:26:36 +0100
Date:   Tue, 26 Jan 2021 17:26:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com, linus.walleij@linaro.org,
        mchehab+huawei@kernel.org, angelo.dureghello@timesys.com
Subject: Re: [PATCH v5 1/3] usb: serial: Add MaxLinear/Exar USB to Serial
 driver
Message-ID: <YBBCvHvduivta07b@hovoldconsulting.com>
References: <20201122170822.21715-1-mani@kernel.org>
 <20201122170822.21715-2-mani@kernel.org>
 <YAlVLOqzx8otPgOg@hovoldconsulting.com>
 <20210126154604.GC29751@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126154604.GC29751@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 09:16:04PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jan 21, 2021 at 11:19:24AM +0100, Johan Hovold wrote:
> > On Sun, Nov 22, 2020 at 10:38:20PM +0530, Manivannan Sadhasivam wrote:
> > > Add support for MaxLinear/Exar USB to Serial converters. This driver
> > > only supports XR21V141X series but it can be extended to other series
> > > from Exar as well in future.
> > 
> > There are still a few issues with this driver, but I really don't want
> > to have to review it again in a couple of months so I've fixed it up
> > myself this time.
> > 
> > The trivial stuff I folded into this patch, and I'll submit a follow-on
> > series for the rest.
> > 
> 
> Many thanks for doing this! These days it is really difficult to find
> time for spare time stuffs.
> 
> And all of your fixes makes sense to me.

Thanks for taking a look!

Johan
