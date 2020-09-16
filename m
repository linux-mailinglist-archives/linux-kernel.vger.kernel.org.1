Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6140826CA53
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgIPTzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbgIPRgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:36:19 -0400
Received: from localhost (unknown [122.172.186.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8966822248;
        Wed, 16 Sep 2020 12:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600260195;
        bh=0OLSmN/cIrNezA8tWwltWL9shByktai2WOMAvUtj3e4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1JxsTTh8Rs7QWngycnbg1Hd2Uk/I/iV/w6MHEkhyV7tetqTHFXeA4WNm5eX1Ybix
         17VmgnG8YRGUKmro1iUC07ULX0tCaXqav/yguD6W3Vbj+mdMapAp2iXjVhpiK0yr22
         rez4NtivWRXeDjd3zJ631FgmN5bFRdC9v0nvP4aU=
Date:   Wed, 16 Sep 2020 18:13:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sekhar Nori <nsekhar@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>, kishon@ti.com,
        linux-kernel@vger.kernel.org, maxime@cerno.tech,
        mparab@cadence.com, yamonkar@cadence.com, tomi.valkeinen@ti.com,
        jsarha@ti.com, praneeth@ti.com
Subject: Re: [PATCH v6 0/2] PHY: Add new PHY attribute max_link_rate
Message-ID: <20200916124307.GL2968@vkoul-mobl>
References: <1599805114-22063-1-git-send-email-sjakhade@cadence.com>
 <e1ae0a53-02a2-8a17-094f-570be6d24b1c@ti.com>
 <20200916121855.GB3853@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916121855.GB3853@pendragon.ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-09-20, 15:18, Laurent Pinchart wrote:
> Hi Sekhar,
> 
> On Wed, Sep 16, 2020 at 01:11:17PM +0530, Sekhar Nori wrote:
> > On 11/09/20 11:48 AM, Swapnil Jakhade wrote:
> > > This patch series adds a new PHY attribute max_link_rate.
> > > It also updates Cadence Torrent PHY driver to set attributes bus_width,
> > > max_link_rate and mode for DisplayPort.
> > > 
> > > It includes following patches:
> > > 
> > > 1. 0001-phy-Add-new-PHY-attribute-max_link_rate.patch
> > > This patch adds max_link_rate as a new PHY attribute.
> > > 
> > > 2. 0002-phy-cadence-torrent-Set-Torrent-PHY-attributes.patch
> > > This patch sets PHY attributes in Cadence Torrent PHY driver. This will
> > > enable drivers using this PHY to read these properties.
> > > 
> > > These attributes will be used in the Cadence MHDP DRM bridge driver [1]
> > > which is in the process of upstreaming.
> > 
> > Can you please add these patches on an immutable branch/tag when you are
> > ready to apply them - will try to see if we can use it to get the
> > DisplayPort driver merged in v5.10 too.
> > 
> > Hi Laurent, any other ideas on managing the dependency?
> 
> I think that will work fine.

Please pull tag phy-attrs-5.10 for phy tree

Thanks
-- 
~Vinod
