Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9294202924
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 08:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgFUGg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 02:36:29 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:49902 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbgFUGg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 02:36:28 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 49AA820021;
        Sun, 21 Jun 2020 08:36:26 +0200 (CEST)
Date:   Sun, 21 Jun 2020 08:36:24 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RESEND v2 0/4] panel-simple: CDTech S070PWS19HP-FC21 and
 S070SWV29HG-DC44, Tianma TM070JVHG33
Message-ID: <20200621063624.GF74146@ravnborg.org>
References: <20200612072219.13669-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612072219.13669-1-matthias.schiffer@ew.tq-group.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=edQTgYMH c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=8f9FM25-AAAA:8 a=e5mUnYsNAAAA:8
        a=kXfxDWqNk04gDUbaWmUA:9 a=CjuIK1q_8ugA:10 a=uSNRK0Bqq4PXrUp6LDpb:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias

On Fri, Jun 12, 2020 at 09:22:15AM +0200, Matthias Schiffer wrote:
> From: Matthias Schiffer <matthias.schiffer@tq-group.com>
> 
> This adds a few panels TQ-Systems uses with various starterkit
> mainboards. Device trees actually using these panels will be added with
> a later submission.
> 
> 
> Matthias Schiffer (2):
>   dt-bindings: display: simple: add CDTech S070PWS19HP-FC21 and
>     S070SWV29HG-DC44
>   dt-bindings: display: simple: add Tianma TM070JVHG33
> 
> Max Merchel (1):
>   drm/panel: simple: add Tianma TM070JVHG33
> 
> Michael Krummsdorf (1):
>   drm/panel: simple: add CDTech S070PWS19HP-FC21 and S070SWV29HG-DC44

Thanks, all applied to drm-misc-next.

	Sam

> 
>  .../bindings/display/panel/panel-simple.yaml  |  6 ++
>  drivers/gpu/drm/panel/panel-simple.c          | 75 +++++++++++++++++++
>  2 files changed, 81 insertions(+)
> 
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
