Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6186424CD28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 07:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgHUFQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 01:16:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgHUFQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 01:16:44 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54B0D21734;
        Fri, 21 Aug 2020 05:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597987004;
        bh=Iy83bYwnLCjvIXMukxznaSN4QfSseL5th92EoimnnD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xy/B/UXWhz06U0zd6oAiLdm06hBFGiNZMpWH9iu+ZWZP5Kj3KkNOyeB+0MSM/6K35
         1qqCBBbKtAE+AEzaPM1TpTYkJ42/IgzTtoEculxqC0fcULnqwdmzusm193IFzI2Vpt
         hwPLdledDyTmxOk0Ht4iGZdnMv4JNwv6OBBbTyLU=
Date:   Fri, 21 Aug 2020 10:46:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Roger Quadros <rogerq@ti.com>, kishon@ti.com, vigneshr@ti.com,
        jan.kiszka@siemens.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] phy: omap-usb2-phy: disable PHY charger detect
Message-ID: <20200821051640.GL2639@vkoul-mobl>
References: <20200820133937.32504-1-rogerq@ti.com>
 <a3b3e82c-983b-928c-156e-13d43636aa36@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3b3e82c-983b-928c-156e-13d43636aa36@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-20, 20:27, Sekhar Nori wrote:
> On 8/20/20 7:09 PM, Roger Quadros wrote:
> > AM654x PG1.0 has a silicon bug that D+ is pulled high after POR, which
> > could cause enumeration failure with some USB hubs.  Disabling the
> > USB2_PHY Charger Detect function will put D+ into the normal state.
> > 
> > This addresses Silicon Errata:
> > i2075 - "USB2PHY: USB2PHY Charger Detect is Enabled by Default Without VBUS
> > Presence"
> > 
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> + Vinod as well

Thanks, can you please rebase and resend these patches. I dont have
them in my inbox

Regards
-- 
~Vinod
