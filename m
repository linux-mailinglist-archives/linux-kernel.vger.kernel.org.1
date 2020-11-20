Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279482BAEF2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgKTP3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:29:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgKTP3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:29:12 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D3AE22252;
        Fri, 20 Nov 2020 15:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605886150;
        bh=C1UlPa/GYyfam2rrHlRsRravwU1KFSGi7/88ciV6lwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QC+BDgbu+g+zV7miu1cRvAZotfIAEo/Dqi+fSA5JaJZby7mDDKXkeJrNmuBZPtuL+
         4fHBykz97M8oxxFlbtlmrLXyO3lS3/GQtzmSkcAlfrV2YAkbGsE6ewuaNqyqOooJqc
         t9vQyidLmsST2+bK/jWHMnQdedvfSTP5eaEEpaU0=
Date:   Fri, 20 Nov 2020 16:29:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [GIT PULL]: Generic phy fixes for 5.10
Message-ID: <X7fg5DW5agFfkqWk@kroah.com>
References: <20201120145136.GK2925@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120145136.GK2925@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 08:21:36PM +0530, Vinod Koul wrote:
> Hello Greg
> 
> Please consider PULL to recive fixes for 5.10 for Generic phy.
> All minor fixes to drivers, already in linux-next
> 
> The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:
> 
>   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-5.10
> 
> for you to fetch changes up to fb89b2544b645527b3a359176999a416e65f5ada:
> 
>   phy: mediatek: fix spelling mistake in Kconfig "veriosn" -> "version" (2020-11-16 13:21:28 +0530)
> 
> ----------------------------------------------------------------
> phy: fixes for 5.10
> 
> Bunch of fixes for phy drivers:
> *) USB phy incorrect clearing of bits
> *) Tegra xusb dangling pointer
> *) qcom-qmp null ptr initialization
> *) cpcap-usb irq flags
> *) intel kkembay kconfig depends
> *) qualcomm OF dependency
> *) mediatek typo

pulled and pushed out, thanks.

greg k-h
