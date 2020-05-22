Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E15F1DE1F7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 10:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgEVIgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 04:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729151AbgEVIgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 04:36:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7037920757;
        Fri, 22 May 2020 08:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590136572;
        bh=FqENk5ZzEkCXawXIxN8/HBdH/uo1MtiY6c7jGr0Hg/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CSN1DXVFDL1wKH6FB8gQZOzEqatDonKzsoQGa8082skOWNlJPit9K69cpygjZUy2/
         wycOrVeRYZ1YrGYW9/ZXGMYpzb2CURDIZGAIzTdXF6t1NRJOtNbm4xKn6pJuQp2XaZ
         JJq5KkuSzwVCPYna8W9aUp7iF8mYFnqXGsaZdXsE=
Date:   Fri, 22 May 2020 10:36:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [GIT PULL] PHY: For 5.8
Message-ID: <20200522083609.GC1078778@kroah.com>
References: <20200521150209.6521-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521150209.6521-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 08:32:09PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the pull request for 5.8 merge window below.
> 
> It adds four new PHY drivers for the various Cadence, Intel and
> Qualcomm's PHYs. It adds support for Qualcomm's SM8250 UFS PHY
> and SM8150 QMP USB3 PHY, Amlogic's USB2 PHY on Meson8m2 in existing
> PHY drivers.
> 
> It also adds fixes to get USB working reliably in the various Broadcom,
> Samsung, Amlogic and Cadence PHYs and converts bunch of device tree
> binding documents to schema YAML format.
> 
> Please see the tag message below for the detailed list of changes and
> let me know if I have to change something.
> 
> Thanks
> Kishon
> 
> The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:
> 
>   Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.8

Pulled and pushed out, thanks.

greg k-h
