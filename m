Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D0C2D433A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbgLIN2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:28:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732357AbgLIN2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:28:03 -0500
Date:   Wed, 9 Dec 2020 14:28:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607520442;
        bh=zy8BwFvU9UE8vHUDRCQXDyem8YkIQ5O1H5q68AAAFfY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=fK2XxPocazqNsOuSdEPaSHERylfk8bC7FAOUPLQDuEbvlH6iU/AaL0Uj5O46D5Tmt
         NX4GxBZ9cMulTz6766IaPQxSi8C+E6xtt0qRx/cRigFJ9yBXiAzyBJbX1DzF5DjG6W
         2XIVfkWk/tYPd3CJC57YSNXbe5CkqZlH5UMZ5KUo=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [GIT PULL]: Generic phy updates for v5.11
Message-ID: <X9DRB9bHUvb0UV7u@kroah.com>
References: <20201209125657.GJ8403@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209125657.GJ8403@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 06:26:57PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Here is the pull request for phy susbsystem. All the changes are already
> in linux-next, sorry for delayed request this time.
> 
> The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:
> 
>   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.11

Note I do have the following error when sending out emails for this:

Commit: 4ea0bf2a52f1 ("phy: tegra: xusb: Fix usb_phy device driver field")
	Fixes tag: Fixes: e8f7d2f409a1 ("phy: tegra: xusb: Add usb-phy support")
	Has these problem(s):
	        - empty lines surround the Fixes tag

Try to watch out for that in the future.

thanks,

greg k-h
