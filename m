Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E08122AA97
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 10:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgGWI1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 04:27:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgGWI1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:27:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21CB420768;
        Thu, 23 Jul 2020 08:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595492826;
        bh=gszaEQS10t6JkQ0Jsx7tJbVQwQCESSJWDC2XvNsVy2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a1HHGDoA2IzuKghSG8cRZwymzGHfSeQlMoWlIG43Fzyg73uBt5s+PzgMigiw12tqA
         NRmj9fuyhK83+SqdkMjJuUWlCwdFDpDjSDEL5dH1OsC3CrxwC1nvzoswFpMIQGcWy/
         LVbzh09uNY0BIsLSOJ15kr/hqRvBrvZfuBkmiyys=
Date:   Thu, 23 Jul 2020 10:26:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] phy updates for 5.9-rc1
Message-ID: <20200723082625.GA1503700@kroah.com>
References: <20200723072455.GW12965@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723072455.GW12965@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 12:54:55PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Here are the updates for phy subsystem for 5.9. Please pull.
> 
> The following changes since commit 38b1927e5bf9bcad4a2e33189ef1c5569f9599ba:
> 
>   phy: sun4i-usb: fix dereference of pointer phy0 before it is null checked (2020-06-25 18:25:37 +0530)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.9

Pulled and pushed out, thanks.

greg k-h
