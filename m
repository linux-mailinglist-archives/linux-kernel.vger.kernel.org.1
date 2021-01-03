Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7F72E8D39
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 17:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbhACQfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 11:35:02 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:40211 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbhACQfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 11:35:01 -0500
Received: by mail-io1-f54.google.com with SMTP id r9so22869629ioo.7;
        Sun, 03 Jan 2021 08:34:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lESNZu8ZguyyGzEbPXvK2r3c1oXq1tI69/4HjkrNEiI=;
        b=irLxdMZevODzvSRbnq3hqvxgwgI+fwYoWTRBIriTtqKTrIAn9Jsy+bvD5TFUKxbI3T
         /aSlH4HJY0b4CeM70USmGG7/Tv2XwR0rVgdUcspP+IKMd50Ztkw+IxvRh6+rhL/2lfdx
         vAiF8Hw2/5l4COUTK1kxxrqrIxjMqQbNwP77w0MDacCorQ74wY8GM5/mN4yM2QhGn6s1
         COrLBuLuOnyEpIMqMAVRHibvtyIxgSE9fljDGO4ZtQU1GjqWKJ9BVuQzK4WRSvfBPHXF
         PGt8UJhvFJNr6sru7UyVqsS0yZ0nleuDTeq5rglx2EYkmAm+YyCcrqayhUit7DWoynTo
         PzLA==
X-Gm-Message-State: AOAM532GKPNUNzMVBqeiL3FZJ0Q0slVu3jw/Pp9jxXVW33vSVIQLWig5
        snwQSDji9B1K9vs/tH2GiA==
X-Google-Smtp-Source: ABdhPJz7K3c9R/fCWpG0iNos4Mc5ecieXixWMmhPTpnMWsFo3mOJnh2sSB0BRfeuRPDvEBm7cZckxg==
X-Received: by 2002:a05:6638:3012:: with SMTP id r18mr58677111jak.13.1609691660361;
        Sun, 03 Jan 2021 08:34:20 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id r11sm39150891ilg.39.2021.01.03.08.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 08:34:19 -0800 (PST)
Received: (nullmailer pid 4002058 invoked by uid 1000);
        Sun, 03 Jan 2021 16:34:14 -0000
Date:   Sun, 3 Jan 2021 09:34:14 -0700
From:   Rob Herring <robh@kernel.org>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        krzk@kernel.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        festevam@gmail.com, shawnguo@kernel.org,
        devicetree@vger.kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de
Subject: Re: [PATCH v9 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Message-ID: <20210103163414.GA4001998@robh.at.kernel.org>
References: <20201222081057.26401-1-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222081057.26401-1-alice.guo@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Dec 2020 16:10:54 +0800, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Add DT Binding doc for the Unique ID of i.MX 8M series.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> 
> Changes for v9:
>  - add additionalProperties for "^soc@[0-9a-f]+$"
>  - add examples
> Changes for v8:
>  - match soc node with regular expression
> Changes for v7:
>  - change to a separate schema file
> Changes for v6:
>  - none
> Changes for v5:
>  - correct the error of using allOf
> Changes for v4:
>  - use allOf to limit new version DTS files for i.MX8M to include
>    "fsl,imx8m*-soc", nvmem-cells and nvmem-cells-names
> Changes for v3:
>  - put it into Documentation/devicetree/bindings/arm/fsl.yaml
>  - modify the description of nvmem-cells
>  - use "make ARCH=arm64 dtbs_check" to make sure it is right
> Changes for v2:
>  - remove the subject prefix "LF-2571-1"
> 
>  .../bindings/soc/imx/imx8m-soc.yaml           | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
