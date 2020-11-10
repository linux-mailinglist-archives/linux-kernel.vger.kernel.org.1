Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9492AD388
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgKJKWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgKJKWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:22:47 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD65FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:22:47 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c20so11011983pfr.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6PCWqJl8pEDfipLVn6gpQAIGHDMdj/6ZpzXCO5aKsP0=;
        b=cCDN01If9WxCbn3wlPtOgAWBXC8RXki0IMQ7eAc7vSTfx8z5CcT6LGi1fjGXEJX2dl
         /FTINyjvC4A5tQSh7z2YzYyURdHL+WAmqMNpD/jkn0QY3fFv/Fq6JFRiC1s1pbdJ1fp7
         xPXKl+lyLmwwOSmdGJknqyxxQS9ori2vr707t9PtF+oG7fTnAEOBewNFaO71bb+RBSDE
         2m1WKxuZWS4pFR5MedsDkmJcjN1aWYI/k9auM5dUa5u5KkFvUqpmMMEX5lXEOOoikKGf
         pHeYdndZrDXuCV5/q6vyVfhjUeB8tp9+9AIpAU9ut/MMmc9L9ikazGQD/skzHl7SuU7R
         V4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6PCWqJl8pEDfipLVn6gpQAIGHDMdj/6ZpzXCO5aKsP0=;
        b=gBYwJripJpskDyaVD+rcJrnLeLp9pSaNjzHhc0bXaYk4n+t3Fofntgk2CIEozOSoTN
         WAxT7S68hjxEXCUjxzE200wYwNQDL15jrncmfrvwa91Z9OQrn7GYPRYqT/rtwUrcFn/0
         /fz4i4ITK4n7cAedSDZwDqSKNfZu+1zSlcKplJDB1i8cySRouae1f0tFOOEKYqsnNJPh
         c9WvSSCstI6Ims2DW8FkAbpsK9SueFaXyQT4Ys4i2wJiaJCHe1ZOr45X6l5Fts//+7iu
         aDDZB0VCglBh+SP7VUNfIdnSq3AyYhQW16oiq0rQb8m9fOHtkQh/5MqoRCRf9bVu3MPa
         duLw==
X-Gm-Message-State: AOAM530HtEg3f48I+Rm0RvBReSPzO9yxS7Hl88ZVLmtXTKAkaraPiv5/
        VkvtW9ozWbtMbNLDDJ5RDH/RHA==
X-Google-Smtp-Source: ABdhPJyMkgBTPKTtQjxxUPWrUBQPn/9Ogtr19DRB6tkNsxAeWbSx/2YrWNdPLHw9T02YgBLcNTUCmg==
X-Received: by 2002:a17:90b:118d:: with SMTP id gk13mr4340143pjb.6.1605003767087;
        Tue, 10 Nov 2020 02:22:47 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.127.239.100])
        by smtp.gmail.com with ESMTPSA id 12sm2897410pjn.19.2020.11.10.02.22.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 02:22:46 -0800 (PST)
Date:   Tue, 10 Nov 2020 18:22:41 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/22] perf arm-spe: Consolidate arm_spe_pkt_desc()'s
 return value
Message-ID: <20201110102241.GA18189@leoy-ThinkPad-X240s>
References: <20201106014136.14103-1-leo.yan@linaro.org>
 <20201106014136.14103-8-leo.yan@linaro.org>
 <478837ab-5477-ef17-fe6a-6ea24311d904@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <478837ab-5477-ef17-fe6a-6ea24311d904@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 04:52:35PM +0000, André Przywara wrote:
