Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47862F2DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbhALLX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbhALLX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:23:56 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D11BC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 03:23:15 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t30so2131032wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 03:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzofRgscToXHiyum2Z+jxt17ev79BRTc3KWqhsJgxzc=;
        b=zSfknHy2GEsWrZaD49O8+1+49wKuNzIb25gMdQJDsm4LKZB9QL8qdERpEAP13+FnN2
         aZnp5+Rj8IRxOkhYu0m2zkyhJycYg+Rav3Gfd8b5zZL9dpxLMt+1p51Mc+Cd1p/vHvTf
         T5GiTIPDRzjZUChhX3PH/H5LKp/d5JTmjlq5m1l+tlmusHK8jz4dnqA+lpdI/rD1kS/H
         lDbRWcr8nYRGk7hxnSY9aVX0x44GnZCShW3TQePAn8LUUahr2SLLlJgeaQNyymX4JHe2
         +GejQ4A2eflSvqoi3hy8a4ft3MVw1BIIWsiHLUCSqHkZZ90GcT0vSmQhVbGYmoUSt9Qr
         LFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzofRgscToXHiyum2Z+jxt17ev79BRTc3KWqhsJgxzc=;
        b=nwi6mK/9GtQXl3zeOU23NgvAqcwrpv/eWoqPEX/Ax/GjtoVg+JAQ9+pxQYMA4bDDtq
         Quvr1zENw5MGm/F+DEcTO/FE2dO23+8l6FnCPbgpEW9+muWRW8qjlfCKpk1kqJlES/TY
         4mqT5/HRS6uLseynrGKOZycydkvLiK9KA8SbM1y4rxPvzgkTvmOwomz6ii0U2HfvUlQz
         TODHFKrNNCWzlGx2hDuslfs6DDkjBkSHIfWQuxOMye+wNJGbCUCAY3oByobFZNgthBQh
         fxDXGA1kF/2pp2jPZCw7JUi8FTVcu8q7amBXVx1EciA6YWguqa73bIj68XpZ07qb+iND
         1/mA==
X-Gm-Message-State: AOAM533IdBPRS3rECdNARzzH+FiGTlb/Cg5Rg/wPWsSHHy7NxdtteKTg
        UYOPStXpTbufvkx5IDjIYsW43BdxsIG/ekD2qwZZog==
X-Google-Smtp-Source: ABdhPJyrPHY57MMsYow40VMZ7CMKrRRfsy3qRSwS9eCyvpoKJjjD4xy63lH4x9O/aeXW3HnSYJHWrJ1ki/GFkXOdF5c=
X-Received: by 2002:a05:6000:114e:: with SMTP id d14mr3086415wrx.176.1610450594112;
 Tue, 12 Jan 2021 03:23:14 -0800 (PST)
MIME-Version: 1.0
References: <20210109074435.626855-1-leo.yan@linaro.org> <20210109074435.626855-2-leo.yan@linaro.org>
 <CAJ9a7VgTqsa4_W0bmfS1BPYnKyvToyVLD=fk85_t9-yehCY9Lw@mail.gmail.com> <20210112085826.GC18965@leoy-ThinkPad-X240s>
In-Reply-To: <20210112085826.GC18965@leoy-ThinkPad-X240s>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 12 Jan 2021 11:23:03 +0000
Message-ID: <CAJ9a7VgYt-JemRaJn_KtO-X729jo-0y0OO5hCm=tHay31Q6msw@mail.gmail.com>
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

On Tue, 12 Jan 2021 at 08:58, Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Mike,
>
> On Mon, Jan 11, 2021 at 04:22:39PM +0000, Mike Leach wrote:
>
> [...]
>
> > > diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> > > index b0e35eec6499..927c6285ce5d 100644
> > > --- a/include/linux/coresight-pmu.h
> > > +++ b/include/linux/coresight-pmu.h
> > > @@ -11,16 +11,19 @@
> > >  #define CORESIGHT_ETM_PMU_SEED  0x10
> > >
> > >  /* ETMv3.5/PTM's ETMCR config bit */
> > > -#define ETM_OPT_CYCACC  12
> > > -#define ETM_OPT_CTXTID 14
> > > -#define ETM_OPT_TS      28
> > > -#define ETM_OPT_RETSTK 29
> > > +#define ETM_OPT_CYCACC         12
> > > +#define ETM_OPT_CTXTID         14
> > > +#define ETM_OPT_CTXTID_IN_VMID 15
> >
> > Minor issue here - ETMv3.x / PTM cannot trace CXTID in VMID so this
> > may better be named ETM4_OPT_CTXTID_IN_VMID, rather than be grouped
> > with the ETM3.5 options?
>
> I looked into this suggestion but found it's complex than I assumed.
> This config bits are not only used for ETMv3.x / PTM, it's also used
> as an configuration interface between user space in Perf and kernel
> drivers.
>
> For example, in the userspace, perf tool sets bit ETM_OPT_TS to enable
> timestamp [1], this is same for ETMv3 and ETMv4.  In the kernel side,
> the configuration is directly used ETMv3 (in coresight-etm3x-core.c),
> but the configuration bits are converted for ETMv4 in the function
> etm4_parse_event_config() [2].
>
> So this is a historical issue, at the early period ETMv3 and ETMv4 can
> be compatible with each other for configurations, but after evoluation,
> some configs only belong to ETMv4 and cannot be applied on ETMv3
> anymore, but we still use ETMv3.5 config bits as the interface between
> kernel and userspace.
>

I was aware that etm3/ptm used these bits as both the options and the
bit values for direct writing to the ETMCR register for ETMv3, and
re-mapped to appropriate register values in ETMv4.
In the past we have re-used etmv3.5 bit definitions ETM_xxx  when
appropriate, but where unique to ETM4 we  have used a ETM4_xxx naming
convention.

I am not suggesting re-factoring the options completely, just
re-naming this single option to make it clear it is unique to ETM4+.

Looking at the etmv3 driver, at present it does not actually appear to
support contextid tracing - and when it does, both bits 14 and 15 will
be required to be used - as ETMCR defines these bits as ContextID
size.
Should this ever get fixed. then having an overlapping option bit -
that appears to be valid for ETMv3 will be confusing.

Regards

Mike

> I'd like suggest we use a saperate patch set to refactor the
> configuration bits, e.g. define the arbitrary configuration bits as
> interface between user space and kernel, these bits are neutral for any
> ETM version, in the kernel ETM drivers need to convert to its own
> configuration formats.  For this patch, I want to keep current
> change as it is, is this okay for you?
>
> Thanks,
> Leo
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/arm/util/cs-etm.c?h=v5.11-rc3#n152
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hwtracing/coresight/coresight-etm4x-core.c?h=v5.11-rc3#n422


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
