Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42DC298566
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 02:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420321AbgJZBmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 21:42:05 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36060 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420291AbgJZBmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 21:42:04 -0400
Received: by mail-pj1-f67.google.com with SMTP id d22so878868pjz.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 18:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gR1anoVspPY6VM2EVs+RjunFJOobxxG0tGa88nMT4zY=;
        b=zZ3O9HhTzxN7SPI3g8PE3gP7dbGrhHhKGMUX/G1QhS8Nlfh0iqqxpFLC16IoLB/iI+
         QN4b3nzyuwufOS4cqeCml5GpQAl1FPafrq2/50J2im8HyMkPUDXp4ku2XU0Lt99PdurI
         gB/iItCQQfYAUIUVviWLqxh11+Qst0NrqXJ/IJ2VEmfErMV30S2bXDF3vKeU4wbFQoxc
         EsqJW45DiHJyXju/n9139LdTmxF6xUgW7eV0AS5Qa7GflFY0y2h0qvLiyCGHRpm8WTyX
         9ex3ONiNK2lcKQMb9jL/ORC6x96Nogch0OIjMekTuhzf0Lk70+wu5v12wP/qBrxo47m0
         05Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gR1anoVspPY6VM2EVs+RjunFJOobxxG0tGa88nMT4zY=;
        b=FTlfnpR7+3lUE5qT8cOI+HP/oLc8MtiuBZYVaRjV9GkVwX2dC8DDC+K5Vd4r5eT8p4
         NgIPzIMqTE6Me5kgM1ag/60W5CGYAKF8fEt8/xhGIZR0OYAbpTGmhr/B1Iay4mxj6Bps
         WJCPf/BoZAg5hIG4mRo9eQjTXan8Ikv+Yqnng/IbVuI5B09cjqyCC1n3V6JndDWeKhgy
         Ed9+KyQF0oh/24Ljo6u/TF7RfyxhO+l28Fz5e9aETLAfp4lYbDvBVgim1rppYvBAWiPh
         qvaHH3Lp1EktmXRKytoJoTwF+PXnEb8yeS9+ZU5ORsmpUyiTLWxOYk+bU7RWi+nwSdJv
         kL+g==
X-Gm-Message-State: AOAM533i2z5H/AUYw8HybEyB/1wJnUEG1xPr85FD3XX5aKCr2JxRHc5g
        R+V4eZGhTS6XnQO/jzRkNzNO2Q==
X-Google-Smtp-Source: ABdhPJwcOc4Zh0wAnIv+ytnyFoyFPbBZgpFkn0M6VUoROwnMWS6AleP0ZRcea/wr1/76cpsu0cv44w==
X-Received: by 2002:a17:902:9306:b029:d6:3600:46ea with SMTP id bc6-20020a1709029306b02900d6360046eamr8914367plb.2.1603676521721;
        Sun, 25 Oct 2020 18:42:01 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id e14sm5687719pga.61.2020.10.25.18.41.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Oct 2020 18:42:01 -0700 (PDT)
Date:   Mon, 26 Oct 2020 09:41:55 +0800
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
Subject: Re: [PATCH v3 03/20] perf arm-spe: Refactor payload size calculation
Message-ID: <20201026014155.GB9541@leoy-ThinkPad-X240s>
References: <20201022145816.14069-1-leo.yan@linaro.org>
 <20201022145816.14069-4-leo.yan@linaro.org>
 <b77beca4-91e3-5b76-8cd6-ba31057374a8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b77beca4-91e3-5b76-8cd6-ba31057374a8@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On Fri, Oct 23, 2020 at 06:08:53PM +0100, André Przywara wrote:
> On 22/10/2020 15:57, Leo Yan wrote:
> 
> Hi Leo,
> 
> > This patch defines macro to extract "sz" field from header, and renames
> > the function payloadlen() to arm_spe_payload_len().
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  .../util/arm-spe-decoder/arm-spe-pkt-decoder.c | 18 +++++++++---------
> >  .../util/arm-spe-decoder/arm-spe-pkt-decoder.h |  3 +++
> >  2 files changed, 12 insertions(+), 9 deletions(-)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > index 7c7b5eb09fba..4294c133a465 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > @@ -69,22 +69,22 @@ const char *arm_spe_pkt_name(enum arm_spe_pkt_type type)
> >  	return arm_spe_packet_name[type];
> >  }
> >  
> > -/* return ARM SPE payload size from its encoding,
> > - * which is in bits 5:4 of the byte.
> > - * 00 : byte
> > - * 01 : halfword (2)
> > - * 10 : word (4)
> > - * 11 : doubleword (8)
> > +/*
> > + * Extracts the field "sz" from header bits and converts to bytes:
> > + *   00 : byte (1)
> > + *   01 : halfword (2)
> > + *   10 : word (4)
> > + *   11 : doubleword (8)
> >   */
> > -static int payloadlen(unsigned char byte)
> > +static unsigned int arm_spe_payload_len(unsigned char hdr)
> >  {
> > -	return 1 << ((byte & 0x30) >> 4);
> > +	return 1 << SPE_HEADER_SZ(hdr);
> 
> I know, I know, I asked for this, but now looking again at it - and
> after having seen the whole series:
> This is now really trivial, and there are just two users? And
> SPE_HEADER_SZ() is only used in here?
> 
> So either you just stuff the "1U << .." into the callers of
> arm_spe_payload_len(), or indeed put all of this into one macro (as you
> had originally).

Okay, will stuff the "1U << .." into the function.

> Apologies for this forth and back, but I didn't realise how this is
> really used eventually, and I just saw the transition from function to
> macro.

Actually you considered more than me and I learned many details from the
reivewing process, so no worries :)

> But please use 1U << .., signed shifts are treacherous.
> 
> >  }
> >  
> >  static int arm_spe_get_payload(const unsigned char *buf, size_t len,
> >  			       struct arm_spe_pkt *packet)
> >  {
> > -	size_t payload_len = payloadlen(buf[0]);
> > +	size_t payload_len = arm_spe_payload_len(buf[0]);
> >  
> >  	if (len < 1 + payload_len)
> >  		return ARM_SPE_NEED_MORE_BYTES;
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > index 4c870521b8eb..e9ea8e3ead5d 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > @@ -9,6 +9,7 @@
> >  
> >  #include <stddef.h>
> >  #include <stdint.h>
> > +#include <linux/bits.h>
> >  
> >  #define ARM_SPE_PKT_DESC_MAX		256
> >  
> > @@ -36,6 +37,8 @@ struct arm_spe_pkt {
> >  	uint64_t		payload;
> >  };
> >  
> > +#define SPE_HEADER_SZ(val)			((val & GENMASK_ULL(5, 4)) >> 4)
> 
> If you should keep this, please put parentheses around "val".

I went through your suggestions in this patch and other patches, looks
reasonable to me, will follow them and respin patch set.

Thanks a lot for timely reviewing!

Leo
