Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9B427B040
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgI1OsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 10:48:02 -0400
Received: from foss.arm.com ([217.140.110.172]:52748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgI1OsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:48:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE3041063;
        Mon, 28 Sep 2020 07:48:00 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7B633F73B;
        Mon, 28 Sep 2020 07:47:58 -0700 (PDT)
Date:   Mon, 28 Sep 2020 15:47:56 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Wei Li <liwei391@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] perf: arm_spe: Decode SVE events
Message-ID: <20200928144755.GI6642@arm.com>
References: <20200922101225.183554-1-andre.przywara@arm.com>
 <20200922101225.183554-6-andre.przywara@arm.com>
 <20200928132114.GF6642@arm.com>
 <8efd63eb-5ae7-0f9a-6c37-ef5e68af4e6c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8efd63eb-5ae7-0f9a-6c37-ef5e68af4e6c@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 02:59:34PM +0100, André Przywara wrote:
> On 28/09/2020 14:21, Dave Martin wrote:
> 
> Hi Dave,
> 
> > On Tue, Sep 22, 2020 at 11:12:25AM +0100, Andre Przywara wrote:
> >> The Scalable Vector Extension (SVE) is an ARMv8 architecture extension
> >> that introduces very long vector operations (up to 2048 bits).
> > 
> > (8192, in fact, though don't expect to see that on real hardware any
> > time soon...  qemu and the Arm fast model can do it, though.)
> > 
> >> The SPE profiling feature can tag SVE instructions with additional
> >> properties like predication or the effective vector length.
> >>
> >> Decode the new operation type bits in the SPE decoder to allow the perf
> >> tool to correctly report about SVE instructions.
> > 
> > 
> > I don't know anything about SPE, so just commenting on a few minor
> > things that catch my eye here.
> 
> Many thanks for taking a look!
> Please note that I actually missed a prior submission by Wei, so the
> code changes here will end up in:
> https://lore.kernel.org/patchwork/patch/1288413/
> 
> But your two points below magically apply to his patch as well, so....
> 
> > 
> >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >> ---
> >>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 48 ++++++++++++++++++-
> >>  1 file changed, 47 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> >> index a033f34846a6..f0c369259554 100644
> >> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> >> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> >> @@ -372,8 +372,35 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >>  	}
> >>  	case ARM_SPE_OP_TYPE:
> >>  		switch (idx) {
> >> -		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
> >> +		case 0: {
> >> +			size_t blen = buf_len;
> >> +
> >> +			if ((payload & 0x89) == 0x08) {
> >> +				ret = snprintf(buf, buf_len, "SVE");
> >> +				buf += ret;
> >> +				blen -= ret;
> > 
> > (Nit: can ret be < 0 ?  I've never been 100% clear on this myself for
> > the s*printf() family -- if this assumption is widespread in perf tool
> > a lready that I guess just go with the flow.)
> 
> Yeah, some parts of the code in here check for -1, actually, but doing
> this on every call to snprintf would push this current code over the
> edge - and I cowardly avoided a refactoring ;-)
> 
> Please note that his is perf userland, and also we are printing constant
> strings here.
> Although admittedly this starts to sounds like an excuse now ...
> 
> > I wonder if this snprintf+increment+decrement sequence could be wrapped
> > up as a helper, rather than having to be repeated all over the place.
> 
> Yes, I was hoping nobody would notice ;-)

It's probably not worth losing sleep over.

snprintf(3) says, under NOTES:

	Until glibc 2.0.6, they would return -1 when the output was
	truncated.

which is probably ancient enough history that we don't care.  C11 does
say that a negative return value can happen "if an encoding error
occurred".  _Probably_ not a problem if perf tool never calls
setlocale(), but ...


> >> +				if (payload & 0x2)
> >> +					ret = snprintf(buf, buf_len, " FP");
> >> +				else
> >> +					ret = snprintf(buf, buf_len, " INT");
> >> +				buf += ret;
> >> +				blen -= ret;
> >> +				if (payload & 0x4) {
> >> +					ret = snprintf(buf, buf_len, " PRED");
> >> +					buf += ret;
> >> +					blen -= ret;
> >> +				}
> >> +				/* Bits [7..4] encode the vector length */
> >> +				ret = snprintf(buf, buf_len, " EVLEN%d",
> >> +					       32 << ((payload >> 4) & 0x7));
> > 
> > Isn't this just extracting 3 bits (0x7)? 
> 
> Ah, right, the comment is wrong. It's actually bits [6:4].
> 
> > And what unit are we aiming
> > for here: is it the number of bytes per vector, or something else?  I'm
> > confused by the fact that this will go up in steps of 32, which doesn't
> > seem to match up to the architecure.
> 
> So this is how SPE encodes the effective vector length in its payload:
> the format is described in section "D10.2.7 Operation Type packet" in a
> (recent) ARMv8 ARM. I put the above statement in a C file and ran all
> input values through it, it produced the exact *bit* length values as in
> the spec.
> 
> Is there any particular pattern you are concerned about?
> I admit this is somewhat hackish, I can do an extra function to put some
> comments in there.

Mostly I'm curious because the encoding doesn't match the SVE
architecture: SVE requires 4 bits to specify the vector length, not 3.
This might have been a deliberate limitation in the SPE spec., but it
raises questions about what should happen when 3 bits is not enough.

For SVE, valid vector lengths are 16 bytes * n
or equivalently 128 bits * n), where 1 <= n <= 16.

The code here though cannot print EVLEN16 or EVLEN48 etc.  This might
not be a bug, but I'd like to understand where it comes from...

> 
> > 
> > I notice that bit 7 has to be zero to get into this if() though.
> > 
> >> +				buf += ret;
> >> +				blen -= ret;
> >> +				return buf_len - blen;
> >> +			}
> >> +
> >> +			return snprintf(buf, buf_len, "%s", payload & 0x1 ?
> >>  					"COND-SELECT" : "INSN-OTHER");
> >> +			}
> >>  		case 1:	{
> >>  			size_t blen = buf_len;
> >>  
> >> @@ -403,6 +430,25 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >>  				ret = snprintf(buf, buf_len, " NV-SYSREG");
> >>  				buf += ret;
> >>  				blen -= ret;
> >> +			} else if ((payload & 0x0a) == 0x08) {
> >> +				ret = snprintf(buf, buf_len, " SVE");
> >> +				buf += ret;
> >> +				blen -= ret;
> >> +				if (payload & 0x4) {
> >> +					ret = snprintf(buf, buf_len, " PRED");
> >> +					buf += ret;
> >> +					blen -= ret;
> >> +				}
> >> +				if (payload & 0x80) {
> >> +					ret = snprintf(buf, buf_len, " SG");
> >> +					buf += ret;
> >> +					blen -= ret;
> >> +				}
> >> +				/* Bits [7..4] encode the vector length */
> >> +				ret = snprintf(buf, buf_len, " EVLEN%d",
> >> +					       32 << ((payload >> 4) & 0x7));
> > 
> > Same comment as above.  Maybe have a common helper for decoding the
> > vector length bits so it can be fixed in a single place?
> 
> Yup. Although I wonder if this is the smallest of the problems with this
> function going forward.
> 
> Cheers,
> Andre

Fair enough.

Cheers
---Dave
