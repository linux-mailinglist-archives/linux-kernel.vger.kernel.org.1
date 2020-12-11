Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B662D6E78
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405187AbgLKDTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:19:50 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36008 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405175AbgLKDTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:19:20 -0500
Received: by mail-ot1-f65.google.com with SMTP id y24so7043469otk.3;
        Thu, 10 Dec 2020 19:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CBoDlLHyHdiFhpGceXWDywNOt0L2TnBD6qDw3c+HJVM=;
        b=WgGyjBUcg4aGLkqYSFF6hVW3qF0uhg8u13qbKg1l7vgMYUOy3D9/lFNygAKgjW9/PW
         SB/yIFWJe07sy8Pbm9ovIC8qBv0SbBarrZ1+7R3hEXvnPBwP7+eEfcu2eAcsB5q1LOfu
         DJWVVZxXiawZscbGbIl1QBhbeK1gOPxXQEOI3lB7xRawRXoDil33YT+ax/dvCc/HsABH
         kbSzdFX4rZHhPXLmHnXkoIRCD0ozsG/fXXw9ywwk92tn8OVZrAIGYGHvNRcMq9g2SgJb
         9EsmSblqJE8+RkykjoclRu0UfRKnLOTn+rLxhHVnpBRatzNkBML5XZt9EqNOvZj4eNF6
         vpGw==
X-Gm-Message-State: AOAM531HBWPPK0XgWXHj5NgBTzDt3LnrDwI84jssCN77uZH1hIS+8plh
        MwhCdNaLYcN9DQiFpWkZYg==
X-Google-Smtp-Source: ABdhPJxTY09tIRosDM+jXE0CdMnaUgz5xWfvD40+3lqxBp9FHxQSOSy8st8000534RB+y/79qDojQg==
X-Received: by 2002:a05:6830:13d2:: with SMTP id e18mr3846932otq.366.1607656719303;
        Thu, 10 Dec 2020 19:18:39 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 66sm1585851ooj.0.2020.12.10.19.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:18:38 -0800 (PST)
Received: (nullmailer pid 3564301 invoked by uid 1000);
        Fri, 11 Dec 2020 03:18:37 -0000
Date:   Thu, 10 Dec 2020 21:18:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     jernej.skrabec@siol.net, robh+dt@kernel.org, robert.chiras@nxp.com,
        linux-imx@nxp.com, shawnguo@kernel.org, narmstrong@baylibre.com,
        martin.kepplinger@puri.sm, linux-arm-kernel@lists.infradead.org,
        a.hajda@samsung.com, kishon@ti.com,
        Laurent.pinchart@ideasonboard.com, kernel@pengutronix.de,
        vkoul@kernel.org, dri-devel@lists.freedesktop.org, agx@sigxcpu.org,
        airlied@linux.ie, jonas@kwiboo.se, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: phy: Convert mixel, mipi-dsi-phy to
 json-schema
Message-ID: <20201211031837.GA3564257@robh.at.kernel.org>
References: <1607495069-10946-1-git-send-email-victor.liu@nxp.com>
 <1607495069-10946-4-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1607495069-10946-4-git-send-email-victor.liu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Dec 2020 14:24:26 +0800, Liu Ying wrote:
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
> v1->v2:
> * Newly introduced in v2.  (Guido)
> 
>  .../devicetree/bindings/phy/mixel,mipi-dsi-phy.txt | 29 ---------
>  .../bindings/phy/mixel,mipi-dsi-phy.yaml           | 73 ++++++++++++++++++++++
>  2 files changed, 73 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
