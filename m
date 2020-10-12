Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4FF28AB4D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 03:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgJLBAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 21:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgJLBAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 21:00:48 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BBDC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 18:00:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c6so7677634plr.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 18:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Hg4pNtTrdIIxMv1ygCotZbagLsWphrKoFSZAlC7Ddrc=;
        b=ZsHhylGm9Xsf276PufT6SCjTNNeFNbVkkvHd7TyvWyEKdrJjDvsnvHXHODtmHAIvYH
         ihK6+x9dHLneLlpDVehbUmIuG3xR0OLIvb5weP/XCB0Sq6Q7boVyMSgDXwcWc6LEUagv
         tYq96V0nyTzczVFAUFt9sIXFidtDxUGtPRU2F8dctY4sc7K2gZHrOybyGiM6MsMmkMvp
         vA5tIXpnl6olNFqo4fllPSXLXBKk5M/lHvoY6s2qPqazlA8KLwK+7aYqn1uQLPm7kyG0
         N7v+ysvX2DB83fnYBgN0jjTlJHK/+bHxNbRuAN6EeBBTweICzbAsEAS37f4zGDew8/ZT
         v0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Hg4pNtTrdIIxMv1ygCotZbagLsWphrKoFSZAlC7Ddrc=;
        b=XCcfalgCmoaOPwSpOrAVFUpjaWMYXtLGPnERJo2LK29j/Eo5ltltpUosE44h0M3xNj
         m2DG4J484k6qRG46EgCjMscwuXO++m67JQDh4yEq4eX14JAKLuyvoliM/jcI8Vob6AuF
         kLx+WLug/SRivoemg15UfW7pRvUvGf7POsX6cl//yQYrAVCnH3tj/0rji3Mg0D19u5sx
         +rMO0b31kyCaUZ1Qd7SVQaPTpBhOaZUtj2zoO9F3PxYoJ6FACn/aarDWuBZdlfGChQz9
         AeP7hyEFQCBA9zsh9QxkobfnAnHJH5BrmQJMpuAX0wKXN0EdFLIkNBmYYwRA8a1y7Ttc
         8VpA==
X-Gm-Message-State: AOAM5339GbW4ggU/piwpieY+GVHRUvFQMM2ztTseEt81rgDO5BdNDHlK
        SmjZJkBIwrkdHyB4EknGfR0PtQ==
X-Google-Smtp-Source: ABdhPJzN5R1/0a5T0pXelrO+J+KiJaDIEEcdx7omaF59M23NYc1/Xl2ytALgLa53N2qdlHiDMCQUrA==
X-Received: by 2002:a17:902:b58a:b029:d4:d44a:f56d with SMTP id a10-20020a170902b58ab02900d4d44af56dmr5663341pls.7.1602464447558;
        Sun, 11 Oct 2020 18:00:47 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id x18sm12613157pga.49.2020.10.11.18.00.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Oct 2020 18:00:46 -0700 (PDT)
Date:   Mon, 12 Oct 2020 09:00:38 +0800
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
Subject: Re: [PATCH v2 06/14] perf arm-spe: Refactor packet header parsing
Message-ID: <20201012010038.GD15194@leoy-ThinkPad-X240s>
References: <20200929133917.9224-1-leo.yan@linaro.org>
 <20200929133917.9224-7-leo.yan@linaro.org>
 <d3d0bf64-0285-1aef-3ec1-74f0d28257a6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3d0bf64-0285-1aef-3ec1-74f0d28257a6@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 08:49:11PM +0100, André Przywara wrote:
> On 29/09/2020 14:39, Leo Yan wrote:
> 
> Hi Leo,
> 
> > The packet header parsing uses the hard coded values and it uses nested
> > if-else statements.
> > 
> > To improve the readability, this patch refactors the macros for packet
> > header format so it removes the hard coded values.  Furthermore, based
> > on the new mask macros it reduces the nested if-else statements and
> > changes to use the flat conditions checking, this is directive and can
> > easily map to the descriptions in ARMv8-a architecture reference manual
> > (ARM DDI 0487E.a), chapter 'D10.1.5 Statistical Profiling Extension
> > protocol packet headers'.
> 
> Yeah, that's so much better, thank you!

Welcome :)

