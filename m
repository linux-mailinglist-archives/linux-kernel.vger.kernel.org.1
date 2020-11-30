Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7732C7E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 08:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgK3HIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 02:08:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:47598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgK3HIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 02:08:36 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB101206CA;
        Mon, 30 Nov 2020 07:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606720076;
        bh=mhLhbRtLioruDCpjmJFWkBemNzwX2cqn90klfwLFuc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dp5EDDFjiemfsgqtbs/mQAFdMIXzjMGQ8BlYlmE4J/Ut9KR6RBAczQYtdE40ihfqI
         oqGYRE2ZLd0o/lQ032/LYo7/8d6WsZ0pW5fW4ZSrOTlU+/CeORvizVFDpnImHtS5Og
         4O6irbVO5034hO3sVU47hjiQGz1SM1SdsPjbSxr0=
Date:   Mon, 30 Nov 2020 15:07:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] arm: dts: ls1021a: fix flextimer failed to wake
 system
Message-ID: <20201130070747.GA28406@dragon>
References: <20201102072652.34893-1-ran.wang_1@nxp.com>
 <20201102072652.34893-2-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102072652.34893-2-ran.wang_1@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 03:26:51PM +0800, Ran Wang wrote:
> The data of property 'fsl,rcpm-wakeup' is not corrcet, which causing
> RCPM driver incorrectly program register IPPDEXPCR1, then flextimer is
> wrongly clock gated during system suspend, can't send interrupt to
> wake.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Acked-by: Li Yang <leoyang.li@nxp.com>

Applied, thanks.
