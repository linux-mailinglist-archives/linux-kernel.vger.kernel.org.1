Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C522743DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgIVOMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:12:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgIVOMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:12:10 -0400
Received: from localhost (unknown [122.179.101.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2202214F1;
        Tue, 22 Sep 2020 14:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600783930;
        bh=Vpf2pL0jUPCJ9oLBoH8Nc83YU38iF7sBREy78UoNZn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XOwjQrtY92EHRCu84I+ncl+Cq8Q/ty/e8j2e6ZwxvOxK5IT5S81fFuP9Itsi0PDkG
         bj12PPd48fICfv25yqZsiU7aOsc5KxPEQBde6zXINZbnc5sAbLbKQ0Am12iqSKKylv
         Wc/s+MqSJ4WUmxdDkLMtZbe3LMmQYgGEbrRgSbMk=
Date:   Tue, 22 Sep 2020 19:42:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Li Yin <yin1.li@intel.com>,
        Vadivel Murugan R <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH -next] phy: fix USB_LGM_PHY warning & build errors
Message-ID: <20200922141202.GZ2968@vkoul-mobl>
References: <d1dd0ddd-3143-5777-1c63-195e1a32f237@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1dd0ddd-3143-5777-1c63-195e1a32f237@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-09-20, 10:51, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix a Kconfig warning that is causing lots of build errors
> when USB_SUPPORT is not set.
> 
> USB_PHY depends on USB_SUPPORT but "select" doesn't care about
> dependencies, so this driver should also depend on USB_SUPPORT.
> It should not select USB_SUPPORT.
> 
> WARNING: unmet direct dependencies detected for USB_PHY
>   Depends on [n]: USB_SUPPORT [=n]
>   Selected by [m]:
>   - USB_LGM_PHY [=m]

Applied, thanks

-- 
~Vinod
