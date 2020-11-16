Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E032B3DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgKPHke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:40:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbgKPHkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:40:33 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55FCF2227F;
        Mon, 16 Nov 2020 07:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605512433;
        bh=7jTJCw3S7E2FV8E/VJOv3lfpuh/NrI3VyGnERMHDBes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dOXDYU8tEhQiVWO+awGXLh8L7J8u1TyOQHVwo2wBoIxruw7RcGCzNdPf5qG4M/M03
         wgFN1kPuApRnOLzhl2ipnxZEToAvIm4HnAQtp+tFPGw0n+9ZnR7DlYLVgPzGMToapk
         fqXf1P+NTCXYYOomEWsEP7j7bUz8pwzNzaZdCbYc=
Date:   Mon, 16 Nov 2020 13:10:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: intel: PHY_INTEL_KEEMBAY_EMMC should depend on
 ARCH_KEEMBAY
Message-ID: <20201116074029.GM7499@vkoul-mobl>
References: <20201110144600.3279752-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110144600.3279752-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-11-20, 15:46, Geert Uytterhoeven wrote:
> The Intel Keem Bay eMMC PHY is only present on Intel Keem Bay SoCs.
> Hence add a dependency on ARCH_KEEMBAY, to prevent asking the user about
> this driver when configuring a kernel without Intel Keem Bay platform
> support.

Applied, thanks

-- 
~Vinod
