Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECFA2A1B90
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 02:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgKABCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 21:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgKABCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 21:02:19 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB49920888;
        Sun,  1 Nov 2020 01:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604192539;
        bh=SAa5l4bz6H/R056xOeB+clBF7AF9OoRRA+KnVzNeg/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mbQlyvy5DCS1sYW0egOWXIzhekPYFo9ZGjKgq/SzEIYxoHmrO16eWkAs76SX6zIAl
         GumR5mUYG/gxlseuaoPoKcifsuI345wvMI2JXOp0OYEo0i1iEPbf7KePzip5Snzs/f
         s9BJ6uK1w2B9SigJXmHdUS5vEkWjCLcBFe2w2r3o=
Date:   Sun, 1 Nov 2020 09:02:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] arm64: defconfig: Enable ASRC and EASRC
Message-ID: <20201101010212.GB31601@dragon>
References: <20201019174529.289499-1-aford173@gmail.com>
 <20201019174529.289499-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019174529.289499-2-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 12:45:25PM -0500, Adam Ford wrote:
> The i.MX8M Nano supports the EASRC driver, and it requires ASRC.
> Enable both of them as modules.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
