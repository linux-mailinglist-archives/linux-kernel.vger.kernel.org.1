Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9A71DA733
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 03:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgETB3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 21:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgETB3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:29:48 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83E78207C4;
        Wed, 20 May 2020 01:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589938188;
        bh=LL7OWjzsQ/VdGe08gSDVgyPGonsCBCoHm37y5v591OM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fkLrh1FwV3EEx9dUkxvjBnW0iuIEaHgFfG4hqn2wPx8x0OVHuqSLgz4//h1I14kF0
         QhFYbMGHLC/OMPuoLdX9YKNrkkd9wg8Ep8vMamB47MJKa2V13O79D1Pq+j1LZ6KT/O
         yOa/Upp+wL8tt1fNmRJf9mz4bWFp92OB917O4Xyg=
Date:   Wed, 20 May 2020 09:29:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, aford173@gmail.com,
        oleksandr.suvorov@toradex.com, u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: extend RN5T618 PMIC family
 support
Message-ID: <20200520012942.GK11739@dragon>
References: <20200507204339.31253-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507204339.31253-1-andreas@kemnade.info>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 10:43:39PM +0200, Andreas Kemnade wrote:
> There are new drivers for functionality of that family
> (RTC and ADC), so enable them, since they are used by
> various i.MX6 boards.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied, thanks.
