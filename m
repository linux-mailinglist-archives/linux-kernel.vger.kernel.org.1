Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA3A2A3CFE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 07:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgKCGvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 01:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgKCGvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 01:51:11 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEE0C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 22:51:11 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 13so13348653pfy.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 22:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qWfYkA27Iu7xAv2Up/L/0FvJb57pqevAg/SnNx2G0j8=;
        b=xnpnraIxKtGMct5KNiCU83j+WDfFgKoDuT9gNsZ9065BYbP3e2T5+Rs7r418goMeRa
         Ec7l0dydbZGm55CMaZy6OQ/cGq/Aa52CT0DgE9ovJuX+NjKfCW9JZrqcxWLyQKwjLkV0
         f76fBSWrhOr5Y2/zNo+sj0vxiquAKa++o4wKXmwf/e3TmIKAdGMIu8YSeoxyhRubO++m
         46/secRBbrg+eyljIvPoQTCNc6V1OowMomrEZ8oDAbdjYq2Ps9/Kf7/ejkXDMWWl6Tem
         5s806jmbVbCXE/t/Q6eMPuHpxXn36HkUmbS4HEmS2MMFqY4sakZKG0GMrZumGfGjQI5I
         xBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qWfYkA27Iu7xAv2Up/L/0FvJb57pqevAg/SnNx2G0j8=;
        b=LPWT54aDYN/IjQ5Admrpwik2DhPyJeBMtIZ3rlGOP9nyd0eVzPhZy3dgvT38JO9Crz
         0R8Ff3KH/iG+56oEABIEHIWMfv2xXFCHRvwTYhT+hVfD/yLkMZqpYBOel3i7rVZFVzEX
         ObRvx8GlehU1BwiSkQFjW+dHuSLNFQBZcUAE4Kv6Q8l1dH0qn6z54LlbUnjDBiilTp2y
         lYHBFGhemiMnMdhSmHLqWjotRxNEKYT97NJFF4X2251bfma+T9n23A/HeJi3fOeB/8M9
         3qCL/JMheaEXUzb5VVFy8FUZJAvnMuDkeL4s1V/5K4pzExCf+q9xQorZjXEwWoZzCwUV
         ZTOA==
X-Gm-Message-State: AOAM5330vNqMBYzXdL4uagOir/RoWuJswcrSavOkFrifUSjU9DWv5ObJ
        Ed+/zBBb/BlO4yAU+8SPES5/hw==
X-Google-Smtp-Source: ABdhPJwzDUhDRNVnXKEK7mPMePkdyGH1QypI0T2bjX0vdEgAXBsL+pLWqG2JpiYkol7zgVeZEL+brQ==
X-Received: by 2002:a17:90b:342:: with SMTP id fh2mr2205189pjb.188.1604386270800;
        Mon, 02 Nov 2020 22:51:10 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.141.182.112])
        by smtp.gmail.com with ESMTPSA id z10sm1685437pjz.49.2020.11.02.22.51.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Nov 2020 22:51:10 -0800 (PST)
Date:   Tue, 3 Nov 2020 14:51:01 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <Andre.Przywara@arm.com>,
        James Clark <James.Clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Wei Li <liwei391@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 20/21] perf arm_spe: Decode memory tagging properties
Message-ID: <20201103065101.GE13232@leoy-ThinkPad-X240s>
References: <20201030025724.19157-1-leo.yan@linaro.org>
 <20201030025724.19157-21-leo.yan@linaro.org>
 <20201102162519.GA6882@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102162519.GA6882@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 04:25:36PM +0000, Dave Martin wrote:
> On Fri, Oct 30, 2020 at 02:57:23AM +0000, Leo Yan wrote:
> > From: Andre Przywara <andre.przywara@arm.com>
> > 
> > When SPE records a physical address, it can additionally tag the event
> > with information from the Memory Tagging architecture extension.
> > 
> > Decode the two additional fields in the SPE event payload.
> > 
> > [leoy: Refined patch to use predefined macros]
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 6 +++++-
> >  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 2 ++
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > index 3fca65e9cbbf..9ec3057de86f 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > @@ -371,6 +371,7 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
> >  				 char *buf, size_t buf_len)
> >  {
> >  	int ns, el, idx = packet->index;
> > +	int ch, pat;
> >  	u64 payload = packet->payload;
> >  	int err = 0;
> >  
> > @@ -388,9 +389,12 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
> >  					    "VA 0x%llx", payload);
> >  	case SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS:
> >  		ns = !!SPE_ADDR_PKT_GET_NS(payload);
> > +		ch = !!SPE_ADDR_PKT_GET_CH(payload);
> > +		pat = SPE_ADDR_PKT_GET_PAT(payload);
> >  		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
> >  		return arm_spe_pkt_snprintf(&err, &buf, &buf_len,
> > -					    "PA 0x%llx ns=%d", payload, ns);
> > +					    "PA 0x%llx ns=%d ch=%d, pat=%x",
> 
> Nit: given that this data is all closely related, do we really want the
> extra comma here?

No reason for adding comma.  Will remove it.

> (Note, I am not familiar with how this text is consumed, so if there are
> other reasons why the comma is needed then that's probably fine.)
> 
> > +					    payload, ns, ch, pat);
> >  	default:
> >  		return 0;
> >  	}
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > index 7032fc141ad4..1ad14885c2a1 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > @@ -73,6 +73,8 @@ struct arm_spe_pkt {
> >  
> >  #define SPE_ADDR_PKT_GET_NS(v)			(((v) & BIT_ULL(63)) >> 63)
> >  #define SPE_ADDR_PKT_GET_EL(v)			(((v) & GENMASK_ULL(62, 61)) >> 61)
> > +#define SPE_ADDR_PKT_GET_CH(v)			(((v) & BIT_ULL(62)) >> 62)
> > +#define SPE_ADDR_PKT_GET_PAT(v)			(((v) & GENMASK_ULL(59, 56)) >> 56)
> 
> These seem to match the spec.
> 
> With or without addressing the nit above:
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Thanks for reviewing.

> [...]
> 
> Cheers
> ---Dave
