Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FCD2A4390
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgKCK5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:57:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:35162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgKCK5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:57:13 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDFE6208B6;
        Tue,  3 Nov 2020 10:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604401032;
        bh=eTQx++qZBE4INXKV6a7Dmyy/sgoej48ZEPKAeo8heUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/zD78eklbOX8YHWJWH18NcqFLloTQcvYl+CFDrmRC5geySQJs1c0fM0aBAmXaLnU
         OoTiqpHuRe9mDXQ4nN8mGBQAUXIuQS5QwdEdY2jF53JKDzot5J5umTWLHeXym4YTnI
         eXZUqhIWdSZvl2mY5V1rjjQgXQ4q6y2RMaDFoBZ4=
Date:   Tue, 3 Nov 2020 18:57:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx50-kobo-aura: Add 'grp' suffix to pinctrl
 node names
Message-ID: <20201103105706.GC31601@dragon>
References: <20201031210729.2804471-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201031210729.2804471-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 10:07:29PM +0100, Jonathan Neuschäfer wrote:
> i.MX pinctrl group nodes should have names that ends with 'grp'.
> 
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Applied, thanks.
