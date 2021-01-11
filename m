Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0260A2F0B81
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 04:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbhAKDgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 22:36:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbhAKDgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 22:36:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F8B422225;
        Mon, 11 Jan 2021 03:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610336170;
        bh=efAlBowgesJsF4Gecc/ocDjmkDbo6LfEashvo0YlL5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ieN2tIlwd5ITa0n1t5Eb/xEJa32WC1WbonIEupcSbMS1LWB/ZomONbLkBAnp7KBG+
         rAt4rdAw/0AKiIAW/BJFNjA6SUi50MXjWrvUW3U1IFyPJtOj++gQj/5tkbQ5rB0ZjD
         KwFeTgMYm4QCNJM6S1YzrCNijVSmEAZ5h7OTt5ePAIljbnYF+d0eKVZ9T400pNgiub
         e00eDogeH34898ZE6uMeq+Q+YEH4pa87A7PM2qTdGUHR3KIQqiYWC50TcBkMAitINO
         WqjVY6YAWneRORLVdU9bjraynafRduj9GSv23Q0V1/EMfCzNgqit93Di8e5iTXsbQz
         EnnbYONXXFqAw==
Date:   Mon, 11 Jan 2021 11:36:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 0/2] mainline Protonic PRTI6G board
Message-ID: <20210111033604.GC28365@dragon>
References: <20210107085233.15619-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107085233.15619-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 09:52:31AM +0100, Oleksij Rempel wrote:
> changes v2:
> - reorder pinctls
> 
> Oleksij Rempel (2):
>   dt-bindings: arm: fsl: add Protonic PRTI6G board
>   ARM: dts: add Protonic PRTI6G board

Applied both, thanks.
