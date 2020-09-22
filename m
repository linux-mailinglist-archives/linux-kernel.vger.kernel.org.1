Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C925E273837
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgIVBzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:55:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbgIVBzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:55:54 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06E9923A34;
        Tue, 22 Sep 2020 01:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600739753;
        bh=ZyQfKRCZa6JF0hn2R1Jr8dhhJPo94JqoWViY+UbUtGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PvzsLL8TICTwZz3fSlaA8W3mut/srUEdvFW120ek7EZm71MpcxbA3wQ0YpSVZ+N2A
         uSYsNHqnzMSUm05F2UgsNsp5+jFdR1hMxWqckAmvhGIDYxOmxBF6xP0nSUlFFUHwle
         tiCef1nal780Il5I07+doQCX6FV/C0+05Ik9PqT4=
Date:   Tue, 22 Sep 2020 09:55:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: fsl: Add binding for Variscite
 Symphony board with VAR-SOM-MX8MN
Message-ID: <20200922015547.GP25109@dragon>
References: <20200919141332.5095-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919141332.5095-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 19, 2020 at 04:13:30PM +0200, Krzysztof Kozlowski wrote:
> Add a binding for the Variscite Symphony evaluation kit board with
> VAR-SOM-MX8MN System on Module.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied all, thanks.
