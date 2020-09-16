Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4838626CA24
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgIPTsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbgIPRiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:38:08 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA02DC0A3BFF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:24:37 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 574A957F;
        Wed, 16 Sep 2020 14:19:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1600258765;
        bh=ev/yS5qTUd4vkPy46pXJDOJvEKIMIslJGb4EFf8b61M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WjVgTzt4omvWQ55FO48Q0XKLbWKzm07gAJShKeALLRGJ8EJmoXRLV2R4c4mgZ/Za3
         mmY9ZuzAFayV3tpy742HL4J2SprCc7i0WdMP+H2hSxeRPq6VdUGKHnRxaGn946VkFI
         4zYu1kHBMimw6Z/GgFJ1gE66y+JmLzahhoYkNcvY=
Date:   Wed, 16 Sep 2020 15:18:55 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Swapnil Jakhade <sjakhade@cadence.com>, vkoul@kernel.org,
        kishon@ti.com, linux-kernel@vger.kernel.org, maxime@cerno.tech,
        mparab@cadence.com, yamonkar@cadence.com, tomi.valkeinen@ti.com,
        jsarha@ti.com, praneeth@ti.com
Subject: Re: [PATCH v6 0/2] PHY: Add new PHY attribute max_link_rate
Message-ID: <20200916121855.GB3853@pendragon.ideasonboard.com>
References: <1599805114-22063-1-git-send-email-sjakhade@cadence.com>
 <e1ae0a53-02a2-8a17-094f-570be6d24b1c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1ae0a53-02a2-8a17-094f-570be6d24b1c@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sekhar,

On Wed, Sep 16, 2020 at 01:11:17PM +0530, Sekhar Nori wrote:
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
> 
> Hi Laurent, any other ideas on managing the dependency?

I think that will work fine.

-- 
Regards,

Laurent Pinchart
