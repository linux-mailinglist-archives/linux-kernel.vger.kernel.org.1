Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1A527A0DF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 14:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgI0MXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 08:23:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgI0MXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 08:23:05 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B203023718;
        Sun, 27 Sep 2020 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601209385;
        bh=Xgly9v4XEPuR30uhx1ZZu3rViR4F43g5mliPOHLVQ0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Pe4zmgC6zFGnlaN4douRj3DBnUjzV5Gim64cWqjW32eNcLH3+juDR6fkXxCjHYev
         i5Pha3VC4RTg8O0rWsE6YhiIYi8O4MVM/pmsSPa1H4g/3BEPkoHpyAMS5d3uZk6kai
         cXIjhG45jiUAknCeW4KQ0Pz4FRI2dHsYiyn/dilE=
Date:   Sun, 27 Sep 2020 14:23:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     b_lkasam@codeaurora.org
Cc:     broonie@kernel.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH] regmap: irq: Add support to clear ack registers
Message-ID: <20200927122315.GA179084@kroah.com>
References: <1601036740-23044-1-git-send-email-lkasam@codeaurora.org>
 <65dd6c86415a3d8f565160ca0cd66f2c@codeaurora.org>
 <553eabe7ebfb94ac2e76323ef339634b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <553eabe7ebfb94ac2e76323ef339634b@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 07:14:01PM +0530, b_lkasam@codeaurora.org wrote:
> For particular codec HWs have requirement to
> writing interrupt clear and mask interrupt clear
> register to toggle interrupt status. To accommodate it,
> need to add one more field (clear_ack) in the regmap_irq
> struct and update regmap-irq driver to support it.
> 
> Signed-off-by: Laxminath Kasam <lkasam@codeaurora.org>
> ---
>  drivers/base/regmap/regmap-irq.c | 52
> ++++++++++++++++++++++++++++++++++++----
>  include/linux/regmap.h           |  2 ++
>  2 files changed, 49 insertions(+), 5 deletions(-)

Patch is line-wrapped :(

