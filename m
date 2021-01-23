Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC71301659
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 16:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbhAWP0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 10:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbhAWPYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 10:24:14 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13227C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 07:23:34 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b8so4992656plx.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 07:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8lhTAwu1659Pg5CR5zuF6DTK+v2V2OGICDBdx5lHJrY=;
        b=rAnKuSOSrqaul8G4zb9WpvCT6PcrgnUuQ+o+GXAm7zT2fckrgD5queRDSj+PPGlDLu
         aDf/NCefVR3DvrrmzIujh6OVodKkqM/gb1lKx0ZOrEtjm1WoI8UhiYRsMJG+6zZPB4QG
         90MAXuACbG3cKL9JLV+rzTLpcK+bN9PzwwJuTmD11CjCJO2OiyNbgeeytwKG4SniY02L
         zMF0Jim2b40YdX0qBlGKEa/mMAtmagDh+rPo1jCYDkdb6OdHVr0OOZSbnlhQKqy9/yOr
         ZAtZQy1qadFrSc5LM5GsOuAG/62c/K/upfMObRac9YveHpjKzGVcWwTRMtn4wuYOAOk/
         t5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8lhTAwu1659Pg5CR5zuF6DTK+v2V2OGICDBdx5lHJrY=;
        b=F2V8GXlUqF7RL/sw9TAjh1wwMb5uqiMkjFAaXaVbizqEGF//HRborBibPD61yZ49pM
         sz9foWeOEuE0EzJtP3dHUULF+bjDNPWkhsacOjwGWDeutuNde06XSxeJcmft6eQ/g8Ub
         zOR6RKn/zpGuDLAm6nb0Oee1iJnYr6Umja7RTF09+Egt4wcelVNf25zoLDCigJ730XHp
         rX2YlkVw3xCnP62WbvG4ayeWA0SRAhho4wtVPJSzQzv8hRjldCxqD3Ff7YD9qTEhzjsq
         XWgvh6Vd9UD8cy6OloRzOISKH3IuVQEETno/7E111hvGHO4wZUNmNEy2JURLmu60fKD2
         dxbw==
X-Gm-Message-State: AOAM531qJBogXKEFKKnPBob9peLwZBKo5r6Tqbf4f9jwdrfXPvzSgla6
        CQVKqvcn+BKaqWsYQn7IT8DYug==
X-Google-Smtp-Source: ABdhPJylYm48YUIqYGNnCjmxdJnZanI/cWR1BF4OREpnVOXeX6ET7SCXePq87P6e7cHjagxTUZo8kg==
X-Received: by 2002:a17:902:b688:b029:dc:240a:2bd7 with SMTP id c8-20020a170902b688b02900dc240a2bd7mr71476pls.50.1611415413439;
        Sat, 23 Jan 2021 07:23:33 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id c17sm11425254pfi.88.2021.01.23.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 07:23:32 -0800 (PST)
Date:   Sat, 23 Jan 2021 23:23:25 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, will@kernel.org, john.garry@huawei.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Subject: Re: [PATCH v3] perf: cs-etm: update ETM metadata format
Message-ID: <20210123152325.GA71576@leoy-ThinkPad-X240s>
References: <20210119180110.6222-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119180110.6222-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Tue, Jan 19, 2021 at 06:01:10PM +0000, Mike Leach wrote:

[...]

