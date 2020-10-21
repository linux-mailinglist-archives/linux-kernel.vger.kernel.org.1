Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D7E294793
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 06:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440280AbgJUEzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 00:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440234AbgJUEy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 00:54:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DDBC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 21:54:59 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id hk7so508574pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 21:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=G2cSwDDyEq99/q8QnKyDxvIUlGMpzIctZ3sXKu+5rK8=;
        b=KpAMQbQBvzeKziQqpoDmmJ2HFg/gZNZx15plRx2TeBZ/ZIufnoGtHft3GTso9QGUCd
         EAu2OdueKcWbf1DlvWm0Bq0MOo9gLhIm0eJzN1enF0fWmXgH0imnpcnwyqZg5rjxfuOu
         tBFQ5PlabG4pHvANOL2GLSC/gRXK95+fdwybXLnggT/3NTQx18o/Xop38Nc12LwXUZPq
         ILH+StKW8Fb1pf0gmEAhPxwkGCOeMEYCr1vqX3J9M6oMKskUYiHCd/kn+JDr1b7kyaHc
         ALJFFXR9aoUmkf/u03TUswp4oMfkhf55e3c7jWv9OJoWgbuV2y5osJ35DZ72mcHk9FIK
         8KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G2cSwDDyEq99/q8QnKyDxvIUlGMpzIctZ3sXKu+5rK8=;
        b=X86o4JnJPlUiFshn1tRjYSnpkAzBQI0ZbIjWIaGK8IdAAP2OYGYSqK5eVYj6BKRP2j
         p5v7WGn3aO9KLK19iVM5d5bpGxXVl/WZ8CoqyrautjL3BOSXkTAcZevSxg7gqOVihhDT
         WDXUiStpZuz5sXYbU3dQaCWA88SUIH60/7QGMhvdeV8FqEy4XPOSN5n7Rkz3s5w/YwhA
         vo6bXvc9x4tK6ezFMMpUzuvFG7KB9NYwlpXYORrLjyx1RlKlKp6FjNvhoprVwp5dShfm
         Z7v5qiMYQNeDJIfP15vUcx6Qtgr82WJgmb53KH9F2SzUvYdQsF5ezrzpdZKVBo8vi8TZ
         uKJQ==
X-Gm-Message-State: AOAM531d3LW5W+2bJeKkpaCVuOCp6meL8llkEiO0VNBwlOsDN28btUMB
        Hqb7HnFSwlcByoAP2oXAMMmg7A==
X-Google-Smtp-Source: ABdhPJyZDY6S8EOLBJjlmW4Knp+2M4h8Sh59NF7/b6S9IYJeDbjo3mdPJGg5B3KY5VFwRKLPc5gCuQ==
X-Received: by 2002:a17:90b:3716:: with SMTP id mg22mr1531080pjb.83.1603256099198;
        Tue, 20 Oct 2020 21:54:59 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([14.192.49.12])
        by smtp.gmail.com with ESMTPSA id z20sm619437pfk.199.2020.10.20.21.54.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Oct 2020 21:54:58 -0700 (PDT)
Date:   Wed, 21 Oct 2020 12:54:52 +0800
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
Message-ID: <20201021045452.GD7226@leoy-ThinkPad-X240s>
References: <20200929133917.9224-1-leo.yan@linaro.org>
 <20200929133917.9224-11-leo.yan@linaro.org>
 <2605044c-8172-00cf-e924-ece5a0b70e2c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2605044c-8172-00cf-e924-ece5a0b70e2c@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:54:16PM +0100, André Przywara wrote:
> On 29/09/2020 14:39, Leo Yan wrote:
> 
> Hi,
> 
> > Use macros instead of the enum values for event types, this is more
> > directive and without bit shifting when parse packet.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  .../util/arm-spe-decoder/arm-spe-decoder.c    | 16 +++++++-------
> >  .../util/arm-spe-decoder/arm-spe-decoder.h    | 17 --------------
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 22 +++++++++----------
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 16 ++++++++++++++
> >  4 files changed, 35 insertions(+), 36 deletions(-)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > index 9d3de163d47c..ac66e7f42a58 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > @@ -168,31 +168,31 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
> >  		case ARM_SPE_OP_TYPE:
> >  			break;
> >  		case ARM_SPE_EVENTS:
> > -			if (payload & BIT(EV_L1D_REFILL))
> > +			if (payload & SPE_EVT_PKT_L1D_REFILL)
> 
> Not sure this (and the others below) are an improvement? I liked the
> enum below, and reading BIT() here tells me that it's a bitmask.

Agreed.

> >  				decoder->record.type |= ARM_SPE_L1D_MISS;
> >  
> > -			if (payload & BIT(EV_L1D_ACCESS))
> > +			if (payload & SPE_EVT_PKT_L1D_ACCESS)
> >  				decoder->record.type |= ARM_SPE_L1D_ACCESS;
> >  
> > -			if (payload & BIT(EV_TLB_WALK))
> > +			if (payload & SPE_EVT_PKT_TLB_WALK)
> >  				decoder->record.type |= ARM_SPE_TLB_MISS;
> >  
> > -			if (payload & BIT(EV_TLB_ACCESS))
> > +			if (payload & SPE_EVT_PKT_TLB_ACCESS)
> >  				decoder->record.type |= ARM_SPE_TLB_ACCESS;
> >  
> >  			if ((idx == 2 || idx == 4 || idx == 8) &&
> > -			    (payload & BIT(EV_LLC_MISS)))
> > +			    (payload & SPE_EVT_PKT_LLC_MISS))
> >  				decoder->record.type |= ARM_SPE_LLC_MISS;
> >  
> >  			if ((idx == 2 || idx == 4 || idx == 8) &&
> > -			    (payload & BIT(EV_LLC_ACCESS)))
> > +			    (payload & SPE_EVT_PKT_LLC_ACCESS))
> >  				decoder->record.type |= ARM_SPE_LLC_ACCESS;
> >  
> >  			if ((idx == 2 || idx == 4 || idx == 8) &&
> > -			    (payload & BIT(EV_REMOTE_ACCESS)))
> > +			    (payload & SPE_EVT_PKT_REMOTE_ACCESS))
> >  				decoder->record.type |= ARM_SPE_REMOTE_ACCESS;
> >  
> > -			if (payload & BIT(EV_MISPRED))
> > +			if (payload & SPE_EVT_PKT_MISPREDICTED)
> >  				decoder->record.type |= ARM_SPE_BRANCH_MISS;
> >  
> >  			break;
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> > index a5111a8d4360..24727b8ca7ff 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> > @@ -13,23 +13,6 @@
> >  
> >  #include "arm-spe-pkt-decoder.h"
> >  
> > -enum arm_spe_events {
> > -	EV_EXCEPTION_GEN	= 0,
> > -	EV_RETIRED		= 1,
> > -	EV_L1D_ACCESS		= 2,
> > -	EV_L1D_REFILL		= 3,
> > -	EV_TLB_ACCESS		= 4,
> > -	EV_TLB_WALK		= 5,
> > -	EV_NOT_TAKEN		= 6,
> > -	EV_MISPRED		= 7,
> > -	EV_LLC_ACCESS		= 8,
> > -	EV_LLC_MISS		= 9,
> > -	EV_REMOTE_ACCESS	= 10,
> > -	EV_ALIGNMENT		= 11,
> > -	EV_PARTIAL_PREDICATE	= 17,
> > -	EV_EMPTY_PREDICATE	= 18,
> > -};
> 
> So what about keeping this, but moving it into the other header file?

Will do.  This is more directive, especially if we consider every bit
indicates an event type :)

> coding-style.rst says: "Enums are preferred when defining several
> related constants."

Thanks for pasting the coding style, it's useful.  I agree that using
BIT() + enum is better form, will refine the patch for this.

