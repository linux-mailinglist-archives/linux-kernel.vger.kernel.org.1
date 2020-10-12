Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152DE28AB3C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 02:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgJLAaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 20:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgJLAaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 20:30:06 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B76C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 17:30:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id e10so11957138pfj.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 17:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Dzz8AtvP56fc2S3kjLJ9Ac6AwJBJP5SSxCgOVVjjLk8=;
        b=BGn5UdARxo35j3vQCgHppGYhBJdSz00oP83S0KvyfXEW+VchoqBVc0qyTFAYCjispw
         A2hAn68PH6O4ndVD6jVl2/+PIXKo3nC0ymUQL1pRYBOGntzdc2OLYX07OMWLW5AlGQ3n
         4yK3N1ChJ6OhT/UYqO+mJJajimpRRY3KPJbekXzktv4ZO8gKXvwn1rN6On/EnNBwR+Fj
         guoLeqA/f9oYkrANHsY7BIaP9MnEPUFRdTBs7rZbOq0EkX5++AJC+Z533UmGgh38MBPl
         ineljtrRMmM/vrlf0SxTFLfUrbeq+oHziedgfFV7kE7UYJ1ZMpFZseGu4PTG/5Dosito
         BxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Dzz8AtvP56fc2S3kjLJ9Ac6AwJBJP5SSxCgOVVjjLk8=;
        b=hA2seJ9euOn0kvygCFIkHErl6yiuVpkX8BXhSHQBY45/r4V820ULSG9e+gXgWJV6t5
         RZZdYMg8LSHA4SPOMl7wFP1V5wo8P7eHVnw+PM7wAAVe12pgszXhdf2rjAN1sxr9sQ1Z
         SI7dBzgkEMiQj7NmxjB08mELYIq8DQ7++fCoYCjx/uT3d/xy9ss4JZl0PKOhQjpZ2Wzg
         YIR0+2QLVVhAwBQMKt0nbSmb1cREu7ibS/phKzqtV+QL4t6L06kJvXklK3oqKPg7ZSz0
         0jCva+L+tDG2mekN0Az3beespgKQ76Cwf9acuB70xqcl+ugGq+SOvMVtQHseenX2SA3I
         I1Cg==
X-Gm-Message-State: AOAM532Yj/QDhB6Be51Bau9L4yp9N4k3A0xCc/YzSC2iTRB1k8r346KM
        ps7qgQZG8/jrJJzPNf5qdvWtj9y9QOJ8Vjum
X-Google-Smtp-Source: ABdhPJwnBKRL/q0Kpimfr4MZe3PL2tiBkk80j7hXFgEXIwMGzyUPKXEeTd4xNh3vJ9MKjekWkJ2hMA==
X-Received: by 2002:a17:90b:4b90:: with SMTP id lr16mr17538311pjb.0.1602462605805;
        Sun, 11 Oct 2020 17:30:05 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id m22sm16816322pfk.214.2020.10.11.17.30.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Oct 2020 17:30:05 -0700 (PDT)
Date:   Mon, 12 Oct 2020 08:29:58 +0800
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
Subject: Re: [PATCH v2 05/14] perf arm-spe: Refactor printing string to buffer
Message-ID: <20201012002958.GC15194@leoy-ThinkPad-X240s>
References: <20200929133917.9224-1-leo.yan@linaro.org>
 <20200929133917.9224-6-leo.yan@linaro.org>
 <6d565f8a-e573-9b9b-b0b4-43e542dd568c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d565f8a-e573-9b9b-b0b4-43e542dd568c@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 02:46:06PM +0100, André Przywara wrote:
