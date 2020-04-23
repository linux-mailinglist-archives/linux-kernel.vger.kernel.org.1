Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DE01B52EE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 05:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgDWDKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 23:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgDWDKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 23:10:10 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE1832073A;
        Thu, 23 Apr 2020 03:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587611410;
        bh=+/exaij1Arkn6tHuufuk2Xp29ui2IZz1yHWl5Hic8yA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bVL8TzgS4Ij4UHe2Vhg7pNRDHWU6VO8hi5xYIdKT3sy+s1UeJ8Ng8vD7/FDBtPiDy
         v3TDsmTGvjzZQEl7eC22TJCh2BhsVP5Oj+D4pw4oZ2gq7QIe6MzBdPoDUQFtzpNxuL
         P6y/LWPHbogNUGKCTtWB6cRd3cSKYfQYMVNvY9xk=
Date:   Thu, 23 Apr 2020 11:10:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: vendor-prefixes: Add Beacon vendor
 prefix
Message-ID: <20200423031002.GH8571@dragon>
References: <20200324144324.21178-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324144324.21178-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 09:43:22AM -0500, Adam Ford wrote:
> Beacon EmebeddedWorks is the brand owned by Compass Electronics Group,
> LLC based out of the United States.
> https://beaconembedded.com/
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Hi Rob,

Are you okay with this?

Shawn

> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 4c8eaa11daff..7ee772b1840a 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -141,6 +141,8 @@ patternProperties:
>      description: Shenzhen AZW Technology Co., Ltd.
>    "^bananapi,.*":
>      description: BIPAI KEJI LIMITED
> +  "^beacon,.*":
> +    description: Compass Electronics Group, LLC
>    "^bhf,.*":
>      description: Beckhoff Automation GmbH & Co. KG
>    "^bitmain,.*":
> -- 
> 2.25.1
> 
