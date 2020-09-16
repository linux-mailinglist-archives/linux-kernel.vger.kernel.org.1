Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC8626C680
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 19:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgIPRwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:52:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgIPRvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:51:41 -0400
Received: from localhost (unknown [122.172.186.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 587E32067C;
        Wed, 16 Sep 2020 12:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600258547;
        bh=ECAYDYD9YCjnGXghzujnDIjHjbKH5ZHvmBhc5JHRaR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3jFPjFo6CSiLiSNGR5qqdvilZvUQsdbIg08C+uXVx/kkOFOcI+A+7bw0bj9w5Fsz
         dGDGarhJWLCHcrDcWPOG7y9ytVg8xF6SJ6yOLVupOK/f77+NicTWWTeUMNCZEbiogy
         uOi2T80Y8KeeobhjeP0oBsojfkn1uCWJwz84rnM8=
Date:   Wed, 16 Sep 2020 17:45:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        eswara.kota@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v9 0/3] phy: intel: Add Keem Bay eMMC PHY support
Message-ID: <20200916121538.GJ2968@vkoul-mobl>
References: <20200913235522.4316-1-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913235522.4316-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-09-20, 07:55, Wan Ahmad Zainie wrote:
> Hi.
> 
> The first patch is added to rename rename
> phy-intel-{combo,emmc}.c to phy-intel-lgm-{combo,emmc}.c.
> 
> The second patch is to document DT bindings for Keem Bay eMMC PHY.
> 
> The the third is the driver file, loosely based on phy-rockchip-emmc.c
> and phy-intel-emmc.c. The latter is not being reused as there are
> quite a number of differences i.e. registers offset, supported clock
> rates, bitfield to set.
> 
> The patch was tested with Keem Bay evaluation module board.

Applied all, thanks

-- 
~Vinod
