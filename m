Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909D32A806C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgKEOLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:11:00 -0500
Received: from foss.arm.com ([217.140.110.172]:33630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730681AbgKEOK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:10:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46B7314BF;
        Thu,  5 Nov 2020 06:10:59 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC2653F719;
        Thu,  5 Nov 2020 06:10:58 -0800 (PST)
Date:   Thu, 5 Nov 2020 14:10:57 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        souvik.chakravarty@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: implement CPPC FFH support using AMUs
Message-ID: <20201105141057.GB22244@arm.com>
References: <20201105122702.13916-1-ionela.voinescu@arm.com>
 <20201105122702.13916-4-ionela.voinescu@arm.com>
 <20201105132823.GG82102@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105132823.GG82102@C02TD0UTHF1T.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thursday 05 Nov 2020 at 13:28:23 (+0000), Mark Rutland wrote:
[..]
> > +#ifdef CONFIG_ACPI_CPPC_LIB
> > +#include <acpi/cppc_acpi.h>
> 
> As mentioned on patch 1, I think it'd be better to open-code the smp
> call functions here, e.g.
> 
> static void cpu_read_corecnt(void *val)
> {
> 	*(u64 *)val = read_corecnt()
> }
> 
> static void cpu_read_constcnt(void *val)
> {
> 	*(u64 *)val = read_constcnt()
> }
> 
> ... as they're only needed here and it's much clearer what they're
> doing in-context. I think that would als oget rid of the warning you
> mention in the cover letter.
> 

Many thanks for the review. I was tempted by the fewer lines of code of
the macro, for that very simple functionality of the counter reads, but
your arguments against it make sense.

I'll change this and 1/3 and push v4 later today.

Regards,
Ionela.
