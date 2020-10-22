Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E692955BD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 02:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894425AbgJVAoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 20:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442436AbgJVAoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 20:44:34 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD91C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 17:44:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y1so33984plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 17:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JQj/F1WGtmfl96nLYTyRRps4j7+rYPw7b7qMltLSutE=;
        b=JuPqckNek8jwh0li33locD2FsyoxA98In2CWC4qb4IMXieei2HUhZFn3n55ZA8ZIFg
         KNotVqzwZSdDZnwey72PE4d59iorz9iBqfX8QSMnoVI7LBF8Zv2LUBec80oyPlIPCpFD
         WB+ZsNbKEfADH8xinJhmVHx0A6myoT+qROo9468kw2JAEmbuJrXl5GKS6z+vk5jXV6py
         z9/hLweXuLTfUsSidP9hWblrpPMnxGToGsimYzqY1wcBXlqBSYsaUo5KDG1Rxh7XW+oh
         kAd6DyEYmIvMPdZbnu/QP0Fl0Mall7VRuwRPUcr2k0rlsfb8/3JKnP/l0qfYilN9bg6G
         1Bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JQj/F1WGtmfl96nLYTyRRps4j7+rYPw7b7qMltLSutE=;
        b=A6c1OLfhciF6ZRKvnA6IB4F2DDj7q8SGn+8typvs355k7rAS6YN8kYt5whg7uAHc8x
         NWgnEIC9rl0J61f69CNXO7Wn8wYYAEHRdPlXAM3Xeq0JSeFWlvR3p3q5X6r62dkdCHce
         V9GFMQ6d3vTpha2slEanebDk4EIvIWOREPQCjt5b+0JvHnH5UA6g4hVtIx/oS84DrljN
         RoMJzB6tnwqXjHBQSYfHAh2lT1ixzkN08f6YTevK551Suu8e+6Z/ooUagT0edeFnXn5F
         SQFiPWA/LgRgybgkCvd5LGLZluBNtZE85CLIDU884S0jL95k+1gITmPtRNvcTdI17wb6
         Bt6A==
X-Gm-Message-State: AOAM533ztVUYZHhnosGUjo30lf9L+rxiv2NzxjNohQzJt9vLPdlk9CpE
        8M0eU1LZpX/P7Tr6CD90kfBMfQ==
X-Google-Smtp-Source: ABdhPJxF+AJ2bDcGr/lyHDxOp0KSMSY2rdnGD1fjSIH47YTGtT69n6Dy9w2XBi9rV7wTX8qA9t5bnQ==
X-Received: by 2002:a17:90a:de98:: with SMTP id n24mr21643pjv.100.1603327472020;
        Wed, 21 Oct 2020 17:44:32 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([14.192.49.12])
        by smtp.gmail.com with ESMTPSA id y65sm3424517pfy.57.2020.10.21.17.44.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Oct 2020 17:44:31 -0700 (PDT)
Date:   Thu, 22 Oct 2020 08:44:13 +0800
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
Subject: Re: [PATCH v2 14/14] perf arm-spe: Add support for ARMv8.3-SPE
Message-ID: <20201022004413.GC3194@leoy-ThinkPad-X240s>
References: <20200929133917.9224-1-leo.yan@linaro.org>
 <20200929133917.9224-15-leo.yan@linaro.org>
 <9c74082b-fccf-7713-b98d-50da76c5d7af@arm.com>
 <20201021051031.GE7226@leoy-ThinkPad-X240s>
 <df1faa9b-d8cb-ebcf-b70f-3672a6d8db1f@arm.com>
 <20201021101748.GB3194@leoy-ThinkPad-X240s>
 <bf23b7ff-9ecd-26ed-71fd-e3a840a687e1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf23b7ff-9ecd-26ed-71fd-e3a840a687e1@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On Wed, Oct 21, 2020 at 03:53:31PM +0100, André Przywara wrote:

[...]

> >>>>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> >>>>> index 05a4c74399d7..3ec381fddfcb 100644
> >>>>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> >>>>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> >>>>> @@ -342,14 +342,73 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >>>>>  					return ret;
> >>>>>  			}
> >>>>>  		}
> >>>>> +		if (idx > 2) {
> >>>>
> >>>> As I mentioned in the other patch, I doubt this extra comparison is
> >>>> useful. Does that protect us from anything?
> >>>
> >>> It's the same reason with Event packet which have explained for replying
> >>> patch 10, the condition is to respect the SPE specifiction:
> >>>
> >>>   E[11], byte 1, bit [11], when SZ == 0b10 , or SZ == 0b11
> >>>      Alignment.
> >>>      ...
> >>>      Otherwise this bit reads-as-zero.
> >>>
> >>> So we gives higher priority for checking payload size than the Event
> >>> bit setting; if you have other thinking for this, please let me know.
> >>
> >> Ah, thanks for pointing this out. It looks like a bug in the manual
> >> then, because I don't see why bit 11 should be any different from bits
> >> [10:8] and bits [15:12] in this respect. And in the diagrams above you
> >> clearly see bit 11 being shown even when SZ == 0b01.
> >>
> >> I will try to follow this up here.
> > 
> > Thanks for following up!
> 
> Just got the confirmation that this is indeed a bug in the manual. It
> will be fixed, but since the ARM ARM isn't published on a daily base, it
> might take a while to trickle in.

Thanks for confirmation and sharing the info!

Leo
