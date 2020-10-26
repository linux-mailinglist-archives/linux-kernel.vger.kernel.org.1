Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F3429877C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 08:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769788AbgJZHfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 03:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1421023AbgJZHfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 03:35:13 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 685CC222EA;
        Mon, 26 Oct 2020 07:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603697712;
        bh=6/7AiR5oUAO5D1P3XXVqEaMGKCLNi7pxv13r0Z2wiUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tLnVRqyv7T/ytJdA+Um5eUAPxYNQ+AGsSCWUYJFxsifDqevLXlY5/UyP28PJJlDXR
         GsnL7l6uN8GJqcKLN8Ijo+gI20WNVeZrPD+h6wQFgfRK0Xt8k+25HpniuCYbF7MJJG
         +CzQGnzuByO4W8R0Vm31ToL/gSER6VeQ+Dt2kzeM=
Date:   Mon, 26 Oct 2020 15:35:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ARM: dts: imx: align GPIO hog names with dtschema
Message-ID: <20201026073506.GG9880@dragon>
References: <20200920195749.26952-1-krzk@kernel.org>
 <20200920195749.26952-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200920195749.26952-3-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 09:57:49PM +0200, Krzysztof Kozlowski wrote:
> dtschema for GPIO controllers expects GPIO hogs to end with 'hog'
> suffix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
