Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3B82D7CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 18:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405394AbgLKRau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 12:30:50 -0500
Received: from foss.arm.com ([217.140.110.172]:42150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405183AbgLKRar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:30:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C90771FB;
        Fri, 11 Dec 2020 09:30:01 -0800 (PST)
Received: from bogus (unknown [10.57.54.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFFAD3F718;
        Fri, 11 Dec 2020 09:29:59 -0800 (PST)
Date:   Fri, 11 Dec 2020 17:29:53 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] firmware: smccc: Add SMCCC TRNG function call IDs
Message-ID: <20201211172953.rzljlefxy7qjd5wm@bogus>
References: <20201211160005.187336-1-andre.przywara@arm.com>
 <20201211160005.187336-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211160005.187336-2-andre.przywara@arm.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 04:00:01PM +0000, Andre Przywara wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The ARM architected TRNG firmware interface, described in ARM spec
> DEN0098, define an ARM SMCCC based interface to a true random number
> generator, provided by firmware.
> 
> Add the definitions of the SMCCC functions as defined by the spec.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
