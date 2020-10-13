Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3356A28D0AF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgJMOwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:52:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730236AbgJMOwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:52:20 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F1752489B;
        Tue, 13 Oct 2020 14:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602600739;
        bh=1rkYKmpMyyn97uiDmc6UodSnbIU4qXwfrC47nUMN4bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lxWCNYZTL2LBW0DLLDynU9GBdfM7S8DWPGQ37AF3Ym+f6crAUyiRIBqa1uWMT/hR0
         1ZEKw8xzRQ5a50C3lQgZrbcGnC7fjG8V9kZhZHQ+xsluhdcd2YLsSWwE53rQu4wKlg
         S2xJE2cIByLjd88+fgEI6hiIwIiKOwt5+Kk7/UlM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5576C4047F; Tue, 13 Oct 2020 11:52:17 -0300 (-03)
Date:   Tue, 13 Oct 2020 11:52:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] perf: arm_spe: Decode memory tagging properties
Message-ID: <20201013145217.GF1063281@kernel.org>
References: <20200922101225.183554-1-andre.przywara@arm.com>
 <20200922101225.183554-5-andre.przywara@arm.com>
 <20200927031918.GD9677@leoy-ThinkPad-X240s>
 <20201013145103.GE1063281@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013145103.GE1063281@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 13, 2020 at 11:51:03AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sun, Sep 27, 2020 at 11:19:18AM +0800, Leo Yan escreveu:
> > On Tue, Sep 22, 2020 at 11:12:24AM +0100, Andre Przywara wrote:
> > > When SPE records a physical address, it can additionally tag the event
> > > with information from the Memory Tagging architecture extension.
> > > 
> > > Decode the two additional fields in the SPE event payload.
> > > 
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > >  .../util/arm-spe-decoder/arm-spe-pkt-decoder.c  | 17 ++++++++++++-----
> > >  1 file changed, 12 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > index 943e4155b246..a033f34846a6 100644
> > > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > @@ -8,13 +8,14 @@
> > >  #include <string.h>
> > >  #include <endian.h>
> > >  #include <byteswap.h>
> > > +#include <linux/bits.h>
> > >  
> > >  #include "arm-spe-pkt-decoder.h"
> > >  
> > > -#define BIT(n)		(1ULL << (n))
> > > -
> > >  #define NS_FLAG		BIT(63)
> > >  #define EL_FLAG		(BIT(62) | BIT(61))
> > > +#define CH_FLAG		BIT(62)
> > > +#define PAT_FLAG	GENMASK_ULL(59, 56)
> > >  
> > >  #define SPE_HEADER0_PAD			0x0
> > >  #define SPE_HEADER0_END			0x1
> > > @@ -447,10 +448,16 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> > >  			return snprintf(buf, buf_len, "%s 0x%llx el%d ns=%d",
> > >  				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
> > >  		case 2:	return snprintf(buf, buf_len, "VA 0x%llx", payload);
> > > -		case 3:	ns = !!(packet->payload & NS_FLAG);
> > > +		case 3:	{
> > > +			int ch = !!(packet->payload & CH_FLAG);
> > > +			int pat = (packet->payload & PAT_FLAG) >> 56;
> > > +
> > > +			ns = !!(packet->payload & NS_FLAG);
> > >  			payload &= ~(0xffULL << 56);
> > > -			return snprintf(buf, buf_len, "PA 0x%llx ns=%d",
> > > -					payload, ns);
> > > +			return snprintf(buf, buf_len,
> > > +					"PA 0x%llx ns=%d ch=%d, pat=%x",
> > > +					payload, ns, ch, pat);
> > > +			}
> > 
> > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
> Thanks, applied.

I take that back, I'm applying Leo's series that Andre reviewed instead.

- Arnaldo
