Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97DB2FD9AB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388735AbhATSpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391885AbhATSce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:32:34 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B685C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:31:54 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id cq1so2685751pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A8xdUY3w7IC2kLKWBiirmDoNPDspxsi+QaqX935bTjA=;
        b=peiL4a0lOO7MVruwuDn8Uc0azK/JMeqgPdxWwnfvcO8mVNIupi3s5XXNBPWgE7JnYq
         kxrgR8hJwnK3A+a8Wr1pRdLo4q570TaiHJtoaiJKex9rBUqZHxXOcYrBlGd5gA5RqiG3
         iQPjyRuxI2TXpJNML7TNmEgs6KQQfHCJLiLWyRck8HK9+SwNxNT8uZv7TD4/GIIdZ0b2
         U9cgkvEp5O7SapLLWPk25y5rhZ/iOACMH8GdPwJvFD4yRgprbRgQhDdkLVWrEhxjs77z
         u+vrM8rakimiAMgw6LqFIlNdx/DcrIIwi35X/zauapAGM+QMBoRqLZO5jvI/oWIExskn
         t0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A8xdUY3w7IC2kLKWBiirmDoNPDspxsi+QaqX935bTjA=;
        b=MXe9Wql6EqjOIfIDHCFnq+WKaZnxPHvM8f8rn+HhBzFaMVdLRghML3tHEsOc5em+I1
         nUCJHulCanll3DulVSiG0tbCXTMOeKrnoFh3Smn/M98gRzomLHJ806dhA3vTU4xwEvNR
         nSwhykk7mfBxNnwKvyu2lREYxNPp5kUP9XQnpuJUHVCmWxWndwfiCfF82o2pl8XNs5+i
         vSmChCV2gIVNavI/I2vmQLIudgzZXxFTNrbLgOQKdO6W9ZjDyYg6LkTCoa/6GNP7jXE0
         +NIF8V5YCSiKI2sZIZn0jEm3xoivimh7110CSOYzaQUXR+UYZKW00KoyMBcpZW59NY7B
         TdVw==
X-Gm-Message-State: AOAM533kpwzabwCjaO5+wVpvyn7gVH+JzbtEU9Z68XauQE2cHzeyLW0m
        MipH0zIUBBNjeADIzMlVHpuTbQ==
X-Google-Smtp-Source: ABdhPJwPLnG6IZCRp11l8RV/L5PtwJlSSzHCDwoMrsr33j2JDd0ZU2jB09EylThwZ2g/2mnLo6549g==
X-Received: by 2002:a17:90a:17c8:: with SMTP id q66mr6933170pja.167.1611167513298;
        Wed, 20 Jan 2021 10:31:53 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id w21sm2286872pff.220.2021.01.20.10.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:31:52 -0800 (PST)
