Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4514E273F92
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgIVK0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:26:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgIVK0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:26:11 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 348FD2086A;
        Tue, 22 Sep 2020 10:26:08 +0000 (UTC)
Date:   Tue, 22 Sep 2020 11:26:05 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Matheus Castello <matheus@castello.eng.br>,
        Olof Johansson <olof@lixom.net>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, edgar.righi@lsitec.org.br,
        igor.lima@lsitec.org.br, Helen Koike <helen.koike@collabora.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-actions@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v7 4/4] arm64: dts: Add Caninos Loucos Labrador v3
Message-ID: <20200922102605.GE15643@gaia>
References: <20200922024302.205062-1-matheus@castello.eng.br>
 <20200922024302.205062-5-matheus@castello.eng.br>
 <20200922061454.GA29035@Mani-XPS-13-9360>
 <CAK8P3a0yGN80nJU0kcrvYGsSjpaNpU_nmu-ENwE3GMC_9DNBhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0yGN80nJU0kcrvYGsSjpaNpU_nmu-ENwE3GMC_9DNBhg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 10:32:06AM +0200, Arnd Bergmann wrote:
> On Tue, Sep 22, 2020 at 8:15 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > On Mon, Sep 21, 2020 at 11:43:02PM -0300, Matheus Castello wrote:
> > > +     /* Labrador v3 firmware does not support PSCI */
> >
> > Oops. This is unfortunate... I'm not sure if this is even acceptable for
> > ARM64 machines.
> >
> > Let me add Olof and Arnd...
> 
> Adding Catalin and Will for additional input as well, this is more their
> area than ours.
> 
> I don't think we have formalized this as a policy, but we clearly don't
> want new boards to use the spin table hack. As there are other
> boards using psci on the same chip, I don't think this is a
> hardware bug.

I fully agree, we shouldn't allow new boards to use the spin-table
method unless EL3 is missing on the CPU implementation (not the case
here; only the APM hardware has this issue). Unfortunately we missed
another platform with A53, see commit bc66392d8258 ("arm64: dts: fsl:
Add device tree for S32V234-EVB").

The kernel relies on firmware for other things (power management, errata
workarounds), so an SMC calling convention compliant firmware is highly
recommended. I also don't see why it would be that hard to add PSCI.
Even if you don't port something like Trusted Firmware, U-Boot has basic
support for PSCI.

So from my perspective, NAK on this patch.

I'm tempted to also modify smp_spin_table_cpu_init() to print a big
warning and return an error if this is attempted on new platforms. IOW,
we make it a policy from now on.

-- 
Catalin
