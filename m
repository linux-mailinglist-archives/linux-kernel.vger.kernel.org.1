Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62B31CC44D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 22:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgEIUA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 16:00:56 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:59988 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgEIUAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 16:00:55 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id B831B804C8;
        Sat,  9 May 2020 22:00:52 +0200 (CEST)
Date:   Sat, 9 May 2020 22:00:51 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>, robdclark@chromium.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: display: simple: Add BOE NV133FHM-N62
Message-ID: <20200509200051.GB30802@ravnborg.org>
References: <20200508155859.1.I4d29651c0837b4095fb4951253f44036a371732f@changeid>
 <20200508155859.2.I37c879ef4ec6d4028a3d45728bc3a58060bba175@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508155859.2.I37c879ef4ec6d4028a3d45728bc3a58060bba175@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=cm27Pg_UAAAA:8 a=KCbFThoRF98PNkAbFwoA:9
        a=CjuIK1q_8ugA:10 a=xmb-EsYY8bH0VWELuYED:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 03:59:01PM -0700, Douglas Anderson wrote:
> This panel appears to be the same or nearly the same as the BOE
> NV133FHM-N61, but since (in the very least) it identifies itself as a
> different model in the EDID we should add a new compatible string for
> it.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
Applied this and the next patch to drm-misc-next.

Thanks,
	Sam

> ---
> 
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index fdd74d07f645..d6cca1479633 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -75,6 +75,8 @@ properties:
>        - boe,nv101wxmn51
>          # BOE NV133FHM-N61 13.3" FHD (1920x1080) TFT LCD Panel
>        - boe,nv133fhm-n61
> +        # BOE NV133FHM-N62 13.3" FHD (1920x1080) TFT LCD Panel
> +      - boe,nv133fhm-n62
>          # BOE NV140FHM-N49 14.0" FHD a-Si FT panel
>        - boe,nv140fhmn49
>          # CDTech(H.K.) Electronics Limited 4.3" 480x272 color TFT-LCD panel
> -- 
> 2.26.2.645.ge9eca65c58-goog