> I checked all the bits and comparisons against the ARM ARM.
> 
> Two minor things below ...
> 
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 92 +++++++++----------
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 21 +++++
> >  2 files changed, 62 insertions(+), 51 deletions(-)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > index 96b717a19163..e738bd04f209 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > @@ -16,28 +16,6 @@
> >  #define NS_FLAG		BIT(63)
> >  #define EL_FLAG		(BIT(62) | BIT(61))
> >  
> > -#define SPE_HEADER0_PAD			0x0
> > -#define SPE_HEADER0_END			0x1
> > -#define SPE_HEADER0_ADDRESS		0x30 /* address packet (short) */
> > -#define SPE_HEADER0_ADDRESS_MASK	0x38
> > -#define SPE_HEADER0_COUNTER		0x18 /* counter packet (short) */
> > -#define SPE_HEADER0_COUNTER_MASK	0x38
> > -#define SPE_HEADER0_TIMESTAMP		0x71
> > -#define SPE_HEADER0_TIMESTAMP		0x71
> > -#define SPE_HEADER0_EVENTS		0x2
> > -#define SPE_HEADER0_EVENTS_MASK		0xf
> > -#define SPE_HEADER0_SOURCE		0x3
> > -#define SPE_HEADER0_SOURCE_MASK		0xf
> > -#define SPE_HEADER0_CONTEXT		0x24
> > -#define SPE_HEADER0_CONTEXT_MASK	0x3c
> > -#define SPE_HEADER0_OP_TYPE		0x8
> > -#define SPE_HEADER0_OP_TYPE_MASK	0x3c
> > -#define SPE_HEADER1_ALIGNMENT		0x0
> > -#define SPE_HEADER1_ADDRESS		0xb0 /* address packet (extended) */
> > -#define SPE_HEADER1_ADDRESS_MASK	0xf8
> > -#define SPE_HEADER1_COUNTER		0x98 /* counter packet (extended) */
> > -#define SPE_HEADER1_COUNTER_MASK	0xf8
> > -
> >  #if __BYTE_ORDER == __BIG_ENDIAN
> >  #define le16_to_cpu bswap_16
> >  #define le32_to_cpu bswap_32
> > @@ -198,46 +176,58 @@ static int arm_spe_get_addr(const unsigned char *buf, size_t len,
> >  static int arm_spe_do_get_packet(const unsigned char *buf, size_t len,
> >  				 struct arm_spe_pkt *packet)
> >  {
> > -	unsigned int byte;
> > +	unsigned int hdr;
> > +	unsigned char ext_hdr = 0;
> >  
> >  	memset(packet, 0, sizeof(struct arm_spe_pkt));
> >  
> >  	if (!len)
> >  		return ARM_SPE_NEED_MORE_BYTES;
> >  
> > -	byte = buf[0];
> > -	if (byte == SPE_HEADER0_PAD)
> > +	hdr = buf[0];
> > +
> > +	if (hdr == SPE_HEADER0_PAD)
> >  		return arm_spe_get_pad(packet);
> > -	else if (byte == SPE_HEADER0_END) /* no timestamp at end of record */
> > +
> > +	if (hdr == SPE_HEADER0_END) /* no timestamp at end of record */
> >  		return arm_spe_get_end(packet);
> > -	else if (byte & 0xc0 /* 0y11xxxxxx */) {
> > -		if (byte & 0x80) {
> > -			if ((byte & SPE_HEADER0_ADDRESS_MASK) == SPE_HEADER0_ADDRESS)
> > -				return arm_spe_get_addr(buf, len, 0, packet);
> > -			if ((byte & SPE_HEADER0_COUNTER_MASK) == SPE_HEADER0_COUNTER)
> > -				return arm_spe_get_counter(buf, len, 0, packet);
> > -		} else
> > -			if (byte == SPE_HEADER0_TIMESTAMP)
> > -				return arm_spe_get_timestamp(buf, len, packet);
> > -			else if ((byte & SPE_HEADER0_EVENTS_MASK) == SPE_HEADER0_EVENTS)
> > -				return arm_spe_get_events(buf, len, packet);
> > -			else if ((byte & SPE_HEADER0_SOURCE_MASK) == SPE_HEADER0_SOURCE)
> > -				return arm_spe_get_data_source(buf, len, packet);
> > -			else if ((byte & SPE_HEADER0_CONTEXT_MASK) == SPE_HEADER0_CONTEXT)
> > -				return arm_spe_get_context(buf, len, packet);
> > -			else if ((byte & SPE_HEADER0_OP_TYPE_MASK) == SPE_HEADER0_OP_TYPE)
> > -				return arm_spe_get_op_type(buf, len, packet);
> > -	} else if ((byte & 0xe0) == 0x20 /* 0y001xxxxx */) {
> > -		/* 16-bit header */
> > -		byte = buf[1];
> > -		if (byte == SPE_HEADER1_ALIGNMENT)
> > +
> > +	if (hdr == SPE_HEADER0_TIMESTAMP)
> > +		return arm_spe_get_timestamp(buf, len, packet);
> > +
> > +	if ((hdr & SPE_HEADER0_MASK1) == SPE_HEADER0_EVENTS)
> > +		return arm_spe_get_events(buf, len, packet);
> > +
> > +	if ((hdr & SPE_HEADER0_MASK1) == SPE_HEADER0_SOURCE)
> > +		return arm_spe_get_data_source(buf, len, packet);
> > +
> > +	if ((hdr & SPE_HEADER0_MASK2) == SPE_HEADER0_CONTEXT)
> > +		return arm_spe_get_context(buf, len, packet);
> > +
> > +	if ((hdr & SPE_HEADER0_MASK2) == SPE_HEADER0_OPERATION)
> > +		return arm_spe_get_op_type(buf, len, packet);
> > +
> > +	if ((hdr & SPE_HEADER0_MASK3) == SPE_HEADER0_EXTENDED) {
> 
> Is there any reason you are using MASK3 here, and not MASK2? The ARM ARM
> seems to suggest that bits [7:2] make up the mask for the extended
> header type, as the actual subtype is handled in the next byte.

You are right, here I introduced confusion for MASK3 for bits [7:5];
will change to use MASK2 for the mask of the extended header type.

> > +		/* 16-bit extended format header */
> > +		ext_hdr = 1;
> > +
> > +		hdr = buf[1];
> > +		if (hdr == SPE_HEADER1_ALIGNMENT)
> >  			return arm_spe_get_alignment(buf, len, packet);
> > -		else if ((byte & SPE_HEADER1_ADDRESS_MASK) == SPE_HEADER1_ADDRESS)
> > -			return arm_spe_get_addr(buf, len, 1, packet);
> > -		else if ((byte & SPE_HEADER1_COUNTER_MASK) == SPE_HEADER1_COUNTER)
> > -			return arm_spe_get_counter(buf, len, 1, packet);
> >  	}
> >  
> > +	/*
> > +	 * The short format header's byte 0 or the extended format header's
> > +	 * byte 1 has been assigned to 'hdr', which uses the same encoding for
> > +	 * address packet and counter packet, so don't need to distinguish if
> > +	 * it's short format or extended format and handle in once.
> > +	 */
> > +	if ((hdr & SPE_HEADER0_MASK4) == SPE_HEADER0_ADDRESS)
> > +		return arm_spe_get_addr(buf, len, ext_hdr, packet);
> > +
> > +	if ((hdr & SPE_HEADER0_MASK4) == SPE_HEADER0_COUNTER)
> > +		return arm_spe_get_counter(buf, len, ext_hdr, packet);
> > +
> >  	return ARM_SPE_BAD_PACKET;
> >  }
> >  
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > index f2d0af39a58c..a30fe3c5ab67 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > @@ -37,6 +37,27 @@ struct arm_spe_pkt {
> >  	uint64_t		payload;
> >  };
> >  
> > +/* Short header (HEADER0) and extended header (HEADER1) */
> > +#define SPE_HEADER0_PAD			0x0
> > +#define SPE_HEADER0_END			0x1
> > +#define SPE_HEADER0_TIMESTAMP		0x71
> > +/* Mask for event & data source */
> > +#define SPE_HEADER0_MASK1		(GENMASK_ULL(7, 6) | GENMASK_ULL(3, 0))
> > +#define SPE_HEADER0_EVENTS		0x42
> > +#define SPE_HEADER0_SOURCE		0x43
> > +/* Mask for context & operation */
> > +#define SPE_HEADER0_MASK2		GENMASK_ULL(7, 2)
> > +#define SPE_HEADER0_CONTEXT		0x64
> > +#define SPE_HEADER0_OPERATION		0x48
> 
> Just a nit, but should the name be ..._OP_TYPE instead?

Exactly, will apply this in next spin.

Very appreicate for your detailed reviewing.

Thanks,
Leo
