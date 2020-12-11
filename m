Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3F32D6EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405293AbgLKDrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:47:02 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38893 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390347AbgLKDqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:46:22 -0500
Received: by mail-oi1-f195.google.com with SMTP id o25so8386007oie.5;
        Thu, 10 Dec 2020 19:46:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xsOzNAdYOyw/VZpV4HjCVyfu36qNDBUH0JgMyFTiKVw=;
        b=AGhXnFH+IAMX4ToD0Fa/vJYrMRbHCB4iXo0YlT5RtbmHs31Sg5886EDBKauGiiMbr2
         Usm3jrA8G8osvNa4quP0IVjRFEO0Xrg9x3Cwgt1vVJIcQpFOB1zh+mbMXrv4mwnxIeTh
         m53Xtp4hCBcTJ3T3Ujg1/P8zsSCl4KriZqXB26eGih3qadmpupmpg9k8c5FgmOwLh/1G
         02Ng/8Dn3qJ0/6P7YeaXYjISJObvtTU42k2uH4pjBYLej/HJkPX24zEJZ7UNIbkBJU1b
         LPXt1Ed2e0WQdf9Ix8CTpxOkAu6SOF1Xmy2prBV5LhLpGobosaT6nuqbZrNL2avdHJu1
         PkuA==
X-Gm-Message-State: AOAM5306yITa3kul3I1NAqfFySUoy6jlzRDTNAIrS+YcIsYiVCtp1J8U
        NMHQynZeIYS5cuuqpRNruEtJMOpN1w==
X-Google-Smtp-Source: ABdhPJyQTCEPjNY/kQ1/yjp0xHMabgSIYSkGQnlAc/e3YbbqgAYmAmyXIyemdmykEfRjLJvPM4XVtw==
X-Received: by 2002:aca:e082:: with SMTP id x124mr7836201oig.3.1607658341156;
        Thu, 10 Dec 2020 19:45:41 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e81sm1516934oia.30.2020.12.10.19.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:45:40 -0800 (PST)
Received: (nullmailer pid 3601454 invoked by uid 1000);
        Fri, 11 Dec 2020 03:45:39 -0000
Date:   Thu, 10 Dec 2020 21:45:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 1/5] dt-bindings: vendor-prefixes: Add an entry for
 Kverneland Group
Message-ID: <20201211034539.GA3601407@robh.at.kernel.org>
References: <20201210091341.27110-1-o.rempel@pengutronix.de>
 <20201210091341.27110-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210091341.27110-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 10:13:37 +0100, Oleksij Rempel wrote:
> Add "kvg" entry for Kverneland Group: https://ien.kvernelandgroup.com/
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
