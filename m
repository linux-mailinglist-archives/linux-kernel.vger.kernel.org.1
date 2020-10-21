Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72741294B21
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 12:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438656AbgJUKNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 06:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438556AbgJUKNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:13:10 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7C6C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 03:13:09 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id p21so917213pju.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KKxkiwugSA8ovsQQk98B7vCBdUg6Ojx2CH1WvJsNVmw=;
        b=DdLhmSYlX5OhZLKF7XkHmU4/G002c+ZjzwFjN2fY2v6PBT41QABXIh5jZLZ6vi347G
         Wuag0pI3eMO9Y9IFum4irlu9o9QISAbGaftwzAfQGDdlEcmnxYrWxt+tzGDWZRAzODa7
         OMCrqEqmtlYQH2ScbRXEmDbIakmSNys2Am38E9AK2VTOIrS+faCAo5vaVzHpmdA6BecA
         ZEVTYNdbcCrrCTZEp+miDtm5Y6vhgehxHhUycAcW7ceBy/6hHrdiSqTyoAPWlkDgjR/j
         eJnnlfioaBm8eQtlsmJpDZrtyKhzNYSZaBLmKMdL3v64oyMnvbrGo7w46aoFcio+PHvC
         FwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KKxkiwugSA8ovsQQk98B7vCBdUg6Ojx2CH1WvJsNVmw=;
        b=fN7y8dCSDur12qbLh4UY4fMPT/agrztWWHfWUWs2yjjAUnwWa1wVCIHCy6Qtbsal6l
         Eg8Hq32M49uUpWna2qbNyXgS0z6QKfSN7qxWRDeKYIhnbaGjQV/9XInIAtJq1yaKotAd
         N5LyohQzUM9As1A2B2DRcLMpH4dEQdsZ9CIho4LzSqRuwi19lLChrPPHT1G1/V4tOW5u
         cD3ivgb1vi921Vm5xXrlaGNORewc5i/4YdlM316vGEbr588CMqm+sDn3NefQN4xr1FOj
         WfJ0qF6WvMSd2u5boqt61tE6uCkG/ATS++pRNNWveDXTwwNGYjiwNJNWR5gCdlw8NtOh
         XjMw==
X-Gm-Message-State: AOAM531xhbS9XvP7UJn8auyxiVxdInPMn89u2Lfh56x+fVgCQBpiizQz
        H2MMmpPMtEQ9k1X/CxfiVeVhrQ==
X-Google-Smtp-Source: ABdhPJxAoFsFgCyv35yICctEb7hyRn4/yVGmem8Whyqb3JRAw9wG/rHdbfNCa5PIEsprmUI4f4rKgg==
X-Received: by 2002:a17:902:8a97:b029:d4:d3f4:d209 with SMTP id p23-20020a1709028a97b02900d4d3f4d209mr2623126plo.35.1603275188764;
        Wed, 21 Oct 2020 03:13:08 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([14.192.49.12])
        by smtp.gmail.com with ESMTPSA id l13sm2045417pgq.33.2020.10.21.03.13.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Oct 2020 03:13:08 -0700 (PDT)
Date:   Wed, 21 Oct 2020 18:13:02 +0800
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
Subject: Re: [PATCH v2 10/14] perf arm-spe: Refactor event type handling
Message-ID: <20201021101302.GA3194@leoy-ThinkPad-X240s>
References: <20200929133917.9224-1-leo.yan@linaro.org>
 <20200929133917.9224-11-leo.yan@linaro.org>
 <2605044c-8172-00cf-e924-ece5a0b70e2c@arm.com>
 <20201021045452.GD7226@leoy-ThinkPad-X240s>
 <1406e767-e85a-e859-bfa2-221678e08392@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1406e767-e85a-e859-bfa2-221678e08392@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On Wed, Oct 21, 2020 at 10:20:24AM +0100, André Przywara wrote:

[...]

