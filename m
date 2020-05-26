Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D792D1DA701
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 03:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgETBOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 21:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgETBOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:14:17 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E07F20708;
        Wed, 20 May 2020 01:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589937256;
        bh=xu7DPZR+nitRymSy5tLjdNup86IE5xSR0RPp5wz5Axo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bTv3PNyonknRWT0jeRDQbGmzUXc/xMUn/rXUEc/qH/nbyMKQkabHT9LNsdxM9vn0R
         KHYodIRi9FyhEpzvUzZeLjazXOZKb7037/Dc+Z/LgyRAXnUu2YmY1doOo+QFTonyL3
         9KwhHIwbxwZscZSeEuXodYSOuNizuJ+TqMDUV3zY=
Date:   Wed, 20 May 2020 09:14:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: freescale: sl28: enable LPUART1
Message-ID: <20200520011411.GH11739@dragon>
References: <20200505150037.32573-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505150037.32573-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 05:00:37PM +0200, Michael Walle wrote:
> Now that the LPUART has support for the LS1028A SoC, also enable it on
> our board.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> 
> Hi Shawn,
> 
> After adding/fixing the LPUART support for the LS1028A I've forgot to send
> this patch to actually enable the LPUART on our boards. It would be great
> if this could make it into the fixes queue for the -rc. If not its also ok.

We only take critical bug fixes at this point.  Applied it for -next.

Shawn
