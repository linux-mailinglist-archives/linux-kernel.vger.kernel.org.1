Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACE02C810F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgK3JbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:31:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgK3JbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:31:08 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6A122076E;
        Mon, 30 Nov 2020 09:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606728625;
        bh=OPTZZoFbOuM/K/lSXF9disfU6si2jVW+WQde1KUIGoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ed/aBH0s8uK2fUHb7qJDigmHnICrHXVdp5WXXrk+1cXCXXdEINonbLWFwf4mk0pfg
         UsX1xesaT2tr4LDEYdJMbogI2SHGTnDh+9pMTYEXQ+7ukg6l+Ay/vWx5nsLuA5Cn+F
         uWy1pMVvi4wZyvNeCiOj7uPNjE3a6Bi0WCEAW8bc=
Date:   Mon, 30 Nov 2020 17:30:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: freescale: sl28: combine SPI MTD partitions
Message-ID: <20201130093020.GD4072@dragon>
References: <20201115225435.8529-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115225435.8529-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 11:54:35PM +0100, Michael Walle wrote:
> The upstream port, doesn't really follow the vendor partitioning. The
> bootloader partition has one U-Boot FIT image containing all needed
> bits and pieces. Even today the bootloader is already larger than the
> current "bootloader" partition. Thus, fold all the partitions into one
> and keep the environment one. The latter is still valid.
> We keep the failsafe partitions because the first half of the SPI flash
> is preinstalled by the vendor and immutable.
> 
> Fixes: 815364d0424e ("arm64: dts: freescale: add Kontron sl28 support")
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks.