> >>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> >>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> >>> @@ -284,58 +284,58 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >>>  		if (ret < 0)
> >>>  			return ret;
> >>>  
> >>> -		if (payload & 0x1) {
> >>> +		if (payload & SPE_EVT_PKT_GEN_EXCEPTION) {
> >>
> >> Having the bitmask here directly is indeed not very nice and error
> >> prone. But I would rather see the above solution:
> >> 		if (payload & BIT(EV_EXCEPTION_GEN)) {
> > 
> > Will do.
> > 
> >>>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCEPTION-GEN");
> >>>  			if (ret < 0)
> >>>  				return ret;
> >>>  		}
> >>> -		if (payload & 0x2) {
> >>> +		if (payload & SPE_EVT_PKT_ARCH_RETIRED) {
> >>>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " RETIRED");
> >>>  			if (ret < 0)
> >>>  				return ret;
> >>>  		}
> >>> -		if (payload & 0x4) {
> >>> +		if (payload & SPE_EVT_PKT_L1D_ACCESS) {
> >>>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-ACCESS");
> >>>  			if (ret < 0)
> >>>  				return ret;
> >>>  		}
> >>> -		if (payload & 0x8) {
> >>> +		if (payload & SPE_EVT_PKT_L1D_REFILL) {
> >>>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-REFILL");
> >>>  			if (ret < 0)
> >>>  				return ret;
> >>>  		}
> >>> -		if (payload & 0x10) {
> >>> +		if (payload & SPE_EVT_PKT_TLB_ACCESS) {
> >>>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-ACCESS");
> >>>  			if (ret < 0)
> >>>  				return ret;
> >>>  		}
> >>> -		if (payload & 0x20) {
> >>> +		if (payload & SPE_EVT_PKT_TLB_WALK) {
> >>>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-REFILL");
> >>>  			if (ret < 0)
> >>>  				return ret;
> >>>  		}
> >>> -		if (payload & 0x40) {
> >>> +		if (payload & SPE_EVT_PKT_NOT_TAKEN) {
> >>>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " NOT-TAKEN");
> >>>  			if (ret < 0)
> >>>  				return ret;
> >>>  		}
> >>> -		if (payload & 0x80) {
> >>> +		if (payload & SPE_EVT_PKT_MISPREDICTED) {
> >>>  			ret = arm_spe_pkt_snprintf(&buf, &blen, " MISPRED");
> >>>  			if (ret < 0)
> >>>  				return ret;
> >>>  		}
> >>>  		if (idx > 1) {
> >>
> >> Do you know what the purpose of this comparison is? Surely payload would
> >> not contain more bits than would fit in "idx" bytes? So is this some
> >> attempt of an optimisation?
> > 
> > Here "idx" is for payload size (in bytes); you could see function
> > arm_spe_get_events() calculate the payload size:
> > 
> >   packet->index = PAYLOAD_LEN(buf[0]);
> > 
> > Please note, the raw payload size (field "sz" in header) value is:
> > 
> >   0b00 Byte.
> >   0b01 Halfword.
> >   0b10 Word.
> >   0b11 Doubleword.
> > 
> > After using PAYLOAD_LEN(), the payload size is converted to value in
> > byte, so:
> > 
> >   packet->index = 1 << "sz";
> > 
> >   1  Byte
> >   2  Halfword
> >   4  Word
> >   8  Doubleword
> > 
> > In Armv8 ARM, chapter "D10.2.6 Events packet", we can see the events
> > "Remote access", "Last Level cache miss" and "Last Level cache access"
> > are only valid when "sz" is equal or longer than Halfword, thus idx is
> > 2/4/8; this is why here checks the condition "if (idx > 1)".
> 
> Right, thanks for the explanation. But in the end this is just a lot of
> words for: "You can only fit n*8 bits in n bytes.", isn't it?
> So if the payload size is 1 bytes, we can't have bits 8 or higher.
> 
> And in arm_spe_get_payload() we load payload with casts, so the upper
> bits, beyond the payload size, must always be 0? Regardless of what was
> in the buffer. Or am I looking at the wrong function?

You are right!  Sorry I didn't connect with the function
arm_spe_get_payload(), so packet->payload has been been casted, so we
don't need to do extra checking for payload size at here.

Will remove the condition checking in next spin.

Thanks a lot!

Leo

> Even if that wouldn't be the case, I'd rather mask it here again, so
> that we can rely on this, and lose the extra check.
> 
> > 
> >> If so, I doubt it's really useful, the
> >> compiler might find a smarter solution to the problem. Just continuing
> >> with the bit mask comparison would make it look nicer, I think.
> > 
> > ARMv8 ARM gives out "Otherwise this bit reads-as-zero.", IIUC this
> > suggests to firstly check the size, if cannot meet the size requirement,
> > then the Event bit should be reads-as-zero.
> 
> But as mentioned above, we take care of this already:
>         switch (payload_len) {
>         case 1: packet->payload = *(uint8_t *)buf; break;
>         case 2: packet->payload = le16_to_cpu(*(uint16_t *)buf); break;
> 	...
> 
> Thanks,
> Andre
