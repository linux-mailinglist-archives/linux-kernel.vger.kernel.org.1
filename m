Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71E62F968B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 01:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbhARARo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 19:17:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729202AbhARARl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 19:17:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 476D82137B;
        Mon, 18 Jan 2021 00:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610929021;
        bh=zO/KbGkUS88EPcQXMhBUqz/fW643HhNr55nJOexjy+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uvDQGe00uNkxRH73MmCU30nN5Q2mnYhlLGtp83Tvj0BPm6nVK8Uqv4G8/kZBlOt9s
         hGgWANVXz/lIOuX7LkDbb6l/e/ajm2QmeYJgkyqUUuzjAI2NnRuBR47rEKYB+XcnUh
         Wh0uvMw0uCM6yv5rM8gQL5i/qxM8azp2tn5tzHiAwx/L+MvAUYt/gr231cYdcKIbN9
         BXHZh3ISot1z0h9lFlole6URB9Pg075CbcfWEFFATJ+NFIvewNlrBj1vd2JgRUjfFr
         87aKlntZcWVDfVEx9mLou7boxoPItWkebZGp9zUopoDktpnjcVVd/sRv/et1F48/hn
         G54+GYWQl+eGA==
Date:   Mon, 18 Jan 2021 08:16:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-beacon: add more pinctrl states for
 usdhc1
Message-ID: <20210118001655.GA28365@dragon>
References: <20210110113826.1257293-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210110113826.1257293-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 05:38:26AM -0600, Adam Ford wrote:
> The WiFi chip is capable of communication at SDR104 speeds.
> Enable 100Mhz and 200MHz pinmux to support this.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
