Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B4428AB35
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 02:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgJLAVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 20:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgJLAVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 20:21:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C00C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 17:21:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id e10so11938857pfj.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 17:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=umo1JJaWMVDDLm+NYEkI+I4VsV4+nInMO5COiy1y5iE=;
        b=MnBwOtwWtQYj1Ux/oYhdJmbg6tGyoELIxGJ90ECTlhGXasZ4ZzqwwYwibB8QUET/YQ
         7c8XoslSOToHoDZGpxeXwF8OXRc6MLqu66kxbkRrPvPFAeyh3F8c/+490MuPRgb2d/xj
         zyzUqvLXe6rfzye+x3K/K9Z+it07RMokqonbTJmG21WoaPNFj4+I1XaY/C1M/43eo2sz
         MCv/6oaXO1GpTs0XkAyP4f29UJRdLcvROsi3YzNFO1Bu0AVvIEdpIuT/gcyOv9WDWrmd
         xwTOX1UaXfoYNvyVpjqTlItdwPO/mgFrDz+8jyqQvdWT05cvPhYBthpNtEY/vgYD6Uzr
         haZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=umo1JJaWMVDDLm+NYEkI+I4VsV4+nInMO5COiy1y5iE=;
        b=X++vm3mJejblgY9H1xUh8FKic56paaNgOuU5zPBE+Zd1d0ZLGDM2maJ2eg9dNVSJIe
         ykz4XEvMqOIX2yVxce0+yeL5SmjESkFyKuzEYhYeyTtaGrIRyY6/ZH6ARPSosHqhvyii
         cqmiuncaByrEv8rTCvK87S5Z2/5/n5L/rkp25Cb2ihm0j6irTe23htKDs7dcv7giHUVJ
         liwQG5zgqRQCQqv8khmiOlsFtTvPkBKnyEmjqrVcA81/aC9DVV20K1/57oFx5UxG5NgI
         2gj/sEtHVp8fwhAvyrMtWvb2T7z32IPC5empFLAZN1SqX9Ym9nz3YpHJy8TwBBnQcPE7
         iKpw==
X-Gm-Message-State: AOAM532QI9syIxgbWhJn7tIPKrwuHkxDIapXIJCuYlzf7ujMwe99JCAU
        JapSwlCzZdTWsGX4c591C6euRg==
X-Google-Smtp-Source: ABdhPJxJAtX0jXjHDu7n+OmfHNEkb6ilOarNFM5gk94OXNyLK6vgUczMy4J8wdCtVz2YYEmItn+4xw==
X-Received: by 2002:a62:8389:0:b029:152:416d:f026 with SMTP id h131-20020a6283890000b0290152416df026mr21767963pfe.64.1602462070545;
        Sun, 11 Oct 2020 17:21:10 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id 3sm6095911pfg.125.2020.10.11.17.21.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Oct 2020 17:21:09 -0700 (PDT)
Date:   Mon, 12 Oct 2020 08:21:02 +0800
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
Subject: Re: [PATCH v2 03/14] perf arm-spe: Refactor payload length
 calculation
Message-ID: <20201012002102.GB15194@leoy-ThinkPad-X240s>
References: <20200929133917.9224-1-leo.yan@linaro.org>
 <20200929133917.9224-4-leo.yan@linaro.org>
 <995b40af-13b9-faef-fb3b-235f04289eb5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <995b40af-13b9-faef-fb3b-235f04289eb5@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On Thu, Oct 08, 2020 at 02:44:59PM +0100, André Przywara wrote:
> On 29/09/2020 14:39, Leo Yan wrote:
> 
> Hi Leo,
> 
> > Defines macro for payload length calculation instead of static function.
> 
> What is the reason for that? I thought the kernel's direction is more
> the other way: replacing macros with static functions ("Don't write CPP,
> write C")? Ideally the compiler would generate the same code.

Okay, I didn't note this before.  Will change back to use static
function.

> > Currently the event packet's 'index' is assigned as payload length, but
> > the flow is not directive: it firstly gets the packet length (includes
> > header length and payload length) and then reduces header length from
> > packet length, so finally get the payload length; to simplify the code,
> > this patch directly assigns payload length to event packet's index.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 26 ++++++++-----------
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.h     |  4 +++
> >  2 files changed, 15 insertions(+), 15 deletions(-)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > index 7c7b5eb09fba..5a8696031e16 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > @@ -69,22 +69,20 @@ const char *arm_spe_pkt_name(enum arm_spe_pkt_type type)
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
> > + * Return ARM SPE payload size from header bits 5:4
> > + *   00 : byte
> > + *   01 : halfword (2)
> > + *   10 : word (4)
> > + *   11 : doubleword (8)
> >   */
> > -static int payloadlen(unsigned char byte)
> > -{
> > -	return 1 << ((byte & 0x30) >> 4);
> > -}
> > +#define PAYLOAD_LEN(val)	\
> > +	(1 << (((val) & SPE_HEADER_SZ_MASK) >> SPE_HEADER_SZ_SHIFT))
> 
> This change of the expression is good (although it should be 1U), but
> please keep it a function. The return type should be unsigned, I guess.

Will do.

> The rest looks fine.

Thanks a lot for reviewing!

Leo

> Cheers,
> Andre
> 
> >  
> >  static int arm_spe_get_payload(const unsigned char *buf, size_t len,
> >  			       struct arm_spe_pkt *packet)
> >  {
> > -	size_t payload_len = payloadlen(buf[0]);
> > +	size_t payload_len = PAYLOAD_LEN(buf[0]);
> >  
> >  	if (len < 1 + payload_len)
> >  		return ARM_SPE_NEED_MORE_BYTES;
> > @@ -136,8 +134,6 @@ static int arm_spe_get_timestamp(const unsigned char *buf, size_t len,
> >  static int arm_spe_get_events(const unsigned char *buf, size_t len,
> >  			      struct arm_spe_pkt *packet)
> >  {
> > -	int ret = arm_spe_get_payload(buf, len, packet);
> > -
> >  	packet->type = ARM_SPE_EVENTS;
> >  
> >  	/* we use index to identify Events with a less number of
> > @@ -145,9 +141,9 @@ static int arm_spe_get_events(const unsigned char *buf, size_t len,
> >  	 * LLC-REFILL, and REMOTE-ACCESS events are identified if
> >  	 * index > 1.
> >  	 */
> > -	packet->index = ret - 1;
> > +	packet->index = PAYLOAD_LEN(buf[0]);
> >  
> > -	return ret;
> > +	return arm_spe_get_payload(buf, len, packet);
> >  }
> >  
> >  static int arm_spe_get_data_source(const unsigned char *buf, size_t len,
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > index 4c870521b8eb..f2d0af39a58c 100644
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
> > @@ -36,6 +37,9 @@ struct arm_spe_pkt {
> >  	uint64_t		payload;
> >  };
> >  
> > +#define SPE_HEADER_SZ_SHIFT		(4)
> > +#define SPE_HEADER_SZ_MASK		GENMASK_ULL(5, 4)
> > +
> >  #define SPE_ADDR_PKT_HDR_INDEX_INS		(0x0)
> >  #define SPE_ADDR_PKT_HDR_INDEX_BRANCH		(0x1)
> >  #define SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT	(0x2)
> > 
> 
