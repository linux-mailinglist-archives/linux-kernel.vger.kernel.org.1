Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0047D294713
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 05:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411865AbgJUDwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 23:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411844AbgJUDwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 23:52:19 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4A8C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 20:52:19 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id p3so1567951pjd.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 20:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mFpqSA2KhjqRwu8wHBb6+NW2cwuO0N+7Zos8HJ01i7c=;
        b=wnJnlbvKioV60GDwgvJJidcKH1/VKZoW5z0rnonNUbBPYaq/YatSNgbOjlRGYwGzfo
         SXY536CPop8IqBuvljkSvDGLUikbkls+B17bSG2+U/KPjkt4cpJs07Z/cIhNQo5WPDmc
         a5PXy5FcARnlB/LsUt3FdK8Mk8EjU834biBSDvkecWOj2tEYxolPSx9sH2IO6Ym6M6xo
         PAM9c9nUZMz9OvEhzdr9oRiJhVCChO0gPn5VGTqUQe0xKWCCeXXrotNGzA6zB7HyjmbQ
         s5GygeFz71Ba0LUDE2Cd36C3ImCcRS4swkcOndyhkfr3PRcoCAr8o4+CvcCHspNX0s+L
         91Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mFpqSA2KhjqRwu8wHBb6+NW2cwuO0N+7Zos8HJ01i7c=;
        b=N1xPtnklWZZrtIra7DUCJEy3BPLgFxTmNimxffidU72xNkqWMxI0YzJc3UCbMTIKqw
         hBUIF+rhpCdIF9x6vC7BhyBPu2h838a5abXMKRrzSHWdqG2rGZOMl/s73QlawjLaoYHw
         NAMCcYZzdj6TVVl95U2lp8Rk/wuumtUhwzme+Tg/WZ8OwTHtf8VAL/CaoJXtuJgATvwL
         Bzealv/9SA1gsOVBLstw/HzABF+d3yaEfhUQNf8LgsuCVc4J6Pf4zB0uxsXjUb7QDGMx
         VP2CQqvfDKuTgGNLsMLBiBAbWEjOFNx0PxJY7Mr92Mwh4eK2V0LCUg8db40dmamikaCg
         cvfw==
X-Gm-Message-State: AOAM530A/bmbH/Wrhsn/hLfL7ips3h1venGf4kaBE8SHOKIV+zq+gyW/
        w6j45GRtjgkWO5iZCeWTM1KfdA==
X-Google-Smtp-Source: ABdhPJxsBTpPODsyDASGDdO8lDNy4uu2wCHpRxd+a0X32Li3QsurMYsj9xdhcAfbdGNQojYwbiw4hw==
X-Received: by 2002:a17:90a:d317:: with SMTP id p23mr1292947pju.52.1603252338814;
        Tue, 20 Oct 2020 20:52:18 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([14.192.49.12])
        by smtp.gmail.com with ESMTPSA id z30sm470982pfq.87.2020.10.20.20.52.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Oct 2020 20:52:18 -0700 (PDT)
Date:   Wed, 21 Oct 2020 11:52:12 +0800
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
Subject: Re: [PATCH v2 09/14] perf arm-spe: Refactor counter packet handling
Message-ID: <20201021035212.GC7226@leoy-ThinkPad-X240s>
References: <20200929133917.9224-1-leo.yan@linaro.org>
 <20200929133917.9224-10-leo.yan@linaro.org>
 <6080472e-a117-e36d-ec4a-80f7ef93b3fb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6080472e-a117-e36d-ec4a-80f7ef93b3fb@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:53:47PM +0100, André Przywara wrote:
> On 29/09/2020 14:39, Leo Yan wrote:
> 
> Hi,
> 
> > This patch defines macros for counter packet header, and uses macro to
> > replace hard code values for packet parsing.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  .../util/arm-spe-decoder/arm-spe-pkt-decoder.c  | 17 ++++++++++-------
> >  .../util/arm-spe-decoder/arm-spe-pkt-decoder.h  |  9 +++++++++
> >  2 files changed, 19 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > index 00a2cd1af422..ed0f4c74dfc5 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > @@ -150,10 +150,13 @@ static int arm_spe_get_counter(const unsigned char *buf, size_t len,
> >  			       const unsigned char ext_hdr, struct arm_spe_pkt *packet)
> >  {
> >  	packet->type = ARM_SPE_COUNTER;
> > -	if (ext_hdr)
> > -		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
> > -	else
> > -		packet->index = buf[0] & 0x7;
> > +	if (ext_hdr) {
> > +		packet->index  = (buf[1] & SPE_CNT_PKT_HDR_INDEX_MASK);
> > +		packet->index |= ((buf[0] & SPE_CNT_PKT_HDR_EXT_INDEX_MASK)
> > +			<< SPE_CNT_PKT_HDR_EXT_INDEX_SHIFT);
> > +	} else {
> > +		packet->index = buf[0] & SPE_CNT_PKT_HDR_INDEX_MASK;
> 
> That looks suspiciously similar to the extended header in the address
> packet. Can you use the same name for that?

Checked for counter packet and address packet, they are using the same
format for index.  Will use the same name.

> And, similar to the address packet, what about:
> 	packet->index |= SPE_PKT_EXT_HEADER_INDEX(buf[0]);

Will do.

> (merging the mask and the shift in the macro definition)
> 
> > +	}
> >  
> >  	return arm_spe_get_payload(buf, len, ext_hdr, packet);
> >  }
> > @@ -431,17 +434,17 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >  			return ret;
> >  
> >  		switch (idx) {
> > -		case 0:
> > +		case SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT:
> >  			ret = arm_spe_pkt_snprintf(&buf, &blen, "TOT");
> >  			if (ret < 0)
> >  				return ret;
> >  			break;
> > -		case 1:
> > +		case SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT:
> >  			ret = arm_spe_pkt_snprintf(&buf, &blen, "ISSUE");
> >  			if (ret < 0)
> >  				return ret;
> >  			break;
> > -		case 2:
> > +		case SPE_CNT_PKT_HDR_INDEX_TRANS_LAT:
> >  			ret = arm_spe_pkt_snprintf(&buf, &blen, "XLAT");
> >  			if (ret < 0)
> >  				return ret;
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > index 62db4ff91832..18667a63f5ba 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > @@ -89,6 +89,15 @@ struct arm_spe_pkt {
> >  /* Context packet header */
> >  #define SPE_CTX_PKT_HDR_INDEX_MASK		GENMASK_ULL(1, 0)
> >  
> > +/* Counter packet header */
> > +#define SPE_CNT_PKT_HDR_INDEX_MASK		GENMASK_ULL(2, 0)
> > +#define SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT		(0x0)
> > +#define SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT		(0x1)
> > +#define SPE_CNT_PKT_HDR_INDEX_TRANS_LAT		(0x2)
> 
> I think the Linux kernel coding style does not mention parentheses just
> around numbers, so just 0x2 would suffice, for instance.
> See section 12) in Documentation/process/coding-style.rst

Yeah, it gives example as "#define CONSTANT 0x4000"; will follow the
coding style.

Thanks for suggestions!
Leo
