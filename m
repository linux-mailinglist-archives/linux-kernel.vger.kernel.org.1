Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E424726C990
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgIPTNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727313AbgIPRka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:40:30 -0400
Received: from localhost (unknown [122.172.186.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAD5622209;
        Wed, 16 Sep 2020 12:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600258141;
        bh=/PEHb0bQ0hzOiam0x0I97ptl06cw+UgKXjvJHrGwcYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yEcEjb8IC0CCZ6yqWkNX+XpPZz8UINg3ejRTW7ycSGwrsaP8uswlXCdupdiNhox1R
         7diKZG76HtPSM8sc4CY1TrI7CODs+fe1+sKdpULCVIG8T/GVbKbS+nTnXGaWcHBKtC
         n2rYAnOXLpd3bngDaqvvq3YUPY1+yQPQhPbwWckI=
Date:   Wed, 16 Sep 2020 17:38:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org, maxime@cerno.tech,
        Laurent.pinchart@ideasonboard.com, mparab@cadence.com,
        yamonkar@cadence.com, nsekhar@ti.com, tomi.valkeinen@ti.com,
        jsarha@ti.com, praneeth@ti.com
Subject: Re: [PATCH v6 0/2] PHY: Add new PHY attribute max_link_rate
Message-ID: <20200916120854.GF2968@vkoul-mobl>
References: <1599805114-22063-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599805114-22063-1-git-send-email-sjakhade@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-09-20, 08:18, Swapnil Jakhade wrote:
> This patch series adds a new PHY attribute max_link_rate.
> It also updates Cadence Torrent PHY driver to set attributes bus_width,
> max_link_rate and mode for DisplayPort.
> 
> It includes following patches:
> 
> 1. 0001-phy-Add-new-PHY-attribute-max_link_rate.patch
> This patch adds max_link_rate as a new PHY attribute.
> 
> 2. 0002-phy-cadence-torrent-Set-Torrent-PHY-attributes.patch
> This patch sets PHY attributes in Cadence Torrent PHY driver. This will
> enable drivers using this PHY to read these properties.
> 
> These attributes will be used in the Cadence MHDP DRM bridge driver [1]
> which is in the process of upstreaming.

Applied, thanks

-- 
~Vinod