> On 06/11/2020 01:41, Leo Yan wrote:
> > arm_spe_pkt_desc() returns the length of consumed the buffer for
> > the success case; otherwise, it delivers the return value from
> > arm_spe_pkt_snprintf(), and returns the last return value if there have
> > multiple calling arm_spe_pkt_snprintf().
> > 
> > Since arm_spe_pkt_snprintf() has the same semantics with vsnprintf() for
> > the return value, and vsnprintf() might return value equals to or bigger
> > than the parameter 'size' to indicate the truncation.  Because the
> > return value is >= 0 when the string is truncated, this condition will
> > be returned up the stack as "success".
> > 
> > This patch simplifies the return value for arm_spe_pkt_desc(): '0' means
> > success and other values mean an error has occurred.  To realize this,
> > it relies on arm_spe_pkt_snprintf()'s parameter 'err', the 'err' is a
> > cumulative value, returns its final value if printing buffer is called
> > for one time or multiple times.
> > 
> > To unify the error value generation, this patch handles error in a
> > central place, rather than directly bailing out in switch-cases,
> > it returns error at the end of arm_spe_pkt_desc().
> 
> And the but-last hunk means it will basically always return 0?

Yes, if the buffer is overflow, the last chunk code tries to rollback
to dump the packet name, payload's raw data nd packet index.  So in
theory, it should always return 0.

> Just checking, it's probably fine (and I don't want to review a v8 ;-)

