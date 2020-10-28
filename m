Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1B729D6B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbgJ1WRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731614AbgJ1WRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:35 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 790E62467F;
        Wed, 28 Oct 2020 09:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603875603;
        bh=cfMIr4fiYF0NJu/rh8yiKL35w1hV0pyU5UEChNa3ttE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VIcyYBCFd4e9EnAQjitL0PQde4hS6319Ew6Hcf0AavpS6jOU740NJBAxGj7ZAI51B
         oY/o0ucqkLK3nLeKYR9P7t6GEgWQesEAzR8VHSfSgUNF9wYWnUQyeQf8x6c9L/Bh76
         wunuNh9rO1/nH3v2CFU6MaUv5GKvD9fP6FRLNbqI=
Date:   Wed, 28 Oct 2020 16:59:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, abel.vesa@nxp.com,
        kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com
Subject: Re: [PATCH] firmware: imx: add dummy functions
Message-ID: <20201028085953.GI28755@dragon>
References: <1600770269-30619-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600770269-30619-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 06:24:29PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> add dummy functions to avoid build failure when header files
> are included, but drivers are not built.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
