Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAB42DB139
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbgLOQVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:21:52 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39101 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbgLOQVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:21:37 -0500
Received: by mail-ot1-f66.google.com with SMTP id d8so19912844otq.6;
        Tue, 15 Dec 2020 08:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=34KtQrwQPQdUruOS7IGSVnCyYoZ5bhkan6tsIdf2DjA=;
        b=tKDCLNU6h4qvCun8w3j8aW5/52BqCN39WT6GBeKVPeNLqj//Gt0cAPNYFRw998Yd44
         ySINbP3VCMJdzHrch3pJhHnnFQX/eicnu/nCCZ2bQIWiQ1Xd0p0Uax4iNECIAURbkbiO
         iTIRT3SpRNox7Hyof98Rd51VgM35YC8+IC+oQALdz7dxsrJmI9sPXLnWgnlaDI/WLwTK
         Gv+OxlWNEB59Q6uK0WS+chpJ8xY144TVubtd+ANM3GhhYXdsqtKO7sz01A9JZMxQ3bi+
         e4hhiaICR0pOLlBN5zVdfywVFLcZk0aZ+M+L05bO/5ICIOchqcD96Kt3y2dHx9pG9pcY
         rscQ==
X-Gm-Message-State: AOAM5309xr8WdT+tMyfjscJ613k6moKCyZeoXwESsZwWKQg3VDKwQM0M
        suXAIhJ/Y9f9S9tnwn7nUg==
X-Google-Smtp-Source: ABdhPJyfBYjhmmyDBWsWA9jqIzDpzF3wFmtV6wV/5vM6bJ5lRmDO0ZaiwF6fL3eFbbxqacgg+LoBPw==
X-Received: by 2002:a9d:2941:: with SMTP id d59mr16101017otb.232.1608049256919;
        Tue, 15 Dec 2020 08:20:56 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i24sm4783779oot.42.2020.12.15.08.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 08:20:56 -0800 (PST)
Received: (nullmailer pid 3962283 invoked by uid 1000);
        Tue, 15 Dec 2020 16:20:55 -0000
Date:   Tue, 15 Dec 2020 10:20:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2, 01/17] dt-bindings: mediatek: add description for
 postmask
Message-ID: <20201215162055.GA3958446@robh.at.kernel.org>
References: <1607746317-4696-1-git-send-email-yongqiang.niu@mediatek.com>
 <1607746317-4696-2-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607746317-4696-2-git-send-email-yongqiang.niu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 12, 2020 at 12:11:41PM +0800, Yongqiang Niu wrote:
> add description for postmask
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> index 5ca693a..1972fa7 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> @@ -37,6 +37,7 @@ Required properties (all function blocks):
>  	"mediatek,<chip>-disp-aal"   		- adaptive ambient light controller
>  	"mediatek,<chip>-disp-gamma" 		- gamma correction
>  	"mediatek,<chip>-disp-merge" 		- merge streams from two RDMA sources
> +	"mediatek,<chip>-disp-postmask" 	- post mask

Needs a better explanation. What's the type? Constraints on the values?

>  	"mediatek,<chip>-disp-split" 		- split stream to two encoders
>  	"mediatek,<chip>-disp-ufoe"  		- data compression engine
>  	"mediatek,<chip>-dsi"        		- DSI controller, see mediatek,dsi.txt
> -- 
> 1.8.1.1.dirty
> 
