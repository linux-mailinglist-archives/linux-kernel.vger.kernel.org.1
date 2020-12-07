Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B0F2D1DC4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgLGWvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:51:06 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45221 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgLGWvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:51:06 -0500
Received: by mail-oi1-f193.google.com with SMTP id f132so2876429oib.12;
        Mon, 07 Dec 2020 14:50:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OOjXvzmUiGjPiWQnDBF3fUFBdTIAN342UXa8biTDBZY=;
        b=ipwev36jHn+yFDOHUNQJIm4+j0bK5NCF4jc6Q63Ddy6sFy0gdrs2UhPtATvH2vwRXs
         gHWAKWlUkcPkPbHOn6iE97vnprPW/5GCfRgZUJ/QYSRyKq6Ys05Q2U7wwEZz1OuSGQg2
         vGGtKYmEIX77oyU1GydcYuZGK9lWQE2o0Oj4t+Zr9iumsfCUUqjYbrTsdKA7v0AXDmMl
         SvR428lP5I9gRt6ilY0jBkPfBOumPtm8IaZWh1VWkOJVx98b+lL33vUaUzQyN75sngnE
         ZTaQjUD5AVF2gos1ijFWd2f6XdKCXKRI4jv7m+VNshTPpXk+mBkT+dE/Rz6fqO8eyExE
         x5VQ==
X-Gm-Message-State: AOAM530pljcvpi9f3S8hihNH9t9qCLfWWIGDy41aQlqIV+lgHvENkT3m
        9Usj68i7vHR6aiDL5emvfA==
X-Google-Smtp-Source: ABdhPJxjmuWPyB2q7LBKu3uvUIWs2vkBHsFks2mtNMtTNthmYmCU6ILC/3dqCqhbfOBYUbHUIugK/Q==
X-Received: by 2002:aca:6103:: with SMTP id v3mr806928oib.64.1607381425377;
        Mon, 07 Dec 2020 14:50:25 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h8sm2834490oom.41.2020.12.07.14.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 14:50:24 -0800 (PST)
Received: (nullmailer pid 990371 invoked by uid 1000);
        Mon, 07 Dec 2020 22:50:23 -0000
Date:   Mon, 7 Dec 2020 16:50:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/6] dt-bindings: phy: phy-stm32-usbphyc: move PLL
 supplies to parent node
Message-ID: <20201207225023.GA990319@robh.at.kernel.org>
References: <20201123170132.17859-1-amelie.delaunay@st.com>
 <20201123170132.17859-2-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123170132.17859-2-amelie.delaunay@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020 18:01:27 +0100, Amelie Delaunay wrote:
> PLL block requires to be powered with 1v1 and 1v8 supplies to catch ENABLE
> signal.
> Currently, supplies are managed through phy_ops .power_on/off, and PLL
> activation/deactivation is managed through phy_ops .init/exit.
> The sequence of phy_ops .power_on/.phy_init, .power_off/.exit is USB
> drivers dependent.
> To ensure a good behavior of the PLL, supplies have to be managed at PLL
> activation/deactivation. That means the supplies need to be put in usbphyc
> parent node and not in phy children nodes.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
> Note that even with bindings change, it doesn't break the backward
> compatibility: old device trees are still compatible, USB is still
> functional. Device trees will be updated with this new bindings
> when approved.
> ---
>  .../bindings/phy/phy-stm32-usbphyc.yaml       | 22 +++++++++----------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
