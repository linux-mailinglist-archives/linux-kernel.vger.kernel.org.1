Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289602D80AB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 22:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgLKVMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 16:12:38 -0500
Received: from mail-oo1-f67.google.com ([209.85.161.67]:43785 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395157AbgLKVLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:11:48 -0500
Received: by mail-oo1-f67.google.com with SMTP id h10so2478094ooi.10;
        Fri, 11 Dec 2020 13:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4NTTHHr7mOEfXkNGuntp7FwEGD1KvufY8eCqfkNsfa0=;
        b=JJmGq2fE7wSiJfD/mY48V0vyBsxw1eQNsdYlJKgieJjQXAnloHIqWNsL8xTKQA+thN
         ivS3PVBR0iKCoH+AzOBDS0eKn4YtoLFcF18+gSFjXt661iSUgq3pEj/QGJPi6tuGq1nU
         PziQhMjtOGOh+mn7MbsHRsnzM6DzLW7lC6vuEwqEYhzTSfeWtHdzrjd1xaFH0sfnjLq6
         GkC4Z7gpRDHoXjst2/LCesLuoFAzn/6LTdkMqgBxbh9pMtAtPnNAZVt1J6xgVsiQMszJ
         nwL5ISTHTTyxH90L2dtqvQZPlgEsVhTzPijKN5Be4qShZjsnOLsXW3HgWiVRbUkoa/eU
         5GFQ==
X-Gm-Message-State: AOAM530FPiZLUbTpQ+WZz5EbsFDTgV/OD9FDhN9SmZQgnpr90CVZivfT
        Li5ekGhEMpAZn6wV+DsQ/5j15sGX+w==
X-Google-Smtp-Source: ABdhPJwphA/KS8Koyk+lG6TgLm2qa0Xhv6kCYJOy86qcVxZjNNgyYmG8jsym2vhi/WQbA/2+Hm/s0A==
X-Received: by 2002:a4a:6f01:: with SMTP id h1mr9883394ooc.88.1607721067665;
        Fri, 11 Dec 2020 13:11:07 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f201sm1888766oig.21.2020.12.11.13.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 13:11:06 -0800 (PST)
Received: (nullmailer pid 942618 invoked by uid 1000);
        Fri, 11 Dec 2020 21:11:05 -0000
Date:   Fri, 11 Dec 2020 15:11:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        agx@sigxcpu.org, vkoul@kernel.org, shawnguo@kernel.org,
        linux-imx@nxp.com, jonas@kwiboo.se, kishon@ti.com,
        martin.kepplinger@puri.sm, s.hauer@pengutronix.de,
        robert.chiras@nxp.com, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, narmstrong@baylibre.com,
        linux-arm-kernel@lists.infradead.org, airlied@linux.ie,
        a.hajda@samsung.com, jernej.skrabec@siol.net
Subject: Re: [PATCH v3 3/5] dt-bindings: phy: Convert mixel, mipi-dsi-phy to
 json-schema
Message-ID: <20201211211105.GA942315@robh.at.kernel.org>
References: <1607651182-12307-1-git-send-email-victor.liu@nxp.com>
 <1607651182-12307-4-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1607651182-12307-4-git-send-email-victor.liu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020 09:46:20 +0800, Liu Ying wrote:
> This patch converts the mixel,mipi-dsi-phy binding to
> DT schema format using json-schema.
> 
> Comparing to the plain text version, the new binding adds
> the 'assigned-clocks', 'assigned-clock-parents' and
> 'assigned-clock-rates' properites, otherwise 'make dtbs_check'
> would complain that there are mis-matches.  Also, the new
> binding requires the 'power-domains' property since all potential
> SoCs that embed this PHY would provide a power domain for it.
> The example of the new binding takes reference to the latest
> dphy node in imx8mq.dtsi.
> 
> Cc: Guido Günther <agx@sigxcpu.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v2->v3:
> * Improve the 'clock-names' property by dropping 'items:'.
> 
> v1->v2:
> * Newly introduced in v2.  (Guido)
> 
>  .../devicetree/bindings/phy/mixel,mipi-dsi-phy.txt | 29 ---------
>  .../bindings/phy/mixel,mipi-dsi-phy.yaml           | 72 ++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
