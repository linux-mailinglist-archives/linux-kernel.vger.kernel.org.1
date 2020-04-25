Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8821B871C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgDYOkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 10:40:12 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:42826 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDYOkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 10:40:12 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 67C242007C;
        Sat, 25 Apr 2020 16:40:08 +0200 (CEST)
Date:   Sat, 25 Apr 2020 16:40:06 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com
Subject: Re: [PATCHv2 0/3] Add multiple AUO panels
Message-ID: <20200425144006.GB32235@ravnborg.org>
References: <20200415172725.84257-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415172725.84257-1-sebastian.reichel@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=e5mUnYsNAAAA:8 a=KIFCHchCShzuCEW-doMA:9
        a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian.

On Wed, Apr 15, 2020 at 07:27:22PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> Patches are more or less independent of each other. There
> was a previous version for the 12" and 15" panels, which
> was missing the DT binding update. The 19" patch is new,
> for the previous 10" panel a different patch has been merged
> in the meantime.
> 
> -- Sebastian
> 
> Sebastian Reichel (3):
>   drm/panel: simple: Add support for AUO G190EAN01 panel
>   drm/panel: simple: Add support for AUO G156XTN01.0 panel
>   drm/panel: simple: Add support for AUO G121EAN01.4 panel

Applied to drm-misc-next.

	Sam


> 
>  .../bindings/display/panel/panel-simple.yaml  |  6 ++
>  drivers/gpu/drm/panel/panel-simple.c          | 89 +++++++++++++++++++
>  2 files changed, 95 insertions(+)
> 
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
