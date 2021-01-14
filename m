Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D931F2F6D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbhANVbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbhANVbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:31:40 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D473DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:30:59 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 190so5723360wmz.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LN1PUxjTCfjOn6bOx2XYDOAqRhgYIkwM50cwA1MLhVE=;
        b=hRpD7CjBHIlTXnUBgP73Dt4/Zf2TaWfwW/QphVRnD8S3qkeew/XaXNcR4EX3b4FCSx
         GpZGOTDhb3wXY92Zb48AwKG3PqjsrMTahBYDMeZ2jChXWcKrfc+M/LwdzvHcW/bJ5sN7
         ngo8fcvMfbHvOBer7Lc27N4ovIJko3mBSl1WbhacG1U2BvID6h0OM6PaUUe5tEBdsRJk
         GUMv01pnHx7vxtfAZGYvCVKZQS7Vp3vv30t4+e7OYeSU3VaaLpl1prr41gh46ub952t4
         TN5DtqOOigX/i2wCecBL1Mf2wsf9zoCgjj+UM5KPtoR9Zx4PM9AWbcJelH0TEw/mL5im
         LdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LN1PUxjTCfjOn6bOx2XYDOAqRhgYIkwM50cwA1MLhVE=;
        b=slD9E627Hyc5CLEbDTxEgNnNLUMZojrMpROisqFXGt83qE1vhuNE9+pmwh+taTehke
         I4xRoJxHbjMFI+y4RvGBGoU9JXc9QH10Xl29QReOXeG7OPEKTc7XXzdHJl/70+O/rnjF
         jg6JbUy94gYSsBEB1dMsOV7bV8yrCviBKDxuz299Zsuy9kICz92rN6vPhVDdi5jxwxaB
         GohjzH+2Fq4CgoywqDt6YQCFmrjCCJTBGuv30rOjSPVc3vyLG9XspnBnECtXyWxoGeR9
         caULHk85sRknmGbjMuRGPCdmzgv3GqGZIjR+5Wss2v75wPc2/3RatGe6VS689ilTbIV9
         HNXA==
X-Gm-Message-State: AOAM5312Mi6XZBwBp+euikQ1saEb3l9+AKuZWSSR+6eDHu9brcyLjFga
        8sbJXJqQqU/lxmyL7i/q1nDxO74Gb6yGcuV2ZyRJ4g==
X-Google-Smtp-Source: ABdhPJzfoXbN39uGXEo/NfQGBn95XTyLTHQQPEU6zB4WB2QQIvCqqfEfOCSae9CXzuZOQXMzMFCaSeif7Kw+oxw6vdg=
X-Received: by 2002:a7b:cbd5:: with SMTP id n21mr3654553wmi.5.1610659858374;
 Thu, 14 Jan 2021 13:30:58 -0800 (PST)
MIME-Version: 1.0
References: <20210113133504.13020-1-mike.leach@linaro.org> <20210114134637.GB191023@leoy-ThinkPad-X240s>
In-Reply-To: <20210114134637.GB191023@leoy-ThinkPad-X240s>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 14 Jan 2021 21:30:47 +0000
Message-ID: <CAJ9a7VjtEntfhmAqMsF+YpUkRVFpvOBiw+tEWgagQf-9-akPZQ@mail.gmail.com>
Subject: Re: [PATCH] perf: cs-etm: update ETM metadata format
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Thu, 14 Jan 2021 at 13:46, Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Mike,
>
> On Wed, Jan 13, 2021 at 01:35:04PM +0000, Mike Leach wrote:
> > The current fixed metadata version format (version 0), means that adding
> > metadata parameter items renders files from a previous version of perf
> > unreadable. Per CPU parameters appear in a fixed order, but there is no
> > field to indicate the number of ETM parameters per CPU.
> >
> > This patch updates the per CPU parameter blocks to include a NR_PARAMs
> > value which indicates the number of parameters in the block.
> >
> > The header version is incremented to 1. Fixed ordering is retained,
> > new ETM parameters are added to the end of the list.
> >
> > The reader code is updated to be able to read current version 0 files,
> > For version 1, the reader will read the number of parameters in the
> > per CPU block. This allows the reader to process older or newer files
> > that may have different numbers of parameters than in use at the
> > time perf was built.
>
> Seems to me, this patch is big and have several complex logics, so
> it's better to divide into smaller patches in one series.  But this is
> not necessary, please see below comments.
>

