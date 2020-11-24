Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9ACE2C2F17
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403951AbgKXRpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:45:41 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:51120 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390713AbgKXRpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:45:41 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 0EBBF80636;
        Tue, 24 Nov 2020 18:45:36 +0100 (CET)
Date:   Tue, 24 Nov 2020 18:45:35 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     "Lukas F. Hartmann" <lukas@mntre.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: display/panel: add Innolux N125HCE-GN1
Message-ID: <20201124174535.GA57448@ravnborg.org>
References: <20201124172604.981746-1-lukas@mntre.com>
 <20201124172604.981746-2-lukas@mntre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124172604.981746-2-lukas@mntre.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=Xw0AzbREAAAA:8 a=FZtKqjOaVaul58dK6XgA:9
        a=CjuIK1q_8ugA:10 a=8ntjimWYsTyQni2bnFcl:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas

On Tue, Nov 24, 2020 at 06:26:06PM +0100, Lukas F. Hartmann wrote:
> The Innolux N125HCE-GN1 display is used in the MNT Reform 2.0 laptop,
> attached via eDP to a SN65DSI86 MIPI-DSI to eDP bridge. This patch
> contains the DT binding for "innolux,n125hce-gn1".
> 
> Signed-off-by: Lukas F. Hartmann <lukas@mntre.com>

bindings before their usage, so this should be first patch.

> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index edb53ab0d..03b3e0b9d 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -160,6 +160,8 @@ properties:
>          # Innolux Corporation 11.6" WXGA (1366x768) TFT LCD panel
>        - innolux,n116bge
>          # InnoLux 15.6" WXGA TFT LCD panel
> +      - innolux,n125hce-gn1
> +        # InnoLux 13.3" FHD (1920x1080) eDP TFT LCD panel

Comments before the compatible.

I applied this first and reordered the comment - so both details are
handled.

Applied to drm-misc-next.

	Sam
