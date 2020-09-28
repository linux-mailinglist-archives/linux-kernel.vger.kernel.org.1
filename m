Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494D227AC71
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 13:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgI1LJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 07:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgI1LJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 07:09:00 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BFDC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 04:09:00 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mm21so444135pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 04:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=D7hFPD/UIncBaTjn81NRYz8OqFIdTpnrdS3XNJeL41o=;
        b=zFeV4c4e5TAEDJF9Inbklt5a96uAUIj1MudWQRyBQuNi1G2qbtm+GTdl2VbeWt2Dt0
         1qotaK0pmFxCg7hzhgf66RTwMq6cVa/t71hkKrQD8l/ZQ/ipErol1UmitK80kD7cc/Fj
         cbzf44BjE9AYuwRoMnIZ1P8je9bTqSTJ+CXFRM1R4sFnaxGU6XgWXQ08mGhk1Y6XueXx
         uCwr6xqAO11EhGohsVJ78k8oSX0cCvamA+RkQlmLk0d4p174AkzbUXR5VBqBoxYF3q/l
         Zj5R6XN0Q37fp0Lk3BrpxjT6PSfQy01wEzm0f8yv2oRhuKCjmzysWKhAp48PV4XoJHy4
         1FUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=D7hFPD/UIncBaTjn81NRYz8OqFIdTpnrdS3XNJeL41o=;
        b=ZN4B9BSEbBxNotoDKvFfkC5Hci7xD7tttBC/mTSyXPhAlBukbPwQJGcEZjjPha0fKo
         Hke+suRipFI4XgqFcPh9lbhi/A5oCbgyc0sHC3Pt5jMOxWkapJli/OdVo6rB8LB/UuKo
         NlXQ2FBhQOTGOsOnkG80lyjS0aFAL98SkHBkFjkPuStusaOCPvcV4TTcDiLx7ERV6CMH
         NkAJ65TIIx7RD8NcaTPluLcWGGfzwOl5hWnO/i+47eMb23VcbccjhuSj2BPR6qxxHxyE
         OzASWLmq95IviIsBRpDLe/QEeRlJCGpMLQGpblo1v+Uph7YwpI+r6ZM1dSK87dQF4QDy
         VCWQ==
X-Gm-Message-State: AOAM531AzDBQ808xLL3GZofqUqyfze3ed7P66UhEgMCOQLePGqYYr7A+
        xroW85alqxbqf0q0F4+/xqChNw==
X-Google-Smtp-Source: ABdhPJydRrDSzhwdzqFBtUaEyIaVhdiWZEHi3Kv3wTqHLVyACu4Y3hCysSNOgwnCCPsZtOustRQWHA==
X-Received: by 2002:a17:90b:4b11:: with SMTP id lx17mr865803pjb.22.1601291339969;
        Mon, 28 Sep 2020 04:08:59 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id g23sm1252943pfh.133.2020.09.28.04.08.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Sep 2020 04:08:59 -0700 (PDT)
Date:   Mon, 28 Sep 2020 19:08:51 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wei Li <liwei391@huawei.com>
Subject: Re: [PATCH 5/5] perf: arm_spe: Decode SVE events
Message-ID: <20200928110851.GC11043@leoy-ThinkPad-X240s>
References: <20200922101225.183554-1-andre.przywara@arm.com>
 <20200922101225.183554-6-andre.przywara@arm.com>
 <20200927033035.GE9677@leoy-ThinkPad-X240s>
 <2a301585-1930-17e4-f9a1-d47ca5264734@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a301585-1930-17e4-f9a1-d47ca5264734@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On Mon, Sep 28, 2020 at 11:15:53AM +0100, André Przywara wrote:

[...]

> > So my summary for patches 02 ~ 05, except patch 04, other changes has
> > been included in the patch set "perf arm-spe: Refactor decoding &
> > dumping flow".
> 
> Ah, my sincere apologies, I totally missed Wei's and your series on this
> (although I did some research on "prior art").

No worries!

> > I'd like to add your patch 04 into the patch set "perf arm-spe:
> > Refactor decoding & dumping flow" and I will respin the patch set v2 on
> > the latest perf/core branch and send out to review.
> > 
> > For patch 01, you could continue to try to land it in the kernel.
> > (Maybe consolidate a bit with Wei?).
> > 
> > Do you think this is okay for you?
> 
> Yes, sounds like a plan. So Wei's original series is now fully
> integrated into your 13-patch rework, right?

Thanks for confirmation.

You could see Wei's patch set has 4 patches [1].  I only picked the
patch 02 [2] from Wei's patch set into my refactoring patch set; the
patch 01 is for enabling driver for SVE events, the patches 03/04
introduced new synthesized events.

Patches 03 / 04 should be considered carefully and it's good to prove
these synthesized events will be useful for user cases before upstream
them.  The reason is AFAIK a good direction to generate SPE trace data
for memory events [3], and for SVE, I think we should firstly consider
if can reuse the memory event for profiling rather than adding new
synthesized events.

So I prefer to give priority for patches 01 / 02.

> Is "[RESEND,v1,xx/13] ..." the latest revision of your series?

Yes.

> Do you plan on sending a v2 anytime soon? Or shall I do review on the
> existing one?

For saving time, let me respin patch set v2 and send to LKML (hope in
next 1~2 days).  Then you could review patch set v2.

Thanks,
Leo

[1] https://lore.kernel.org/patchwork/cover/1278778/
[2] https://lore.kernel.org/patchwork/patch/1278780/
[3] https://lore.kernel.org/patchwork/cover/1298085/
