Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBE22ACAF0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 03:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbgKJCRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 21:17:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKJCRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 21:17:47 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A29CD206B6;
        Tue, 10 Nov 2020 02:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604974666;
        bh=Z2YKuS5E9HnIPJvgzwiP2pZ8tz9wbpvCvI1ZS9WjtdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UKX7MWJK4asbJspSFmKpUjwwkLoUNeF08iaBbRZFmvJjpXKZ1rLuqizEJA78XAY5i
         90A483I/S9yxejc1oPqyVtmyoE9h2V6dBvKGWRGxSmGhZiTkvaNvvR3Zj8PjFudslu
         6nM32XXpFK/rp6c9dNNqJ+/2LqUbBc0k1kIeGESw=
Date:   Tue, 10 Nov 2020 10:17:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] clk: imx: scu: Make pd_np with static keyword
Message-ID: <20201110021738.GR31601@dragon>
References: <1604488771-40827-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604488771-40827-1-git-send-email-zou_wei@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 07:19:31PM +0800, Zou Wei wrote:
> Fix the following sparse warning:
> 
> ./clk-scu.c:23:20: warning: symbol 'pd_np' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Applied, thanks.
