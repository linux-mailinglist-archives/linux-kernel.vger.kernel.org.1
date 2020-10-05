Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6694F2833DE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 12:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgJEKPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 06:15:50 -0400
Received: from foss.arm.com ([217.140.110.172]:43256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgJEKPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 06:15:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F90D113E;
        Mon,  5 Oct 2020 03:15:49 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E1C83F66B;
        Mon,  5 Oct 2020 03:15:46 -0700 (PDT)
Date:   Mon, 5 Oct 2020 11:15:44 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Wei Li <liwei391@huawei.com>
Subject: Re: [PATCH 5/5] perf: arm_spe: Decode SVE events
Message-ID: <20201005101541.GQ6642@arm.com>
References: <20200922101225.183554-1-andre.przywara@arm.com>
 <20200922101225.183554-6-andre.przywara@arm.com>
 <20200928132114.GF6642@arm.com>
 <8efd63eb-5ae7-0f9a-6c37-ef5e68af4e6c@arm.com>
 <20200928144755.GI6642@arm.com>
 <20200929021902.GA16749@leoy-ThinkPad-X240s>
 <20200930103409.GP6642@arm.com>
 <20200930110453.GB9968@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930110453.GB9968@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 07:04:53PM +0800, Leo Yan wrote:

[...]

> > > > > >> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > > > >> index a033f34846a6..f0c369259554 100644
> > > > > >> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > > > >> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > > > >> @@ -372,8 +372,35 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> > > > > >>  	}
> > > > > >>  	case ARM_SPE_OP_TYPE:
> > > > > >>  		switch (idx) {
> > > > > >> -		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
> > > > > >> +		case 0: {
> > > > > >> +			size_t blen = buf_len;
> > > > > >> +
> > > > > >> +			if ((payload & 0x89) == 0x08) {
> > > > > >> +				ret = snprintf(buf, buf_len, "SVE");
> > > > > >> +				buf += ret;
> > > > > >> +				blen -= ret;
> > > > > > 
> > > > > > (Nit: can ret be < 0 ?  I've never been 100% clear on this myself for
> > > > > > the s*printf() family -- if this assumption is widespread in perf tool
> > > > > > a lready that I guess just go with the flow.)
> > > > > 
> > > > > Yeah, some parts of the code in here check for -1, actually, but doing
> > > > > this on every call to snprintf would push this current code over the
> > > > > edge - and I cowardly avoided a refactoring ;-)
> > > > > 
> > > > > Please note that his is perf userland, and also we are printing constant
> > > > > strings here.
> > > > > Although admittedly this starts to sounds like an excuse now ...
> > > > > 
> > > > > > I wonder if this snprintf+increment+decrement sequence could be wrapped
> > > > > > up as a helper, rather than having to be repeated all over the place.
> > > > > 
> > > > > Yes, I was hoping nobody would notice ;-)
> > > > 
> > > > It's probably not worth losing sleep over.
> > > > 
> > > > snprintf(3) says, under NOTES:
> > > > 
> > > > 	Until glibc 2.0.6, they would return -1 when the output was
> > > > 	truncated.
> > > > 
> > > > which is probably ancient enough history that we don't care.  C11 does
> > > > say that a negative return value can happen "if an encoding error
> > > > occurred".  _Probably_ not a problem if perf tool never calls
> > > > setlocale(), but ...
> > > 
> > > I have one patch which tried to fix the snprintf+increment sequence
> > > [1], to be honest, the change seems urgly for me.  I agree it's better
> > > to use a helper to wrap up.
> > > 
> > > [1] https://lore.kernel.org/patchwork/patch/1288410/
> > 
> > Sure, putting explicit checks all over the place makes a lot of noise in
> > the code.
> > 
> > I was wondering whether something along the following lines would work:
> > 
> > 	/* ... */
> > 
> > 	if (payload & SVE_EVT_PKT_GEN_EXCEPTION)
> > 		buf_appendf_err(&buf, &buf_len, &ret, " EXCEPTION-GEN");
> > 	if (payload & SVE_EVT_PKT_ARCH_RETIRED)
> > 		buf_appendf_err(&buf, &buf_len, &ret, " RETIRED");
> > 	if (payload & SVE_EVT_PKT_L1D_ACCESS)
> > 		buf_appendf_err(&buf, &buf_len, &ret, " L1D-ACCESS");
> > 
> > 	/* ... */
> > 
> > 	if (ret)
> > 		return ret;
> > 
> > [...]
> 
> I have sent out the patch v2 [1] and Cc'ed you; I used a similiar API
> definition with your suggestion:
> 
>   static int arm_spe_pkt_snprintf(char **buf_p, size_t *blen,
>  				  const char *fmt, ...)
> 
> Only a difference is when return from arm_spe_pkt_snprintf(), will check
> the return value and directly bail out when detect failure.  Your input
> will be considered for next spin.
> 
> > Best to keep such refactoring independent of this series though.
> 
> Yeah, the patch set [2] is quite heavy; after get some reviewing,
> maybe need to consider to split into 2 or even 3 small patch sets.
> 
> Thanks a lot for your suggestions!
>
> Leo

No problem, your approach seems reasonable to me.

Cheers
---Dave

> [1] https://lore.kernel.org/patchwork/patch/1314603/
> [2] https://lore.kernel.org/patchwork/cover/1314599/
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
