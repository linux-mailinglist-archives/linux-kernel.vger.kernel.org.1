Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C20D2FB85B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392750AbhASMTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404466AbhASMNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:13:19 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9BDC061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 04:12:38 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m2so1086834wmm.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 04:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F6NhnznVE/llahlC2OH+eaXVzKEgsRs4fzzalpoIjf4=;
        b=dAFVfxaOYKQakPcT8u0jkIP9w7dilWKVPTFYdHse2agLZV8+CrGCJsLtgUCmpVN1cH
         0j0eH3BGqrkLLGYmoaWXvpHsNXoLh6kMK1fQV4g+b02crT4Qk/Oyr6aReivh//W9mygW
         FOgYUaAIR/v7vvV4OLhSYmxok53oD0TVTKJx6m4IG6RjIpXS7R0O1z0RQqhQWSXdwihK
         sFz3D5Jrm2DoXDYDKk5WXKW9ikq7Ov2hj1Zw1UXisJl3byMQ9tWSDa2ccdYpkiAMyIxQ
         4gY4VDGmbxkDDl7e1fTB/D51xHlUTqfDOjgz6CgtySykoQoXyKFkiKE3ppU9tHn86X80
         VyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F6NhnznVE/llahlC2OH+eaXVzKEgsRs4fzzalpoIjf4=;
        b=Nc6KyeToDw0a2aqOQetptXpaqPnNG/eABrWns0wClCvMc8QzhB0YLwiIC42633FERb
         diYiObUtODVdE0QusFBlzPNjjWGzmWl1s2UZ3QDftVLNteWy+BPyFrFIyNvGlXPZO8Ri
         NrkNNVtlQRIEeGG4FliR1j38bUm1CDr8vVfd1dmG1pwSQtapO8QM08VmZYOJKZg+uXrC
         IjYZ/anp7Dnh7agcn223e/bJLTjeMpcVN1lgfVMEVtVi31t5JBIZthiOh4+JLMVmH1vw
         XsMhCvPykuLk9sO1rXWpy5oehn9JTuZnXXyYGlLeQ9XrfyLrKPiC+zpZpLn0QmofjCMS
         SClQ==
X-Gm-Message-State: AOAM5319SiuSqE3X06KCHsI2VdJIGrBqT9F81UmlcwuvPP4Fenoos1wq
        BbbdxFN6NTMRNSTFMGGrkWe2YcvbGhoYlxLkH6LdGg==
X-Google-Smtp-Source: ABdhPJx511KXCL4/nMXb/hWd/YyZhbPpjnPWnCi/3EP5xQl5UR14ZLQF2SU5yKoe0W3UDgSxrPVZMCV5aO2DnGgByHE=
X-Received: by 2002:a1c:1f04:: with SMTP id f4mr3837810wmf.98.1611058356897;
 Tue, 19 Jan 2021 04:12:36 -0800 (PST)
MIME-Version: 1.0
References: <20210115172702.11460-1-mike.leach@linaro.org> <20210118190613.GB464579@xps15>
In-Reply-To: <20210118190613.GB464579@xps15>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 19 Jan 2021 12:12:25 +0000
Message-ID: <CAJ9a7Vg+fL71pptOKuJX0Y9ammvaDPf0mJ6rVvuHbZcaCxV_Kg@mail.gmail.com>
Subject: Re: [PATCH v2] perf: cs-etm: update ETM metadata format
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

Hi Mathieu,

