Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992EE2F4075
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393007AbhAMAmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 19:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390303AbhALXor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:44:47 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6BFC06179F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:44:07 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id g10so1926811wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=13Pl4XAMUhez0jbUfywZeknBjZz6BXpikXW9lK4IWSQ=;
        b=DxOMUV/AwzsU8Bxxho9X9o2mffHav5+nYYGjmOjHu0UF64RmP6BGE69vwTkoAbNCV3
         UlTwohTzPOqfFZfVUm7p8I77E/zXdBmSgIjycKvDbzpYnTTLRfRpR2HUWRBuTRXkDsQg
         2fxh+3OYqQZPtTfbCARmDBJUTrXkpl25QrrSST4rZpKWLForEuJJX7G6mc9N1MlnlW3Q
         xyF1lfEZ+Jl+txKx8Qg+qSjVjsIF+hqpiSVsAnAFLNbROhjRbSPpwYib9yN0g/OHNhBF
         JBKQM/4+2FXsKmEDqI9V17fZ4p0aJ/+E+YIFu5b6TPtEu56+SPo9+Fwd1frxl9MpKnuF
         IvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13Pl4XAMUhez0jbUfywZeknBjZz6BXpikXW9lK4IWSQ=;
        b=m88+MhNu/W0cRTcYL8CRY/DE7BAsg0d4OCu0Em06+6+xeXBUJmdrvLFTbpRUNV698x
         dDXSKCw+mAKYB9e0Yk/bl/xwbV1Kq1ET8ZUOs+ahFOaBLHTnBYVf+fweG8zSPVKwYrUi
         JrE9LzPaB0FbnXPURBAeSHJw1c0JdteEfkxxMlNsbcfcLsGrTkP3rytGYeK8rYCCV6hp
         z4945FRg3fWsTIsRCz/PJ8AlEWjaaCiUslJVpAsDi9MDgJOobbKXVNCVUv08XSS5b6+C
         +tWZ5aidULv2KNcJC2vYRqdiIBkmiWenZ8RA4kqIGyQDfCXdJnemsIyBWHJcyySHPHfY
         wP0w==
X-Gm-Message-State: AOAM532AWc2o09J+03YqUFaMgL7dAFJ1DxMJMKlQ4Hmp/QSU2Yl+9Wbw
        Qn0+UBkcLzPQvTeSZotnKlgy1SV58Atomsbl8fAEOQ==
X-Google-Smtp-Source: ABdhPJx06ofU6hqy2BlI6NNCevuMzXNikWqi5FxP+z9XcarFcWeXXiYfhd7bVr6n+PKXss2BXMbSmbKtwTTaLjlhncE=
X-Received: by 2002:a7b:c184:: with SMTP id y4mr92985wmi.92.1610495045888;
 Tue, 12 Jan 2021 15:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20210109074435.626855-1-leo.yan@linaro.org> <20210109074435.626855-2-leo.yan@linaro.org>
 <CAJ9a7VgTqsa4_W0bmfS1BPYnKyvToyVLD=fk85_t9-yehCY9Lw@mail.gmail.com>
 <20210112085826.GC18965@leoy-ThinkPad-X240s> <CAJ9a7VgYt-JemRaJn_KtO-X729jo-0y0OO5hCm=tHay31Q6msw@mail.gmail.com>
 <20210112141458.GF18965@leoy-ThinkPad-X240s>
In-Reply-To: <20210112141458.GF18965@leoy-ThinkPad-X240s>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 12 Jan 2021 23:43:55 +0000
Message-ID: <CAJ9a7Vj5Yz_2pXzwSgwou2Uq3O9CZ77VWDaPbohdy0-aeJXOxA@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] coresight: etm-perf: Add support for PID tracing
 for kernel at EL2
