Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068832A3A83
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 03:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgKCCjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 21:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgKCCjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 21:39:47 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C114CC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 18:39:45 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 10so12915345pfp.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 18:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mn3sDTgYMXJpCfMaBD5+BPDw3JCg+Qnck/DUU21mivQ=;
        b=osEjQlCvvTh/Z3h2iPCDXRK27cYyZ5u/ki+e/6mQEp95ht0sl00At7lw+eFfQNlPsb
         ugfQW5f9L6jZ3iV5PqVYOQZjQ0BAcpnGMJ9NhdibdBA+sWJXBPxG233kwDhB85Znp1LE
         FwrZmxAivHBF+f1bV2TMsQRaaNl+p9CIqHkwbWRsML63/fXfnVdmpT1P6xrDzrc0BR9D
         4/DKgolbmPFSUx8BjUrys9mp7T/J/s5KL7DingYODmZZqLMG+Y/nB2JWjZbPTgrjLiUP
         WKnd7NwWD/AF3a/WAMeUbYM3UlTlAI0Xc/jZ0H4dxtQXDbLSSKNpSE6ubw3V0TZTH8dN
         WETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mn3sDTgYMXJpCfMaBD5+BPDw3JCg+Qnck/DUU21mivQ=;
        b=gO6Gmnet02xPLHFMqnPKlXZcFOnSljhhFlY7VGjImCy0mNUoe7HbbyS+BT5SPeCWSu
         DCHHdtiBobWWKcE89MbUl6IwPt0PiPrrBvMB4tezjpDfD7mQcKKbXMb/afE0UlOWVGyw
         kTi2oUekHGQzSQMGG7kwSC3K/lW89i6HzvDQR08Fu5ezw8QdPV7amslxkauv2H6HcnLf
         RzoLYyJ+7dkr/yQKwdTZoVnokDu3mfvuid40LQ0s3MWMFqjnNkUvbuqpVA92ggBH9cs6
         XmA2TjQiBsoLo8EtK13MoGILgFug4VGYFoauVcVgYqqf1bhxi0aJnAmPsmwa6TRkFm7L
         1hzw==
X-Gm-Message-State: AOAM531lC4Kz4rTf0+XR4JuYK7oeaWIRzc3Rarc7E/z+Ik6K+zHIVw1D
        gcV2JtXKVCdXZdEU/6Cx/gDocg==
X-Google-Smtp-Source: ABdhPJybgtB185azBlWoau29BF26DQkGOs3cBf7OF0pyan4NX5qBvMp/H+z6+PDbqCASjeWYd/VMQQ==
X-Received: by 2002:a17:90a:1bc3:: with SMTP id r3mr1405831pjr.196.1604371185188;
        Mon, 02 Nov 2020 18:39:45 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.141.182.112])
        by smtp.gmail.com with ESMTPSA id e20sm14295906pfi.30.2020.11.02.18.39.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Nov 2020 18:39:44 -0800 (PST)
Date:   Tue, 3 Nov 2020 10:39:36 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/21] perf arm-spe: Refactor printing string to buffer
Message-ID: <20201103023936.GC13232@leoy-ThinkPad-X240s>
References: <20201030025724.19157-1-leo.yan@linaro.org>
 <20201030025724.19157-7-leo.yan@linaro.org>
 <91d5de6b-885e-d56d-0845-49b2dde6894c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91d5de6b-885e-d56d-0845-49b2dde6894c@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 03:50:01PM +0000, André Przywara wrote:
> On 30/10/2020 02:57, Leo Yan wrote:
> > When outputs strings to the decoding buffer with function snprintf(),
> > SPE decoder needs to detects if any error returns from snprintf() and if
> > so needs to directly bail out.  If snprintf() returns success, it needs
> > to update buffer pointer and reduce the buffer length so can continue to
> > output the next string into the consequent memory space.
> > 
> > This complex logics are spreading in the function arm_spe_pkt_desc() so
> > there has many duplicate codes for handling error detecting, increment
> > buffer pointer and decrement buffer size.
> > 
> > To avoid the duplicate code, this patch introduces a new helper function
> > arm_spe_pkt_snprintf() which is used to wrap up the complex logics, and
> > it's used by the caller arm_spe_pkt_desc(); if printing buffer is called
> > for multiple times in a flow, the error is a cumulative value and simply
> > returns its final value.
> > 
> > This patch also moves the variable 'blen' as the function's local
> > variable, this allows to remove the unnecessary braces and improve the
> > readability.
> > 
> > Suggested-by: Dave Martin <Dave.Martin@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Wow, that's a bit tricky to review in its current incarnation, but it
> looks alright to me.

Yes, I had the same feeling when I saw the generated patch :)

> I have some optimisation idea below, but that's a nit and the patch as
> is seems correct to me (checked twice, the second time in an editor,
> matching the lines), so:
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
>
> 
> ...
> 
> > ---
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 267 ++++++++----------
> >  1 file changed, 117 insertions(+), 150 deletions(-)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > index 04fd7fd7c15f..1ecaf9805b79 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > @@ -9,6 +9,7 @@
> >  #include <endian.h>
> >  #include <byteswap.h>
> >  #include <linux/bitops.h>
> > +#include <stdarg.h>
> >  
> >  #include "arm-spe-pkt-decoder.h"
> >  
> > @@ -258,192 +259,158 @@ int arm_spe_get_packet(const unsigned char *buf, size_t len,
> >  	return ret;
> >  }
> >  
> > +static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
> > +				const char *fmt, ...)
> > +{
> > +	va_list ap;
> > +	int ret;
> > +
> > +	/* Bail out if any error occurred */
> > +	if (err && *err)
> > +		return *err;
> > +
> > +	va_start(ap, fmt);
> > +	ret = vsnprintf(*buf_p, *blen, fmt, ap);
> > +	va_end(ap);
> > +
> > +	if (ret < 0) {
> > +		if (err && !*err)
> > +			*err = ret;
> > +	} else {
> > +		*buf_p += ret;
> > +		*blen -= ret;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >  		     size_t buf_len)
> >  {
> > -	int ret, ns, el, idx = packet->index;
> > +	int ns, el, idx = packet->index;
> >  	unsigned long long payload = packet->payload;
> >  	const char *name = arm_spe_pkt_name(packet->type);
> > +	size_t blen = buf_len;
> > +	int err = 0;
> >  
> >  	switch (packet->type) {
> >  	case ARM_SPE_BAD:
> >  	case ARM_SPE_PAD:
> >  	case ARM_SPE_END:
> > -		return snprintf(buf, buf_len, "%s", name);
> > -	case ARM_SPE_EVENTS: {
> > -		size_t blen = buf_len;
> > -
> > -		ret = 0;
> > -		ret = snprintf(buf, buf_len, "EV");
> > -		buf += ret;
> > -		blen -= ret;
> > -		if (payload & 0x1) {
> > -			ret = snprintf(buf, buf_len, " EXCEPTION-GEN");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x2) {
> > -			ret = snprintf(buf, buf_len, " RETIRED");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x4) {
> > -			ret = snprintf(buf, buf_len, " L1D-ACCESS");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x8) {
> > -			ret = snprintf(buf, buf_len, " L1D-REFILL");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x10) {
> > -			ret = snprintf(buf, buf_len, " TLB-ACCESS");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x20) {
> > -			ret = snprintf(buf, buf_len, " TLB-REFILL");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x40) {
> > -			ret = snprintf(buf, buf_len, " NOT-TAKEN");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > -		if (payload & 0x80) {
> > -			ret = snprintf(buf, buf_len, " MISPRED");
> > -			buf += ret;
> > -			blen -= ret;
> > -		}
> > +		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
> 
> Nothing critical, but in case you need to respin this series for
> whatever reason, you might want to use NULL for the first argument,
> since you return here and there is little point in setting err. Same for
> other cases where you return directly from an arm_spe_pkt_snprintf() call.
> But it doesn't hurt, so you could leave it as well, and it's more robust
> in case someone extends the code later.

Makes sense for me.  Eventually, we also can remove the local variable
"err", so will do it.  Thanks a lot!

> > +	case ARM_SPE_EVENTS:
> > +		arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
> > +
> > +		if (payload & 0x1)
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
> > +		if (payload & 0x2)
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
> > +		if (payload & 0x4)
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-ACCESS");
> > +		if (payload & 0x8)
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-REFILL");
> > +		if (payload & 0x10)
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-ACCESS");
> > +		if (payload & 0x20)
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-REFILL");
> > +		if (payload & 0x40)
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
> > +		if (payload & 0x80)
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
> >  		if (idx > 1) {
> > -			if (payload & 0x100) {
> > -				ret = snprintf(buf, buf_len, " LLC-ACCESS");
> > -				buf += ret;
> > -				blen -= ret;
> > -			}
> > -			if (payload & 0x200) {
> > -				ret = snprintf(buf, buf_len, " LLC-REFILL");
> > -				buf += ret;
> > -				blen -= ret;
> > -			}
> > -			if (payload & 0x400) {
> > -				ret = snprintf(buf, buf_len, " REMOTE-ACCESS");
> > -				buf += ret;
> > -				blen -= ret;
> > -			}
> > +			if (payload & 0x100)
> > +				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
> > +			if (payload & 0x200)
> > +				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
> > +			if (payload & 0x400)
> > +				arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
> >  		}
> > -		if (ret < 0)
> > -			return ret;
> > -		blen -= ret;
> > -		return buf_len - blen;
> > -	}
> > +		return err ?: (int)(buf_len - blen);
> > +
> >  	case ARM_SPE_OP_TYPE:
> >  		switch (idx) {
> > -		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
> > -					"COND-SELECT" : "INSN-OTHER");
> > -		case 1:	{
> > -			size_t blen = buf_len;
> > +		case 0:
> > +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> > +					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
> 
> same here (and below, you get the idea ...)
> 
> Cheers,
> Andre
> 
> 
> > +		case 1:
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen,
> > +					     payload & 0x1 ? "ST" : "LD");
> >  
> > -			if (payload & 0x1)
> > -				ret = snprintf(buf, buf_len, "ST");
> > -			else
> > -				ret = snprintf(buf, buf_len, "LD");
> > -			buf += ret;
> > -			blen -= ret;
> >  			if (payload & 0x2) {
> > -				if (payload & 0x4) {
> > -					ret = snprintf(buf, buf_len, " AT");
> > -					buf += ret;
> > -					blen -= ret;
> > -				}
> > -				if (payload & 0x8) {
> > -					ret = snprintf(buf, buf_len, " EXCL");
> > -					buf += ret;
> > -					blen -= ret;
> > -				}
> > -				if (payload & 0x10) {
> > -					ret = snprintf(buf, buf_len, " AR");
> > -					buf += ret;
> > -					blen -= ret;
> > -				}
> > +				if (payload & 0x4)
> > +					arm_spe_pkt_snprintf(&err, &buf, &blen, " AT");
> > +				if (payload & 0x8)
> > +					arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
> > +				if (payload & 0x10)
> > +					arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
> >  			} else if (payload & 0x4) {
> > -				ret = snprintf(buf, buf_len, " SIMD-FP");
> > -				buf += ret;
> > -				blen -= ret;
> > -			}
> > -			if (ret < 0)
> > -				return ret;
> > -			blen -= ret;
> > -			return buf_len - blen;
> > -		}
> > -		case 2:	{
> > -			size_t blen = buf_len;
> > -
> > -			ret = snprintf(buf, buf_len, "B");
> > -			buf += ret;
> > -			blen -= ret;
> > -			if (payload & 0x1) {
> > -				ret = snprintf(buf, buf_len, " COND");
> > -				buf += ret;
> > -				blen -= ret;
> > -			}
> > -			if (payload & 0x2) {
> > -				ret = snprintf(buf, buf_len, " IND");
> > -				buf += ret;
> > -				blen -= ret;
> > +				arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
> >  			}
> > -			if (ret < 0)
> > -				return ret;
> > -			blen -= ret;
> > -			return buf_len - blen;
> > -			}
> > -		default: return 0;
> > +
> > +			return err ?: (int)(buf_len - blen);
> > +
> > +		case 2:
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
> > +
> > +			if (payload & 0x1)
> > +				arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
> > +			if (payload & 0x2)
> > +				arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
> > +
> > +			return err ?: (int)(buf_len - blen);
> > +
> > +		default:
> > +			return 0;
> >  		}
> >  	case ARM_SPE_DATA_SOURCE:
> >  	case ARM_SPE_TIMESTAMP:
> > -		return snprintf(buf, buf_len, "%s %lld", name, payload);
> > +		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %lld", name, payload);
> >  	case ARM_SPE_ADDRESS:
> >  		switch (idx) {
> >  		case 0:
> >  		case 1: ns = !!(packet->payload & NS_FLAG);
> >  			el = (packet->payload & EL_FLAG) >> 61;
> >  			payload &= ~(0xffULL << 56);
> > -			return snprintf(buf, buf_len, "%s 0x%llx el%d ns=%d",
> > +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> > +					"%s 0x%llx el%d ns=%d",
> >  				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
> > -		case 2:	return snprintf(buf, buf_len, "VA 0x%llx", payload);
> > +		case 2:
> > +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> > +						    "VA 0x%llx", payload);
> >  		case 3:	ns = !!(packet->payload & NS_FLAG);
> >  			payload &= ~(0xffULL << 56);
> > -			return snprintf(buf, buf_len, "PA 0x%llx ns=%d",
> > -					payload, ns);
> > -		default: return 0;
> > +			return arm_spe_pkt_snprintf(&err, &buf, &blen,
> > +						    "PA 0x%llx ns=%d", payload, ns);
> > +		default:
> > +			return 0;
> >  		}
> >  	case ARM_SPE_CONTEXT:
> > -		return snprintf(buf, buf_len, "%s 0x%lx el%d", name,
> > -				(unsigned long)payload, idx + 1);
> > -	case ARM_SPE_COUNTER: {
> > -		size_t blen = buf_len;
> > -
> > -		ret = snprintf(buf, buf_len, "%s %d ", name,
> > -			       (unsigned short)payload);
> > -		buf += ret;
> > -		blen -= ret;
> > +		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%lx el%d",
> > +					    name, (unsigned long)payload, idx + 1);
> > +	case ARM_SPE_COUNTER:
> > +		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %d ", name,
> > +				     (unsigned short)payload);
> > +
> >  		switch (idx) {
> > -		case 0:	ret = snprintf(buf, buf_len, "TOT"); break;
> > -		case 1:	ret = snprintf(buf, buf_len, "ISSUE"); break;
> > -		case 2:	ret = snprintf(buf, buf_len, "XLAT"); break;
> > -		default: ret = 0;
> > +		case 0:
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, "TOT");
> > +			break;
> > +		case 1:
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, "ISSUE");
> > +			break;
> > +		case 2:
> > +			arm_spe_pkt_snprintf(&err, &buf, &blen, "XLAT");
> > +			break;
> > +		default:
> > +			break;
> >  		}
> > -		if (ret < 0)
> > -			return ret;
> > -		blen -= ret;
> > -		return buf_len - blen;
> > -	}
> > +
> > +		return err ?: (int)(buf_len - blen);
> > +
> >  	default:
> >  		break;
> >  	}
> >  
> > -	return snprintf(buf, buf_len, "%s 0x%llx (%d)",
> > -			name, payload, packet->index);
> > +	return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%llx (%d)",
> > +				    name, payload, packet->index);
> >  }
> > 
> 
