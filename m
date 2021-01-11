Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF39C2F0B11
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 03:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbhAKCra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 21:47:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbhAKCr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 21:47:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 602CD22473;
        Mon, 11 Jan 2021 02:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610333209;
        bh=AwyhIyBVhJBgmElONOSlam9Zn/Uqknq6a29IeC4rDvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZgDQzqwskkpBWaEthHhCUvL/1SUME8rPiWu/HC7d9s5aajpe6Mdi4o36EtMEZ9dy
         oK3ADtvUTvoj6UvS5+3vGGuYlSBbpohBiqfvP+hmQrQhMCYYAY9Hhx5lYpTTToXjP0
         3f2ld8Pfw4rF2WnWa4K3GtlmzbYwr2tGFY73DIktofGb1STdPMkjn4pdIIB/5w3stN
         eQnKn9mZYp/qWAJ8lrgF1MccERYb6JE/fDwT3wmS4vkqBnW3KrY+grkfzTyTN3+oLu
         naa1lvwX7nYTz8Ju7xVMYUE/jTQFiE38/GjBz1+S39G0QkG9Xlf2MSbJmOshrj/4mm
         LUcd3fI79lYmA==
Date:   Mon, 11 Jan 2021 10:46:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, krzk@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH v10 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Message-ID: <20210111024642.GX28365@dragon>
References: <20210104091544.13972-1-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104091544.13972-1-alice.guo@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 05:15:41PM +0800, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Add DT Binding doc for the Unique ID of i.MX 8M series.
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>

Applied all, thanks.
