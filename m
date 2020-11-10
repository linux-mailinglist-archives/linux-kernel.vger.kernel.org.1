Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24362ACAF3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 03:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgKJCV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 21:21:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKJCV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 21:21:56 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 520BA206C0;
        Tue, 10 Nov 2020 02:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604974915;
        bh=xnhwepSJXFHmxoNunfr8u7RT5KMGoGIip7WUnAG+wpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0k1BAbv6wN3bGn5ycL4xMz0fBp65j+9X+w2KQfsHCLRKhBQzD4ThybccsZTW4h5YE
         EDEX71iJdQHVvrmgnsUg00mGaCLLBdBrXpTRyBPD0DqRmYCizWEp+s+quPZ5Rsbpj/
         6LKyVSqXwYqpQxtGTXZ5nfBZaUZfEHNE+HL38gQQ=
Date:   Tue, 10 Nov 2020 10:21:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ARM: imx: mach-imx6q: correctly identify i.MX6QP SoCs
Message-ID: <20201110022148.GS31601@dragon>
References: <20201104165418.4903-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104165418.4903-1-TheSven73@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 11:54:18AM -0500, Sven Van Asbroeck wrote:
> The i.MX6QP rev 1.1 SoC on my board is mis-identified by Linux:
> the log (incorrectly) shows "i.MX6Q rev 2.1".
> 
> Correct this by assuming that every SoC that identifies as
> i.MX6Q with rev >= 2.0 is really an i.MX6QP.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>

Applied, thanks.
