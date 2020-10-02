Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA938281180
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 13:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbgJBLrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 07:47:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBLrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:47:39 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97784206FA;
        Fri,  2 Oct 2020 11:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601639259;
        bh=NrQ9Yu2LhbzI6Hx8V61GyJlb2S/rArXqQ0XTIXvBD/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q75hmoh6fqiCpOiFjAAlbeZMdWg7T72dfHzJAgg0CgBlv7qXEUD7Nj0FTI3bYyUzm
         lowXIQ6e6qOFWBujVGu9Z8wiiTspF3kym+5GhMDlUGD9F2Tdj985GRXlaLWZEc7yE3
         Bc0fiTtU3php66szFIoEXx3jVRHtNcnOZyeUomRI=
Date:   Fri, 2 Oct 2020 13:46:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: Generic PHY updates for v5.10
Message-ID: <20201002114609.GA3314512@kroah.com>
References: <20201002095412.GZ2968@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002095412.GZ2968@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 03:24:12PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive updates for Generic phy susbsystem. Bunch of new
> drivers and device support and a new core API this time.
> 
> The following changes since commit ad7a7acaedcf45071c822b6c983f9c1e084041c9:
> 
>   phy: omap-usb2-phy: disable PHY charger detect (2020-08-31 14:30:59 +0530)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.10

Pulled and pushed out, thanks.

greg k-h
