Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5A221CD99
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 05:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgGMDWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 23:22:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMDWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:22:17 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EB08206E2;
        Mon, 13 Jul 2020 03:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594610537;
        bh=59mZYRNAzcxgHIO3OMwPaOI3VjJIXJrdO39yAFq5mxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9Z8rFVc8LGG0fLJt9zmjolvrFqpVzB2yq3XuaRC2J07hHBD1n3J607TuXx3/ywIP
         zcMjQigf7sjNMbHtNL3fvWoLp+F2cyinbykF5LwUuTcxxVxogZCWv6rhI7wYkNni9T
         mrRzVZ4Qz4H+IDWOZGnCQgHvPTfwrP0wjvsM1DxU=
Date:   Mon, 13 Jul 2020 11:22:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6ul: Add ASRC device node
Message-ID: <20200713032207.GC21277@dragon>
References: <1593575216-19921-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593575216-19921-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 11:46:56AM +0800, Shengjiu Wang wrote:
> Add ASRC device node.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Applied, thanks.
