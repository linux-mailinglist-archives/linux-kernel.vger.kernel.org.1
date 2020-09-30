Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F31227E75C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 13:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgI3LFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 07:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgI3LFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 07:05:03 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05443C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 04:05:03 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d23so820562pll.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 04:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JJYQrBdSm8SVfWUamUu8kolSU+H/tu2hxah3v/KgVJo=;
        b=XBoZ/FIm18NNdvtVcfhgfXLm9pOCDfLBxx7//afNzP9oETWinPLk8IJPUWzO+Uf2Ta
         oKosDQjD8FEXd2wGRt+JtoOkVZujUsoXm977DOpS3LZ+cswE4sKLcqRvbVgUleWiS5JV
         4F6E1vwnk407vLf44QQbLk8eDbFK2ftbCyV7WhuH7/7ZX7MB91cEMAaJWa/4N2PKJDWE
         f44W+j32kgtdZuTm2kTX5fIwizqpbHHmHMc+TWKTQcuOM9HLtmIEKYWVaaZedLDDehhC
         K1oi4gGOCtG/8hITmrRpGrXI1UtpkqSSrFaRjDoupyTbCSGrRA0WY4i041k07zE0xMVX
         CSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JJYQrBdSm8SVfWUamUu8kolSU+H/tu2hxah3v/KgVJo=;
        b=ouR9Xg/B6cDszi3J/pVtKzW48oszfe3p7n7aHMV1RtW97TQ++aDzyRtoQ+X+oYZUBh
         BQRZztw9NeNhSy8oJn28kaOv+wT9LNXkfx2p0Pb9IcUTnyaD/qU0jx9IllObj2bMFQ9Z
         iEfJwqg60dxrFfFl8DZ39GYmo0h6apltlnQ94fMUXPSdSsNKKEgQ3Xe5jf8RxKgZRGJ7
         EsjPYdVLZSsPsF1o4lKcqxpLqfQSdjIltMTrLbBZmBVpkQZ6TdPqm0k9z/rXAz/wmhMO
         uj1F/syeHiIxu6sl5+eewj1ER1vdHQ9od/TrjLLs57KCHvFCQclf77Dj43C2Ul1g/V6Y
         j0yw==
X-Gm-Message-State: AOAM531m1GBd+ZlE9+lwd6IwTDxr5CQQK2orc/xalEghEd4Np8oh9wAA
        vm4CZpY3T1c67fHhEPx9PpGPyw==
X-Google-Smtp-Source: ABdhPJyBTErywS/BjG9OzprzBZramQ+q+ZvDS9limkkTSM1ut0yZYkjK6smb/SCYZD9lZtmDgkLSQg==
X-Received: by 2002:a17:90a:2a03:: with SMTP id i3mr2036605pjd.43.1601463902222;
        Wed, 30 Sep 2020 04:05:02 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id x140sm2069167pfc.211.2020.09.30.04.04.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 04:05:01 -0700 (PDT)
Date:   Wed, 30 Sep 2020 19:04:53 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Dave Martin <Dave.Martin@arm.com>
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
Message-ID: <20200930110453.GB9968@leoy-ThinkPad-X240s>
References: <20200922101225.183554-1-andre.przywara@arm.com>
 <20200922101225.183554-6-andre.przywara@arm.com>
 <20200928132114.GF6642@arm.com>
 <8efd63eb-5ae7-0f9a-6c37-ef5e68af4e6c@arm.com>
 <20200928144755.GI6642@arm.com>
 <20200929021902.GA16749@leoy-ThinkPad-X240s>
 <20200930103409.GP6642@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930103409.GP6642@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Wed, Sep 30, 2020 at 11:34:11AM +0100, Dave Martin wrote:

[...]

> > > > >> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > > >> index a033f34846a6..f0c369259554 100644
> > > > >> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > > >> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > > >> @@ -372,8 +372,35 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> > > > >>  	}
> > > > >>  	case ARM_SPE_OP_TYPE:
> > > > >>  		switch (idx) {
> > > > >> -		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
> > > > >> +		case 0: {
> > > > >> +			size_t blen = buf_len;
> > > > >> +
> > > > >> +			if ((payload & 0x89) == 0x08) {
> > > > >> +				ret = snprintf(buf, buf_len, "SVE");
> > > > >> +				buf += ret;
> > > > >> +				blen -= ret;
> > > > > 
> > > > > (Nit: can ret be < 0 ?  I've never been 100% clear on this myself for
> > > > > the s*printf() family -- if this assumption is widespread in perf tool
> > > > > a lready that I guess just go with the flow.)
> > > > 
> > > > Yeah, some parts of the code in here check for -1, actually, but doing
> > > > this on every call to snprintf would push this current code over the
> > > > edge - and I cowardly avoided a refactoring ;-)
> > > > 
> > > > Please note that his is perf userland, and also we are printing constant
> > > > strings here.
> > > > Although admittedly this starts to sounds like an excuse now ...
> > > > 
> > > > > I wonder if this snprintf+increment+decrement sequence could be wrapped
> > > > > up as a helper, rather than having to be repeated all over the place.
> > > > 
> > > > Yes, I was hoping nobody would notice ;-)
> > > 
> > > It's probably not worth losing sleep over.
> > > 
> > > snprintf(3) says, under NOTES:
> > > 
> > > 	Until glibc 2.0.6, they would return -1 when the output was
> > > 	truncated.
> > > 
> > > which is probably ancient enough history that we don't care.  C11 does
> > > say that a negative return value can happen "if an encoding error
> > > occurred".  _Probably_ not a problem if perf tool never calls
> > > setlocale(), but ...
> > 
> > I have one patch which tried to fix the snprintf+increment sequence
> > [1], to be honest, the change seems urgly for me.  I agree it's better
> > to use a helper to wrap up.
> > 
> > [1] https://lore.kernel.org/patchwork/patch/1288410/
> 
> Sure, putting explicit checks all over the place makes a lot of noise in
> the code.
> 
> I was wondering whether something along the following lines would work:
> 
> 	/* ... */
> 
> 	if (payload & SVE_EVT_PKT_GEN_EXCEPTION)
> 		buf_appendf_err(&buf, &buf_len, &ret, " EXCEPTION-GEN");
> 	if (payload & SVE_EVT_PKT_ARCH_RETIRED)
> 		buf_appendf_err(&buf, &buf_len, &ret, " RETIRED");
> 	if (payload & SVE_EVT_PKT_L1D_ACCESS)
> 		buf_appendf_err(&buf, &buf_len, &ret, " L1D-ACCESS");
> 
> 	/* ... */
> 
> 	if (ret)
> 		return ret;
> 
> [...]

I have sent out the patch v2 [1] and Cc'ed you; I used a similiar API
definition with your suggestion:

  static int arm_spe_pkt_snprintf(char **buf_p, size_t *blen,
 				  const char *fmt, ...)

Only a difference is when return from arm_spe_pkt_snprintf(), will check
the return value and directly bail out when detect failure.  Your input
will be considered for next spin.

> Best to keep such refactoring independent of this series though.

Yeah, the patch set [2] is quite heavy; after get some reviewing,
maybe need to consider to split into 2 or even 3 small patch sets.

Thanks a lot for your suggestions!

Leo

[1] https://lore.kernel.org/patchwork/patch/1314603/
[2] https://lore.kernel.org/patchwork/cover/1314599/
