Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8E52C8178
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgK3JyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:54:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728674AbgK3JyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:54:16 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53A8F206D5;
        Mon, 30 Nov 2020 09:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606730016;
        bh=VcuPQ5Sr8i5HvDsiM/kYNiSZfrUK56TLcroWBcmMkEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cDwzAlnO7eR3HAhq27dAz6d4uq+TPcYZ177eu6BRLn5lCDF5ZsK1JcE4usaxDMh7C
         pK9aqf7KOFcPCMhvO/Sxef/KKjEMA9qfdZwrlu11HNpxfcP0s6Mp0ucYwpttaeau/K
         RSU+CiVePuOZEbMamgTHp82YV4UhCvHz+7w46Sfo=
Date:   Mon, 30 Nov 2020 17:53:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, bth@kamstrup.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: fsl: add kamstrup flex concentrator
 to schema
Message-ID: <20201130095329.GH4072@dragon>
References: <20201118102119.3254-1-bruno.thomsen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118102119.3254-1-bruno.thomsen@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 11:21:18AM +0100, Bruno Thomsen wrote:
> Add Kamstrup OMNIA Flex Concentrator compatibles to the schema
> so we can make use of them for the validation.
> 
> Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied both, thanks.
