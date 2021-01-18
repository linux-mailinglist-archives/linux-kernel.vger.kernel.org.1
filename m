Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5E32F9A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 08:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbhARHN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 02:13:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:41598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbhARHNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 02:13:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F20E223DB;
        Mon, 18 Jan 2021 07:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610953974;
        bh=uqjpFmrs8TwX63BLBEG3jSv9AAcixri54fwNldvXC1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NtMCxWHOBmOlgKiusThrjy4s+oZmco7W34C7DsLvhtCIZ1Hj0uvuk6ALfW59CkBvN
         /wplMBl1Q0Gmz0PRROT+U2jCvOTzZn/JgnlAoBZTxC9tJsYiH/TxyPg1B1tiMaJ5bC
         vp7BcdVfvCzNhev/N1dJAtSCp96KtkNEHUZ3lyTe1p4U/YkrN4aUap28EcGrpls4iv
         90Syvk8+gF7pe7AeCoxtGnNgGMXMRdRs5lt4DjdIgbodVoV8fUBeiFUUXBjxqbFD6W
         jEmV9XR5GXYsT+co766n7WYoo88h7JK4NWOJ4tE+JOxxol0AsaMWQCm1deN4gPO8qC
         /oB3pVuGU3AKg==
Date:   Mon, 18 Jan 2021 15:12:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        j.neuschaefer@gmx.net, letux-kernel@openphoenux.org
Subject: Re: [PATCH 0/4] ARM: dts: imx: uart improvements for ebookreaders
Message-ID: <20210118071247.GM28365@dragon>
References: <20210112231549.29957-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112231549.29957-1-andreas@kemnade.info>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 12:15:44AM +0100, Andreas Kemnade wrote:
> - add second uart
> - correct pinmux for console uart (it was working before because of
>   setup by uboot)
> - document locations on board
> 
> Andreas Kemnade (4):
>   ARM: dts: imx6sl-tolino-shine2hd: correct console uart pinmux
>   ARM: dts: imx6sl-tolino-shine2hd: add second uart
>   ARM: dts: imx6sl-tolino-shine3: correct console uart pinmux
>   ARM: dts: imx: e60k02: add second uart

Applied all, thanks.
