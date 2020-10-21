Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF692947B8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 07:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440395AbgJUFRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 01:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440388AbgJUFRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 01:17:03 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE701C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 22:17:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so785336pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 22:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=j6Ur/gsET9allS69C/SwfChyOM+T3pg318AITvWNDuA=;
        b=g4TTsKvaowv7/wr+VS3Ku6rtExc5x8W7HPbEQU6zpWz2X8OuSv+1OkckKYcm/1M2m/
         aOHbG4yr78TMHC7Wj89rdtWl0ZIMgcEc6utPG445aqpDXT6BGq4nnqVx8W1o7vzmvmRv
         u8zSvmt7K99e2goVnUUsfj32YKv/K3NSPlhNk5cWPqzoVW8/1S8+ofXcByA3uhZBkxbF
         aM9e706gA8R31S3+pMccLDMYA2y63A7aJNhPNgKTkQsGAWNONzzOBjErvoeys72msFNU
         gCKeSLbIMdPPKYh9SX0ZIJ258S/3CM2o2I3bJwOPcrk89b9EMf7JeY0ANNHCuLF1ff81
         ToLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=j6Ur/gsET9allS69C/SwfChyOM+T3pg318AITvWNDuA=;
        b=W82mtLSRK0mQebvHt7Ec6RmeGoKLMGG/EM3Gj7w3EKOZl+39yxZSEdNOG9d7V5VTs2
         l6s39lGWYieSmP4Go8yZFdXvK+1oYER5nyl+Nxew4keQiSSv8X+/IYma+uB7ZFj9UPgw
         ri70vBNh0YquQQNBBTOEv0q8MH9jplbh7Tgm/9ydyYbVmq9ELVZ/mnSlzAQjfXAXv7xy
         hhHrZ7Aqt/7/ao2IzfKTENhLx7v5M8SC8/EMcmXXY2DTn+iqIIzTUIvgl6s0K18S6jc6
         QKVC+EywdpgtWbn6/4wpLyorhHKGflmEDWuZaOmX0ZpGVj0vCnSqyqiiq/8YF2byEUUm
         XjBw==
X-Gm-Message-State: AOAM531i5zXidtYp0Pj7kQ383NexoBKBnoP9gWtFFf4Z9dQ4KWhxhL/k
        Esh98Zy+8v/szOjqAMhucvtawQ==
X-Google-Smtp-Source: ABdhPJycofoRoqzjnkg5UtG2FjiPsM6yWwwsNijvUU0TgcTdxc24SnVc8wv/Uvir4pfHYajHkyAWtA==
X-Received: by 2002:aa7:854a:0:b029:154:f2fd:c70a with SMTP id y10-20020aa7854a0000b0290154f2fdc70amr1601089pfn.39.1603257423084;
        Tue, 20 Oct 2020 22:17:03 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([14.192.49.12])
        by smtp.gmail.com with ESMTPSA id l18sm725024pfd.210.2020.10.20.22.16.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Oct 2020 22:17:02 -0700 (PDT)
Date:   Wed, 21 Oct 2020 13:16:56 +0800
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
Subject: Re: [PATCH v2 12/14] perf arm-spe: Add more sub classes for
 operation packet
Message-ID: <20201021051656.GF7226@leoy-ThinkPad-X240s>
References: <20200929133917.9224-1-leo.yan@linaro.org>
 <20200929133917.9224-13-leo.yan@linaro.org>
 <de7d783c-29c6-0f71-922d-bcefe8f1962a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de7d783c-29c6-0f71-922d-bcefe8f1962a@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:54:57PM +0100, André Przywara wrote:
> On 29/09/2020 14:39, Leo Yan wrote:
> 
> Hi,
> 
> > For the operation type packet payload with load/store class, it misses
> > to support these sub classes:
> > 
> >   - A load/store targeting the general-purpose registers;
> >   - A load/store targeting unspecified registers;
> >   - The ARMv8.4 nested virtualisation extension can redirect system
> >     register accesses to a memory page controlled by the hypervisor.
> >     The SPE profiling feature in newer implementations can tag those
> >     memory accesses accordingly.
> > 
> > Add the bit pattern describing load/store sub classes, so that the perf
> > tool can decode it properly.
> > 
> > Inspired by Andre Przywara, refined the commit log and code for more
> > clear description.
> > 
> > Co-developed-by: Andre Przywara <andre.przywara@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  .../util/arm-spe-decoder/arm-spe-pkt-decoder.c    | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > index a848c784f4cf..57a2d5494838 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > @@ -378,6 +378,21 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >  				ret = arm_spe_pkt_snprintf(&buf, &blen, " SIMD-FP");
> >  				if (ret < 0)
> >  					return ret;
> > +			} else if ((payload & SPE_OP_PKT_LDST_SUBCLASS_MASK) ==
> 
> These three and the one above use the same mask, should this go into a
> switch case? Move this block to the end, then do:
> 	switch (payload & SPE_OP_PKT_LDST_SUBCLASS_MASK) {
> 	case SPE_OP_PKT_LDST_SUBCLASS_GP_REG:
> 		...
> 	case SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG:
> 		...
> Maybe even assign just a string pointer inside, then have one snprintf.
> Haven't checked it that *really* looks better, though.

Good point, will follow up this suggestion.

> Also those later checks are quite indented, shall those be moved to
> helper functions? Again just an idea ....

Yeah, I also considered to divide into small functions to handle
different types of packets so can avoid deep indention.  Will tweak
patches for this.

Very appreciate for your detailed reviewing and suggestions throughout
the patch set!

Leo
