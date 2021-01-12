Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82A32F32C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbhALOPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbhALOPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:15:46 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6882EC061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:15:06 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id lj6so1671932pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7GtD3YonrmXIET8rBk/Trj9GYaC3dwJx6PaGPk04xNU=;
        b=p8zPfzTtoi55Jiq3vrboqKOsVERPA/n2bF35M7daR4boTgYxhddvsIyjQxvcVmLooa
         0xBRL05l6RWtKiE8TMeMxDtCFYueNjl4dOMSSxCKZ275OfsSAxctnDujd3HkEVCwRJIP
         4fcdnMKyLh4GkpH/6avje2iRLTTPNW+QAuTk3TCeBgovAGh73eSgHYs+x3xt0jIRlRhy
         bSgOrkRMr1eFe/4MVPY7viBZrlANizGeEm7HH1NZmM8T4RXXNbsRQ5YSQ6qaAn5bUgyN
         1FNKilRh2T7Cw7XjO5eggmetopm4Bk/epZ/R9T2S0+wGtUhGmpXenG26M6asawwU7O7C
         a5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7GtD3YonrmXIET8rBk/Trj9GYaC3dwJx6PaGPk04xNU=;
        b=UYI01V0dRMTyuvyHgaB3Bj4sHcOkWaEbo9FLOkTSbBenJLwlb2NUhhLmKv8+dOeNgM
         hmmqFFDrKbcKkdl9uJm+SDIjpwUZTXMIBJqOnUFqduIBSd9Eg/m6giXhDNG710jVqJs3
         fH2vYhHiV0oc3IkH/sVEXDl7vKWQ/TRBK06wA79ZNnpdZ2o+36n0pLZ3NjvvF/fn/yR5
         vO8ZQJ2hA7roTzY3Emv617ztFvHsRR2fhfr2Oxy7o5VENthceOf3hhzx/g76dx8m1Vjo
         ZWfO2IWV7q5OFMQFHlhAreHqPvCFrIsH56A/mRz42qHF4i4i3P6GAL0Y8xyNQyECXSKi
         czZA==
X-Gm-Message-State: AOAM530rcORanfi7RdHCKyUBme5do5wTYN8jDZ8l6dO96rZbtSXOixyY
        bRfNve2PrvjJZGZaIIVbOHevCQ==
X-Google-Smtp-Source: ABdhPJx3te7nt4Meaz1hm32robPfSSYqRQOAN/H6JsLTOVomFO7bTq5g/J3hhhn7CeMTHLe+h7uBOA==
X-Received: by 2002:a17:902:82c8:b029:da:eead:94a0 with SMTP id u8-20020a17090282c8b02900daeead94a0mr4988832plz.42.1610460905559;
        Tue, 12 Jan 2021 06:15:05 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id b11sm3355025pfr.38.2021.01.12.06.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:15:04 -0800 (PST)
Date:   Tue, 12 Jan 2021 22:14:58 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Grant <al.grant@arm.com>
Subject: Re: [PATCH v1 1/7] coresight: etm-perf: Add support for PID tracing
 for kernel at EL2
Message-ID: <20210112141458.GF18965@leoy-ThinkPad-X240s>
References: <20210109074435.626855-1-leo.yan@linaro.org>
 <20210109074435.626855-2-leo.yan@linaro.org>
 <CAJ9a7VgTqsa4_W0bmfS1BPYnKyvToyVLD=fk85_t9-yehCY9Lw@mail.gmail.com>
 <20210112085826.GC18965@leoy-ThinkPad-X240s>
 <CAJ9a7VgYt-JemRaJn_KtO-X729jo-0y0OO5hCm=tHay31Q6msw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VgYt-JemRaJn_KtO-X729jo-0y0OO5hCm=tHay31Q6msw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Tue, Jan 12, 2021 at 11:23:03AM +0000, Mike Leach wrote:
> Hi Leo,
> 
> On Tue, 12 Jan 2021 at 08:58, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > Hi Mike,
> >
> > On Mon, Jan 11, 2021 at 04:22:39PM +0000, Mike Leach wrote:
> >
> > [...]
> >
> > > > diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> > > > index b0e35eec6499..927c6285ce5d 100644
> > > > --- a/include/linux/coresight-pmu.h
> > > > +++ b/include/linux/coresight-pmu.h
> > > > @@ -11,16 +11,19 @@
> > > >  #define CORESIGHT_ETM_PMU_SEED  0x10
> > > >
> > > >  /* ETMv3.5/PTM's ETMCR config bit */
> > > > -#define ETM_OPT_CYCACC  12
> > > > -#define ETM_OPT_CTXTID 14
> > > > -#define ETM_OPT_TS      28
> > > > -#define ETM_OPT_RETSTK 29
> > > > +#define ETM_OPT_CYCACC         12
> > > > +#define ETM_OPT_CTXTID         14
> > > > +#define ETM_OPT_CTXTID_IN_VMID 15
> > >
> > > Minor issue here - ETMv3.x / PTM cannot trace CXTID in VMID so this
> > > may better be named ETM4_OPT_CTXTID_IN_VMID, rather than be grouped
> > > with the ETM3.5 options?
> >
> > I looked into this suggestion but found it's complex than I assumed.
> > This config bits are not only used for ETMv3.x / PTM, it's also used
> > as an configuration interface between user space in Perf and kernel
> > drivers.
> >
> > For example, in the userspace, perf tool sets bit ETM_OPT_TS to enable
> > timestamp [1], this is same for ETMv3 and ETMv4.  In the kernel side,
> > the configuration is directly used ETMv3 (in coresight-etm3x-core.c),
> > but the configuration bits are converted for ETMv4 in the function
> > etm4_parse_event_config() [2].
> >
> > So this is a historical issue, at the early period ETMv3 and ETMv4 can
> > be compatible with each other for configurations, but after evoluation,
> > some configs only belong to ETMv4 and cannot be applied on ETMv3
> > anymore, but we still use ETMv3.5 config bits as the interface between
> > kernel and userspace.
> >
> 
> I was aware that etm3/ptm used these bits as both the options and the
> bit values for direct writing to the ETMCR register for ETMv3, and
> re-mapped to appropriate register values in ETMv4.
> In the past we have re-used etmv3.5 bit definitions ETM_xxx  when
> appropriate, but where unique to ETM4 we  have used a ETM4_xxx naming
> convention.

I am concern this approach is not friendly for extension; for example,
let's say IP ETM5 with defined bit 28 as CTXTID, if add a new option
for it, we need to define macro as:

        #define ETM5_OPT_CTXTID         28

This will result in confliction with the existed option ETM_OPT_TS
and it is hard for maintenance for options, since there have different
prefixes (like ETM_OPT_xxx, ETM4_OPT_xxx, ETM5_OPT_xxx, etc).

I'd like to take option as knob to enable or disable hardware
feature; the low level drivers should set the appropriate values for
registers based on different options.

Furthermore, ETM driver should report error when detect any option is
not supported, I.e. ETM3 driver should report failure if user wrongly
set the option ETM_OPT_CTXTID_IN_VMID.

> I am not suggesting re-factoring the options completely, just
> re-naming this single option to make it clear it is unique to ETM4+.

Here I perfer Suzuki's suggestion to simply refine comments, something
like below:

/*
 * Below are bit offsets for perf options, most of them are orignally
 * coming from ETMv3.5/PTM's ETMCR config bits (so far except
 * ETM_OPT_CTXTID_IN_VMID is only used for ETMv4).
 *
 * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
 * directly use below macros as config bits.
 */
#define ETM_OPT_CYCACC          12
#define ETM_OPT_CTXTID          14
#define ETM_OPT_CTXTID_IN_VMID  15
#define ETM_OPT_TS              28
#define ETM_OPT_RETSTK          29

> Looking at the etmv3 driver, at present it does not actually appear to
> support contextid tracing - and when it does, both bits 14 and 15 will
> be required to be used - as ETMCR defines these bits as ContextID
> size.
> Should this ever get fixed.

Good catch!  Seems to me, this is a good example that we should
distinguish the definition between Perf options and config bits :)

> then having an overlapping option bit -
> that appears to be valid for ETMv3 will be confusing.

I hope the the proposed change can avoid the confusion, if have
concern, please let me know.

Thanks a lot for suggestions,
Leo