> On 29/09/2020 14:39, Leo Yan wrote:
> 
> Hi,
> 
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
> > the caller arm_spe_pkt_desc() will call it and simply check the returns
> > value.
> > 
> > This patch also moves the variable 'blen' as the function's local
> > variable, this allows to remove the unnecessary braces and improve the
> > readability.
> 
> Ah, many thanks for tackling this, I wondered about those code
> duplications and missing error handling already.
> 
> So I tried some sed pattern on the "old" part of the patch, to get to
> the new format and spot any differences apart from mechanically changing
> "snprintf(buf, buf_len," to "arm_spe_pkt_snprintf(&buf, &blen,".
> See below.
> 
> > 
> > Suggested-by: Dave Martin <Dave.Martin@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Very nice cleanup! If you can address this one '"%s", name' comment
> below, then:
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> 
> 
> > ---
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 247 ++++++++++--------
> >  1 file changed, 135 insertions(+), 112 deletions(-)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > index 4f0aeb62e97b..96b717a19163 100644
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
> > @@ -256,192 +257,214 @@ int arm_spe_get_packet(const unsigned char *buf, size_t len,
> >  	return ret;
> >  }
> >  
> > +static int arm_spe_pkt_snprintf(char **buf_p, size_t *blen,
> > +				const char *fmt, ...)
> > +{
> > +	va_list ap;
> > +	int ret;
> > +
> > +	va_start(ap, fmt);
> > +	ret = vsnprintf(*buf_p, *blen, fmt, ap);
> > +	va_end(ap);
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*buf_p += ret;
> > +	*blen -= ret;
> > +	return ret;
> > +}
> > +
> >  int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >  		     size_t buf_len)
> >  {
> >  	int ret, ns, el, idx = packet->index;
> >  	unsigned long long payload = packet->payload;
> >  	const char *name = arm_spe_pkt_name(packet->type);
> > +	size_t blen = buf_len;
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
> > +		return arm_spe_pkt_snprintf(&buf, &blen, name);
> 
> Isn't it considered safer to use '..., "%s", name)', because that would
> handle percent signs in "name" correctly?
> Not really an issue in the current code, but good style, I believe.

Good point.  '..., "%s", name)' format is more reliable, will change
to use it.