> > -
> >  enum arm_spe_sample_type {
> >  	ARM_SPE_L1D_ACCESS	= 1 << 0,
> >  	ARM_SPE_L1D_MISS	= 1 << 1,
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > index ed0f4c74dfc5..b8f343320abf 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > @@ -284,58 +284,58 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >  		if (ret < 0)
> >  			return ret;
> >  
> > -		if (payload & 0x1) {
> > +		if (payload & SPE_EVT_PKT_GEN_EXCEPTION) {
> 
> Having the bitmask here directly is indeed not very nice and error
> prone. But I would rather see the above solution:
> 		if (payload & BIT(EV_EXCEPTION_GEN)) {

Will do.

> >  			ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCEPTION-GEN");
> >  			if (ret < 0)
> >  				return ret;
> >  		}
> > -		if (payload & 0x2) {
> > +		if (payload & SPE_EVT_PKT_ARCH_RETIRED) {
> >  			ret = arm_spe_pkt_snprintf(&buf, &blen, " RETIRED");
> >  			if (ret < 0)
> >  				return ret;
> >  		}
> > -		if (payload & 0x4) {
> > +		if (payload & SPE_EVT_PKT_L1D_ACCESS) {
> >  			ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-ACCESS");
> >  			if (ret < 0)
> >  				return ret;
> >  		}
> > -		if (payload & 0x8) {
> > +		if (payload & SPE_EVT_PKT_L1D_REFILL) {
> >  			ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-REFILL");
> >  			if (ret < 0)
> >  				return ret;
> >  		}
> > -		if (payload & 0x10) {
> > +		if (payload & SPE_EVT_PKT_TLB_ACCESS) {
> >  			ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-ACCESS");
> >  			if (ret < 0)
> >  				return ret;
> >  		}
> > -		if (payload & 0x20) {
> > +		if (payload & SPE_EVT_PKT_TLB_WALK) {
> >  			ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-REFILL");
> >  			if (ret < 0)
> >  				return ret;
> >  		}
> > -		if (payload & 0x40) {
> > +		if (payload & SPE_EVT_PKT_NOT_TAKEN) {
> >  			ret = arm_spe_pkt_snprintf(&buf, &blen, " NOT-TAKEN");
> >  			if (ret < 0)
> >  				return ret;
> >  		}
> > -		if (payload & 0x80) {
> > +		if (payload & SPE_EVT_PKT_MISPREDICTED) {
> >  			ret = arm_spe_pkt_snprintf(&buf, &blen, " MISPRED");
> >  			if (ret < 0)
> >  				return ret;
> >  		}
> >  		if (idx > 1) {
> 
> Do you know what the purpose of this comparison is? Surely payload would
> not contain more bits than would fit in "idx" bytes? So is this some
> attempt of an optimisation?

Here "idx" is for payload size (in bytes); you could see function
arm_spe_get_events() calculate the payload size:

  packet->index = PAYLOAD_LEN(buf[0]);

Please note, the raw payload size (field "sz" in header) value is:

  0b00 Byte.
  0b01 Halfword.
  0b10 Word.
  0b11 Doubleword.

After using PAYLOAD_LEN(), the payload size is converted to value in
byte, so:

  packet->index = 1 << "sz";

  1  Byte
  2  Halfword
  4  Word
  8  Doubleword

In Armv8 ARM, chapter "D10.2.6 Events packet", we can see the events
"Remote access", "Last Level cache miss" and "Last Level cache access"
are only valid when "sz" is equal or longer than Halfword, thus idx is
2/4/8; this is why here checks the condition "if (idx > 1)".

> If so, I doubt it's really useful, the
> compiler might find a smarter solution to the problem. Just continuing
> with the bit mask comparison would make it look nicer, I think.

ARMv8 ARM gives out "Otherwise this bit reads-as-zero.", IIUC this
suggests to firstly check the size, if cannot meet the size requirement,
then the Event bit should be reads-as-zero.

Thanks,
Leo
