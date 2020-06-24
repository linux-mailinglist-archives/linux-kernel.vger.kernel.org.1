Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50175206C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 07:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389095AbgFXF4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 01:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388854AbgFXF4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:56:37 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 479F2207DD;
        Wed, 24 Jun 2020 05:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592978197;
        bh=T9HGZgQSFhYHhphxCCK/tAU7Drx348osXhVkKUhD8AU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sb0bLB0DmCTNrKV6F2FraehEKEMOkcrzAAYSYexm7OAEXPPZDuOD7NLhJkzIYsypn
         Zbn1lnR2tnb+aQNldKxBinmXX27vWFI2FBKYkkRnU+ZBo7KGw5t2sFFtPIaOcIqnlm
         2gyFyB9DSyH0ysHUu2b8ljunJvWBiWxTVInddTeQ=
Date:   Wed, 24 Jun 2020 11:26:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Zhou Wang <wangzhou1@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] dmaengine: hisilicon: Use struct_size() in
 devm_kzalloc()
Message-ID: <20200624055633.GY2324254@vkoul-mobl>
References: <20200617211135.GA8660@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617211135.GA8660@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-06-20, 16:11, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.

Applied, thanks

-- 
~Vinod
