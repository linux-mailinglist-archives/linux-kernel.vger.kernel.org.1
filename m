Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0E627E6B5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgI3KeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:34:17 -0400
Received: from foss.arm.com ([217.140.110.172]:33708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3KeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:34:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F9C8D6E;
        Wed, 30 Sep 2020 03:34:16 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C41B3F70D;
        Wed, 30 Sep 2020 03:34:14 -0700 (PDT)
Date:   Wed, 30 Sep 2020 11:34:11 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Al Grant <Al.Grant@arm.com>,
        Will Deacon <will@kernel.org>,
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
        Wei Li <liwei391@huawei.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] perf: arm_spe: Decode SVE events
Message-ID: <20200930103409.GP6642@arm.com>
References: <20200922101225.183554-1-andre.przywara@arm.com>
 <20200922101225.183554-6-andre.przywara@arm.com>
 <20200928132114.GF6642@arm.com>
 <8efd63eb-5ae7-0f9a-6c37-ef5e68af4e6c@arm.com>
 <20200928144755.GI6642@arm.com>
 <20200929021902.GA16749@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200929021902.GA16749@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 10:19:02AM +0800, Leo Yan wrote:
> On Mon, Sep 28, 2020 at 03:47:56PM +0100, Dave Martin wrote:
> > On Mon, Sep 28, 2020 at 02:59:34PM +0100, André Przywara wrote:
> > > On 28/09/2020 14:21, Dave Martin wrote:
> > > 
> > > Hi Dave,
> > > 
> > > > On Tue, Sep 22, 2020 at 11:12:25AM +0100, Andre Przywara wrote:
> > > >> The Scalable Vector Extension (SVE) is an ARMv8 architecture extension
> > > >> that introduces very long vector operations (up to 2048 bits).
> > > > 
> > > > (8192, in fact, though don't expect to see that on real hardware any
> > > > time soon...  qemu and the Arm fast model can do it, though.)
> > > > 
> > > >> The SPE profiling feature can tag SVE instructions with additional
> > > >> properties like predication or the effective vector length.
> > > >>
> > > >> Decode the new operation type bits in the SPE decoder to allow the perf
> > > >> tool to correctly report about SVE instructions.
> > > > 
> > > > 
> > > > I don't know anything about SPE, so just commenting on a few minor
> > > > things that catch my eye here.
> > > 
> > > Many thanks for taking a look!
> > > Please note that I actually missed a prior submission by Wei, so the
> > > code changes here will end up in:
> > > https://lore.kernel.org/patchwork/patch/1288413/
> > > 
> > > But your two points below magically apply to his patch as well, so....
> > > 
> > > > 
> > > >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > >> ---
> > > >>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 48 ++++++++++++++++++-
> > > >>  1 file changed, 47 insertions(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > >> index a033f34846a6..f0c369259554 100644
> > > >> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > >> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > >> @@ -372,8 +372,35 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> > > >>  	}
> > > >>  	case ARM_SPE_OP_TYPE:
> > > >>  		switch (idx) {
> > > >> -		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
> > > >> +		case 0: {
> > > >> +			size_t blen = buf_len;
> > > >> +
> > > >> +			if ((payload & 0x89) == 0x08) {
> > > >> +				ret = snprintf(buf, buf_len, "SVE");
> > > >> +				buf += ret;
> > > >> +				blen -= ret;
> > > > 
> > > > (Nit: can ret be < 0 ?  I've never been 100% clear on this myself for
> > > > the s*printf() family -- if this assumption is widespread in perf tool
> > > > a lready that I guess just go with the flow.)
> > > 
> > > Yeah, some parts of the code in here check for -1, actually, but doing
> > > this on every call to snprintf would push this current code over the
> > > edge - and I cowardly avoided a refactoring ;-)
> > > 
> > > Please note that his is perf userland, and also we are printing constant
> > > strings here.
> > > Although admittedly this starts to sounds like an excuse now ...
> > > 
> > > > I wonder if this snprintf+increment+decrement sequence could be wrapped
> > > > up as a helper, rather than having to be repeated all over the place.
> > > 
> > > Yes, I was hoping nobody would notice ;-)
> > 
> > It's probably not worth losing sleep over.
> > 
> > snprintf(3) says, under NOTES:
> > 
> > 	Until glibc 2.0.6, they would return -1 when the output was
> > 	truncated.
> > 
> > which is probably ancient enough history that we don't care.  C11 does
> > say that a negative return value can happen "if an encoding error
> > occurred".  _Probably_ not a problem if perf tool never calls
> > setlocale(), but ...
> 
> I have one patch which tried to fix the snprintf+increment sequence
> [1], to be honest, the change seems urgly for me.  I agree it's better
> to use a helper to wrap up.
> 
> [1] https://lore.kernel.org/patchwork/patch/1288410/

Sure, putting explicit checks all over the place makes a lot of noise in
the code.

I was wondering whether something along the following lines would work:

	/* ... */

	if (payload & SVE_EVT_PKT_GEN_EXCEPTION)
		buf_appendf_err(&buf, &buf_len, &ret, " EXCEPTION-GEN");
	if (payload & SVE_EVT_PKT_ARCH_RETIRED)
		buf_appendf_err(&buf, &buf_len, &ret, " RETIRED");
	if (payload & SVE_EVT_PKT_L1D_ACCESS)
		buf_appendf_err(&buf, &buf_len, &ret, " L1D-ACCESS");

	/* ... */

	if (ret)
		return ret;

[...]

Best to keep such refactoring independent of this series though.

Cheers
---Dave