It is quite big, but all the changes are directly related to the
header file format change.

> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >  tools/perf/arch/arm/util/cs-etm.c |   3 +-
> >  tools/perf/util/cs-etm.c          | 171 ++++++++++++++++++++++++------
> >  tools/perf/util/cs-etm.h          |  22 +++-
> >  3 files changed, 159 insertions(+), 37 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> > index bd446aba64f7..1876cdf146a0 100644
> > --- a/tools/perf/arch/arm/util/cs-etm.c
> > +++ b/tools/perf/arch/arm/util/cs-etm.c
> > @@ -629,6 +629,7 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
> >       /* Build generic header portion */
> >       info->priv[*offset + CS_ETM_MAGIC] = magic;
> >       info->priv[*offset + CS_ETM_CPU] = cpu;
> > +     info->priv[*offset + CS_ETM_NR_PARAMS] = increment - CS_ETM_NR_PARAMS - 1;
>
> NR_PARAMS can be a self-contained value, so it can account the items
> from common header, thus it could be:
>
>   info->priv[*offset + CS_ETM_NR_PARAMS] = increment;
>

Changing this here, will simply alter the logic elsewhere. Having
NR_PARAMS as the number of specific ETM parameters makes the user
readble output from --dump better.

> >       /* Where the next CPU entry should start from */
> >       *offset += increment;
> >  }
> > @@ -674,7 +675,7 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
> >
> >       /* First fill out the session header */
> >       info->type = PERF_AUXTRACE_CS_ETM;
> > -     info->priv[CS_HEADER_VERSION_0] = 0;
> > +     info->priv[CS_HEADER_VERSION_0] = CS_HEADER_CURRENT_VERSION;
>
> Should rename "CS_HEADER_VERSION_0" to "CS_HEADER_VERSION"?  Also
> rename "CS_HEADER_VERSION_0_MAX" to "CS_HEADER_VERSION_MAX"?
>
Yes - could do this.

