Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2D72B3DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgKPHtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:49:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:47874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbgKPHtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:49:43 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B44192225E;
        Mon, 16 Nov 2020 07:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605512982;
        bh=sjPBesIJi3zyXIxDps7N7oYZaEQOIv4C1Ue24MRmAX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+1l9mCrbGg2Olh+hXFQsCYUA24kOYPRadbHf5S5VUVy6L05Wlzujpwgu9ZB0fJqA
         nQ6nKyY+djOJBz0aGZ8SplkfojuI2Q9RCHkjsiU/Tkj1bWfx1uqbBNiekbsBblT70V
         p6GsWywEfViYr0RsURSPLEwR2ap+IIXARm77oDNg=
Date:   Mon, 16 Nov 2020 13:19:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     JC Kuo <jckuo@nvidia.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] phy: tegra: Don't warn on probe deferral
Message-ID: <20201116074938.GP7499@vkoul-mobl>
References: <20201111103708.152566-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111103708.152566-1-jonathanh@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-11-20, 10:37, Jon Hunter wrote:
> Deferred probe is an expected return value for devm_regulator_bulk_get().
> Given that the driver deals with it properly, there's no need to output a
> warning that may potentially confuse users.

Applied, thanks

-- 
~Vinod