> +/*
> + * Read a single cpu parameter block from the auxtrace_info priv block.
> + *
> + * For version 1 there is a per cpu nr_params entry. If we are handling
> + * version 1 file, then there may be less, the same, or more params
> + * indicated by this value than the compile time number we understand.
> + *
> + * For a version 0 info block, there are a fixed number, and we need to
> + * fill out the nr_param value in the metadata we create.
> + */
> +static u64 *cs_etm__create_meta_blk(u64 *buff_in, int *buff_in_offset,
> +				    int out_blk_size, int nr_params_v0)
> +{
> +	u64 *metadata = NULL;
> +	int hdr_version;
> +	int nr_in_params, nr_out_params, nr_cmn_params;
> +	int i, k;
> +
> +	metadata = zalloc(sizeof(*metadata) * out_blk_size);
> +	if (!metadata)
> +		return NULL;
> +
> +	/* read block current index & version */
> +	i = *buff_in_offset;
> +	hdr_version = buff_in[CS_HEADER_VERSION];
> +
> +	if (!hdr_version) {
> +	/* read version 0 info block into a version 1 metadata block  */
> +		nr_in_params = nr_params_v0;
> +		metadata[CS_ETM_MAGIC] = buff_in[i + CS_ETM_MAGIC];
> +		metadata[CS_ETM_CPU] = buff_in[i + CS_ETM_CPU];
> +		metadata[CS_ETM_NR_TRC_PARAMS] = nr_in_params;
> +		/* remaining block params at offset +1 from source */
> +		for (k = CS_ETM_ETMCR; k < nr_in_params; k++)
> +			metadata[k+1] = buff_in[i + k];

Here it misses to copy data into metadata[CS_ETM_ETMCR], you could see
it starts to copy from offset 3 (k = CS_ETM_ETMCR) from buff_in,
actually it's the item for CS_ETM_ETMTRACEIDR in the metadata v0.

So need to change the logic as below; please confirm if I
misunderstand or not.

                for (k = CS_ETM_ETMCR - 1; k < nr_in_params; k++)
                        metadata[k+1] = buff_in[i + k];

Except this issue for ETMv3, I didn't find any other logic issue for
ETMv4; I tested and confirmed the tool shows the consistent result for
metadata v0 before and after applying this patch; and it handles
metadata v1 correctly.

So after fixed the issue for ETMv3, the change looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>

Thanks!

> +		/* version 0 has 2 common params */
> +		nr_cmn_params = 2;
> +	} else {
> +	/* read version 1 info block - input and output nr_params may differ */
> +		/* version 1 has 3 common params */
> +		nr_cmn_params = 3;
> +		nr_in_params = buff_in[i + CS_ETM_NR_TRC_PARAMS];
> +
> +		/* if input has more params than output - skip excess */
> +		nr_out_params = nr_in_params + nr_cmn_params;
> +		if (nr_out_params > out_blk_size)
> +			nr_out_params = out_blk_size;
> +
> +		for (k = CS_ETM_MAGIC; k < nr_out_params; k++)
> +			metadata[k] = buff_in[i + k];
> +
> +		/* record the actual nr params we copied */
> +		metadata[CS_ETM_NR_TRC_PARAMS] = nr_out_params - nr_cmn_params;
> +	}
> +
> +	/* adjust in offset by number of in params used */
> +	i += nr_in_params + nr_cmn_params;
> +	*buff_in_offset = i;
> +	return metadata;
> +}
> +
>  int cs_etm__process_auxtrace_info(union perf_event *event,
>  				  struct perf_session *session)
>  {
> @@ -2492,11 +2635,12 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  	int info_header_size;
>  	int total_size = auxtrace_info->header.size;
>  	int priv_size = 0;
> -	int num_cpu;
> -	int err = 0, idx = -1;
> -	int i, j, k;
> +	int num_cpu, trcidr_idx;
> +	int err = 0;
> +	int i, j;
>  	u64 *ptr, *hdr = NULL;
>  	u64 **metadata = NULL;
> +	u64 hdr_version;
>  
>  	/*
>  	 * sizeof(auxtrace_info_event::type) +
> @@ -2512,16 +2656,21 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  	/* First the global part */
>  	ptr = (u64 *) auxtrace_info->priv;
>  
> -	/* Look for version '0' of the header */
> -	if (ptr[0] != 0)
> +	/* Look for version of the header */
> +	hdr_version = ptr[0];
> +	if (hdr_version > CS_HEADER_CURRENT_VERSION) {
> +		/* print routine will print an error on bad version */
> +		if (dump_trace)
> +			cs_etm__print_auxtrace_info(auxtrace_info->priv, 0);
>  		return -EINVAL;
> +	}
>  
> -	hdr = zalloc(sizeof(*hdr) * CS_HEADER_VERSION_0_MAX);
> +	hdr = zalloc(sizeof(*hdr) * CS_HEADER_VERSION_MAX);
>  	if (!hdr)
>  		return -ENOMEM;
>  
>  	/* Extract header information - see cs-etm.h for format */
> -	for (i = 0; i < CS_HEADER_VERSION_0_MAX; i++)
> +	for (i = 0; i < CS_HEADER_VERSION_MAX; i++)
>  		hdr[i] = ptr[i];
>  	num_cpu = hdr[CS_PMU_TYPE_CPUS] & 0xffffffff;
>  	pmu_type = (unsigned int) ((hdr[CS_PMU_TYPE_CPUS] >> 32) &
> @@ -2552,35 +2701,31 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  	 */
>  	for (j = 0; j < num_cpu; j++) {
>  		if (ptr[i] == __perf_cs_etmv3_magic) {
> -			metadata[j] = zalloc(sizeof(*metadata[j]) *
> -					     CS_ETM_PRIV_MAX);
> -			if (!metadata[j]) {
> -				err = -ENOMEM;
> -				goto err_free_metadata;
> -			}
> -			for (k = 0; k < CS_ETM_PRIV_MAX; k++)
> -				metadata[j][k] = ptr[i + k];
> +			metadata[j] =
> +				cs_etm__create_meta_blk(ptr, &i,
> +							CS_ETM_PRIV_MAX,
> +							CS_ETM_NR_TRC_PARAMS_V0);
>  
>  			/* The traceID is our handle */
> -			idx = metadata[j][CS_ETM_ETMTRACEIDR];
> -			i += CS_ETM_PRIV_MAX;
> +			trcidr_idx = CS_ETM_ETMTRACEIDR;
> +
>  		} else if (ptr[i] == __perf_cs_etmv4_magic) {
> -			metadata[j] = zalloc(sizeof(*metadata[j]) *
> -					     CS_ETMV4_PRIV_MAX);
> -			if (!metadata[j]) {
> -				err = -ENOMEM;
> -				goto err_free_metadata;
> -			}
> -			for (k = 0; k < CS_ETMV4_PRIV_MAX; k++)
> -				metadata[j][k] = ptr[i + k];
> +			metadata[j] =
> +				cs_etm__create_meta_blk(ptr, &i,
> +							CS_ETMV4_PRIV_MAX,
> +							CS_ETMV4_NR_TRC_PARAMS_V0);
>  
>  			/* The traceID is our handle */
> -			idx = metadata[j][CS_ETMV4_TRCTRACEIDR];
> -			i += CS_ETMV4_PRIV_MAX;
> +			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
> +		}
> +
> +		if (!metadata[j]) {
> +			err = -ENOMEM;
> +			goto err_free_metadata;
>  		}
>  
>  		/* Get an RB node for this CPU */
> -		inode = intlist__findnew(traceid_list, idx);
> +		inode = intlist__findnew(traceid_list, metadata[j][trcidr_idx]);
>  
>  		/* Something went wrong, no need to continue */
>  		if (!inode) {
> @@ -2601,7 +2746,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  	}
>  
>  	/*
> -	 * Each of CS_HEADER_VERSION_0_MAX, CS_ETM_PRIV_MAX and
> +	 * Each of CS_HEADER_VERSION_MAX, CS_ETM_PRIV_MAX and
>  	 * CS_ETMV4_PRIV_MAX mark how many double words are in the
>  	 * global metadata, and each cpu's metadata respectively.
>  	 * The following tests if the correct number of double words was
> @@ -2703,6 +2848,12 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  	intlist__delete(traceid_list);
>  err_free_hdr:
>  	zfree(&hdr);
> -
> +	/*
> +	 * At this point, as a minimum we have valid header. Dump the rest of
> +	 * the info section - the print routines will error out on structural
> +	 * issues.
> +	 */
> +	if (dump_trace)
> +		cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
>  	return err;
>  }
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index 4ad925d6d799..e153d02df0de 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -17,23 +17,37 @@ struct perf_session;
>   */
>  enum {
>  	/* Starting with 0x0 */
> -	CS_HEADER_VERSION_0,
> +	CS_HEADER_VERSION,
>  	/* PMU->type (32 bit), total # of CPUs (32 bit) */
>  	CS_PMU_TYPE_CPUS,
>  	CS_ETM_SNAPSHOT,
> -	CS_HEADER_VERSION_0_MAX,
> +	CS_HEADER_VERSION_MAX,
>  };
>  
> +/*
> + * Update the version for new format.
> + *
> + * New version 1 format adds a param count to the per cpu metadata.
> + * This allows easy adding of new metadata parameters.
> + * Requires that new params always added after current ones.
> + * Also allows client reader to handle file versions that are different by
> + * checking the number of params in the file vs the number expected.
> + */
> +#define CS_HEADER_CURRENT_VERSION 1
> +
>  /* Beginning of header common to both ETMv3 and V4 */
>  enum {
>  	CS_ETM_MAGIC,
>  	CS_ETM_CPU,
> +	/* Number of trace config params in following ETM specific block */
> +	CS_ETM_NR_TRC_PARAMS,
> +	CS_ETM_COMMON_BLK_MAX_V1,
>  };
>  
>  /* ETMv3/PTM metadata */
>  enum {
>  	/* Dynamic, configurable parameters */
> -	CS_ETM_ETMCR = CS_ETM_CPU + 1,
> +	CS_ETM_ETMCR = CS_ETM_COMMON_BLK_MAX_V1,
>  	CS_ETM_ETMTRACEIDR,
>  	/* RO, taken from sysFS */
>  	CS_ETM_ETMCCER,
> @@ -41,10 +55,13 @@ enum {
>  	CS_ETM_PRIV_MAX,
>  };
>  
> +/* define fixed version 0 length - allow new format reader to read old files. */
> +#define CS_ETM_NR_TRC_PARAMS_V0 (CS_ETM_ETMIDR - CS_ETM_ETMCR + 1)
> +
>  /* ETMv4 metadata */
>  enum {
>  	/* Dynamic, configurable parameters */
> -	CS_ETMV4_TRCCONFIGR = CS_ETM_CPU + 1,
> +	CS_ETMV4_TRCCONFIGR = CS_ETM_COMMON_BLK_MAX_V1,
>  	CS_ETMV4_TRCTRACEIDR,
>  	/* RO, taken from sysFS */
>  	CS_ETMV4_TRCIDR0,
> @@ -55,6 +72,9 @@ enum {
>  	CS_ETMV4_PRIV_MAX,
>  };
>  
> +/* define fixed version 0 length - allow new format reader to read old files. */
> +#define CS_ETMV4_NR_TRC_PARAMS_V0 (CS_ETMV4_TRCAUTHSTATUS - CS_ETMV4_TRCCONFIGR + 1)
> +
>  /*
>   * ETMv3 exception encoding number:
>   * See Embedded Trace Macrocell spcification (ARM IHI 0014Q)
> @@ -162,7 +182,7 @@ struct cs_etm_packet_queue {
>  
>  #define BMVAL(val, lsb, msb)	((val & GENMASK(msb, lsb)) >> lsb)
>  
> -#define CS_ETM_HEADER_SIZE (CS_HEADER_VERSION_0_MAX * sizeof(u64))
> +#define CS_ETM_HEADER_SIZE (CS_HEADER_VERSION_MAX * sizeof(u64))
>  
>  #define __perf_cs_etmv3_magic 0x3030303030303030ULL
>  #define __perf_cs_etmv4_magic 0x4040404040404040ULL
> -- 
> 2.17.1
> 