Date:   Wed, 20 Jan 2021 11:31:50 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
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
Subject: Re: [PATCH v2] perf: cs-etm: update ETM metadata format
Message-ID: <20210120183150.GA708905@xps15>
References: <20210115172702.11460-1-mike.leach@linaro.org>
 <20210118190613.GB464579@xps15>
 <CAJ9a7Vg+fL71pptOKuJX0Y9ammvaDPf0mJ6rVvuHbZcaCxV_Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7Vg+fL71pptOKuJX0Y9ammvaDPf0mJ6rVvuHbZcaCxV_Kg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > +static u64 *cs_etm__create_meta_blk(u64 *buff_in, int *buff_in_offset,
> > > +                                 int out_blk_size, int nr_params_v0)
> > > +{
> > > +     u64 *metadata = NULL;
> > > +     int hdr_version;
> > > +     int nr_in_params, nr_out_params, nr_cmn_params;
> > > +     int i, k;
> > > +
> > > +     metadata = zalloc(sizeof(*metadata) * out_blk_size);
> > > +     if (!metadata)
> > > +             return NULL;
> > > +
> > > +     /* read block current index & version */
> > > +     i = *buff_in_offset;
> > > +     hdr_version = buff_in[CS_HEADER_VERSION];
> > > +
> > > +     if (!hdr_version) {
> > > +     /* read version 0 info block into a version 1 metadata block  */
> > > +             nr_in_params = nr_params_v0;
> > > +             metadata[CS_ETM_MAGIC] = buff_in[i + CS_ETM_MAGIC];
> > > +             metadata[CS_ETM_CPU] = buff_in[i + CS_ETM_CPU];
> > > +             metadata[CS_ETM_NR_TRC_PARAMS] = nr_in_params;
> > > +             /* remaining block params at offset +1 from source */
> > > +             for (k = 2; k < nr_in_params; k++)
> >
> >                 for (k = CS_ETM_ETMCR; ...)
> >
> > > +                     metadata[k+1] = buff_in[i + k];
> >
> >                         metadata[k + 1] = buff_in[i + k];
> >
> > > +             /* version 0 has 2 common params */
> > > +             nr_cmn_params = 2;
> > > +     } else {
> > > +     /* read version 1 info block - input and output nr_params may differ */
> > > +             /* version 1 has 3 common params */
> > > +             nr_cmn_params = 3;
> > > +             nr_in_params = buff_in[i + CS_ETM_NR_TRC_PARAMS];
> > > +
> > > +             /* if input has more params than output - skip excess */
> > > +             nr_out_params = nr_in_params + nr_cmn_params;
> > > +             if (nr_out_params > out_blk_size)
> > > +                     nr_out_params = out_blk_size;
> >
> > I don't think we should try to fix what is broken.  I would return an error to
> > give us a chance to look at outlying conditions.
> >
> 
> I added the flexibility here for a couple of reasons.
> 
> 1) Returning an error will currently skip the printing of the header
> if in --dump mode. This actually prevents users from figuring out why
> the decode / dump has failed.
> This can in part be fixed by calling the print routines even on the
> error exit path - which I will do in the next revision. The print
> routines will spot version / magic errors and report them, which the
> previous version didn't

Ok

> 
> 2) Here - excess parameters does not preclude successful decode. For
> example, suppose v1.1 of a protocol adds a metadata parameter needed
> to decode that version. Moving forwards, usng the newer perf to
> capture data on v1.0 hardware will still have the new parameter - it
> will simply be unused. So the earlier perf can still successfully
> decode - if we permit it to. Our view is that we should do as much as
> we can  -  especially when using --dump to show the user what is in
> the file, rather than bail out early.
> If it is not possible to decode - then the decoder will error out -
> but at least the information will be available in the --dump headers
> to allow an investigation into the problem.
>

Ok
 
> Currently if we have a parameter mis-match of any kind, then the tool
> will bail out without any information on why, even when using --dump.
> The user is then faced with doing a byte by byte analysis of the
> header to figure out the fault.
> 
> What we are finding is that exchanging perf.data files between teams /
> customers & support, to look into CS trace issues, was leading to
> difficulties if things were slightly mis-matched. Moreover, by
> printing nothing on error, this made the tool unhelpful when trying to
> determine what was going wrong in these cases.  This is both
> unnecessary and easy to fix - at least for the ETM auxtrace sections.
> 
> The goals of this set were to get some robustness around the addition
> of new parameters, and improve the reporting of issues relating to
> metadata - especially when using --dump.
>

Ok

> 
> > > +
> > > +             for (k = 0; k < nr_out_params; k++)
> >
> >                 for (k = CS_ETMV4_TRCCONFIGR; ...)
> >
> 
> Not in this case - for the v1 patch we have NR_PARAMS as part of the
> input as well as the output, so can simply copy over the entire block
> - though CS_ETM_MAGIC could be used to make this obvious.

I added your V3 to my patch log - I will reconsider this when review the patch.

