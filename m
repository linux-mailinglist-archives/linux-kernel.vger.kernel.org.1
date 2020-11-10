Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7DD2AC9DE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 01:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgKJAvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 19:51:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:52552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729454AbgKJAvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 19:51:36 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15D1A206D8;
        Tue, 10 Nov 2020 00:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604969495;
        bh=fHvyMbe0ih6BAcs5WE75jOxBrAq4NHN71OG7fV1KPDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UdXCGmxczUfLXuRZoj9VQRABfj6X9ssTda9acK9R9YWCU/6iLpBUBnosZ/aPELOTN
         UPaxsDMdNRY2/bgpVnNNDzdKRr3z3pa5wMYQxpzhz1y3WDfzu9jFLg0ViqZVghHS+Y
         qJx0qHJnAsJ020QO1e09IJYgN4dkGqAQw7n3jnMc=
Date:   Tue, 10 Nov 2020 08:51:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mkl@pengutronix.de
Subject: Re: [PATCH V2] arm64: dts: imx8mp-evk: add CAN support
Message-ID: <20201110005122.GH31601@dragon>
References: <20201102021634.6480-1-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102021634.6480-1-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 10:16:34AM +0800, Joakim Zhang wrote:
> Add CAN device node and pinctrl on i.MX8MP evk board.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

Applied, thanks.
