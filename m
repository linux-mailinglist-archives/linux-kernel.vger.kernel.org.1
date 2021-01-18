Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E392FA2B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392844AbhARORZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:17:25 -0500
Received: from foss.arm.com ([217.140.110.172]:36868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392705AbhAROPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:15:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7772A1FB;
        Mon, 18 Jan 2021 06:14:36 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.39.202])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08AA53F68F;
        Mon, 18 Jan 2021 06:14:32 -0800 (PST)
Date:   Mon, 18 Jan 2021 14:14:29 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Alexander Potapenko <glider@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v3 3/4] arm64: mte: Enable async tag check fault
Message-ID: <20210118141429.GC31263@C02TD0UTHF1T.local>
References: <20210115120043.50023-1-vincenzo.frascino@arm.com>
 <20210115120043.50023-4-vincenzo.frascino@arm.com>
 <20210118125715.GA4483@gaia>
 <c076b1cc-8ce5-91a0-9957-7dcd78026b18@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c076b1cc-8ce5-91a0-9957-7dcd78026b18@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 01:37:35PM +0000, Vincenzo Frascino wrote:
> On 1/18/21 12:57 PM, Catalin Marinas wrote:

> >> +	if (tfsr_el1 & SYS_TFSR_EL1_TF1) {
> >> +		write_sysreg_s(0, SYS_TFSR_EL1);
> >> +		isb();
> > While in general we use ISB after a sysreg update, I haven't convinced
> > myself it's needed here. There's no side-effect to updating this reg and
> > a subsequent TFSR access should see the new value.
> 
> Why there is no side-effect?

Catalin's saying that the value of TFSR_EL1 doesn't affect anything
other than a read of TFSR_EL1, i.e. there are no indirect reads of
TFSR_EL1 where the value has an effect, so there are no side-effects.

Looking at the ARM ARM, no synchronization is requires from a direct
write to an indirect write (per ARM DDI 0487F.c table D13-1), so I agree
that we don't need the ISB here so long as there are no indirect reads.

Are you aware of cases where the TFSR_EL1 value is read other than by an
MRS? e.g. are there any cases where checks are elided if TF1 is set? If
so, we may need the ISB to order the direct write against subsequent
indirect reads.

Thanks,
Mark.
