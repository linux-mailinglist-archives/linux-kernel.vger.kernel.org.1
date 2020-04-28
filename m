Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6041BB928
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 10:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgD1Iuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 04:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgD1Iuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:50:35 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB15F206B9;
        Tue, 28 Apr 2020 08:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588063834;
        bh=hLMWpEDI26F/FaYQHonyCM62/7WmXicw7oJ3Vyoy5fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0c2FJkRrQFDS+eqYj4OIKpDHN/O+HVTEJuLSvCdyLuc1A3nYBOXz9vpoQIK/u6aH/
         akSB8tH0MdvandMDGmov6mAnJFVwbBamzXgCziHAqvtGnufLTAAnbqo9ih/6AS3FXh
         GU27XxgSGI/wGzP4ikZxl/VPyFaZ0uPpYOCY5T3E=
Date:   Tue, 28 Apr 2020 16:50:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, robh+dt@kernel.org,
        jaswinder.singh@linaro.org, linux@rempel-privat.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: imx8qxp: support scu mailbox channel
Message-ID: <20200428085019.GB32592@dragon>
References: <1586870668-32630-1-git-send-email-peng.fan@nxp.com>
 <1586870668-32630-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586870668-32630-2-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 09:24:28PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> With mailbox driver support i.MX8 SCU MU channel, we could
> use it to avoid trigger interrupts for each TR/RR registers
> in one MU, instead, only one RX interrupt for a recv and
> one TX interrupt for a send.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
