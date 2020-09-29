Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B199927BAC4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 04:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgI2CTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 22:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgI2CTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 22:19:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611D2C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 19:19:12 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x16so2604006pgj.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 19:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lQaBqY6VJb803KoPdODFXalC90BAvQ5GzxBqbcjKhGI=;
        b=G6DxSVm/SbQWCx780cgVhlI36BjHX00T8Ux2yJWcYGuPet+iV8W9MVWlTf24P/O3TY
         9lWt+hloK60tdwarBdh92Uvy9Z771JSlSgnOWaK8yz/7EF9m3k26jHV2s/9FN61UpxUG
         M7RuXSoIcdnPFSb6f3llxMHVcFuMAJIXqMHgkpVigUURWwuimJHRWY8p1yM4479Xc2t2
         tkaparzndyOPPkOFmmkr869mOKaI+Dj7sGRGgtHvrMx1W53xAA32VHD4m3ALCl0OacAY
         ZxkRuNp9xyD7yexbCl/Z1ZJEI7+idsitJ5REYjxsBjapO9VdRF9jxrM2n7OWqpclirCb
         6mXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lQaBqY6VJb803KoPdODFXalC90BAvQ5GzxBqbcjKhGI=;
        b=ZBsVx0gox5OSM5PGo2AtOGJRruIa1U/609MwNDF5cXT4b90PpPbXngnf0STT7DeIH1
         zqxkplKt7hUvBeE1p403dG/+G7PNEOkVN/GbCD52gX4DhfGZdTk4N3eyQsLulyzQxmS3
         KB7JiiuOWpUUerj/YbS8kZ/XMMfRJ1WGrAkfTN27vFTzemJzHrGW89aEoLkC844NZHwD
         0HS1jWVb1y2HVrLeJ4p45qFcsjwBh3sbv2jmH+0lOdUTHA9sG+erAIF7ixz/DsPtNZOa
         khP2rFK8P9iwbdrXAPDzUdHD8er4tXF0VFSE5taa+dnCam3a/M1UdSbCqkRQWflLvxt1
         GklQ==
X-Gm-Message-State: AOAM530nlchGX+0rKpjdjcz/ziDBU/BBgxbgAe5YnqEl6zd4dRWD25Th
        iWLVlTBzl68DlU2qHriD/JgjyzRn+COMb6UN
X-Google-Smtp-Source: ABdhPJy+XZRr1qGEsTeUZfNqorpd+qntUhC5OUUunPwMUbFsdqpjZijobKbw/vcJWGvPssbbJJnCtg==
X-Received: by 2002:a63:490d:: with SMTP id w13mr1505126pga.24.1601345951682;
        Mon, 28 Sep 2020 19:19:11 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id m188sm3126554pfd.56.2020.09.28.19.19.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Sep 2020 19:19:10 -0700 (PDT)
Date:   Tue, 29 Sep 2020 10:19:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        linux-arm-kernel@lists.infradead.org, Al Grant <Al.Grant@arm.com>
Subject: Re: [PATCH 5/5] perf: arm_spe: Decode SVE events
Message-ID: <20200929021902.GA16749@leoy-ThinkPad-X240s>
References: <20200922101225.183554-1-andre.przywara@arm.com>
 <20200922101225.183554-6-andre.przywara@arm.com>
 <20200928132114.GF6642@arm.com>
 <8efd63eb-5ae7-0f9a-6c37-ef5e68af4e6c@arm.com>
 <20200928144755.GI6642@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200928144755.GI6642@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 03:47:56PM +0100, Dave Martin wrote:
> On Mon, Sep 28, 2020 at 02:59:34PM +0100, André Przywara wrote:
> > On 28/09/2020 14:21, Dave Martin wrote:
> > 
> > Hi Dave,
> > 
> > > On Tue, Sep 22, 2020 at 11:12:25AM +0100, Andre Przywara wrote:
> > >> The Scalable Vector Extension (SVE) is an ARMv8 architecture extension
> > >> that introduces very long vector operations (up to 2048 bits).
> > > 
> > > (8192, in fact, though don't expect to see that on real hardware any
> > > time soon...  qemu and the Arm fast model can do it, though.)
> > > 
> > >> The SPE profiling feature can tag SVE instructions with additional
> > >> properties like predication or the effective vector length.
> > >>
> > >> Decode the new operation type bits in the SPE decoder to allow the perf
> > >> tool to correctly report about SVE instructions.
> > > 
> > > 
> > > I don't know anything about SPE, so just commenting on a few minor
> > > things that catch my eye here.
> > 
> > Many thanks for taking a look!
> > Please note that I actually missed a prior submission by Wei, so the
> > code changes here will end up in:
> > https://lore.kernel.org/patchwork/patch/1288413/
> > 
> > But your two points below magically apply to his patch as well, so....
> > 
> > > 
> > >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > >> ---
> > >>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 48 ++++++++++++++++++-
> > >>  1 file changed, 47 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > >> index a033f34846a6..f0c369259554 100644
> > >> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > >> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > >> @@ -372,8 +372,35 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> > >>  	}
> > >>  	case ARM_SPE_OP_TYPE:
> > >>  		switch (idx) {
> > >> -		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
> > >> +		case 0: {
> > >> +			size_t blen = buf_len;
> > >> +
> > >> +			if ((payload & 0x89) == 0x08) {
> > >> +				ret = snprintf(buf, buf_len, "SVE");
> > >> +				buf += ret;
> > >> +				blen -= ret;
> > > 
> > > (Nit: can ret be < 0 ?  I've never been 100% clear on this myself for
> > > the s*printf() family -- if this assumption is widespread in perf tool
> > > a lready that I guess just go with the flow.)
> > 
> > Yeah, some parts of the code in here check for -1, actually, but doing
> > this on every call to snprintf would push this current code over the
> > edge - and I cowardly avoided a refactoring ;-)
> > 
> > Please note that his is perf userland, and also we are printing constant
> > strings here.
> > Although admittedly this starts to sounds like an excuse now ...
> > 
> > > I wonder if this snprintf+increment+decrement sequence could be wrapped
> > > up as a helper, rather than having to be repeated all over the place.
> > 
> > Yes, I was hoping nobody would notice ;-)
> 
> It's probably not worth losing sleep over.
> 
> snprintf(3) says, under NOTES:
> 
> 	Until glibc 2.0.6, they would return -1 when the output was
> 	truncated.
> 
> which is probably ancient enough history that we don't care.  C11 does
> say that a negative return value can happen "if an encoding error
> occurred".  _Probably_ not a problem if perf tool never calls
> setlocale(), but ...

I have one patch which tried to fix the snprintf+increment sequence
[1], to be honest, the change seems urgly for me.  I agree it's better
to use a helper to wrap up.

[1] https://lore.kernel.org/patchwork/patch/1288410/

> > >> +				if (payload & 0x2)
> > >> +					ret = snprintf(buf, buf_len, " FP");
> > >> +				else
> > >> +					ret = snprintf(buf, buf_len, " INT");
> > >> +				buf += ret;
> > >> +				blen -= ret;
> > >> +				if (payload & 0x4) {
> > >> +					ret = snprintf(buf, buf_len, " PRED");
> > >> +					buf += ret;
> > >> +					blen -= ret;
> > >> +				}
> > >> +				/* Bits [7..4] encode the vector length */
> > >> +				ret = snprintf(buf, buf_len, " EVLEN%d",
> > >> +					       32 << ((payload >> 4) & 0x7));
> > > 
> > > Isn't this just extracting 3 bits (0x7)? 
> > 
> > Ah, right, the comment is wrong. It's actually bits [6:4].
> > 
> > > And what unit are we aiming
> > > for here: is it the number of bytes per vector, or something else?  I'm
> > > confused by the fact that this will go up in steps of 32, which doesn't
> > > seem to match up to the architecure.
> > 
> > So this is how SPE encodes the effective vector length in its payload:
> > the format is described in section "D10.2.7 Operation Type packet" in a
> > (recent) ARMv8 ARM. I put the above statement in a C file and ran all
> > input values through it, it produced the exact *bit* length values as in
> > the spec.
> > 
> > Is there any particular pattern you are concerned about?
> > I admit this is somewhat hackish, I can do an extra function to put some
> > comments in there.
> 
> Mostly I'm curious because the encoding doesn't match the SVE
> architecture: SVE requires 4 bits to specify the vector length, not 3.
> This might have been a deliberate limitation in the SPE spec., but it
> raises questions about what should happen when 3 bits is not enough.
> 
> For SVE, valid vector lengths are 16 bytes * n
> or equivalently 128 bits * n), where 1 <= n <= 16.
> 
> The code here though cannot print EVLEN16 or EVLEN48 etc.  This might
> not be a bug, but I'd like to understand where it comes from...

In the SPE's spec, the defined values for EVL are:

  0b'000 -> EVLEN: 32 bits.
  0b'001 -> EVLEN: 64 bits.
  0b'010 -> EVLEN: 128 bits.
  0b'011 -> EVLEN: 256 bits.
  0b'100 -> EVLEN: 512 bits.
  0b'101 -> EVLEN: 1024 bits.
  0b'110 -> EVLEN: 2048 bits.

Note that 0b'111 is reserved.  In theory, I think SPE Operation packet
can support up to 4196 bits (32 << 7) when the EVL field is 0b'111; but
it's impossible to express vector length for 8192 bits as you mentioned.

Thanks,
Leo

> > > I notice that bit 7 has to be zero to get into this if() though.
> > > 
> > >> +				buf += ret;
> > >> +				blen -= ret;
> > >> +				return buf_len - blen;
> > >> +			}
> > >> +
> > >> +			return snprintf(buf, buf_len, "%s", payload & 0x1 ?
> > >>  					"COND-SELECT" : "INSN-OTHER");
> > >> +			}
> > >>  		case 1:	{
> > >>  			size_t blen = buf_len;
> > >>  
> > >> @@ -403,6 +430,25 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> > >>  				ret = snprintf(buf, buf_len, " NV-SYSREG");
> > >>  				buf += ret;
> > >>  				blen -= ret;
> > >> +			} else if ((payload & 0x0a) == 0x08) {
> > >> +				ret = snprintf(buf, buf_len, " SVE");
> > >> +				buf += ret;
> > >> +				blen -= ret;
> > >> +				if (payload & 0x4) {
> > >> +					ret = snprintf(buf, buf_len, " PRED");
> > >> +					buf += ret;
> > >> +					blen -= ret;
> > >> +				}
> > >> +				if (payload & 0x80) {
> > >> +					ret = snprintf(buf, buf_len, " SG");
> > >> +					buf += ret;
> > >> +					blen -= ret;
> > >> +				}
> > >> +				/* Bits [7..4] encode the vector length */
> > >> +				ret = snprintf(buf, buf_len, " EVLEN%d",
> > >> +					       32 << ((payload >> 4) & 0x7));
> > > 
> > > Same comment as above.  Maybe have a common helper for decoding the
> > > vector length bits so it can be fixed in a single place?
> > 
> > Yup. Although I wonder if this is the smallest of the problems with this
> > function going forward.
> > 
> > Cheers,
> > Andre
> 
> Fair enough.
> 
> Cheers
> ---Dave
