Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4635F2C8125
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgK3JhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:37:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgK3JhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:37:13 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65F8620578;
        Mon, 30 Nov 2020 09:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606728993;
        bh=d4lgpKU06SJ+PAtZJyVWZbeLI8bmr3++iqfqZhWWmIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D9Z/LprowU2b42t1gpqRQYY74yc+jGCFAh1MY81ER8lTQHvMaVyIUP9qW5bSWLBSY
         +TXhhnPisdMDeSwunThQQUjgSsigH2vYECYJH0rRiFZxEIAixncZ6AXIHwTcfbMfDa
         HI4HYsJsK+1mCRpG4dO/xVmuxRHyhiUodDtF+0Ow=
Date:   Mon, 30 Nov 2020 17:36:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     andy.tang@nxp.com
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: freescale: update calibration table for
 TMU module
Message-ID: <20201130093625.GF4072@dragon>
References: <20201117034305.42546-1-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117034305.42546-1-andy.tang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:43:04AM +0800, andy.tang@nxp.com wrote:
> From: Yuantian Tang <andy.tang@nxp.com>
> 
> Update the calibration table to make the temperature more accurate.
> Three platforms have been updated: ls1012a, ls1043a and ls1046a.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>

Applied both, thanks.
