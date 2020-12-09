Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA322D469C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 17:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbgLIQTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 11:19:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730122AbgLIQTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:19:49 -0500
Date:   Wed, 9 Dec 2020 21:49:04 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607530748;
        bh=UiXw9GG/DxEw7106Ul5j+DKt0C+sVjoN2mmwscIn3M4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=qNmXn9vqgwyd7EBbR3MWxpNvfbeLCADe5ocMmuLy3CZKkKiJmx+PbMTmt+Jqg+pXG
         1dCWrPdDGsNSt5ai85SKlbGJhMNuTK1RMGt/V1k0Hv3wbde7TljnYSpURbtGbjDoVV
         n7pAaKEsRKuRiIyoUuHNUj97U07YZv32zos5p+qxAUbf7Dp3XUts0Rbgasy88jK47l
         gksEfM8mxjrwP/Zm1khRhOpQkOm8O81OpqEZ0KzS6CT73NeSMlLPVTRfYYwedAmRO4
         6eZrZKKbSg/XETd9nB38bVxAYmumWsUIFVu+1XBkLrkWRa/kmWA5/oMXQnyNsT76Jb
         Ro42h4kenOQfA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [GIT PULL]: Generic phy updates for v5.11
Message-ID: <20201209161904.GL8403@vkoul-mobl>
References: <20201209125657.GJ8403@vkoul-mobl>
 <X9DRB9bHUvb0UV7u@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9DRB9bHUvb0UV7u@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-12-20, 14:28, Greg KH wrote:
> On Wed, Dec 09, 2020 at 06:26:57PM +0530, Vinod Koul wrote:
> > Hello Greg,
> > 
> > Here is the pull request for phy susbsystem. All the changes are already
> > in linux-next, sorry for delayed request this time.
> > 
> > The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:
> > 
> >   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.11
> 
> Note I do have the following error when sending out emails for this:
> 
> Commit: 4ea0bf2a52f1 ("phy: tegra: xusb: Fix usb_phy device driver field")
> 	Fixes tag: Fixes: e8f7d2f409a1 ("phy: tegra: xusb: Add usb-phy support")
> 	Has these problem(s):
> 	        - empty lines surround the Fixes tag
> 
> Try to watch out for that in the future.

Thanks I do and manually fix up and checkpatch also complains so my
apply script should have let me know, not sure how this got missed.

Apologies for this
-- 
~Vinod
