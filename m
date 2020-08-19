Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D760A24A0F5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 15:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgHSN7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 09:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgHSN7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:59:40 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF183204FD;
        Wed, 19 Aug 2020 13:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597845580;
        bh=+D3smgI5UYuv8+FESQ5SimLMUbGU6pQoXa4AqKQ/NqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=thKHKVpxE4xIxBVCsNSKxL+COHpxzGkgG2RIzPmzOX2RPGHCGOtcpSoWa2ZiQgskx
         MWeJAdNAHrLqwC/1HYmDJc37ALy6NanHmMYn1rKfaJ8U5z4tjBiM63hAkzw7KJfIqo
         NQuObG8ZsrFfsiLFhJ2uKHI6LjagB4tQH0DcmZco=
Date:   Wed, 19 Aug 2020 21:59:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, arnd@arndb.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Support i.MX8MN/P/Q
Message-ID: <20200819135926.GF7114@dragon>
References: <1595926504-6121-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595926504-6121-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 04:55:04PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MN/P/Q is built with AArch64 hardware, this is to support
> it could run in AArch32 mode with clock and pinctrl driver enabled.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks. 
