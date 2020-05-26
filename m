Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8EB1B0EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgDTO5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 10:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgDTO5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:57:03 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6A5A20775;
        Mon, 20 Apr 2020 14:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587394622;
        bh=YMqSLYesrVGfEVE3naJYR+Hx7EfHi7G425jwAw+TTLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sW5B2zF5DOuLuC4jUKuLD0NhFx2My7Kck3JlCva2C/MRMzM/yhtP3LfQPHFmhQ0ne
         jAbeao3r34jrR2VlKyWcVZ7VVBSAkIgAUFOYivnleQdB+CR9cV+6v6XzUhpJk4+w0c
         GqhQlndLXud0y4e646rhIuc0ybDgk1Amo9Csxzao=
Date:   Mon, 20 Apr 2020 22:56:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, gustavo@embeddedor.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de, abel.vesa@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2] clk: imx: clk-pllv3: Use readl_relaxed_poll_timeout()
 for PLL lock wait
Message-ID: <20200420145654.GF32419@dragon>
References: <1584661443-12032-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584661443-12032-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 07:44:03AM +0800, Anson Huang wrote:
> Use readl_relaxed_poll_timeout() for PLL lock wait which can simplify the
> code a lot.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

Applied, thanks.
