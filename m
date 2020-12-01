Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D372C94D0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 02:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgLABnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 20:43:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728678AbgLABnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 20:43:11 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6277D206E0;
        Tue,  1 Dec 2020 01:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606786951;
        bh=lTRsEMrpRvS2rkpUlAULfE1RMIMXCz4/9GqqdWBH9Fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZNTGYkwQKGjoSgP5+hkVLJMA8B6mn5neQMmBS2FNKmKo272Q+rDMiz3z1oQ9mtxLM
         Ps0RQsoKBHhl5YQTTJGjq29sjkp1R5Msc7n9ninTMrB4g4e4Ed9GUixyhlV59q8VxW
         8FoN9bjlzcbr/M4VzDHMQONqoCqE9CE7dQQQAXyA=
Date:   Tue, 1 Dec 2020 09:42:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: imx28: Fix label name for L2 switch
Message-ID: <20201201014204.GT4072@dragon>
References: <20201125161815.2361-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125161815.2361-1-lukma@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 05:18:13PM +0100, Lukasz Majewski wrote:
> The 'eth_switch' name has been misspelled in the imx28.dtsi file,
> so this change fixes it.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Applied, thanks.
