Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B989B1FF4CE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 16:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbgFROdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 10:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728161AbgFROdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:33:51 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40390207E8;
        Thu, 18 Jun 2020 14:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592490830;
        bh=C7ZYkDUKtqNmQK9XpqU0E9C/xc5qiOrmi1v9i16eauo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WcD1MxsJYeK3+FbwpQ9EuBja9XRN1Hzk7g34G64GdYbtOyFzJt0gOJqGhLZR8rFGd
         C47ToJctnLFdFxLDtGaWWn6vjEpPC2S+i3ok2O1UCb9UU0fo87STJZZ9MIIREBcHpJ
         jh6eppxd8O2w+BbeRxTeaXNpXX0sFrcTv0bxjhKc=
Date:   Thu, 18 Jun 2020 22:33:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yuantian Tang <andy.tang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ls1028a: add one more thermal zone support
Message-ID: <20200618143345.GD464@dragon>
References: <20200525073827.13272-1-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525073827.13272-1-andy.tang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 03:38:27PM +0800, Yuantian Tang wrote:
> There are 2 thermal zones in ls1028a soc. Current dts only
> includes one. This patch adds the other thermal zone node
> in dts to enable it.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>

Applied, thanks.
