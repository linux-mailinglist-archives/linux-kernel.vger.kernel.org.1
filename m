Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707A92DC39A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 16:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgLPP7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 10:59:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgLPP7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 10:59:05 -0500
Date:   Wed, 16 Dec 2020 15:58:20 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, will@kernel.org, yj.chiang@mediatek.com
Subject: Re: [PATCH] arm64: Kconfig: Add SYS_SUPPORTS_APM_EMULATION
Message-ID: <20201216155820.GH2511@gaia>
References: <20201125103637.GC70906@C02TD0UTHF1T.local>
 <20201125114130.507-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125114130.507-1-lecopzer.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 07:41:30PM +0800, Lecopzer Chen wrote:
> >> In order to select CONFIG_APM_EMULATION, make SYS_SUPPORTS_APM_EMULATION
> >> default is y if ACPI isn't configured.
> >
> >I'm a bit confused why this should be enabled for !ACPI. Which DT
> >platforms need this, and how do they use it? Why should this only be
> >enabled for kernels without ACPI support, and not for kernels that
> >support both ACPI and DT?
> 
> In our internal patch has no !ACPI here,
> the reason I add here is that in kernel document[1] it mention:
> > No, sorry, you cannot have both ACPI and APM enabled and running at once.
> Thus, I try to limit the scope for who don't use the ACPI because I'm not sure
> they could exist at the same time or not.
> 
> But I think it should be fine without !ACPI if APM and APCI
> config won't conflict with each other.
> 
> So if it's better to remove !ACPI I'll send v2 for this.
> 
> BTW, The platform is for our internal kernel drivers, they utilize APM interface,
> /dev/apm_bios to do their works in arm64.

Sorry, I don't think the APM interface makes sense on an arm64 kernel
(and it's also used by an out of tree driver).

-- 
Catalin
