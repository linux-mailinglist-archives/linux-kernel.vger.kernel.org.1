Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5167F21D1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 10:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgGMImu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 04:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgGMImu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:42:50 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41D742065D;
        Mon, 13 Jul 2020 08:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594629769;
        bh=LdpccAyFI9fwuNnhYayjz6SRpq8yPiOMVCzMMC8edko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wQea3l5lI81XSLWVUP3saRauJMWMv0MmAfpJjhvGRZqqmliYdYBPyVCBDuNI/Q+fE
         53qOHTFG0fTDVXqnvcv+nHInea+VsShUCt6YaLtfZ98MQA9BjZvU1IqQjw+oKDerz2
         1rucuvvy4xYSbfYVHugnolSnPBLQIyYQgRcL4bCw=
Date:   Mon, 13 Jul 2020 16:42:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, aisheng.dong@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] soc: imx: select ARM_GIC_V3 for i.MX8M
Message-ID: <20200713084244.GE15718@dragon>
References: <1594345433-18001-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594345433-18001-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 09:43:53AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Select ARM_GIC_V3, then it is able to use gic v3 driver in aarch32
> mode linux on aarch64 hardware. For aarch64 mode, it not hurts
> to select ARM_GIC_V3.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