On Mon, 18 Jan 2021 at 19:06, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> Hey Mike,
>
> On Fri, Jan 15, 2021 at 05:27:02PM +0000, Mike Leach wrote:
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
> >
> > Changes since v1 (from Review by Leo):
> > 1. Split printing routine into sub functions per version
> > 2. Renamed NR_PARAMs to NR_TRC_PARAMs to emphasise use as count of trace
> > related parameters, not total block parameter.
> > 3. Misc other fixes.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >  tools/perf/arch/arm/util/cs-etm.c |   7 +-
> >  tools/perf/util/cs-etm.c          | 212 ++++++++++++++++++++++++------
> >  tools/perf/util/cs-etm.h          |  30 ++++-
> >  3 files changed, 200 insertions(+), 49 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> > index bd446aba64f7..b0470f2a955a 100644
> > --- a/tools/perf/arch/arm/util/cs-etm.c
> > +++ b/tools/perf/arch/arm/util/cs-etm.c
> > @@ -572,7 +572,7 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
> >                               struct auxtrace_record *itr,
> >                               struct perf_record_auxtrace_info *info)
> >  {
> > -     u32 increment;
> > +     u32 increment, nr_trc_params;
> >       u64 magic;
> >       struct cs_etm_recording *ptr =
> >                       container_of(itr, struct cs_etm_recording, itr);
> > @@ -607,6 +607,7 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
> >
> >               /* How much space was used */
> >               increment = CS_ETMV4_PRIV_MAX;
> > +             nr_trc_params = CS_ETMV4_PRIV_MAX - CS_ETMV4_TRCCONFIGR;
> >       } else {
> >               magic = __perf_cs_etmv3_magic;
> >               /* Get configuration register */
> > @@ -624,11 +625,13 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
> >
> >               /* How much space was used */
> >               increment = CS_ETM_PRIV_MAX;
> > +             nr_trc_params = CS_ETM_PRIV_MAX - CS_ETM_ETMCR;
> >       }
> >
> >       /* Build generic header portion */
> >       info->priv[*offset + CS_ETM_MAGIC] = magic;
> >       info->priv[*offset + CS_ETM_CPU] = cpu;
> > +     info->priv[*offset + CS_ETM_NR_TRC_PARAMS] = nr_trc_params;
> >       /* Where the next CPU entry should start from */
> >       *offset += increment;
> >  }
> > @@ -674,7 +677,7 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
> >
> >       /* First fill out the session header */
> >       info->type = PERF_AUXTRACE_CS_ETM;
> > -     info->priv[CS_HEADER_VERSION_0] = 0;
> > +     info->priv[CS_HEADER_VERSION] = CS_HEADER_CURRENT_VERSION;
> >       info->priv[CS_PMU_TYPE_CPUS] = type << 32;
> >       info->priv[CS_PMU_TYPE_CPUS] |= nr_cpu;
> >       info->priv[CS_ETM_SNAPSHOT] = ptr->snapshot_mode;
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index a2a369e2fbb6..23115f9633dc 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -2435,7 +2435,7 @@ static bool cs_etm__is_timeless_decoding(struct cs_etm_auxtrace *etm)
> >  }
> >
> >  static const char * const cs_etm_global_header_fmts[] = {
> > -     [CS_HEADER_VERSION_0]   = "     Header version                 %llx\n",
> > +     [CS_HEADER_VERSION]     = "     Header version                 %llx\n",
> >       [CS_PMU_TYPE_CPUS]      = "     PMU type/num cpus              %llx\n",
> >       [CS_ETM_SNAPSHOT]       = "     Snapshot                       %llx\n",
> >  };
> > @@ -2443,6 +2443,7 @@ static const char * const cs_etm_global_header_fmts[] = {
> >  static const char * const cs_etm_priv_fmts[] = {
> >       [CS_ETM_MAGIC]          = "     Magic number                   %llx\n",
> >       [CS_ETM_CPU]            = "     CPU                            %lld\n",
> > +     [CS_ETM_NR_TRC_PARAMS]  = "     NR_TRC_PARAMS                  %llx\n",
> >       [CS_ETM_ETMCR]          = "     ETMCR                          %llx\n",
> >       [CS_ETM_ETMTRACEIDR]    = "     ETMTRACEIDR                    %llx\n",
> >       [CS_ETM_ETMCCER]        = "     ETMCCER                        %llx\n",
> > @@ -2452,6 +2453,7 @@ static const char * const cs_etm_priv_fmts[] = {
> >  static const char * const cs_etmv4_priv_fmts[] = {
> >       [CS_ETM_MAGIC]          = "     Magic number                   %llx\n",
> >       [CS_ETM_CPU]            = "     CPU                            %lld\n",
> > +     [CS_ETM_NR_TRC_PARAMS]  = "     NR_TRC_PARAMS                  %llx\n",
> >       [CS_ETMV4_TRCCONFIGR]   = "     TRCCONFIGR                     %llx\n",
> >       [CS_ETMV4_TRCTRACEIDR]  = "     TRCTRACEIDR                    %llx\n",
> >       [CS_ETMV4_TRCIDR0]      = "     TRCIDR0                        %llx\n",
> > @@ -2461,24 +2463,152 @@ static const char * const cs_etmv4_priv_fmts[] = {
> >       [CS_ETMV4_TRCAUTHSTATUS] = "    TRCAUTHSTATUS                  %llx\n",
> >  };
> >
> > -static void cs_etm__print_auxtrace_info(__u64 *val, int num)
> > +static const char * const param_unk_fmt =
> > +     "       Unknown parameter [%d]         %llx\n";
> > +static const char * const magic_unk_fmt =
> > +     "       Magic number Unknown           %llx\n";
> > +
> > +static void cs_etm__print_cpu_metadata_v0(__u64 *val, int *offset)
> > +{
> > +     int i = *offset, j, nr_params = 0;
> > +     __u64 magic;
> > +
> > +     /* common header block */
> > +     magic = val[i];
> > +     fprintf(stdout, cs_etm_priv_fmts[0], val[i++]);
> > +     fprintf(stdout, cs_etm_priv_fmts[1], val[i++]);
>
> Please use CS_ETM_MAGIC and CS_ETM_CPU as indexes into cs_etm_priv_fmts[].
>

OK,

> > +
> > +     if (magic == __perf_cs_etmv3_magic) {
>
>                 start = CS_ETM_ETMCR;
>
> > +             nr_params = CS_ETM_NR_TRC_PARAMS_V0;
> > +             /* after common block, offset format index past NR_PARAMS */
> > +             for (j = 3; j < nr_params + 3; j++, i++)
>
>                 for (j = start; j < nr_params + start; j++; i++)
>
> That way we don't have to guess what '3' means.  It is clear to us because we
> are familiar with the code but I imagine it would be confusing for someone who is
> trying to figure out what we did.
>

Agreed.
>
> > +                     fprintf(stdout, cs_etm_priv_fmts[j], val[i]);
> > +     } else if (magic == __perf_cs_etmv4_magic) {
> > +             nr_params = CS_ETMV4_NR_TRC_PARAMS_V0;
> > +             /* after common block, offset format index past NR_PARAMS */
> > +             for (j = 3; j < nr_params + 3; j++, i++)
> > +                     fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
> > +     } else {
> > +             /* failure - note bad magic value */
> > +             fprintf(stdout, magic_unk_fmt, magic);
> > +     }
> > +     *offset = i;
>
> I don't like introcuding coupling between functions but I haven't found an
> alternative that looks better.
>
> > +}
> > +
> > +static void cs_etm__print_cpu_metadata_v1(__u64 *val, int *offset)
> >  {
> > -     int i, j, cpu = 0;
> > +     int i = *offset, j, total_params = 0;
> > +     __u64 magic;
> >
> > -     for (i = 0; i < CS_HEADER_VERSION_0_MAX; i++)
> > -             fprintf(stdout, cs_etm_global_header_fmts[i], val[i]);
> > +     magic = val[i + CS_ETM_MAGIC];
> > +     /* total params to print is NR_PARAMS + common block size for v1 */
> > +     total_params = val[i + CS_ETM_NR_TRC_PARAMS] + CS_ETM_COMMON_BLK_MAX_V1;
> >
> > -     for (i = CS_HEADER_VERSION_0_MAX; cpu < num; cpu++) {
> > -             if (val[i] == __perf_cs_etmv3_magic)
> > -                     for (j = 0; j < CS_ETM_PRIV_MAX; j++, i++)
> > +     if (magic == __perf_cs_etmv3_magic) {
> > +             for (j = 0; j < total_params; j++, i++) {
> > +                     /* if newer record - could be excess params */
> > +                     if (j >= CS_ETM_PRIV_MAX)
> > +                             fprintf(stdout, param_unk_fmt, j, val[i]);
> > +                     else
> >                               fprintf(stdout, cs_etm_priv_fmts[j], val[i]);
> > -             else if (val[i] == __perf_cs_etmv4_magic)
> > -                     for (j = 0; j < CS_ETMV4_PRIV_MAX; j++, i++)
> > +             }
> > +     } else if (magic == __perf_cs_etmv4_magic) {
> > +             /* after common block */
>
> The main header has already been printed in cs_etm__print_auxtrace_info() and
> as such the only thing this function is concerned with are the CPU specific
> block.  But all the CPU specific block will be printed, which makes the above
> comment quite confusing.  I suggest removing it or make it clearer.
>

Comment removed - not relevant now the print split by v1 / v0 blocks.

> > +             for (j = 0; j < total_params; j++, i++) {
> > +                     /* if newer record - could be excess params */
> > +                     if (j >= CS_ETMV4_PRIV_MAX)
> > +                             fprintf(stdout, param_unk_fmt, j, val[i]);
> > +                     else
> >                               fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
> > -             else
> > -                     /* failure.. return */
> > -                     return;
> > +             }
> > +     } else {
> > +             /* failure - note bad magic value */
> > +             fprintf(stdout, magic_unk_fmt, magic);
> >       }
> > +     *offset = i;
>
> I spent some time trying to break cs_etm__print_cpu_metadata_v0() and
> cs_etm__print_cpu_metadata_v1 but couldn't find a successful case.  I think what
> you have will work.
>
> > +}
> > +
> > +static void cs_etm__print_auxtrace_info(__u64 *val, int num)
> > +{
> > +     int i, cpu = 0, version;
> > +
> > +     for (i = 0; i < CS_HEADER_VERSION_MAX; i++)
> > +             fprintf(stdout, cs_etm_global_header_fmts[i], val[i]);
> > +     version = val[0];
> > +     if (version > CS_HEADER_CURRENT_VERSION) {
> > +             /* failure.. return */
> > +             fprintf(stdout, "       Unknown Header Version = %x, ", version);
> > +             fprintf(stdout, "Version supported <= %x\n", CS_HEADER_CURRENT_VERSION);
> > +             return;
> > +     }
> > +
> > +     for (i = CS_HEADER_VERSION_MAX; cpu < num; cpu++) {
> > +             if (version == 0)
> > +                     cs_etm__print_cpu_metadata_v0(val, &i);
> > +             else if (version == 1)
> > +                     cs_etm__print_cpu_metadata_v1(val, &i);
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
> > +     hdr_version = buff_in[CS_HEADER_VERSION];
> > +
> > +     if (!hdr_version) {
> > +     /* read version 0 info block into a version 1 metadata block  */
> > +             nr_in_params = nr_params_v0;
> > +             metadata[CS_ETM_MAGIC] = buff_in[i + CS_ETM_MAGIC];
> > +             metadata[CS_ETM_CPU] = buff_in[i + CS_ETM_CPU];
> > +             metadata[CS_ETM_NR_TRC_PARAMS] = nr_in_params;
> > +             /* remaining block params at offset +1 from source */
> > +             for (k = 2; k < nr_in_params; k++)
>
>                 for (k = CS_ETM_ETMCR; ...)
>
> > +                     metadata[k+1] = buff_in[i + k];
>
>                         metadata[k + 1] = buff_in[i + k];
>
> > +             /* version 0 has 2 common params */
> > +             nr_cmn_params = 2;
> > +     } else {
> > +     /* read version 1 info block - input and output nr_params may differ */
> > +             /* version 1 has 3 common params */
> > +             nr_cmn_params = 3;
> > +             nr_in_params = buff_in[i + CS_ETM_NR_TRC_PARAMS];
> > +
> > +             /* if input has more params than output - skip excess */
> > +             nr_out_params = nr_in_params + nr_cmn_params;
> > +             if (nr_out_params > out_blk_size)
> > +                     nr_out_params = out_blk_size;
>
> I don't think we should try to fix what is broken.  I would return an error to
> give us a chance to look at outlying conditions.
>

I added the flexibility here for a couple of reasons.

1) Returning an error will currently skip the printing of the header
if in --dump mode. This actually prevents users from figuring out why
the decode / dump has failed.
This can in part be fixed by calling the print routines even on the
error exit path - which I will do in the next revision. The print
routines will spot version / magic errors and report them, which the
previous version didn't

2) Here - excess parameters does not preclude successful decode. For
example, suppose v1.1 of a protocol adds a metadata parameter needed
to decode that version. Moving forwards, usng the newer perf to
capture data on v1.0 hardware will still have the new parameter - it
will simply be unused. So the earlier perf can still successfully
decode - if we permit it to. Our view is that we should do as much as
we can  -  especially when using --dump to show the user what is in
the file, rather than bail out early.
If it is not possible to decode - then the decoder will error out -
but at least the information will be available in the --dump headers
to allow an investigation into the problem.

Currently if we have a parameter mis-match of any kind, then the tool
will bail out without any information on why, even when using --dump.
The user is then faced with doing a byte by byte analysis of the
header to figure out the fault.

What we are finding is that exchanging perf.data files between teams /
customers & support, to look into CS trace issues, was leading to
difficulties if things were slightly mis-matched. Moreover, by
printing nothing on error, this made the tool unhelpful when trying to
determine what was going wrong in these cases.  This is both
unnecessary and easy to fix - at least for the ETM auxtrace sections.

The goals of this set were to get some robustness around the addition
of new parameters, and improve the reporting of issues relating to
metadata - especially when using --dump.


> > +
> > +             for (k = 0; k < nr_out_params; k++)
>
>                 for (k = CS_ETMV4_TRCCONFIGR; ...)
>

Not in this case - for the v1 patch we have NR_PARAMS as part of the
input as well as the output, so can simply copy over the entire block
- though CS_ETM_MAGIC could be used to make this obvious.

Thanks for the review

Regards

Mike



> Other than the above I think this patch works.
>
> Thanks,
> Mathieu
>
> > +                     metadata[k] = buff_in[i + k];
> > +
> > +             /* record the actual nr params we copied */
> > +             metadata[CS_ETM_NR_TRC_PARAMS] = nr_out_params - nr_cmn_params;
> > +     }
> > +
> > +     /* adjust in offset by number of in params used */
> > +     i += nr_in_params + nr_cmn_params;
> > +     *buff_in_offset = i;
> > +     return metadata;
> >  }
> >
> >  int cs_etm__process_auxtrace_info(union perf_event *event,
> > @@ -2492,11 +2622,12 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
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
> > @@ -2512,16 +2643,17 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
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
> > -     hdr = zalloc(sizeof(*hdr) * CS_HEADER_VERSION_0_MAX);
> > +     hdr = zalloc(sizeof(*hdr) * CS_HEADER_VERSION_MAX);
> >       if (!hdr)
> >               return -ENOMEM;
> >
> >       /* Extract header information - see cs-etm.h for format */
> > -     for (i = 0; i < CS_HEADER_VERSION_0_MAX; i++)
> > +     for (i = 0; i < CS_HEADER_VERSION_MAX; i++)
> >               hdr[i] = ptr[i];
> >       num_cpu = hdr[CS_PMU_TYPE_CPUS] & 0xffffffff;
> >       pmu_type = (unsigned int) ((hdr[CS_PMU_TYPE_CPUS] >> 32) &
> > @@ -2552,35 +2684,31 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
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
> > +                                                     CS_ETM_NR_TRC_PARAMS_V0);
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
> > +                                                     CS_ETMV4_NR_TRC_PARAMS_V0);
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
> > @@ -2601,7 +2729,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >       }
> >
> >       /*
> > -      * Each of CS_HEADER_VERSION_0_MAX, CS_ETM_PRIV_MAX and
> > +      * Each of CS_HEADER_VERSION_MAX, CS_ETM_PRIV_MAX and
> >        * CS_ETMV4_PRIV_MAX mark how many double words are in the
> >        * global metadata, and each cpu's metadata respectively.
> >        * The following tests if the correct number of double words was
> > diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> > index 4ad925d6d799..e153d02df0de 100644
> > --- a/tools/perf/util/cs-etm.h
> > +++ b/tools/perf/util/cs-etm.h
> > @@ -17,23 +17,37 @@ struct perf_session;
> >   */
> >  enum {
> >       /* Starting with 0x0 */
> > -     CS_HEADER_VERSION_0,
> > +     CS_HEADER_VERSION,
> >       /* PMU->type (32 bit), total # of CPUs (32 bit) */
> >       CS_PMU_TYPE_CPUS,
> >       CS_ETM_SNAPSHOT,
> > -     CS_HEADER_VERSION_0_MAX,
> > +     CS_HEADER_VERSION_MAX,
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
> > +     /* Number of trace config params in following ETM specific block */
> > +     CS_ETM_NR_TRC_PARAMS,
> > +     CS_ETM_COMMON_BLK_MAX_V1,
> >  };
> >
> >  /* ETMv3/PTM metadata */
> >  enum {
> >       /* Dynamic, configurable parameters */
> > -     CS_ETM_ETMCR = CS_ETM_CPU + 1,
> > +     CS_ETM_ETMCR = CS_ETM_COMMON_BLK_MAX_V1,
> >       CS_ETM_ETMTRACEIDR,
> >       /* RO, taken from sysFS */
> >       CS_ETM_ETMCCER,
> > @@ -41,10 +55,13 @@ enum {
> >       CS_ETM_PRIV_MAX,
> >  };
> >
> > +/* define fixed version 0 length - allow new format reader to read old files. */
> > +#define CS_ETM_NR_TRC_PARAMS_V0 (CS_ETM_ETMIDR - CS_ETM_ETMCR + 1)
> > +
> >  /* ETMv4 metadata */
> >  enum {
> >       /* Dynamic, configurable parameters */
> > -     CS_ETMV4_TRCCONFIGR = CS_ETM_CPU + 1,
> > +     CS_ETMV4_TRCCONFIGR = CS_ETM_COMMON_BLK_MAX_V1,
> >       CS_ETMV4_TRCTRACEIDR,
> >       /* RO, taken from sysFS */
> >       CS_ETMV4_TRCIDR0,
> > @@ -55,6 +72,9 @@ enum {
> >       CS_ETMV4_PRIV_MAX,
> >  };
> >
> > +/* define fixed version 0 length - allow new format reader to read old files. */
> > +#define CS_ETMV4_NR_TRC_PARAMS_V0 (CS_ETMV4_TRCAUTHSTATUS - CS_ETMV4_TRCCONFIGR + 1)
> > +
> >  /*
> >   * ETMv3 exception encoding number:
> >   * See Embedded Trace Macrocell spcification (ARM IHI 0014Q)
> > @@ -162,7 +182,7 @@ struct cs_etm_packet_queue {
> >
> >  #define BMVAL(val, lsb, msb) ((val & GENMASK(msb, lsb)) >> lsb)
> >
> > -#define CS_ETM_HEADER_SIZE (CS_HEADER_VERSION_0_MAX * sizeof(u64))
> > +#define CS_ETM_HEADER_SIZE (CS_HEADER_VERSION_MAX * sizeof(u64))
> >
> >  #define __perf_cs_etmv3_magic 0x3030303030303030ULL
> >  #define __perf_cs_etmv4_magic 0x4040404040404040ULL
> > --
> > 2.17.1
> >



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
