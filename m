Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE582764B1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 01:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgIWXsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 19:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIWXsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 19:48:37 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FA8C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 16:48:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q4so601641pjh.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 16:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ovt4pQ3gKFpnFw1VSWElm9ADFfenrPcCrTS18tiMWV8=;
        b=lFfBnXlNe/bBAY/d5UMogRnM/WSZNv937yUmlXL5I1khfv87rU+tfcXQtoZuu9OxRw
         +QYqEn7Q+ubneCF7hRPrGYbtyen2dQySHoysXGQr/DaMgJwQqqoF4w1lWLb/+hNZEgix
         ccUJ5FcmrROdGr9C18HozmYPEJXfkPT9CsU+fn0WVclJihCcVwDLq3mHdlmo8XZZR3Tp
         6uYf0/44pLiS3PT6mQSiNPmj8zJrlMyU3oHQMwS8jkX4Zj4OwIat8bLAC1msgLuNePyu
         j2duA2hPjqbKFgIf847i83G0TkQJlLmqB6u6qYWUCoJAbbEeKeIUz7ViknLJXOrAQ2PZ
         acpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ovt4pQ3gKFpnFw1VSWElm9ADFfenrPcCrTS18tiMWV8=;
        b=t8jQcjSko4C12hBdtvGwFhG0y2hjaIm08y/Fl+jVL9wvG42gouZ1fdlCMt4oYF1E5l
         Mfju7t/ONnqe9fqfAsYgpMp8xsGBGmDpAaTIy29kxwx43WHw7mtgdQ+Cr60vcLd3ietX
         ouFnBoUfUhKoVnoe+UbOi2bxcsrO/aeXm6KRglzxkuUEH977dB1tL1qJ5VRoFvl7WBE/
         bTZ0VLk2clJ+6ltYeXuyVoNa5DjCKHfqc12nqqJ+7GeFEsUp0++g2x/0lRU66CLf5wot
         Jg2TEXqPSFbHPxrXgFNpZ8L8NMy9WoSasnmls7fFmfRwqaIn7bC3Y5v3HbcWcON+wca9
         fhWw==
X-Gm-Message-State: AOAM532DEYU7jqSeHoSIU3HWbztTi9ASfoN3PMcj6SdLGuSXkHhz27BF
        SR3cuHXMXu9YewkEN4Do7tjWfw==
X-Google-Smtp-Source: ABdhPJz05WPlT6L5effD79aDv96rajwiyHjGm/OitXz4ZewYgNJc7BO5eaRW1A/TPS+rPmP0mc/YrA==
X-Received: by 2002:a17:902:d3d4:b029:d1:e598:3ff3 with SMTP id w20-20020a170902d3d4b02900d1e5983ff3mr1950655plb.45.1600904916977;
        Wed, 23 Sep 2020 16:48:36 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id a9sm478301pjm.40.2020.09.23.16.48.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Sep 2020 16:48:36 -0700 (PDT)
Date:   Thu, 24 Sep 2020 07:48:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Steve MacLean <Steve.MacLean@microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zou Wei <zou_wei@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/6] Perf tool: Support TSC for Arm64
Message-ID: <20200923234828.GA10346@leoy-ThinkPad-X240s>
References: <20200914115311.2201-1-leo.yan@linaro.org>
 <20200922120732.GB15124@leoy-ThinkPad-X240s>
 <20200922164906.GA2248446@kernel.org>
 <20200923152753.GC2517482@kernel.org>
 <20200923155557.GD2517482@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923155557.GD2517482@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Wed, Sep 23, 2020 at 12:55:57PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Sep 23, 2020 at 12:27:53PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Sep 22, 2020 at 01:49:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Tue, Sep 22, 2020 at 08:07:32PM +0800, Leo Yan escreveu:
> > > > Hi Arnaldo,
> > > > 
> > > > On Mon, Sep 14, 2020 at 07:53:05PM +0800, Leo Yan wrote:
> > > > > This patch set is to refactor TSC implementation and move TSC code from
> > > > > x86 folder to util/tsc.c, this allows all archs to reuse the code.  And
> > > > > alse move the TSC testing from x86 folder to tests so can work as a
> > > > > common testing.
> > > > > 
> > > > > So far, for x86 it needs to support cap_user_time_zero and for Arm64
> > > > > it needs to support cap_user_time_short.  For architecture specific
> > > > > code, every arch only needs to implement its own rdtsc() to read out
> > > > > timer's counter.
> > > > > 
> > > > > This patch set has been rebased on the perf/core branch with latest
> > > > > commit b1f815c479c1 ("perf vendor events power9: Add hv_24x7 core level
> > > > > metric events") and tested on Arm64 DB410c.
> > > > 
> > > > Could you pick up this patch set?  Thanks!
> > > 
> > > Yeah, I picked it up now, its a pity nobody provided Acks :-\
> > > 
> > > Or have a missed them somehow?
> > 
> > Also:
> 
> So, this is the first:
> 
> commit 0ab58c405dd7c143a1482cb9414eb0eb9b31d42a (HEAD)
> Author: Leo Yan <leo.yan@linaro.org>
> Date:   Mon Sep 14 19:53:10 2020 +0800
> 
>     perf tests tsc: Make tsc testing as a common testing
> 
> I'll remove it and the ones after that, so the main feature is kept.
> 
> I'll retest, and then push to perf/core you can then continue from
> there.

Will monitor perf/core branch and after you push onto it, I will fix
the issue ASAP.   Sorry for inconvenience.

Thanks,
Leo
