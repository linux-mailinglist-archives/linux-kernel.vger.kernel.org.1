Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C782124E4DC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 05:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgHVD3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 23:29:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgHVD3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 23:29:44 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1708207CD;
        Sat, 22 Aug 2020 03:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598066984;
        bh=5Uk9flHxINPaa5OlAOFUuaAiQgeZi2oqIMu8KGSyZp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BiuZfrbSc71mqso6tI2hpJ65cT4fbLCyz2Y7+9vPZ9QElh565xdNwbHTNjVQVnL1y
         RO38xZUpZ3sxHSyrJApNW4PgEMivQzy3hcvRIq9IcCcGo6U6iJ+2FDtSH94nS0K0GD
         dsQ5ThTtTF5whdyN3NHcMRgq42cf5DtHInJq8xcE=
Date:   Sat, 22 Aug 2020 11:29:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     andy.tang@nxp.com
Cc:     amit.kucheria@linaro.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] arm64: dts: ls1088a: add more thermal zone support
Message-ID: <20200822032930.GA27575@dragon>
References: <20200715064909.9161-1-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715064909.9161-1-andy.tang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 02:49:08PM +0800, andy.tang@nxp.com wrote:
> From: Yuantian Tang <andy.tang@nxp.com>
> 
> There are 2 thermal zones in ls1088a soc. Add the other thermal zone
> node to enable it.
> Also update the values in calibration table to make the temperatures
> monitored more precise.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>

Applied both, thanks.
