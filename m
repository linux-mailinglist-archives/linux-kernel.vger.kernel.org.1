Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6943F29D800
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbgJ1W2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:28:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733257AbgJ1W1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:27:23 -0400
Received: from localhost (unknown [122.171.163.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFE98247D8;
        Wed, 28 Oct 2020 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603901328;
        bh=khIJw3FHkYdF0BDvRvLTZGM8QwAk8X2thpO+rlDXvZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mwnuUkUOOvhj7gH63nY7owuytgrP6FCdmUL/UWVfPjIEbm1hcHpZ1wkn0w6eMahQE
         gEP9fbD4VE2TJGesk4IAssUXyHHCo1stD/gLK70H5DCfsYbodDbEcXsR1dcRt3CRCG
         0DpRDThnCfSEin/YoqkQ8g1BS50RpQaWnoTizsKc=
Date:   Wed, 28 Oct 2020 21:38:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Li Jun <jun.li@nxp.com>
Subject: Re: [PATCH] phy: fsl-imx8mq-usb: Constify imx8mp_usb_phy_ops
Message-ID: <20201028160844.GQ3550@vkoul-mobl>
References: <20200926205844.34218-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926205844.34218-1-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-09-20, 22:58, Rikard Falkeborn wrote:
> The only usage of imx8mp_usb_phy_ops is to assign its address to the
> data field in the of_device_id struct, which is a const void pointer.
> Make it const to allow the compiler to put it in read-only memory.

Applied, thanks

-- 
~Vinod
