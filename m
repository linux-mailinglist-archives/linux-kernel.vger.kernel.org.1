Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC052FED79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbhAUNet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:34:49 -0500
Received: from foss.arm.com ([217.140.110.172]:36720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732279AbhAUNd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:33:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21AEB11B3;
        Thu, 21 Jan 2021 05:32:39 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.35.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CEB63F68F;
        Thu, 21 Jan 2021 05:32:37 -0800 (PST)
Date:   Thu, 21 Jan 2021 13:32:35 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
Subject: Re: [RFC PATCH 7/7] irqchip/apple-aic: add SMP support to the Apple
 AIC driver.
Message-ID: <20210121133235.GG48431@C02TD0UTHF1T.local>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-8-mohamed.mediouni@caramail.com>
 <CAK8P3a1qeVxTxZXpfMe70zpPCSBrTOz23ZTR=PHgw0PP9GUvbw@mail.gmail.com>
 <E77005CF-8B2A-4D17-9330-72ECFD7F3C93@caramail.com>
 <71e94b48857cbdd21c5d6bdadf148621@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71e94b48857cbdd21c5d6bdadf148621@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 01:22:37PM +0000, Marc Zyngier wrote:
> On 2021-01-21 12:50, Mohamed Mediouni wrote:
> > > On 21 Jan 2021, at 13:44, Arnd Bergmann <arnd@kernel.org> wrote:
> > > 
> > > On Wed, Jan 20, 2021 at 2:27 PM Mohamed Mediouni
> 
> [...]
> 
> > > > +       aic.fast_ipi = of_property_read_bool(node, "fast-ipi");
> > > 
> > > Where is this property documented, and what decides which one to use?
> > It’s getting documented in the next patch set.
> > 
> > This property is there to enable support for older iPhone processors
> > later on, some of which do not have fast IPI support.
> > 
> > On Apple M1, fast-ipi is always on.
> 
> Then please focus on a single implementation. Additional features can
> always be merged later once something is up and running.
> 
> Also, there sysregs can be detected by matching the MIDR, so I don't
> think we need a DT property for that.

Generally we do not detect IMP-DEF sysregs based on MIDR because they
won't necessarily be exposed to a VM, so I suspect that we do need DT
properties to describe that IMP-DEF sysregs are accessible, and should
not rely on the MIDR alone. Maybe that's implicit in another property,
but worth bearing in mind.

Thanks,
Mark.
