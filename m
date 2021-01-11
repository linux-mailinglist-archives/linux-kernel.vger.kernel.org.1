Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79ED22F0B77
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 04:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbhAKDaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 22:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbhAKDaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 22:30:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6610A206D6;
        Mon, 11 Jan 2021 03:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610335762;
        bh=Vlnz2MXvnDwEmOJhNGJ5j0qIzDEbPBj5VMUsqGsf6Jo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PUDI1F1O94Ryo5RwuZ7FgRptU/yEbzKe5uzFxDrQVH08DaGZ9J72J6aJS2hnf1gPb
         2rXeMhKeILjoDLrzpuDEpj+LMxdg7DFCHSZZ2GuCkIiGIoOgEt48raJ0hD37OeoM62
         7p6U1I9y25lUhGwPYO9rgKUSOZdF6WbSYRVeH4cq5fxdsyc/Nv9nVaefeQj6Idn2m7
         aKwwJGV27RQiENiXKaM4P1JdKYsdtAXeRmWShykiaSVQqpaB1i9WJ7DSOiqbBz8BVQ
         uSyhadD0Ya8tfMa776Orr7L7s631yLleJw4LGJqXf/83azNm3wdmVN2DxxC4Q22Sbf
         TQlGCUm8CycNw==
Date:   Mon, 11 Jan 2021 11:29:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: fsl: Add binding for Gateworks
 boards with IMX8MM
Message-ID: <20210111032915.GY28365@dragon>
References: <1609781807-15096-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609781807-15096-1-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 09:36:46AM -0800, Tim Harvey wrote:
> Add bindings for the Gateworks Venice Development kit boards with
> IMX8MM System on Module.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied both, thanks.