> > +	case ARM_SPE_EVENTS:
> > +		ret = arm_spe_pkt_snprintf(&buf, &blen, "EV");
> > +		if (ret < 0)
> > +			return ret;
> > +
> >  		if (payload & 0x1) {
> > -			ret = snprintf(buf, buf_len, " EXCEPTION-GEN");
> 
> So this was actually a bug before, right? Because "buf" does no longer
> have buf_len bytes available at this point, it should have been blen
> here already. Which gets fixed with all your changes!

Exactly, I will update the commit log so can give more explicit info.

Thanks a lot,
Leo

> Thanks!
> Andre
> 
> > -			buf += ret;
> > -			blen -= ret;
> > +			ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCEPTION-GEN");
> > +			if (ret < 0)
> > +				return ret;
> >  		}
> >  		if (payload & 0x2) {
> > -			ret = snprintf(buf, buf_len, " RETIRED");
> > -			buf += ret;
> > -			blen -= ret;
> > +			ret = arm_spe_pkt_snprintf(&buf, &blen, " RETIRED");
> > +			if (ret < 0)
> > +				return ret;
> >  		}
> >  		if (payload & 0x4) {
> > -			ret = snprintf(buf, buf_len, " L1D-ACCESS");
> > -			buf += ret;
> > -			blen -= ret;
> > +			ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-ACCESS");
> > +			if (ret < 0)
> > +				return ret;
> >  		}
> >  		if (payload & 0x8) {
> > -			ret = snprintf(buf, buf_len, " L1D-REFILL");
> > -			buf += ret;
> > -			blen -= ret;
> > +			ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-REFILL");
> > +			if (ret < 0)
> > +				return ret;
> >  		}
> >  		if (payload & 0x10) {
> > -			ret = snprintf(buf, buf_len, " TLB-ACCESS");
> > -			buf += ret;
> > -			blen -= ret;
> > +			ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-ACCESS");
> > +			if (ret < 0)
> > +				return ret;
> >  		}
> >  		if (payload & 0x20) {
> > -			ret = snprintf(buf, buf_len, " TLB-REFILL");
> > -			buf += ret;
> > -			blen -= ret;
> > +			ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-REFILL");
> > +			if (ret < 0)
> > +				return ret;
> >  		}
> >  		if (payload & 0x40) {
> > -			ret = snprintf(buf, buf_len, " NOT-TAKEN");
> > -			buf += ret;
> > -			blen -= ret;
> > +			ret = arm_spe_pkt_snprintf(&buf, &blen, " NOT-TAKEN");
> > +			if (ret < 0)
> > +				return ret;
> >  		}
> >  		if (payload & 0x80) {
> > -			ret = snprintf(buf, buf_len, " MISPRED");
> > -			buf += ret;
> > -			blen -= ret;
> > +			ret = arm_spe_pkt_snprintf(&buf, &blen, " MISPRED");
> > +			if (ret < 0)
> > +				return ret;
> >  		}
> >  		if (idx > 1) {
> >  			if (payload & 0x100) {
> > -				ret = snprintf(buf, buf_len, " LLC-ACCESS");
> > -				buf += ret;
> > -				blen -= ret;
> > +				ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-ACCESS");
> > +				if (ret < 0)
> > +					return ret;
> >  			}
> >  			if (payload & 0x200) {
> > -				ret = snprintf(buf, buf_len, " LLC-REFILL");
> > -				buf += ret;
> > -				blen -= ret;
> > +				ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-REFILL");
> > +				if (ret < 0)
> > +					return ret;
> >  			}
> >  			if (payload & 0x400) {
> > -				ret = snprintf(buf, buf_len, " REMOTE-ACCESS");
> > -				buf += ret;
> > -				blen -= ret;
> > +				ret = arm_spe_pkt_snprintf(&buf, &blen, " REMOTE-ACCESS");
> > +				if (ret < 0)
> > +					return ret;
> >  			}
> >  		}
> > -		if (ret < 0)
> > -			return ret;
> > -		blen -= ret;
> >  		return buf_len - blen;
> > -	}
> > +
> >  	case ARM_SPE_OP_TYPE:
> >  		switch (idx) {
> > -		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
> > -					"COND-SELECT" : "INSN-OTHER");
> > -		case 1:	{
> > -			size_t blen = buf_len;
> > -
> > -			if (payload & 0x1)
> > -				ret = snprintf(buf, buf_len, "ST");
> > -			else
> > -				ret = snprintf(buf, buf_len, "LD");
> > -			buf += ret;
> > -			blen -= ret;
> > +		case 0:
> > +			return arm_spe_pkt_snprintf(&buf, &blen,
> > +					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
> > +		case 1:
> > +			ret = arm_spe_pkt_snprintf(&buf, &blen,
> > +						   payload & 0x1 ? "ST" : "LD");
> > +			if (ret < 0)
> > +				return ret;
> > +
> >  			if (payload & 0x2) {
> >  				if (payload & 0x4) {
> > -					ret = snprintf(buf, buf_len, " AT");
> > -					buf += ret;
> > -					blen -= ret;
> > +					ret = arm_spe_pkt_snprintf(&buf, &blen, " AT");
> > +					if (ret < 0)
> > +						return ret;
> >  				}
> >  				if (payload & 0x8) {
> > -					ret = snprintf(buf, buf_len, " EXCL");
> > -					buf += ret;
> > -					blen -= ret;
> > +					ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCL");
> > +					if (ret < 0)
> > +						return ret;
> >  				}
> >  				if (payload & 0x10) {
> > -					ret = snprintf(buf, buf_len, " AR");
> > -					buf += ret;
> > -					blen -= ret;
> > +					ret = arm_spe_pkt_snprintf(&buf, &blen, " AR");
> > +					if (ret < 0)
> > +						return ret;
> >  				}
> >  			} else if (payload & 0x4) {
> > -				ret = snprintf(buf, buf_len, " SIMD-FP");
> > -				buf += ret;
> > -				blen -= ret;
> > +				ret = arm_spe_pkt_snprintf(&buf, &blen, " SIMD-FP");
> > +				if (ret < 0)
> > +					return ret;
> >  			}
> > +
> > +			return buf_len - blen;
> > +
> > +		case 2:
> > +			ret = arm_spe_pkt_snprintf(&buf, &blen, "B");
> >  			if (ret < 0)
> >  				return ret;
> > -			blen -= ret;
> > -			return buf_len - blen;
> > -		}
> > -		case 2:	{
> > -			size_t blen = buf_len;
> >  
> > -			ret = snprintf(buf, buf_len, "B");
> > -			buf += ret;
> > -			blen -= ret;
> >  			if (payload & 0x1) {
> > -				ret = snprintf(buf, buf_len, " COND");
> > -				buf += ret;
> > -				blen -= ret;
> > +				ret = arm_spe_pkt_snprintf(&buf, &blen, " COND");
> > +				if (ret < 0)
> > +					return ret;
> >  			}
> >  			if (payload & 0x2) {
> > -				ret = snprintf(buf, buf_len, " IND");
> > -				buf += ret;
> > -				blen -= ret;
> > +				ret = arm_spe_pkt_snprintf(&buf, &blen, " IND");
> > +				if (ret < 0)
> > +					return ret;
> >  			}
> > -			if (ret < 0)
> > -				return ret;
> > -			blen -= ret;
> > +
> >  			return buf_len - blen;
> > -			}
> > -		default: return 0;
> > +
> > +		default:
> > +			return 0;
> >  		}
> >  	case ARM_SPE_DATA_SOURCE:
> >  	case ARM_SPE_TIMESTAMP:
> > -		return snprintf(buf, buf_len, "%s %lld", name, payload);
> > +		return arm_spe_pkt_snprintf(&buf, &blen, "%s %lld", name, payload);
> >  	case ARM_SPE_ADDRESS:
> >  		switch (idx) {
> >  		case 0:
> >  		case 1: ns = !!(packet->payload & NS_FLAG);
> >  			el = (packet->payload & EL_FLAG) >> 61;
> >  			payload &= ~(0xffULL << 56);
> > -			return snprintf(buf, buf_len, "%s 0x%llx el%d ns=%d",
> > +			return arm_spe_pkt_snprintf(&buf, &blen,
> > +					"%s 0x%llx el%d ns=%d",
> >  				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
> > -		case 2:	return snprintf(buf, buf_len, "VA 0x%llx", payload);
> > +		case 2:
> > +			return arm_spe_pkt_snprintf(&buf, &blen,
> > +						    "VA 0x%llx", payload);
> >  		case 3:	ns = !!(packet->payload & NS_FLAG);
> >  			payload &= ~(0xffULL << 56);
> > -			return snprintf(buf, buf_len, "PA 0x%llx ns=%d",
> > -					payload, ns);
> > -		default: return 0;
> > +			return arm_spe_pkt_snprintf(&buf, &blen,
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
> > -		switch (idx) {
> > -		case 0:	ret = snprintf(buf, buf_len, "TOT"); break;
> > -		case 1:	ret = snprintf(buf, buf_len, "ISSUE"); break;
> > -		case 2:	ret = snprintf(buf, buf_len, "XLAT"); break;
> > -		default: ret = 0;
> > -		}
> > +		return arm_spe_pkt_snprintf(&buf, &blen, "%s 0x%lx el%d",
> > +					    name, (unsigned long)payload, idx + 1);
> > +	case ARM_SPE_COUNTER:
> > +		ret = arm_spe_pkt_snprintf(&buf, &blen, "%s %d ", name,
> > +					   (unsigned short)payload);
> >  		if (ret < 0)
> >  			return ret;
> > -		blen -= ret;
> > +
> > +		switch (idx) {
> > +		case 0:
> > +			ret = arm_spe_pkt_snprintf(&buf, &blen, "TOT");
> > +			if (ret < 0)
> > +				return ret;
> > +			break;
> > +		case 1:
> > +			ret = arm_spe_pkt_snprintf(&buf, &blen, "ISSUE");
> > +			if (ret < 0)
> > +				return ret;
> > +			break;
> > +		case 2:
> > +			ret = arm_spe_pkt_snprintf(&buf, &blen, "XLAT");
> > +			if (ret < 0)
> > +				return ret;
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +
> >  		return buf_len - blen;
> > -	}
> > +
> >  	default:
> >  		break;
> >  	}
> >  
> > -	return snprintf(buf, buf_len, "%s 0x%llx (%d)",
> > -			name, payload, packet->index);
> > +	return arm_spe_pkt_snprintf(&buf, &blen, "%s 0x%llx (%d)",
> > +				    name, payload, packet->index);
> >  }
> > 
> 
