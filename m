Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538CE26B2B9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbgIOWwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:52:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39244 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgIOPmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:42:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id d13so2186938pgl.6;
        Tue, 15 Sep 2020 08:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1fyZNgMatRtDRm5F6K1pH9IP38hhZV0WXalrPxYTXEE=;
        b=gRH5GNj4jis9UwagTheFb7FS9mBgVZvQG5S7DlMdrl31EGyorrn5zRvtRsCUgE9uFX
         WnB21tzeP721uhtVrTyy7MJsFg5n3pZi6ZoE6CxOlPkX9rznkVPc9AyVZP88JQiuIvsp
         /XU3al9FKzUwe9B9YshGaI+7CTSgIACJ5Ky5Z1f9JcZQCKn5eNCX7DQUHutVz6U/9F66
         tXb7h+QJvrKdo5b8RggIud9mIdbOORX60KsygWaJL/wcGTdMUnQAE8KcMzD71aCbLtTE
         RQn+UtIJFknY1CAvFfWMlksTii9eHOpuMYBfJ5RAHSvTsIj7EWdk4DnfLfz2q7feMep0
         r0OA==
X-Gm-Message-State: AOAM530Zt/91J8F4s4RuoSDczaAzkGLf2SWriE8pQdKPCTvCOu6icjCI
        Nt9bRSED4Jc72zwMJ1rTOx8o66f1MR1udZw=
X-Google-Smtp-Source: ABdhPJxblB60qGKbpa/uRK4I1ZRiB+vOa9NARrpUQLiQeXrWQ1UDd3ksQ1EdqPx06vtV1foov4egLg==
X-Received: by 2002:a92:8509:: with SMTP id f9mr14662065ilh.253.1600184054677;
        Tue, 15 Sep 2020 08:34:14 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m87sm9266352ilb.58.2020.09.15.08.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 08:34:13 -0700 (PDT)
Received: (nullmailer pid 1988443 invoked by uid 1000);
        Tue, 15 Sep 2020 15:34:13 -0000
Date:   Tue, 15 Sep 2020 09:34:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel@ffwll.ch, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: display: amlogic,meson-vpu: add
 bindings for VPU found in AXG SoCs
Message-ID: <20200915153413.GA1982161@bogus>
References: <20200907081825.1654-1-narmstrong@baylibre.com>
 <20200907081825.1654-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907081825.1654-2-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 10:18:20AM +0200, Neil Armstrong wrote:
> The Amlogic AXG SoC family has a downgraded VPU supporting only MIPI-DSI output
> after it's ENCL DPI encoder output.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/display/amlogic,meson-vpu.yaml   | 36 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
> index a8d202c9d004..e2e7d99d8ace 100644
> --- a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
> +++ b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
> @@ -31,8 +31,10 @@ description: |
>  
>    The Video Input Unit is in charge of the pixel scanout from the DDR memory.
>    It fetches the frames addresses, stride and parameters from the "Canvas" memory.
> +  On the AXG family, the Video Input Unit direclty reads from DDR memory.
>    This part is also in charge of the CSC (Colorspace Conversion).
>    It can handle 2 OSD Planes and 2 Video Planes.
> +  On the AXG family, only a single OSD plane without scalins is supported.

s/scalins/scaling/ ?

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