> >       info->priv[CS_PMU_TYPE_CPUS] = type << 32;
> >       info->priv[CS_PMU_TYPE_CPUS] |= nr_cpu;
> >       info->priv[CS_ETM_SNAPSHOT] = ptr->snapshot_mode;
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index a2a369e2fbb6..394331aa058a 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -2443,6 +2443,7 @@ static const char * const cs_etm_global_header_fmts[] = {
> >  static const char * const cs_etm_priv_fmts[] = {
> >       [CS_ETM_MAGIC]          = "     Magic number                   %llx\n",
> >       [CS_ETM_CPU]            = "     CPU                            %lld\n",
> > +     [CS_ETM_NR_PARAMS]      = "     NR_PARAMS                      %llx\n",
> >       [CS_ETM_ETMCR]          = "     ETMCR                          %llx\n",
> >       [CS_ETM_ETMTRACEIDR]    = "     ETMTRACEIDR                    %llx\n",
> >       [CS_ETM_ETMCCER]        = "     ETMCCER                        %llx\n",
> > @@ -2452,6 +2453,7 @@ static const char * const cs_etm_priv_fmts[] = {
> >  static const char * const cs_etmv4_priv_fmts[] = {
> >       [CS_ETM_MAGIC]          = "     Magic number                   %llx\n",
> >       [CS_ETM_CPU]            = "     CPU                            %lld\n",
> > +     [CS_ETM_NR_PARAMS]      = "     NR_PARAMS                      %llx\n",
> >       [CS_ETMV4_TRCCONFIGR]   = "     TRCCONFIGR                     %llx\n",
> >       [CS_ETMV4_TRCTRACEIDR]  = "     TRCTRACEIDR                    %llx\n",
> >       [CS_ETMV4_TRCIDR0]      = "     TRCIDR0                        %llx\n",
> > @@ -2461,24 +2463,127 @@ static const char * const cs_etmv4_priv_fmts[] = {
> >       [CS_ETMV4_TRCAUTHSTATUS] = "    TRCAUTHSTATUS                  %llx\n",
> >  };
> >
> > +static const char * const param_unk_fmt =
> > +     "       Unknown parameter [%d]         %llx\n";
> > +static const char * const magic_unk_fmt =
> > +     "       Magic number Unknown           %llx\n";
>
> If "magic_unk_fmt" is only used once, it's not necessary to define it
> as static variable and can directly print it in the place.
>

This is here to make the print loop easier to read. The actual print
statement is deeply indented, and all the other statements have format
as a pre-defined string.

> > +
> >  static void cs_etm__print_auxtrace_info(__u64 *val, int num)
> >  {
> > -     int i, j, cpu = 0;
> > +     int i, j, cpu = 0, version, nr_params;
> > +     __u64 magic;
> >
> > +     fprintf(stdout, "       Reader Header version          %llx\n",
> > +             (__u64)CS_HEADER_CURRENT_VERSION);
>
> This is redundant, the version will be printed by below loop.
>

No it is not. If the new version perf reads a version 0 file then the
following is output:

0x188 [0x148]: PERF_RECORD_AUXTRACE_INFO type: 3
        Reader Header version          1
        Header version                 0
        PMU type/num cpus              900000004

> >       for (i = 0; i < CS_HEADER_VERSION_0_MAX; i++)
>
> >               fprintf(stdout, cs_etm_global_header_fmts[i], val[i]);
> > +     version = val[0];
> >
> >       for (i = CS_HEADER_VERSION_0_MAX; cpu < num; cpu++) {
>
> Considering in the same loop, it needs to handle version 0 and 1
> saperately, so it's better to use two functions to encapsulate
> metadata dumping:
>
>         int version = val[0];
>
>         for (i = CS_HEADER_VERSION_0_MAX; cpu < num; cpu++) {
>                 if (version == 0)
>                         cs_etm__print_metadata_v0(cpu, val, i);
>                 else if (version == 1)
>                         cs_etm__print_metadata_v1(cpu, val, i);
>                 else /* Not supported */
>                         return;
>         }
>

OK - I'll see if this can be made feasible.

> > -             if (val[i] == __perf_cs_etmv3_magic)
> > -                     for (j = 0; j < CS_ETM_PRIV_MAX; j++, i++)
> > -                             fprintf(stdout, cs_etm_priv_fmts[j], val[i]);
> > -             else if (val[i] == __perf_cs_etmv4_magic)
> > -                     for (j = 0; j < CS_ETMV4_PRIV_MAX; j++, i++)
> > -                             fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
> > -             else
> > +             /* common header block */
> > +             magic = val[i];
> > +             fprintf(stdout, cs_etm_priv_fmts[0], val[i++]);
> > +             fprintf(stdout, cs_etm_priv_fmts[1], val[i++]);
> > +
> > +             /* nr param only present in version 1 */
> > +             if (version) {
> > +                     nr_params = val[i];
> > +                     fprintf(stdout, cs_etm_priv_fmts[2], val[i++]);
> > +             }
> > +
> > +             if (magic == __perf_cs_etmv3_magic) {
> > +                     /* version 0 - fixed number of params */
> > +                     if (!version)
> > +                             nr_params =  CS_ETM_NR_PARAMS_V0;
>
> Redundant space after "=".
>
OK

> > +
> > +                     /* after common block */
> > +                     for (j = 3; j < nr_params + 3; j++, i++) {
>
> This is not correct, for the perf data with version 0, you should
> start to print from item 2 for CS_ETM_ETMCR; Only for version 1, it
> should start from 3 for CS_ETM_ETMCR.

The 'j' indexes into the print formats which are v1 ordered, not the
incoming data.
So we have to skip the index to NR_PARAMS when printing v0 files. But
worth a comment here I think.

>
> > +                             /* if newer record - could be excess params */
> > +                             if (j >= CS_ETM_PRIV_MAX)
>
> I think we need support backward compatibility, but cannot support
> forward compatibility.  So need to report error for this?
>

This depends on the content of the trace data. The discussions we had
within ARM were triggered when a perf.data file from a customer who
had added their own parameter to the list failed the perf report
--dump when we tried to analyse it.
The idea of forward compatibily is that you can at least see there are
additional parameters, which makes support tasks a little easier.

If a newer version of perf is used in this sort of case to obtain data
and pass it on, analysis is still possible if the new parameter is not
directly relevant for the decode for a particular test. But if
analysis does fail - then perf report --dump will show the "Unknown"
parameters in the file, rather than silently crash out as the case is
now.


> > +                                     fprintf(stdout, param_unk_fmt, j, val[i]);
> > +                             else
> > +                                     fprintf(stdout, cs_etm_priv_fmts[j], val[i]);
> > +                     }
> > +             } else if (magic == __perf_cs_etmv4_magic) {
> > +                     /* version 0 - fixed number of params */
> > +                     if (!version)
> > +                             nr_params = CS_ETMV4_NR_PARAMS_V0;
> > +
> > +                     /* after common block */
> > +                     for (j = 3; j < nr_params + 3; j++, i++) {
> > +                             /* if newer record - could be excess params */
> > +                             if (j >= CS_ETMV4_PRIV_MAX)
> > +                                     fprintf(stdout, param_unk_fmt, j, val[i]);
> > +                             else
> > +                                     fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
> > +                     }
> > +             } else {
> >                       /* failure.. return */
> > +                     fprintf(stdout, magic_unk_fmt, magic);
> >                       return;
> > +             }
> > +     }
> > +}
> > +
> > +/*
> > + * Read a single cpu parameter block from the auxtrace_info priv block.
> > + *
> > + * For version 1 there is a per cpu nr_params entry. If we are handling
> > + * version 1 file, then there may be less, the same, or more params
> > + * indicated by this value than the compile time number we understand.
> > + *
> > + * For a version 0 info block, there are a fixed number, and we need to
> > + * fill out the nr_param value in the metadata we create.
> > + */
> > +static u64 *cs_etm__create_meta_blk(u64 *buff_in, int *buff_in_offset,
> > +                                 int out_blk_size, int nr_params_v0)
> > +{
> > +     u64 *metadata = NULL;
> > +     int hdr_version;
> > +     int nr_in_params, nr_out_params, nr_cmn_params;
> > +     int i, k;
> > +
> > +     metadata = zalloc(sizeof(*metadata) * out_blk_size);
> > +     if (!metadata)
> > +             return NULL;
> > +
> > +     /* read block current index & version */
> > +     i = *buff_in_offset;
> > +     hdr_version = buff_in[CS_HEADER_VERSION_0];
> > +
> > +     if (!hdr_version) {
> > +     /* read version 0 info block into a version 1 metadata block  */
> > +             nr_in_params = nr_params_v0;
> > +             metadata[CS_ETM_MAGIC] = buff_in[i + CS_ETM_MAGIC];
> > +             metadata[CS_ETM_CPU] = buff_in[i + CS_ETM_CPU];
> > +             metadata[CS_ETM_NR_PARAMS] = nr_in_params;
> > +             /* remaining block params at offset +1 from source */
> > +             for (k = 2; k < nr_in_params; k++)
> > +                     metadata[k+1] = buff_in[i + k];
> > +             /* version 0 has 2 common params */
> > +             nr_cmn_params = 2;
> > +     } else {
> > +     /* read version 1 info block - input and output nr_params may differ */
> > +             /* version 1 has 3 common params */
> > +             nr_cmn_params = 3;
> > +             nr_in_params = buff_in[i + CS_ETM_NR_PARAMS];
> > +
> > +             /* if input has more params than output - skip excess */
> > +             nr_out_params = nr_in_params + nr_cmn_params;
> > +             if (nr_out_params > out_blk_size)
> > +                     nr_out_params = out_blk_size;
> > +
> > +             for (k = 0; k < nr_out_params; k++)
> > +                     metadata[k] = buff_in[i + k];
> > +
> > +             /* record the actual nr params we copied */
> > +             metadata[CS_ETM_NR_PARAMS] = nr_out_params - nr_cmn_params;
>
> If we set CS_ETM_NR_PARAMS as self-contained value (it presents all
> item numbers from CS_ETM_MAGIC to CS_ETMV4_TRCAUTHSTATUS), and we
> can just support backward compatibility and don't support forward
> compabitility, I think the logic can be simplized.
>

See my comments above for the reason we want to support limited
forward compatibility.

Thanks for the review.

Regards

Mike


> Thanks,
> Leo
>
> >       }
> > +
> > +     /* adjust in offset by number of in params used */
> > +     i += nr_in_params + nr_cmn_params;
> > +     *buff_in_offset = i;
> > +     return metadata;
> >  }
> >
> >  int cs_etm__process_auxtrace_info(union perf_event *event,
> > @@ -2492,11 +2597,12 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >       int info_header_size;
> >       int total_size = auxtrace_info->header.size;
> >       int priv_size = 0;
> > -     int num_cpu;
> > -     int err = 0, idx = -1;
> > -     int i, j, k;
> > +     int num_cpu, trcidr_idx;
> > +     int err = 0;
> > +     int i, j;
> >       u64 *ptr, *hdr = NULL;
> >       u64 **metadata = NULL;
> > +     u64 hdr_version;
> >
> >       /*
> >        * sizeof(auxtrace_info_event::type) +
> > @@ -2512,8 +2618,9 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >       /* First the global part */
> >       ptr = (u64 *) auxtrace_info->priv;
> >
> > -     /* Look for version '0' of the header */
> > -     if (ptr[0] != 0)
> > +     /* Look for version of the header */
> > +     hdr_version = ptr[0];
> > +     if (hdr_version > CS_HEADER_CURRENT_VERSION)
> >               return -EINVAL;
> >
> >       hdr = zalloc(sizeof(*hdr) * CS_HEADER_VERSION_0_MAX);
> > @@ -2552,35 +2659,31 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >        */
> >       for (j = 0; j < num_cpu; j++) {
> >               if (ptr[i] == __perf_cs_etmv3_magic) {
> > -                     metadata[j] = zalloc(sizeof(*metadata[j]) *
> > -                                          CS_ETM_PRIV_MAX);
> > -                     if (!metadata[j]) {
> > -                             err = -ENOMEM;
> > -                             goto err_free_metadata;
> > -                     }
> > -                     for (k = 0; k < CS_ETM_PRIV_MAX; k++)
> > -                             metadata[j][k] = ptr[i + k];
> > +                     metadata[j] =
> > +                             cs_etm__create_meta_blk(ptr, &i,
> > +                                                     CS_ETM_PRIV_MAX,
> > +                                                     CS_ETM_NR_PARAMS_V0);
> >
> >                       /* The traceID is our handle */
> > -                     idx = metadata[j][CS_ETM_ETMTRACEIDR];
> > -                     i += CS_ETM_PRIV_MAX;
> > +                     trcidr_idx = CS_ETM_ETMTRACEIDR;
> > +
> >               } else if (ptr[i] == __perf_cs_etmv4_magic) {
> > -                     metadata[j] = zalloc(sizeof(*metadata[j]) *
> > -                                          CS_ETMV4_PRIV_MAX);
> > -                     if (!metadata[j]) {
> > -                             err = -ENOMEM;
> > -                             goto err_free_metadata;
> > -                     }
> > -                     for (k = 0; k < CS_ETMV4_PRIV_MAX; k++)
> > -                             metadata[j][k] = ptr[i + k];
> > +                     metadata[j] =
> > +                             cs_etm__create_meta_blk(ptr, &i,
> > +                                                     CS_ETMV4_PRIV_MAX,
> > +                                                     CS_ETMV4_NR_PARAMS_V0);
> >
> >                       /* The traceID is our handle */
> > -                     idx = metadata[j][CS_ETMV4_TRCTRACEIDR];
> > -                     i += CS_ETMV4_PRIV_MAX;
> > +                     trcidr_idx = CS_ETMV4_TRCTRACEIDR;
> > +             }
> > +
> > +             if (!metadata[j]) {
> > +                     err = -ENOMEM;
> > +                     goto err_free_metadata;
> >               }
> >
> >               /* Get an RB node for this CPU */
> > -             inode = intlist__findnew(traceid_list, idx);
> > +             inode = intlist__findnew(traceid_list, metadata[j][trcidr_idx]);
> >
> >               /* Something went wrong, no need to continue */
> >               if (!inode) {
> > diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> > index 4ad925d6d799..fffc6b50beb9 100644
> > --- a/tools/perf/util/cs-etm.h
> > +++ b/tools/perf/util/cs-etm.h
> > @@ -24,16 +24,28 @@ enum {
> >       CS_HEADER_VERSION_0_MAX,
> >  };
> >
> > +/*
> > + * Update the version for new format.
> > + *
> > + * New version 1 format adds a param count to the per cpu metadata.
> > + * This allows easy adding of new metadata parameters.
> > + * Requires that new params always added after current ones.
> > + * Also allows client reader to handle file versions that are different by
> > + * checking the number of params in the file vs the number expected.
> > + */
> > +#define CS_HEADER_CURRENT_VERSION 1
> > +
> >  /* Beginning of header common to both ETMv3 and V4 */
> >  enum {
> >       CS_ETM_MAGIC,
> >       CS_ETM_CPU,
> > +     CS_ETM_NR_PARAMS,
> >  };
> >
> >  /* ETMv3/PTM metadata */
> >  enum {
> >       /* Dynamic, configurable parameters */
> > -     CS_ETM_ETMCR = CS_ETM_CPU + 1,
> > +     CS_ETM_ETMCR = CS_ETM_NR_PARAMS + 1,
> >       CS_ETM_ETMTRACEIDR,
> >       /* RO, taken from sysFS */
> >       CS_ETM_ETMCCER,
> > @@ -41,10 +53,13 @@ enum {
> >       CS_ETM_PRIV_MAX,
> >  };
> >
> > +/* define fixed version 0 length - allow new format reader to read old files. */
> > +#define CS_ETM_NR_PARAMS_V0 (CS_ETM_ETMIDR - CS_ETM_ETMCR + 1)
> > +
> >  /* ETMv4 metadata */
> >  enum {
> >       /* Dynamic, configurable parameters */
> > -     CS_ETMV4_TRCCONFIGR = CS_ETM_CPU + 1,
> > +     CS_ETMV4_TRCCONFIGR = CS_ETM_NR_PARAMS + 1,
> >       CS_ETMV4_TRCTRACEIDR,
> >       /* RO, taken from sysFS */
> >       CS_ETMV4_TRCIDR0,
> > @@ -55,6 +70,9 @@ enum {
> >       CS_ETMV4_PRIV_MAX,
> >  };
> >
> > +/* define fixed version 0 length - allow new format reader to read old files. */
> > +#define CS_ETMV4_NR_PARAMS_V0 (CS_ETMV4_TRCAUTHSTATUS - CS_ETMV4_TRCCONFIGR + 1)
> > +
> >  /*
> >   * ETMv3 exception encoding number:
> >   * See Embedded Trace Macrocell spcification (ARM IHI 0014Q)
> > --
> > 2.17.1
> >



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
