Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8982637A2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 22:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgIIUno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 16:43:44 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43918 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgIIUnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 16:43:43 -0400
Received: by mail-il1-f195.google.com with SMTP id m1so3628290ilj.10;
        Wed, 09 Sep 2020 13:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BvEuTgm2IZoHBm+jPm4TdnWSuIpSZHMUsLkTxZ2He2I=;
        b=p6in/OdRq2CW+XnLtNM9L/rEUzizgQIjYzMeqWAXiyhMiC3VyOUbMA8ZBqamSGkC5S
         pxsAqxZg7ORAPOnfVU/A+Wp/FCx5sHP10UzMl/8sk9oudHQE0NLVGoclq1WF7EZF9NZg
         yylHqumeVUtQ/fuGL02fc+7xmcEZMR0eVZpWxF1xKpeqmEmx2NzTvsJ31F339ydvM+1Y
         QWk/avNtWkh2RXknHfxWzrxgWHYkin/t5K8PgK7UAU3wi5SVZe9nVSQZ0joBwbW0FD6c
         DpsGt0TEbC/xUQTkF7Yp/a8g3oBAesfqoY5JGksiq8IigrP6iOlxb6AsSal8Xx4OacuF
         7Ylw==
X-Gm-Message-State: AOAM532iUPGSQiLY26DEekDZM7D9ttIVQltFgimU7iJz5LtuKKPUujl3
        3Fe9AnjlOl9WTtVG68wwOQ==
X-Google-Smtp-Source: ABdhPJy4rTKJaPZ/jWpOVJ4cgZzmcFL0VsJJo+wB8OY1va7sQv3j1LxWb/8BcCQh8lOkrHj8o37atg==
X-Received: by 2002:a05:6e02:685:: with SMTP id o5mr5246688ils.72.1599684221973;
        Wed, 09 Sep 2020 13:43:41 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id a21sm1677462ioh.12.2020.09.09.13.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 13:43:41 -0700 (PDT)
Received: (nullmailer pid 3044856 invoked by uid 1000);
        Wed, 09 Sep 2020 20:43:31 -0000
Date:   Wed, 9 Sep 2020 14:43:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Robert Chiras (OSS)" <robert.chiras@oss.nxp.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Fabio Estevam <festevam@gmail.com>,
        Ondrej Jirman <megous@megous.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH 4/5] dt-bindings: display/bridge: nwl-dsi: Document
 fsl,clock-drop-level property
Message-ID: <20200909204331.GA3043802@bogus>
References: <1598613212-1113-1-git-send-email-robert.chiras@oss.nxp.com>
 <1598613212-1113-5-git-send-email-robert.chiras@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598613212-1113-5-git-send-email-robert.chiras@oss.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 02:13:31PM +0300, Robert Chiras (OSS) wrote:
> From: Robert Chiras <robert.chiras@nxp.com>
> 
> Add documentation for a new property: 'fsl,clock-drop-level'.
> 
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> ---
>  Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> index 8b5741b..b415f4e 100644
> --- a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> @@ -143,6 +143,10 @@ properties:
>  
>      additionalProperties: false
>  
> +  clock-drop-level:

fsl, ?

> +    description:
> +      Specifies the level at wich the crtc_clock should be dropped

Needs a type $ref.

> +
>  patternProperties:
>    "^panel@[0-9]+$":
>      type: object
> -- 
> 2.7.4
> 