To:     Leo Yan <leo.yan@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Tue, 12 Jan 2021 at 14:15, Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Mike,
>
> On Tue, Jan 12, 2021 at 11:23:03AM +0000, Mike Leach wrote:
> > Hi Leo,
> >
> > On Tue, 12 Jan 2021 at 08:58, Leo Yan <leo.yan@linaro.org> wrote:
> > >
> > > Hi Mike,
> > >
> > > On Mon, Jan 11, 2021 at 04:22:39PM +0000, Mike Leach wrote:
> > >
> > > [...]
> > >
> > > > > diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> > > > > index b0e35eec6499..927c6285ce5d 100644
> > > > > --- a/include/linux/coresight-pmu.h
> > > > > +++ b/include/linux/coresight-pmu.h
> > > > > @@ -11,16 +11,19 @@
> > > > >  #define CORESIGHT_ETM_PMU_SEED  0x10
> > > > >
> > > > >  /* ETMv3.5/PTM's ETMCR config bit */
> > > > > -#define ETM_OPT_CYCACC  12
> > > > > -#define ETM_OPT_CTXTID 14
> > > > > -#define ETM_OPT_TS      28
> > > > > -#define ETM_OPT_RETSTK 29
> > > > > +#define ETM_OPT_CYCACC         12
> > > > > +#define ETM_OPT_CTXTID         14
> > > > > +#define ETM_OPT_CTXTID_IN_VMID 15
> > > >
> > > > Minor issue here - ETMv3.x / PTM cannot trace CXTID in VMID so this
> > > > may better be named ETM4_OPT_CTXTID_IN_VMID, rather than be grouped
> > > > with the ETM3.5 options?
> > >
> > > I looked into this suggestion but found it's complex than I assumed.
> > > This config bits are not only used for ETMv3.x / PTM, it's also used
> > > as an configuration interface between user space in Perf and kernel
> > > drivers.
> > >
> > > For example, in the userspace, perf tool sets bit ETM_OPT_TS to enable
> > > timestamp [1], this is same for ETMv3 and ETMv4.  In the kernel side,
> > > the configuration is directly used ETMv3 (in coresight-etm3x-core.c),
> > > but the configuration bits are converted for ETMv4 in the function
> > > etm4_parse_event_config() [2].
> > >
> > > So this is a historical issue, at the early period ETMv3 and ETMv4 can
> > > be compatible with each other for configurations, but after evoluation,
> > > some configs only belong to ETMv4 and cannot be applied on ETMv3
> > > anymore, but we still use ETMv3.5 config bits as the interface between
> > > kernel and userspace.
> > >
> >
> > I was aware that etm3/ptm used these bits as both the options and the
> > bit values for direct writing to the ETMCR register for ETMv3, and
> > re-mapped to appropriate register values in ETMv4.
> > In the past we have re-used etmv3.5 bit definitions ETM_xxx  when
> > appropriate, but where unique to ETM4 we  have used a ETM4_xxx naming
> > convention.
>
> I am concern this approach is not friendly for extension; for example,
> let's say IP ETM5 with defined bit 28 as CTXTID, if add a new option
> for it, we need to define macro as:
>
>         #define ETM5_OPT_CTXTID         28
>
> This will result in confliction with the existed option ETM_OPT_TS
> and it is hard for maintenance for options, since there have different
> prefixes (like ETM_OPT_xxx, ETM4_OPT_xxx, ETM5_OPT_xxx, etc).
>

No it will not - we don't need a new option for CTXTID in a
hypothetical ETM5 - as we use the existing one for ETM3 and map it to
the correct bit, just as ETM4 does.


> I'd like to take option as knob to enable or disable hardware
> feature; the low level drivers should set the appropriate values for
> registers based on different options.
>
> Furthermore, ETM driver should report error when detect any option is
> not supported, I.e. ETM3 driver should report failure if user wrongly
> set the option ETM_OPT_CTXTID_IN_VMID.
>
> > I am not suggesting re-factoring the options completely, just
> > re-naming this single option to make it clear it is unique to ETM4+.
>
> Here I perfer Suzuki's suggestion to simply refine comments, something
> like below:
>
> /*
>  * Below are bit offsets for perf options, most of them are orignally
>  * coming from ETMv3.5/PTM's ETMCR config bits (so far except
>  * ETM_OPT_CTXTID_IN_VMID is only used for ETMv4).
>  *
>  * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
>  * directly use below macros as config bits.
>  */
> #define ETM_OPT_CYCACC          12
> #define ETM_OPT_CTXTID          14
> #define ETM_OPT_CTXTID_IN_VMID  15
> #define ETM_OPT_TS              28
> #define ETM_OPT_RETSTK          29
>
> > Looking at the etmv3 driver, at present it does not actually appear to
> > support contextid tracing - and when it does, both bits 14 and 15 will
> > be required to be used - as ETMCR defines these bits as ContextID
> > size.
> > Should this ever get fixed.
>
> Good catch!  Seems to me, this is a good example that we should
> distinguish the definition between Perf options and config bits :)
>
> > then having an overlapping option bit -
> > that appears to be valid for ETMv3 will be confusing.
>
> I hope the the proposed change can avoid the confusion, if have
> concern, please let me know.
>
> Thanks a lot for suggestions,
> Leo

If you think that clarification via comment is better than a change of
name then go ahead.

Regards

Mike

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
