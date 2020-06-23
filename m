Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2CB204A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 08:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbgFWGrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 02:47:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730583AbgFWGrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:47:32 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B4AD20738;
        Tue, 23 Jun 2020 06:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592894852;
        bh=kLci6LzLVkSyO1+Qzm8szD2BRx5DIK3DpLD7Y9eQFuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzBjnYVvqnK5uamD/464mRyu1Pr0AFUmc0dzZL8Pz8mH5c/z1CHKmXr38W0G2tLyY
         5q7RcVK6P6TrthZHoaquEjm05f48kXezXUM2MqTd9sxf3wW0y0VF+jCO0WUW75nbZB
         o6Lhp9oecwEdOdnOBrgZPv0RFiqeEHOuJpmzftME=
Date:   Tue, 23 Jun 2020 14:47:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx6qdl: Remove invalid interrupt for GPC node
Message-ID: <20200623064726.GO30139@dragon>
References: <1590998069-28212-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590998069-28212-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 03:54:29PM +0800, Anson Huang wrote:
> In latest i.MX6Q RM Rev.6, 05/2020, #90 SPI interrupt is reserved,
> so remove it from GPC node.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
