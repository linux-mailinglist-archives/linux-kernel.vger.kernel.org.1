Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8108529F9B1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 01:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgJ3A3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 20:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgJ3A3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 20:29:31 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDB2820738;
        Fri, 30 Oct 2020 00:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604017771;
        bh=hhfWxHMkV3oPCNwjwPSs0iKbFjvy47jIL1h0TU9rE+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PISGVOB7ibRlPN3kpW8A4JrpAJvjX60SXz8j8nsqjBOQ9roo/0ueVs1lb48+bOIrI
         SlZO+o6cSPbEK2azAr2u9EyHPAUb1MlkxrgQPbCMKt5EEo1nRjpjF0oSqE5fULB/0l
         YSCajf8mMfRi/oSKB1PvmBquwHNHnB/G7rg2awh0=
Date:   Fri, 30 Oct 2020 08:29:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, yibin.gong@nxp.com, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mn-evk: Add cpu-supply to enable cpufreq
Message-ID: <20201030002924.GX28755@dragon>
References: <1601259703-28308-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601259703-28308-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 10:21:43AM +0800, Anson Huang wrote:
> PMIC driver is ready on i.MX8MN EVK board, assign cpu-supply for
> each A53 and restore the operating points table to enable cpufreq.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
