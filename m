Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DBB26CA7C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgIPUCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIPRfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A673C061352
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:34:50 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B5393276;
        Wed, 16 Sep 2020 19:34:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1600277683;
        bh=t7M3tGvqNlIhXkZYY0O0MtWpo6tFHQmpP/cN6Q1Ml1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UvKGA9/jRLaV5ca67FcsHC+bl90cCRL6/C2GX3oFcu7ohWUUtbgOh2oSp8NvyFYMx
         QmXC89z5C905Gk7EWKsGYe4vEVsCuUGZmLwhEyRNlzaaTbK0AsMhlh4FHGueYeiN/E
         22gaUz2q43gCqsCEtKxwXJCVk9L4WtOubgXlT3gM=
Date:   Wed, 16 Sep 2020 20:34:12 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>, kishon@ti.com,
        linux-kernel@vger.kernel.org, maxime@cerno.tech,
        mparab@cadence.com, yamonkar@cadence.com, tomi.valkeinen@ti.com,
        jsarha@ti.com, praneeth@ti.com
Subject: Re: [PATCH v6 0/2] PHY: Add new PHY attribute max_link_rate
Message-ID: <20200916173412.GI3853@pendragon.ideasonboard.com>
References: <1599805114-22063-1-git-send-email-sjakhade@cadence.com>
 <e1ae0a53-02a2-8a17-094f-570be6d24b1c@ti.com>
 <20200916121855.GB3853@pendragon.ideasonboard.com>
 <20200916124307.GL2968@vkoul-mobl>
 <d7d2f8b5-86a2-c2f9-62ff-cf60278a5463@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d7d2f8b5-86a2-c2f9-62ff-cf60278a5463@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 10:57:46PM +0530, Sekhar Nori wrote:
> On 16/09/20 6:13 PM, Vinod Koul wrote:
> > On 16-09-20, 15:18, Laurent Pinchart wrote:
> >> Hi Sekhar,
> >>
> >> On Wed, Sep 16, 2020 at 01:11:17PM +0530, Sekhar Nori wrote:
> >>> On 11/09/20 11:48 AM, Swapnil Jakhade wrote:
> >>>> This patch series adds a new PHY attribute max_link_rate.
> >>>> It also updates Cadence Torrent PHY driver to set attributes bus_width,
> >>>> max_link_rate and mode for DisplayPort.
> >>>>
> >>>> It includes following patches:
> >>>>
> >>>> 1. 0001-phy-Add-new-PHY-attribute-max_link_rate.patch
> >>>> This patch adds max_link_rate as a new PHY attribute.
> >>>>
> >>>> 2. 0002-phy-cadence-torrent-Set-Torrent-PHY-attributes.patch
> >>>> This patch sets PHY attributes in Cadence Torrent PHY driver. This will
> >>>> enable drivers using this PHY to read these properties.
> >>>>
> >>>> These attributes will be used in the Cadence MHDP DRM bridge driver [1]
> >>>> which is in the process of upstreaming.
> >>>
> >>> Can you please add these patches on an immutable branch/tag when you are
> >>> ready to apply them - will try to see if we can use it to get the
> >>> DisplayPort driver merged in v5.10 too.
> >>>
> >>> Hi Laurent, any other ideas on managing the dependency?
> >>
> >> I think that will work fine.
> > 
> > Please pull tag phy-attrs-5.10 for phy tree
> 
> Thanks Vinod!
> 
> Swapnil, please be sure to let DRM maintainers know about the PHY tree
> and the tag they can use when the DP patches are ready for merge.

This should be mentioned in the pull request, but as the branch
submitted for DRM/KMS has to be based on 

The simplest (and maybe only) option is to base the branch for the
DRM/KMS subsystem on Vinod's branch. It's however good to mention this
explicitly in the pull request, stating that the base branch is
scheduled for merge in v5.10 through the PHY tree.

> Please keep Vinod in the loop too so he is aware of the tag being pulled.

-- 
Regards,

Laurent Pinchart
