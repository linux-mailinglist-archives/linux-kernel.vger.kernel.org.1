Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4055E294B26
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 12:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409895AbgJUKR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 06:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409812AbgJUKR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:17:56 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4D6C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 03:17:55 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o7so1210501pgv.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 03:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TOGN6/95XVOYasVET4TPHsdfeoSJXlss37vDWxfvwiE=;
        b=Ude9OQLN5X+h7VdE1vy1/p8AF9higk3UfJCg+7iBv68ZmegidJwzpTFQ6v4cgdetMA
         hQbJhYdknBqBJypJ5YBF/IK/a2d2Uqta9OKcU6SyAbjdFCa1gtRNsAzJH5HfNvR8D4cn
         36AtX6gdTEHNEV3ygLSmRueyciqV09l9u3j+THo3AuglIiD4B83sR/RRx6yxjtAFrPxy
         k4IA8BOwe4u9EZ1wm+aMOVD8oAHrfZyLnigQeH6oa9k5ka2PetaTHYDqHCEN1RNf+hgH
         sxITHlvCFrMbIWVvUXsKpI9MCESLjLEdWVZMvvLnOdv0RQY0uO5GlK/tITQtwJ0gGMNd
         QleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TOGN6/95XVOYasVET4TPHsdfeoSJXlss37vDWxfvwiE=;
        b=R7otkunzDBTpP1JT3Gdd7bLycLp2km0eXztgI4FWal8a29Nbzft9gctyHRZwu2K3RH
         BGYghnBHDZheibh+ljDSnDgx2J3FPiqfzsYN5Y5e9gkttoFTBNQq88+NiWouA4/KfDAu
         vh9xZhdG0EKtBqxJ+5iT1E93dWYptlq3VAosdgBJzgbKiNdQiKHwePNp/kh8Sjmbe7SU
         CJFXBqPXDg3zHBraN20+XvgNRGvLmm2cpQbhjAAosOre2UVkQw+biepoNM3rRNT0RcYp
         nKFwlPdWLP9UWrKoqLyvjJAwaLyOAxtwGrUdZWbMI4I1qE7F3v+3GGA/2K0m8v+ho4Bj
         7HHA==
X-Gm-Message-State: AOAM531A5pq9JEVPOV8eP5ATOUAtecusXN7VpatV9K+75Fu/uQo09/NA
        dcjzMU/+Gb4t5gKs4LaHPfoVM2q2IpRxB0Fb7XQ=
X-Google-Smtp-Source: ABdhPJy0/1EEEjO9umjfWyHQ7y2iShiNHMnldyB9wXhCT0WMr2ycfeng98rQiA27sFfmo8O2EdjBHg==
X-Received: by 2002:a65:68c6:: with SMTP id k6mr2731585pgt.231.1603275474575;
        Wed, 21 Oct 2020 03:17:54 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([14.192.49.12])
        by smtp.gmail.com with ESMTPSA id e11sm1967645pfm.160.2020.10.21.03.17.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Oct 2020 03:17:53 -0700 (PDT)
Date:   Wed, 21 Oct 2020 18:17:48 +0800
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
Message-ID: <20201021101748.GB3194@leoy-ThinkPad-X240s>
References: <20200929133917.9224-1-leo.yan@linaro.org>
 <20200929133917.9224-15-leo.yan@linaro.org>
 <9c74082b-fccf-7713-b98d-50da76c5d7af@arm.com>
 <20201021051031.GE7226@leoy-ThinkPad-X240s>
 <df1faa9b-d8cb-ebcf-b70f-3672a6d8db1f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df1faa9b-d8cb-ebcf-b70f-3672a6d8db1f@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 10:26:07AM +0100, André Przywara wrote:
> On 21/10/2020 06:10, Leo Yan wrote:
> 
> Hi,
> 
> > On Tue, Oct 20, 2020 at 10:54:44PM +0100, Andrï¿½ Przywara wrote:
> >> On 29/09/2020 14:39, Leo Yan wrote:
> >>
> >> Hi,
> >>
> >>> From: Wei Li <liwei391@huawei.com>
> >>>
> >>> This patch is to support Armv8.3 extension for SPE, it adds alignment
> >>> field in the Events packet and it supports the Scalable Vector Extension
> >>> (SVE) for Operation packet and Events packet with two additions:
> >>>
> >>>   - The vector length for SVE operations in the Operation Type packet;
> >>>   - The incomplete predicate and empty predicate fields in the Events
> >>>     packet.
> >>>
> >>> Signed-off-by: Wei Li <liwei391@huawei.com>
> >>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> >>> ---
> >>>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 84 ++++++++++++++++++-
> >>>  .../arm-spe-decoder/arm-spe-pkt-decoder.h     |  6 ++
> >>>  2 files changed, 87 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> >>> index 05a4c74399d7..3ec381fddfcb 100644
> >>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> >>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> >>> @@ -342,14 +342,73 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
> >>>  					return ret;
> >>>  			}
> >>>  		}
> >>> +		if (idx > 2) {
> >>
> >> As I mentioned in the other patch, I doubt this extra comparison is
> >> useful. Does that protect us from anything?
> > 
> > It's the same reason with Event packet which have explained for replying
> > patch 10, the condition is to respect the SPE specifiction:
> > 
> >   E[11], byte 1, bit [11], when SZ == 0b10 , or SZ == 0b11
> >      Alignment.
> >      ...
> >      Otherwise this bit reads-as-zero.
> > 
> > So we gives higher priority for checking payload size than the Event
> > bit setting; if you have other thinking for this, please let me know.
> 
> Ah, thanks for pointing this out. It looks like a bug in the manual
> then, because I don't see why bit 11 should be any different from bits
> [10:8] and bits [15:12] in this respect. And in the diagrams above you
> clearly see bit 11 being shown even when SZ == 0b01.
> 
> I will try to follow this up here.

Thanks for following up!

> >>> +			if (payload & SPE_EVT_PKT_ALIGNMENT) {
> >>
> >> Mmh, but this is bit 11, right?
> > 
> > Yes.
> > 
> >> So would need to go into the (idx > 1)
> >> section (covering bits 8-15)? Another reason to ditch this comparison above.
> > 
> > As has explained in patch 10, idx is not the same thing with "sz"
> > field; "idx" stands for payload length in bytes, so:
> > 
> >   idx = 1 << sz
> > 
> > The spec defines the sz is 2 or 3, thus idx is 4 or 8; so this is why
> > here use the condition "(idx > 2)".
> > 
> > I think here need to refine code for more explict expression so can
> > avoid confusion.  So I think it's better to condition such like:
> > 
> >   if (payload_len >= 4) {
> 
> Yes, that would be (or have been) more helpful, but as mentioned in the
> other patch, I'd rather see those comparisons go entirely.

Agree.  Will remove comparisons in next version.

Thanks,
Leo