> > This patch changes the caller arm_spe_dump() to respect the updated
> > return value semantics of arm_spe_pkt_desc().
> > 
> > Suggested-by: Dave Martin <Dave.Martin@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> One tiny thing below ...
> 
> > ---
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 128 +++++++++---------
> >  tools/perf/util/arm-spe.c                     |   2 +-
> >  2 files changed, 68 insertions(+), 62 deletions(-)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > index 1970686f7020..33baef0c2c0b 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > @@ -301,9 +301,10 @@ static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
> >  int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >  		     size_t buf_len)
> >  {
> > -	int ret, ns, el, idx = packet->index;
> > +	int ns, el, idx = packet->index;
> >  	unsigned long long payload = packet->payload;
> >  	const char *name = arm_spe_pkt_name(packet->type);
> > +	char *buf_orig = buf;
> >  	size_t blen = buf_len;
> >  	int err = 0;
> >  
> > @@ -311,82 +312,76 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >  	case ARM_SPE_BAD:
> >  	case ARM_SPE_PAD:
> >  	case ARM_SPE_END:
> > -		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
> > +		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
> > +		break;
> >  	case ARM_SPE_EVENTS:
> > -		ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
> > +		arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
> >  
> >  		if (payload & 0x1)
> > -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
> >  		if (payload & 0x2)
> > -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
> >  		if (payload & 0x4)
> > -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-ACCESS");
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-ACCESS");
> >  		if (payload & 0x8)
> > -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-REFILL");
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-REFILL");
> >  		if (payload & 0x10)
> > -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-ACCESS");
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-ACCESS");
> >  		if (payload & 0x20)
> > -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-REFILL");
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-REFILL");
> >  		if (payload & 0x40)
> > -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
> >  		if (payload & 0x80)
> > -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
> >  		if (idx > 1) {
> >  			if (payload & 0x100)
> > -				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
> > +				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
> >  			if (payload & 0x200)
> > -				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
> > +				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
> >  			if (payload & 0x400)
> > -				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
> > +				arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
> >  		}
> > -		if (ret < 0)
> > -			return ret;
> > -		blen -= ret;
> > -		return buf_len - blen;
> > +		break;
> >  	case ARM_SPE_OP_TYPE:
> >  		switch (idx) {
> >  		case 0:
> > -			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen,
> >  					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
> > +			break;
> >  		case 1:
> > -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen,
> > -						   payload & 0x1 ? "ST" : "LD");
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen,
> > +					     payload & 0x1 ? "ST" : "LD");
> >  
> >  			if (payload & 0x2) {
> >  				if (payload & 0x4)
> > -					ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " AT");
> > +					arm_spe_pkt_snprintf(&err, &buf, &blen, " AT");
> >  				if (payload & 0x8)
> > -					ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
> > +					arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
> >  				if (payload & 0x10)
> > -					ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
> > +					arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
> >  			} else if (payload & 0x4) {
> > -				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
> > +				arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
> >  			}
> > -
> > -			if (ret < 0)
> > -				return ret;
> > -			blen -= ret;
> > -			return buf_len - blen;
> > -
> > +			break;
> >  		case 2:
> > -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
> >  
> >  			if (payload & 0x1)
> > -				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
> > +				arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
> >  			if (payload & 0x2)
> > -				ret = arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
> > -
> > -			if (ret < 0)
> > -				return ret;
> > -			blen -= ret;
> > -			return buf_len - blen;
> > +				arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
> >  
> > +			break;
> >  		default:
> > -			return 0;
> > +			/* Unknown index */
> > +			err = -1;
> > +			break;
> >  		}
> > +		break;
> >  	case ARM_SPE_DATA_SOURCE:
> >  	case ARM_SPE_TIMESTAMP:
> > -		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %lld", name, payload);
> > +		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %lld", name, payload);
> > +		break;
> >  	case ARM_SPE_ADDRESS:
> >  		switch (idx) {
> >  		case 0:
> > @@ -394,48 +389,59 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >  			ns = !!(packet->payload & NS_FLAG);
> >  			el = (packet->payload & EL_FLAG) >> 61;
> >  			payload &= ~(0xffULL << 56);
> > -			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen,
> >  					"%s 0x%llx el%d ns=%d",
> >  				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
> > +			break;
> >  		case 2:
> > -			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> > -						    "VA 0x%llx", payload);
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen,
> > +					     "VA 0x%llx", payload);
> > +			break;
> >  		case 3:
> >  			ns = !!(packet->payload & NS_FLAG);
> >  			payload &= ~(0xffULL << 56);
> > -			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> > -						    "PA 0x%llx ns=%d", payload, ns);
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen,
> > +					     "PA 0x%llx ns=%d", payload, ns);
> > +			break;
> >  		default:
> > -			return 0;
> > +			/* Unknown index */
> > +			err = -1;
> > +			break;
> >  		}
> > +		break;
> >  	case ARM_SPE_CONTEXT:
> > -		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%lx el%d",
> > -					    name, (unsigned long)payload, idx + 1);
> > +		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%lx el%d",
> > +				     name, (unsigned long)payload, idx + 1);
> > +		break;
> >  	case ARM_SPE_COUNTER:
> > -		ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %d ", name,
> > -					   (unsigned short)payload);
> > +		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %d ", name,
> > +				     (unsigned short)payload);
> >  		switch (idx) {
> >  		case 0:
> > -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "TOT");
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, "TOT");
> >  			break;
> >  		case 1:
> > -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "ISSUE");
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, "ISSUE");
> >  			break;
> >  		case 2:
> > -			ret = arm_spe_pkt_snprintf(&err, &buf, &blen, "XLAT");
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, "XLAT");
> >  			break;
> >  		default:
> > -			ret = 0;
> >  			break;
> >  		}
> > -		if (ret < 0)
> > -			return ret;
> > -		blen -= ret;
> > -		return buf_len - blen;
> > +		break;
> >  	default:
> > +		/* Unknown index */
> > +		err = -1;
> >  		break;
> >  	}
> >  
> > -	return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%llx (%d)",
> > -				    name, payload, packet->index);
> > +	/* Output raw data if detect any error */
> > +	if (err) {
> > +		err = 0;
> > +		arm_spe_pkt_snprintf(&err, &buf_orig, &blen, "%s 0x%llx (%d)",
> 
> That needs to be &buf_len here, doesn't it?

Oops :)  Good catching; will fix.

> With that fixed:
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks for the review and very detailed testing in the patch 06/22.

Leo

> Cheers,
> Andre
> 
> > +				     name, payload, packet->index);
> > +	}
> > +
> > +	return err;
> >  }
> > diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> > index 3882a5360ada..8901a1656a41 100644
> > --- a/tools/perf/util/arm-spe.c
> > +++ b/tools/perf/util/arm-spe.c
> > @@ -113,7 +113,7 @@ static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
> >  		if (ret > 0) {
> >  			ret = arm_spe_pkt_desc(&packet, desc,
> >  					       ARM_SPE_PKT_DESC_MAX);
> > -			if (ret > 0)
> > +			if (!ret)
> >  				color_fprintf(stdout, color, " %s\n", desc);
> >  		} else {
> >  			color_fprintf(stdout, color, " Bad packet!\n");
> > 
> 
