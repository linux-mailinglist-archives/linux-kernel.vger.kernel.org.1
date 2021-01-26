Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330D83042B1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406307AbhAZPfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404621AbhAZPeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:34:25 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DB1C0698C0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:33:28 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f16so2796372wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YXqjVdl/eObUKDC6RcIV2zoTiVDYuILTK8/r28Sr2/Y=;
        b=QF0PmDXDt2P6pVtL0UwYWoQM/0teZCDu37fRYpI944CVWk52qwLbc/eKWYpD7ZcDkw
         sKsq4ZwUCi4t9nmzy72qKHIgm4LnlF+fGwNOulERJfOW51bi3tVwZ2BVRzblhAPseGN+
         BNZD5zWC5G+fE842ZmMOXAZVbtK+xpFG+OmvI4Vpv5kFxbPOPZlwzaTvgqdaFR7N3jD4
         KToDkhhOkAKEVuxTbLE19+b22b0TXnW1L7FVqMWAX14e5aLIukPYRGFmaOHxaQBxeg+l
         ummmXn9/zJw1ZE9WCOzZDtoUIIA3FqeQU3vNNqQCFlU0XsyEHjVNXDxA8++Wh3I2yi0U
         g1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YXqjVdl/eObUKDC6RcIV2zoTiVDYuILTK8/r28Sr2/Y=;
        b=EzJ2ZB36O8fyZSzdBw1FXQvS0hYR/FkCZtwsjYBlcAFUmFWgofmcLw0kuXDNUkkXsi
         NM6GxKH1tAeqHyfOzvOFYJIsqFx+Mcj6NxS2fWh6XqPW/KjTdR6LGqTfHk8Ch2xuDWXA
         BYTJMTSJVAs8gh325jZbyutjSLjvJibIKUilzl9g0mKRdTjj9Zgc5KP8o/6eQSJCK2WV
         eE6zsb3QazLzrqV4CMlMgLXSsB4A4aRp8/x+CMqjRZnRW3rhGoK5sAVicBFrQQ5HDjeb
         YK9rrIuz0+uataWn0dD/i5iLEf1XjN7LFiSSRoIISgSQNBH670adxbC4dXpflswVUIq5
         Y3pg==
X-Gm-Message-State: AOAM532d6B9lOXtUCI2EA1LAXC4Ko34ms3wI5py5F81Nb9hSahM4/Ifu
        L41gKaVdZIdHv+djXX7YvsYbM3gyz02nVX+a7VOitg==
X-Google-Smtp-Source: ABdhPJz5WEk/NPfCBYrCKhBucJfrkt1ikWe8JgKdvIJ8wQrXRci8P5nKBxZNld3+UPotVcEtmkk0TqcUYaZQOW0PumU=
X-Received: by 2002:a7b:cbd5:: with SMTP id n21mr283469wmi.5.1611675206741;
 Tue, 26 Jan 2021 07:33:26 -0800 (PST)
MIME-Version: 1.0
References: <20210119180110.6222-1-mike.leach@linaro.org> <20210123152325.GA71576@leoy-ThinkPad-X240s>
In-Reply-To: <20210123152325.GA71576@leoy-ThinkPad-X240s>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 26 Jan 2021 15:33:16 +0000
Message-ID: <CAJ9a7VhP160_EZLmxVgZ08ghrr_b0d8arcEMGVN660mVKDw0vw@mail.gmail.com>
Subject: Re: [PATCH v3] perf: cs-etm: update ETM metadata format
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

On Sat, 23 Jan 2021 at 15:23, Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Mike,
>
> On Tue, Jan 19, 2021 at 06:01:10PM +0000, Mike Leach wrote:
>
> [...]
>
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
> > +             for (k = CS_ETM_ETMCR; k < nr_in_params; k++)
> > +                     metadata[k+1] = buff_in[i + k];
>
> Here it misses to copy data into metadata[CS_ETM_ETMCR], you could see
> it starts to copy from offset 3 (k = CS_ETM_ETMCR) from buff_in,
> actually it's the item for CS_ETM_ETMTRACEIDR in the metadata v0.
>
> So need to change the logic as below; please confirm if I
> misunderstand or not.
>
>                 for (k = CS_ETM_ETMCR - 1; k < nr_in_params; k++)
>                         metadata[k+1] = buff_in[i + k];
>

You are correct - this is the correct code for v0 metadata - I will
fix for v4 of the patch.

Thanks

Mike

> Except this issue for ETMv3, I didn't find any other logic issue for
> ETMv4; I tested and confirmed the tool shows the consistent result for
> metadata v0 before and after applying this patch; and it handles
> metadata v1 correctly.
>
> So after fixed the issue for ETMv3, the change looks good to me:
>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Tested-by: Leo Yan <leo.yan@linaro.org>
>
> Thanks!
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
> > +
> > +             for (k = CS_ETM_MAGIC; k < nr_out_params; k++)
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
> > +}
> > +
> >  int cs_etm__process_auxtrace_info(union perf_event *event,
> >                                 struct perf_session *session)
> >  {
> > @@ -2492,11 +2635,12 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
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
> > @@ -2512,16 +2656,21 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >       /* First the global part */
> >       ptr = (u64 *) auxtrace_info->priv;
> >
> > -     /* Look for version '0' of the header */
> > -     if (ptr[0] != 0)
> > +     /* Look for version of the header */
> > +     hdr_version = ptr[0];
> > +     if (hdr_version > CS_HEADER_CURRENT_VERSION) {
> > +             /* print routine will print an error on bad version */
> > +             if (dump_trace)
> > +                     cs_etm__print_auxtrace_info(auxtrace_info->priv, 0);
> >               return -EINVAL;
> > +     }
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
> > @@ -2552,35 +2701,31 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
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
> > @@ -2601,7 +2746,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >       }
> >
> >       /*
> > -      * Each of CS_HEADER_VERSION_0_MAX, CS_ETM_PRIV_MAX and
> > +      * Each of CS_HEADER_VERSION_MAX, CS_ETM_PRIV_MAX and
> >        * CS_ETMV4_PRIV_MAX mark how many double words are in the
> >        * global metadata, and each cpu's metadata respectively.
> >        * The following tests if the correct number of double words was
> > @@ -2703,6 +2848,12 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >       intlist__delete(traceid_list);
> >  err_free_hdr:
> >       zfree(&hdr);
> > -
> > +     /*
> > +      * At this point, as a minimum we have valid header. Dump the rest of
> > +      * the info section - the print routines will error out on structural
> > +      * issues.
> > +      */
> > +     if (dump_trace)
> > +             cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
> >       return err;
> >  }
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
