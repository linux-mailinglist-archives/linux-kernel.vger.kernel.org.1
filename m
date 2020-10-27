Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37B329A30C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502267AbgJ0DN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:13:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38501 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502220AbgJ0DN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:13:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id i26so6878912pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xQU5G7Ya8yKiDus7kvYDAMdxkZxC/k3Nmfb5N20XC2o=;
        b=BAdL3LaJcDg9l9Nj5XANFP4YuN2vQGNDOrVX+PHZWYkoGvfIBwqeQSA/T5cuC9IOff
         vgoW+5DSvHgjwS8E3AkeRV4qIJ0x+L54dz/QdR8cUWDHeKTPBFsTHx8OxLaGWTfF8axF
         H89FKh2jvAMSepd4k53Y/Xyr4iwmugAHjR7y2rMiLlzH0fYDWOxdxHBRfFx0tbssojfy
         +W6Pb/sWY+jtSKsmswCw8ZI+BxPIyCvAi8zpx7seCFCkIjoR0fMmRwxP7Ji7lRkPubc9
         kekndevCzNi5g5zHdKiZVTYOmP5dA02D+j7GBAW4LZcmrVjOAJhyEtWJeFlJcJ1zMfS3
         tMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xQU5G7Ya8yKiDus7kvYDAMdxkZxC/k3Nmfb5N20XC2o=;
        b=FaeCJySRTJbMFtWOWvmgixQ1nxFoEMLzL8FsfXW2CwMKclHtPqN51VIfgB2c71edlQ
         eIEtyuIj0may9xdWrmpNTmGnJwieo64jf40z05x5ftBI4XJ4tHbDNqrbCtY7aQNKtUpz
         H123+T4juNcW1ethZVRY2Bl7ZQHiRNVf0uSMzJc3nHUfSwY3Y96cZlKGLVl+L0VrwsGD
         NZMVhikBU48drlReWe7y2jQSp86KohLz+z0sKe/oSiz9+kfRy4fDoz+FJoFnz9xveSOL
         VulYn67JxUDdMbEtN6DONhn7FEDYsno/Hp4+TQac2B6O12KBVkVVEpRNdDpYaMn34Ml/
         tECA==
X-Gm-Message-State: AOAM533ZOdXcwOMVlsdiglpu0MLGFI4UunG+Ql3f/lf0NJRneR6r9Hlz
        hbBpUFvQqWFXaNEhygL/V9X1xA==
X-Google-Smtp-Source: ABdhPJxwi//mKUpo/a2+PFhvMC/xEC5CaXKWq8j9VcB6QpYT0ueLf6tA5afMngcXyU94nVhlinOXLA==
X-Received: by 2002:a63:55:: with SMTP id 82mr66393pga.261.1603768438255;
        Mon, 26 Oct 2020 20:13:58 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id v3sm144638pju.38.2020.10.26.20.13.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:13:57 -0700 (PDT)
Date:   Tue, 27 Oct 2020 11:13:50 +0800
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
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/20] perf arm-spe: Add support for ARMv8.3-SPE
Message-ID: <20201027031350.GC32667@leoy-ThinkPad-X240s>
References: <20201022145816.14069-1-leo.yan@linaro.org>
 <20201022145816.14069-21-leo.yan@linaro.org>
 <c4baccf4-2ecd-1633-ec87-0f4911cbdc50@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4baccf4-2ecd-1633-ec87-0f4911cbdc50@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 06:17:20PM +0000, André Przywara wrote:
> On 22/10/2020 15:58, Leo Yan wrote:
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
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 74 ++++++++++++++++++-
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 18 +++++
> >  2 files changed, 90 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > index 74ac12cbec69..6da4cfbc9914 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > @@ -332,6 +332,21 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
> >  		if (ret < 0)
> >  			return ret;
> >  	}
> > +	if (payload & BIT(EV_ALIGNMENT)) {
> > +		ret = arm_spe_pkt_snprintf(&buf, &blen, " ALIGNMENT");
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +	if (payload & BIT(EV_PARTIAL_PREDICATE)) {
> > +		ret = arm_spe_pkt_snprintf(&buf, &blen, " SVE-PARTIAL-PRED");
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +	if (payload & BIT(EV_EMPTY_PREDICATE)) {
> > +		ret = arm_spe_pkt_snprintf(&buf, &blen, " SVE-EMPTY-PRED");
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> >  
> >  	return buf_len - blen;
> >  }
> > @@ -345,8 +360,43 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
> >  
> >  	switch (class) {
> >  	case SPE_OP_PKT_HDR_CLASS_OTHER:
> > -		return arm_spe_pkt_snprintf(&buf, &blen,
> > -			payload & SPE_OP_PKT_COND ? "COND-SELECT" : "INSN-OTHER");
> > +		if (SPE_OP_PKT_OTHER_SUBCLASS_SVE_OP_GET(payload) ==
> > +				SPE_OP_PKT_OTHER_SUBCLASS_SVE_OP) {
> 
> Same comment as in the other patch, can you combine those two into one
> symbol?

Thanks for the suggestion, have refined patches for this and sent out
patch set v4 for reviewing.

Leo
