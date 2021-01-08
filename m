Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B86A2EEB3D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 03:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbhAHCYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 21:24:09 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:43717 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbhAHCYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 21:24:09 -0500
Received: by mail-io1-f49.google.com with SMTP id o6so8262877iob.10;
        Thu, 07 Jan 2021 18:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=46COOYJFwiikLQxeBamcVbHyY1w+rFmKpta5G7UHgSs=;
        b=PxcLwIFPq1bgoubYyAoEcfw4i+5RnttlbpE+mw8NauP73vyyDA0fTn7Tw5HZu0VW5V
         PfBS4crt8QtIXmupcVBXiZNNv17dO9gw+U9LJtzGR2QmqCF9lGWLuy4EvMsWcZ1hsvB9
         PgE3YnLX4wgGHOg38vcO4a23JxEukVXUkQ+3TIbkhNpX6IpInGSDQEhrAxWUNPAAGCzR
         DrL9L9258Q7pPXy1Kvsnr8r8tJ0oqYujTBRhL6GVBNaSVgqrrGyrhWZ53ByrEc9emscD
         OO1Wdrrgcnzt1JH3MBp8coVsxlstQR5Rk53gZTD8iU81JouD28+l0wjOKUoCKK8qrT8g
         W5UQ==
X-Gm-Message-State: AOAM533lV9eoIAVWJXrEVcXSXdXzP0lx/lX4P/WxWEKvwit7UW/R/6j/
        NGosZycAkWH7DiHIAO9tSA==
X-Google-Smtp-Source: ABdhPJyn6H73R/SbxXAgrTxveLGEo9Z73WV8lfXf6/RMmobdcn+6WbTVkzvVZqS+ilzx8Vu/ATWZfA==
X-Received: by 2002:a5d:9e41:: with SMTP id i1mr3734219ioi.104.1610072608333;
        Thu, 07 Jan 2021 18:23:28 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b13sm4467219ils.54.2021.01.07.18.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 18:23:27 -0800 (PST)
Received: (nullmailer pid 1743696 invoked by uid 1000);
        Fri, 08 Jan 2021 02:23:23 -0000
Date:   Thu, 7 Jan 2021 19:23:23 -0700
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        David Jander <david@protonic.nl>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/5] dt-bindings: vendor-prefixes: Add an entry for
 Kverneland Group
Message-ID: <20210108022323.GA1742887@robh.at.kernel.org>
References: <20210107100831.30389-1-o.rempel@pengutronix.de>
 <20210107100831.30389-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107100831.30389-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jan 2021 11:08:27 +0100, Oleksij Rempel wrote:
> Add "kvg" entry for Kverneland Group: https://ien.kvernelandgroup.com/
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

