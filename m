Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB9821CD71
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 04:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgGMC4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 22:56:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgGMC4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:56:06 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E223A206B6;
        Mon, 13 Jul 2020 02:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594608965;
        bh=T934/YnWvVkoIin6yI7H6nd9owFh+U1ASVGBBCj0uA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B2NAK57kV4oKp3qubXnKn3XffMcU0R5FCL1+Y7yeznueIXmsdA7R/LUj1PfbK8Td3
         iuMDlwL68P1bZhIjpvIVO+NEA5aLZ1tnhw44ptkab6h61Lj6RDNYZl4C9+0sp+ujF4
         FNOurfggVY31LIrVeBPCsK3/RSxpVVxcUsLuyMW0=
Date:   Mon, 13 Jul 2020 10:56:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, bth@kamstrup.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 3/3] MAINTAINERS: Add Bruno Thomsen as reviewer of
 Kamstrup DTS
Message-ID: <20200713025559.GZ21277@dragon>
References: <20200629114927.17379-1-bruno.thomsen@gmail.com>
 <20200629114927.17379-3-bruno.thomsen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629114927.17379-3-bruno.thomsen@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 01:49:27PM +0200, Bruno Thomsen wrote:
> Add myself as reviewer of device trees for Kamstrup
> Concentrators.
> 
> Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 496fd4eafb68..97fc112309af 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9282,6 +9282,11 @@ S:	Maintained
>  F:	Documentation/hwmon/k8temp.rst
>  F:	drivers/hwmon/k8temp.c
>  
> +KAMSTRUP CONCENTRATORS
> +R:	Bruno Thomsen <bruno.thomsen@gmail.com>
> +S:	Maintained
> +F:	arch/arm/boot/dts/imx7d-flex-concentrator*.dts
> +

I guess get_maintainer.pl should list you for patches touching the
files, so it's not really required?  I'm worried about that MAINTAINERS
file will get bloated quickly if we patch it for every single DTS
file.

Shawn

>  KASAN
>  M:	Andrey Ryabinin <aryabinin@virtuozzo.com>
>  R:	Alexander Potapenko <glider@google.com>
> -- 
> 2.26.2
> 
