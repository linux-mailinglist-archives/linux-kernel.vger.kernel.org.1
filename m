Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483D32A9899
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 16:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbgKFPfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 10:35:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgKFPfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 10:35:15 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7CB2208C7;
        Fri,  6 Nov 2020 15:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604676914;
        bh=paZN7AmMflubbnBs/ZRVSzsc+RrX8RA/W7ofJ5ThUB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C/vLytVCM05e1EYByu8kmhzsDIqP+J60oRAVf5w8r/c+cO4NuYXpPOrI9VBJuwAPv
         NxpwfRGFFH9zfC7W+h6pzbrx6TGo2RMsVwoPPFO51fmX1iygQvk7L/B5nZtEsepCaI
         qxWEvsSRPSSfVAsVGIsKsB+FAQ/gkVJsHZbLtTBs=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kb3lg-008Ej3-NW; Fri, 06 Nov 2020 15:35:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Nov 2020 15:35:12 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/5] ARM: implement support for SMCCC TRNG entropy
 source
In-Reply-To: <CAMj1kXHfRpA906eDq6-yo-FbhvNbXYa5vs1xhAr7zG43VTP_QQ@mail.gmail.com>
References: <20201105125656.25259-1-andre.przywara@arm.com>
 <20201105125656.25259-4-andre.przywara@arm.com>
 <7b36daa49c78d60dc788bbb3c9c1bdaa@misterjones.org>
 <CAMj1kXHfRpA906eDq6-yo-FbhvNbXYa5vs1xhAr7zG43VTP_QQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <a9ba945763b6dc2b21d48561192f6e3f@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: ardb@kernel.org, andre.przywara@arm.com, will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk, lorenzo.pieralisi@arm.com, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, broonie@kernel.org, sudeep.holla@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-06 15:30, Ard Biesheuvel wrote:
> On Fri, 6 Nov 2020 at 16:30, Marc Zyngier <maz@misterjones.org> wrote:

[...]

>> I don't think this cast is safe. At least not on 64bit.
> 
> True, but this is arch/arm

I think the glasses theme becomes recurrent. Apologies for the noise.

         M.
-- 
Jazz is not dead. It just smells funny...
