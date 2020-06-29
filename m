Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F4C20E597
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 00:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388018AbgF2Vi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 17:38:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbgF2Skb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20B282333C;
        Mon, 29 Jun 2020 08:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593418256;
        bh=vPDldX/OJgl8GaW3Xll0Qf3Mn2CYsqcjnat3j+9TZYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVlL9y6spoDbUQbeqfwoml8Esl7npD20YlZM0kWQxJCgA3zh2OMEm1uqSvPc/vmzm
         VMRF8VxrdD/0e1IKLLbe8pEegiop5mQmNUFKF2AxsqUIlKnF6dao1QWD4mqhVGnStR
         xDzzLNGlP/a2qMf8rWWisRIXTUtxjEm5TkLsxO2w=
Date:   Mon, 29 Jun 2020 10:10:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: mtu3: disable USB2 LPM
Message-ID: <20200629081047.GB1221843@kroah.com>
References: <1593410434-19406-1-git-send-email-chunfeng.yun@mediatek.com>
 <af16d716-8bb3-ea1f-e410-b27443f74c31@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af16d716-8bb3-ea1f-e410-b27443f74c31@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 09:30:58AM +0200, Markus Elfring wrote:
> > A SuperSpeed device shall include the USB 2.0 extension descriptor
> > and shall support LPM when operating in USB 2.0 HS mode(see usb3.2
> > spec9.6.2.1). But we always don't support it, so disable it by
> > default, otherwise device will enter LPM suspend mode when
> > connected to Win10 system.
> 
> How do you think about a wording variant like the following?
> 
>    Change description:
>    A SuperSpeed device shall include the USB 2.0 extension descriptor
>    and shall support Link Power Management when operating in USB 2.0
>    High Speed mode. (See also: USB 3.2 specification 9.6.2.1)
>    But we do not support it generally. Thus disable this functionality
>    by default.
>    Otherwise, the device will enter LPM suspend mode when connected
>    to Win10 system.
> 
> 
> Would you like to add the tag “Fixes” to the commit message?
> 
> Regards,
> Markus

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
