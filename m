Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169B42B3ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgKPIgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:36:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgKPIgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:36:09 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5356D207BC;
        Mon, 16 Nov 2020 08:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605515768;
        bh=tmCvow15NH1iERvzLTpf2YfQbWRCyoYmCxAZHTthwKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hbDcChlzfuEZnaUpfax8SVUvmM/Slt1KwMjP1TRMEfUERCCESxRHKqO+bwK3As9b/
         WJZzWZgOtJ28H8Vre3Sl77im/KHYD95StOxQTkUbGoNDM6ELn8XI5wTyfe1R6qAO54
         IA6Bj+w7kDYOaKdlcrMd9FQ03zbwhwscga572HBo=
Date:   Mon, 16 Nov 2020 16:36:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        krzk@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/5] soc: imx: gpcv2: add support for i.MX8MN power
 domains
Message-ID: <20201116083602.GL5849@dragon>
References: <20201107140026.1974312-1-aford173@gmail.com>
 <20201107140026.1974312-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107140026.1974312-2-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 07, 2020 at 08:00:22AM -0600, Adam Ford wrote:
> This adds support for the power domains founds on i.MX8MN. The Nano
> has fewer domains than the Mini, and the access to some of these domains
> is different than that of the Mini, the Mini power domains cannot be
> reused.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

It doesn't apply for me.

Shawn
