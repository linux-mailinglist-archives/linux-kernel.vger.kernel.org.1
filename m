Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617AD2024C4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 17:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgFTPaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 11:30:18 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:41224 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgFTPaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 11:30:16 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 7CF968053D;
        Sat, 20 Jun 2020 17:30:13 +0200 (CEST)
Date:   Sat, 20 Jun 2020 17:30:12 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 7/7] drm/panel-simple: Add missing connector type for
 some panels
Message-ID: <20200620153012.GA22743@ravnborg.org>
References: <20200617222703.17080-1-digetx@gmail.com>
 <20200617222703.17080-8-digetx@gmail.com>
 <20200620112132.GB16901@ravnborg.org>
 <20200620114934.GB5829@pendragon.ideasonboard.com>
 <ea421084-a91c-bc03-5997-1723075b7cae@gmail.com>
 <20200620143114.GA22329@ravnborg.org>
 <e77a34c1-3e0b-7f30-25d0-a955ec8d8c86@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e77a34c1-3e0b-7f30-25d0-a955ec8d8c86@gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=G88y7es5 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8
        a=I1XKC5YfttuoCrzH9m8A:9 a=QEXdDO2ut3YA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry
On Sat, Jun 20, 2020 at 06:05:37PM +0300, Dmitry Osipenko wrote:
> 20.06.2020 17:31, Sam Ravnborg пишет:
> > Hi Dmitry
> > 
> >>
> >> Oops! Good catch!
> > Yep, thanks Laurent. Should have taken a better look before applying.
> > 
> >> Indeed, I blindly set the LVDS type to all these
> >> panels. Please revert this patch, I'll double check each panel and
> >> prepare an updated version of this patch. Thank you very much for the
> >> review!
> > 
> > If you can prepare a fix within a few days then lets wait for that.
> > I will do a better review next time.
> 
> Hello Sam,
> 
> I should be able to make it later today or tomorrow. Could you please
> clarify what do you mean by the fix, do you what it to be as an
> additional patch on top of the applied one or a new version of the patch?
An additional patch on top of the one applied.
It shall carry a proper fixes: tag like this:

Fixes: 94f07917ebe8 ("drm/panel-simple: Add missing connector type for some panels")
Cc: Dmitry Osipenko <digetx@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org

	Sam
