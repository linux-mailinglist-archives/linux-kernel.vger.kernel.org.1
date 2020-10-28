Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0104F29D6CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbgJ1WS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:18:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731777AbgJ1WRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:45 -0400
Received: from localhost (unknown [122.171.163.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA535247E3;
        Wed, 28 Oct 2020 16:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603901476;
        bh=PjhjCUh6ngLcEub9CREF+3mTMHHnnlz0AmI3vEMzvr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ks84iaq+RBoATI9Tmn30QsE+38dKjNk8exjNOf0Ch2T9+qGSGwQkY4jZdsvF7wanx
         ADvi57TGIrJNAJ6g+o6Pd+cO+4p85qP2aTPAZkdLmLzZ9Ep+dexI934wpDDMTkvg7u
         Yv8lyBjBoGgtFl4cwOtlPJV8f4Gh3jxp9LSTeAQ4=
Date:   Wed, 28 Oct 2020 21:41:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] phy: usb: Fix incorrect clearing of tca_drv_sel bit in
 SETUP reg for 7211
Message-ID: <20201028161112.GR3550@vkoul-mobl>
References: <20201002190115.48017-1-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002190115.48017-1-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-10-20, 15:01, Al Cooper wrote:
> The 7211a0 has a tca_drv_sel bit in the USB SETUP register that
> should never be enabled. This feature is only used if there is a
> USB Type-C PHY, and the 7211 does not have one. If the bit is
> enabled, the VBUS signal will never be asserted. In the 7211a0,
> the bit was incorrectly defaulted to on so the driver had to clear
> the bit. In the 7211c0 the state was inverted so the driver should
> no longer clear the bit. This hasn't been a problem because all
> current 7211 boards don't use the VBUS signal, but there are some
> future customer boards that may use it.

Applied, thanks

-- 
~Vinod