> 
> Thanks for the review
> 
> Regards
> 
> Mike
> 
> 
> 
> > Other than the above I think this patch works.
> >
> > Thanks,
> > Mathieu
> >
> > > +                     metadata[k] = buff_in[i + k];
> > > +
> > > +             /* record the actual nr params we copied */
> > > +             metadata[CS_ETM_NR_TRC_PARAMS] = nr_out_params - nr_cmn_params;
> > > +     }
> > > +
> > > +     /* adjust in offset by number of in params used */
> > > +     i += nr_in_params + nr_cmn_params;
> > > +     *buff_in_offset = i;
> > > +     return metadata;
> > >  }
> > >
> > >  int cs_etm__process_auxtrace_info(union perf_event *event,
> > > @@ -2492,11 +2622,12 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> > >       int info_header_size;
> > >       int total_size = auxtrace_info->header.size;
> > >       int priv_size = 0;
> > > -     int num_cpu;
> > > -     int err = 0, idx = -1;
> > > -     int i, j, k;
> > > +     int num_cpu, trcidr_idx;
> > > +     int err = 0;
> > > +     int i, j;
> > >       u64 *ptr, *hdr = NULL;
> > >       u64 **metadata = NULL;
> > > +     u64 hdr_version;
> > >
> > >       /*
> > >        * sizeof(auxtrace_info_event::type) +
> > > @@ -2512,16 +2643,17 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> > >       /* First the global part */
> > >       ptr = (u64 *) auxtrace_info->priv;
> > >
> > > -     /* Look for version '0' of the header */
> > > -     if (ptr[0] != 0)
> > > +     /* Look for version of the header */
> > > +     hdr_version = ptr[0];
> > > +     if (hdr_version > CS_HEADER_CURRENT_VERSION)
> > >               return -EINVAL;
> > >
> > > -     hdr = zalloc(sizeof(*hdr) * CS_HEADER_VERSION_0_MAX);
> > > +     hdr = zalloc(sizeof(*hdr) * CS_HEADER_VERSION_MAX);
> > >       if (!hdr)
> > >               return -ENOMEM;
> > >
> > >       /* Extract header information - see cs-etm.h for format */
> > > -     for (i = 0; i < CS_HEADER_VERSION_0_MAX; i++)
> > > +     for (i = 0; i < CS_HEADER_VERSION_MAX; i++)
> > >               hdr[i] = ptr[i];
> > >       num_cpu = hdr[CS_PMU_TYPE_CPUS] & 0xffffffff;
> > >       pmu_type = (unsigned int) ((hdr[CS_PMU_TYPE_CPUS] >> 32) &
> > > @@ -2552,35 +2684,31 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> > >        */
> > >       for (j = 0; j < num_cpu; j++) {
> > >               if (ptr[i] == __perf_cs_etmv3_magic) {
> > > -                     metadata[j] = zalloc(sizeof(*metadata[j]) *
> > > -                                          CS_ETM_PRIV_MAX);
> > > -                     if (!metadata[j]) {
> > > -                             err = -ENOMEM;
> > > -                             goto err_free_metadata;
> > > -                     }
> > > -                     for (k = 0; k < CS_ETM_PRIV_MAX; k++)
> > > -                             metadata[j][k] = ptr[i + k];
> > > +                     metadata[j] =
> > > +                             cs_etm__create_meta_blk(ptr, &i,
> > > +                                                     CS_ETM_PRIV_MAX,
> > > +                                                     CS_ETM_NR_TRC_PARAMS_V0);
> > >
> > >                       /* The traceID is our handle */
> > > -                     idx = metadata[j][CS_ETM_ETMTRACEIDR];
> > > -                     i += CS_ETM_PRIV_MAX;
> > > +                     trcidr_idx = CS_ETM_ETMTRACEIDR;
> > > +
> > >               } else if (ptr[i] == __perf_cs_etmv4_magic) {
> > > -                     metadata[j] = zalloc(sizeof(*metadata[j]) *
> > > -                                          CS_ETMV4_PRIV_MAX);
> > > -                     if (!metadata[j]) {
> > > -                             err = -ENOMEM;
> > > -                             goto err_free_metadata;
> > > -                     }
> > > -                     for (k = 0; k < CS_ETMV4_PRIV_MAX; k++)
> > > -                             metadata[j][k] = ptr[i + k];
> > > +                     metadata[j] =
> > > +                             cs_etm__create_meta_blk(ptr, &i,
> > > +                                                     CS_ETMV4_PRIV_MAX,
> > > +                                                     CS_ETMV4_NR_TRC_PARAMS_V0);
> > >
> > >                       /* The traceID is our handle */
> > > -                     idx = metadata[j][CS_ETMV4_TRCTRACEIDR];
> > > -                     i += CS_ETMV4_PRIV_MAX;
> > > +                     trcidr_idx = CS_ETMV4_TRCTRACEIDR;
> > > +             }
> > > +
> > > +             if (!metadata[j]) {
> > > +                     err = -ENOMEM;
> > > +                     goto err_free_metadata;
> > >               }
> > >
> > >               /* Get an RB node for this CPU */
> > > -             inode = intlist__findnew(traceid_list, idx);
> > > +             inode = intlist__findnew(traceid_list, metadata[j][trcidr_idx]);
> > >
> > >               /* Something went wrong, no need to continue */
> > >               if (!inode) {
> > > @@ -2601,7 +2729,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> > >       }
> > >
> > >       /*
> > > -      * Each of CS_HEADER_VERSION_0_MAX, CS_ETM_PRIV_MAX and
> > > +      * Each of CS_HEADER_VERSION_MAX, CS_ETM_PRIV_MAX and
> > >        * CS_ETMV4_PRIV_MAX mark how many double words are in the
> > >        * global metadata, and each cpu's metadata respectively.
> > >        * The following tests if the correct number of double words was
> > > diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> > > index 4ad925d6d799..e153d02df0de 100644
> > > --- a/tools/perf/util/cs-etm.h
> > > +++ b/tools/perf/util/cs-etm.h
> > > @@ -17,23 +17,37 @@ struct perf_session;
> > >   */
> > >  enum {
> > >       /* Starting with 0x0 */
> > > -     CS_HEADER_VERSION_0,
> > > +     CS_HEADER_VERSION,
> > >       /* PMU->type (32 bit), total # of CPUs (32 bit) */
> > >       CS_PMU_TYPE_CPUS,
> > >       CS_ETM_SNAPSHOT,
> > > -     CS_HEADER_VERSION_0_MAX,
> > > +     CS_HEADER_VERSION_MAX,
> > >  };
> > >
> > > +/*
> > > + * Update the version for new format.
> > > + *
> > > + * New version 1 format adds a param count to the per cpu metadata.
> > > + * This allows easy adding of new metadata parameters.
> > > + * Requires that new params always added after current ones.
> > > + * Also allows client reader to handle file versions that are different by
> > > + * checking the number of params in the file vs the number expected.
> > > + */
> > > +#define CS_HEADER_CURRENT_VERSION 1
> > > +
> > >  /* Beginning of header common to both ETMv3 and V4 */
> > >  enum {
> > >       CS_ETM_MAGIC,
> > >       CS_ETM_CPU,
> > > +     /* Number of trace config params in following ETM specific block */
> > > +     CS_ETM_NR_TRC_PARAMS,
> > > +     CS_ETM_COMMON_BLK_MAX_V1,
> > >  };
> > >
> > >  /* ETMv3/PTM metadata */
> > >  enum {
> > >       /* Dynamic, configurable parameters */
> > > -     CS_ETM_ETMCR = CS_ETM_CPU + 1,
> > > +     CS_ETM_ETMCR = CS_ETM_COMMON_BLK_MAX_V1,
> > >       CS_ETM_ETMTRACEIDR,
> > >       /* RO, taken from sysFS */
> > >       CS_ETM_ETMCCER,
> > > @@ -41,10 +55,13 @@ enum {
> > >       CS_ETM_PRIV_MAX,
> > >  };
> > >
> > > +/* define fixed version 0 length - allow new format reader to read old files. */
> > > +#define CS_ETM_NR_TRC_PARAMS_V0 (CS_ETM_ETMIDR - CS_ETM_ETMCR + 1)
> > > +
> > >  /* ETMv4 metadata */
> > >  enum {
> > >       /* Dynamic, configurable parameters */
> > > -     CS_ETMV4_TRCCONFIGR = CS_ETM_CPU + 1,
> > > +     CS_ETMV4_TRCCONFIGR = CS_ETM_COMMON_BLK_MAX_V1,
> > >       CS_ETMV4_TRCTRACEIDR,
> > >       /* RO, taken from sysFS */
> > >       CS_ETMV4_TRCIDR0,
> > > @@ -55,6 +72,9 @@ enum {
> > >       CS_ETMV4_PRIV_MAX,
> > >  };
> > >
> > > +/* define fixed version 0 length - allow new format reader to read old files. */
> > > +#define CS_ETMV4_NR_TRC_PARAMS_V0 (CS_ETMV4_TRCAUTHSTATUS - CS_ETMV4_TRCCONFIGR + 1)
> > > +
> > >  /*
> > >   * ETMv3 exception encoding number:
> > >   * See Embedded Trace Macrocell spcification (ARM IHI 0014Q)
> > > @@ -162,7 +182,7 @@ struct cs_etm_packet_queue {
> > >
> > >  #define BMVAL(val, lsb, msb) ((val & GENMASK(msb, lsb)) >> lsb)
> > >
> > > -#define CS_ETM_HEADER_SIZE (CS_HEADER_VERSION_0_MAX * sizeof(u64))
> > > +#define CS_ETM_HEADER_SIZE (CS_HEADER_VERSION_MAX * sizeof(u64))
> > >
> > >  #define __perf_cs_etmv3_magic 0x3030303030303030ULL
> > >  #define __perf_cs_etmv4_magic 0x4040404040404040ULL
> > > --
> > > 2.17.1
> > >
> 
> 
> 
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
