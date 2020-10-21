Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4582C2947B5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 07:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440373AbgJUFKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 01:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407494AbgJUFKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 01:10:38 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F89DC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 22:10:38 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id p21so545034pju.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 22:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JSYEAwO8kwY23nUIbHWdCP2r6lidkT8y2RiZZHaBypM=;
        b=l+Gf6mdDYFRtshSr5/+q58pfGWe6XCJPEXuZQzYw6GYeAjjUpd+AAxpEUYh61XtFbH
         hcBwRk6mMA1cWGA8pTGulcySy4XDgonqRzsSkR7LQlAIgvfT4GKQVLCmMnVv2CLk5IrG
         15tCRdF1zlyixQGqlD0nZXOMywnhdxTZnKG0nOm9gFJQ99xvKg7E3FW3mKMe0TTL0wOA
         2rddxXkPtXkjTIDtV4TIHgK308q//Ms/wanvQT4TF44tMBBnmfLQha6q1w6mo/Zn5ra+
         tt6dd9bMcRfBt5TXW+h7ttTIZ37ok9W/d9nxWk62esdJtgph3Rpdq2a3pTNLWITTCypV
         UJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JSYEAwO8kwY23nUIbHWdCP2r6lidkT8y2RiZZHaBypM=;
        b=neh4Y/8Ap1i1t/zdhOtaV/SNyPwOPv+r4R4rUR5RUmQC4fYBL8sOvpcM1RPVKCDr/1
         e0Qg83GC1QF2XbYUBK0q12FQokUOYPpdKCgBXvdR3kg7S1xWp6oybJk4h3lQksyI4sp5
         /9C2dU/sOmu4g45PdSpVZ2ectARLvFfO4WTh8SXbjnU4iOW8Z4Z/M8gb3KXooqlC3GFG
         DN7baQj3HGjlS+8EyxKeMDjRTjng2VWQ6W3GyIWrQ61JZtnn+Fr5jaNxPsncstocYKql
         CfEsmQMbvIMiStTGkRajy5nDCIr1BardrDxyEjGQf7c1KOJRcSKhOijPpOelPzJLP6YS
         k1Jw==
X-Gm-Message-State: AOAM533Qis1cPJcdNGzGiibzPNZHCmxz+Bkg1DDFon9rHqVtkpjQ7wF9
        17W5r8fp4Vikf58RbkkvAkguTw==
X-Google-Smtp-Source: ABdhPJxt8mJb1U64sMOS54fE8PGTJ9+0OCY5Mr5RwEPTWOxJxYIEx/3WqcA51bQ4mfT8l7lZ/8kBTw==
X-Received: by 2002:a17:90a:ce8c:: with SMTP id g12mr1449694pju.185.1603257037578;
        Tue, 20 Oct 2020 22:10:37 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([14.192.49.12])
        by smtp.gmail.com with ESMTPSA id k127sm871096pgk.10.2020.10.20.22.10.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Oct 2020 22:10:36 -0700 (PDT)
Date:   Wed, 21 Oct 2020 13:10:31 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org, Al Grant <Al.Grant@arm.com>
Subject: Re: [PATCH v2 14/14] perf arm-spe: Add support for ARMv8.3-SPE
Message-ID: <20201021051031.GE7226@leoy-ThinkPad-X240s>
References: <20200929133917.9224-1-leo.yan@linaro.org>
 <20200929133917.9224-15-leo.yan@linaro.org>
 <9c74082b-fccf-7713-b98d-50da76c5d7af@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c74082b-fccf-7713-b98d-50da76c5d7af@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:54:44PM +0100, André Przywara wrote:
> On 29/09/2020 14:39, Leo Yan wrote:
> 
> Hi,
> 
> > From: Wei Li <liwei391@huawei.com>
> > 
> > This patch is to support Armv8.3 extension for SPE, it adds alignment
> > field in the Events packet and it supports the Scalable Vector Extension
> > (SVE) for Operation packet and Events packet with two additions:
> > 
> >   - The vector length for SVE operations in the Operation Type packet;
> >   - The incomplete predicate and empty predicate fields in the Events
> >     packet.
> > 
> > Signed-off-by: Wei Li <liwei391@huawei.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 84 ++++++++++++++++++-
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.h     |  6 ++
> >  2 files changed, 87 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > index 05a4c74399d7..3ec381fddfcb 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > @@ -342,14 +342,73 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >  					return ret;
> >  			}
> >  		}
> > +		if (idx > 2) {
> 
> As I mentioned in the other patch, I doubt this extra comparison is
> useful. Does that protect us from anything?

It's the same reason with Event packet which have explained for replying
patch 10, the condition is to respect the SPE specifiction:

  E[11], byte 1, bit [11], when SZ == 0b10 , or SZ == 0b11
     Alignment.
     ...
     Otherwise this bit reads-as-zero.

So we gives higher priority for checking payload size than the Event
bit setting; if you have other thinking for this, please let me know.

> > +			if (payload & SPE_EVT_PKT_ALIGNMENT) {
> 
> Mmh, but this is bit 11, right?

Yes.

> So would need to go into the (idx > 1)
> section (covering bits 8-15)? Another reason to ditch this comparison above.

As has explained in patch 10, idx is not the same thing with "sz"
field; "idx" stands for payload length in bytes, so:

  idx = 1 << sz

The spec defines the sz is 2 or 3, thus idx is 4 or 8; so this is why
here use the condition "(idx > 2)".

I think here need to refine code for more explict expression so can
avoid confusion.  So I think it's better to condition such like:

  if (payload_len >= 4) {

     ...

  }

> > +				ret = snprintf(buf, buf_len, " ALIGNMENT");
> > +				if (ret < 0)
> > +					return ret;
> > +				buf += ret;
> > +				blen -= ret;
> 
> Shouldn't we use the new arm_spe_pkt_snprintf() function here as well?
> Or is there a reason that this doesn't work?

Goot point.  Will change to use arm_spe_pkt_snprintf().

> > +			}
> > +			if (payload & SPE_EVT_PKT_SVE_PARTIAL_PREDICATE) {
> > +				ret = snprintf(buf, buf_len, " SVE-PARTIAL-PRED");
> > +				if (ret < 0)
> > +					return ret;
> > +				buf += ret;
> > +				blen -= ret;
> > +			}
> > +			if (payload & SPE_EVT_PKT_SVE_EMPTY_PREDICATE) {
> > +				ret = snprintf(buf, buf_len, " SVE-EMPTY-PRED");
> > +				if (ret < 0)
> > +					return ret;
> > +				buf += ret;
> > +				blen -= ret;
> > +			}
> > +		}
> > +
> >  		return buf_len - blen;
> >  
> >  	case ARM_SPE_OP_TYPE:
> >  		switch (idx) {
> >  		case SPE_OP_PKT_HDR_CLASS_OTHER:
> > -			return arm_spe_pkt_snprintf(&buf, &blen,
> > -					payload & SPE_OP_PKT_OTHER_SUBCLASS_COND ?
> > -					"COND-SELECT" : "INSN-OTHER");
> > +			if ((payload & SPE_OP_PKT_OTHER_SVE_SUBCLASS_MASK) ==
> > +					SPE_OP_PKT_OTHER_SUBCLASS_SVG_OP) {
> > +
> > +				ret = arm_spe_pkt_snprintf(&buf, &blen, "SVE-OTHER");
> > +				if (ret < 0)
> > +					return ret;
> > +
> > +				/* Effective vector length: step is 32 bits */
> > +				ret = arm_spe_pkt_snprintf(&buf, &blen, " EVLEN %d",
> > +					32 << ((payload & SPE_OP_PKT_SVE_EVL_MASK) >>
> > +						SPE_OP_PKT_SVE_EVL_SHIFT));
> 
> Can you move this into a macro, and add a comment about how this works?
> People might get confused over the "32 << something".

Yeah, will refine for it.

Thanks,
Leo
