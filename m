Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436EC26C560
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 18:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgIPQx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 12:53:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgIPQd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:33:28 -0400
Received: from localhost (unknown [122.172.186.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03EF92220B;
        Wed, 16 Sep 2020 12:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600258197;
        bh=EhSHOvvv8rPn7msIksiUHxGQ+dV6J/L8T9JL7uE0RgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UTiVn3crViX3uJwzOyegZqlx89cwq+dQkNQ2ieGlGsMdDxnJnJO/QogEnLLNPMEfR
         3LUr+wbdUIS1NKC1fap+OdVbzbKq7x/GiYBgfZvwwovADD6dN2BV/mjZmc5CFSP0bw
         fS//glOkrDAs/Yajz04+WzBRFphwSFk5/uIUTI2g=
Date:   Wed, 16 Sep 2020 17:39:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Swapnil Jakhade <sjakhade@cadence.com>, kishon@ti.com,
        linux-kernel@vger.kernel.org, maxime@cerno.tech,
        Laurent.pinchart@ideasonboard.com, mparab@cadence.com,
        yamonkar@cadence.com, tomi.valkeinen@ti.com, jsarha@ti.com,
        praneeth@ti.com
Subject: Re: [PATCH v6 0/2] PHY: Add new PHY attribute max_link_rate
Message-ID: <20200916120948.GG2968@vkoul-mobl>
References: <1599805114-22063-1-git-send-email-sjakhade@cadence.com>
 <e1ae0a53-02a2-8a17-094f-570be6d24b1c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1ae0a53-02a2-8a17-094f-570be6d24b1c@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sekhar,

On 16-09-20, 13:11, Sekhar Nori wrote:
> Hi Vinod,
> 
> On 11/09/20 11:48 AM, Swapnil Jakhade wrote:
> > This patch series adds a new PHY attribute max_link_rate.
> > It also updates Cadence Torrent PHY driver to set attributes bus_width,
> > max_link_rate and mode for DisplayPort.
> > 
> > It includes following patches:
> > 
> > 1. 0001-phy-Add-new-PHY-attribute-max_link_rate.patch
> > This patch adds max_link_rate as a new PHY attribute.
> > 
> > 2. 0002-phy-cadence-torrent-Set-Torrent-PHY-attributes.patch
> > This patch sets PHY attributes in Cadence Torrent PHY driver. This will
> > enable drivers using this PHY to read these properties.
> > 
> > These attributes will be used in the Cadence MHDP DRM bridge driver [1]
> > which is in the process of upstreaming.
> 
> Can you please add these patches on an immutable branch/tag when you are
> ready to apply them - will try to see if we can use it to get the
> DisplayPort driver merged in v5.10 too.

I have pushed in into topic/phy_attrs, please let me know if you need a
tag for this

> 
> Hi Laurent, any other ideas on managing the dependency?
> 
> Thanks,
> Sekhar

-- 
~Vinod
