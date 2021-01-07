Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5EE2EC8B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 04:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbhAGDDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 22:03:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbhAGDDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:03:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0134230F9;
        Thu,  7 Jan 2021 03:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609988554;
        bh=5POtNIBpsbV3nGDAuGJ/qLzCMfqiTwIC9EhIKZ9GUAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sjqXHqa3oN8rq78uKjyb1MZ9XGqN0+MM3DsCg3VTLpSpXiJCa+mj5E0ObvF7w3vN3
         6iIAbpYmhzrnR75F3smPRKgaxsq/CaOZkBxHYew1xvXjOIgzRv2mOQwFXOaDpDReZB
         IQLF/3LJN6uBCliCca3WzYmtXLjQIPjuRgo3Q3bv+iGarRWvcoN/ElSp2v1bJV1bLP
         yNGExisXOIRHthgVleMRcMoez7ffO77SW/xabl1D/haRdCQom+BDnJvXqIf2RlD26j
         pecvFwrQtqANm2SUH9wBxTcWLndDbgA2iynrKxBT0PQsW9BVESQexvJr584AGVBJqT
         2L8QUoxJhkelw==
Date:   Thu, 7 Jan 2021 11:02:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com
Subject: Re: [PATCH 0/3] Add sound card support for imx8mn-evk board
Message-ID: <20210107030228.GQ4142@dragon>
References: <1607332356-13431-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607332356-13431-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 05:12:33PM +0800, Shengjiu Wang wrote:
> Support wm8524 and spdif sound card.
> 
> Shengjiu Wang (3):
>   arm64: dts: imx8mn: Configure clock rate for audio plls
>   arm64: dts: imx8mn-evk: Add sound-wm8524 card nodes
>   arm64: dts: imx8mn-evk: Add sound-spdif card nodes

Applied all, thanks.
