Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2CB2F624F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbhANNr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbhANNr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:47:26 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EAAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 05:46:46 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id j13so3214785pjz.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 05:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GV3YaA0OLpZOeTQnr+akVPwtfZdMLjC5E7RmM17a86c=;
        b=N214kPYoj6ksF3CcWsn1pjHL7WOYj+9LhQqLP5egEPwTyTqKNyPLDpBdJawmgVuYmh
         AD8nCuZJQL6dGyCWhmVADFWDrYc0VO2VDktyrLW5kSDmrbjYyqAuaWoDiq4FHiXhWkzs
         dxnwo3RJsJS7mWazVRhPel8NxVg3KMcbWZ2fR2l7JI7oP+fCem36C2hsEx98UGwe9ri/
         wFxLFSc9SMqkYsTc0zg6dmTicPd0trO6tStNj4rQscWgHSlZpZcAfrUhQITXEIM11COR
         DD/m1eD7oip/gTB2zpg9Bbrf2yktFvcxp4XHTV2sonSZY/12omJZ4kpnx7/G+lEm8ax/
         AxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GV3YaA0OLpZOeTQnr+akVPwtfZdMLjC5E7RmM17a86c=;
        b=N7K58ruAX43M5NLK+x9PA5XTLXUSdYyb0dm9v3nfq9ug+iHsuP/jCPtfSsNFDw4edJ
         obkZTEB/S96/K+yTNc2V8pQ+VteQD7Pi2iycy881Mn0p9HN3fGw4rX8B8kQANqTbnBMl
         1yc5i0uoAmoL/EIddE6AtQDQQ4JZtHLOO3yBDCnSe1N7g8xk8ihXGT4UW0gMxTynHVOD
         e4NN++kxqmOPnGABDTGOUsp1YJ5Vp0qJgl+Azkn4JBmSS1HxJwtvn+sL277URQiTwrcR
         g/s026rl8An6wOcceCy7V6vJJt+sNQO8KSLOiPqVcjFTMsYmAPNRoFcrbFLagEKHv3PU
         j+OA==
X-Gm-Message-State: AOAM530o7UpFrE8tuWfioA6+Rh/dEYrqCgxhJCKYhe4hT7zqNhe4nEsi
        KNUrG+fUzRA/GN1+GsQG/vNxPw==
X-Google-Smtp-Source: ABdhPJz4GjrMLod8HrrtvNaDGI3WQgbHFUvLPSysgIds8u4fr7XZcbffxe9bIcnrcmQ0dFvxj3vUJw==
X-Received: by 2002:a17:902:fe87:b029:da:5d3b:4a84 with SMTP id x7-20020a170902fe87b02900da5d3b4a84mr7628361plm.51.1610632005614;
        Thu, 14 Jan 2021 05:46:45 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id q35sm5683867pjh.38.2021.01.14.05.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 05:46:44 -0800 (PST)
Date:   Thu, 14 Jan 2021 21:46:37 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, will@kernel.org, john.garry@huawei.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Subject: Re: [PATCH] perf: cs-etm: update ETM metadata format
Message-ID: <20210114134637.GB191023@leoy-ThinkPad-X240s>
References: <20210113133504.13020-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113133504.13020-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Wed, Jan 13, 2021 at 01:35:04PM +0000, Mike Leach wrote:
> The current fixed metadata version format (version 0), means that adding
> metadata parameter items renders files from a previous version of perf
> unreadable. Per CPU parameters appear in a fixed order, but there is no
> field to indicate the number of ETM parameters per CPU.
> 
> This patch updates the per CPU parameter blocks to include a NR_PARAMs
> value which indicates the number of parameters in the block.
> 
> The header version is incremented to 1. Fixed ordering is retained,
> new ETM parameters are added to the end of the list.
> 
> The reader code is updated to be able to read current version 0 files,
> For version 1, the reader will read the number of parameters in the
> per CPU block. This allows the reader to process older or newer files
> that may have different numbers of parameters than in use at the
> time perf was built.

Seems to me, this patch is big and have several complex logics, so
it's better to divide into smaller patches in one series.  But this is
not necessary, please see below comments.

> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  tools/perf/arch/arm/util/cs-etm.c |   3 +-
>  tools/perf/util/cs-etm.c          | 171 ++++++++++++++++++++++++------
>  tools/perf/util/cs-etm.h          |  22 +++-
>  3 files changed, 159 insertions(+), 37 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index bd446aba64f7..1876cdf146a0 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -629,6 +629,7 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
>  	/* Build generic header portion */
>  	info->priv[*offset + CS_ETM_MAGIC] = magic;
>  	info->priv[*offset + CS_ETM_CPU] = cpu;
> +	info->priv[*offset + CS_ETM_NR_PARAMS] = increment - CS_ETM_NR_PARAMS - 1;

NR_PARAMS can be a self-contained value, so it can account the items
from common header, thus it could be:

  info->priv[*offset + CS_ETM_NR_PARAMS] = increment;

>  	/* Where the next CPU entry should start from */
>  	*offset += increment;
>  }
> @@ -674,7 +675,7 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
>  
>  	/* First fill out the session header */
>  	info->type = PERF_AUXTRACE_CS_ETM;
> -	info->priv[CS_HEADER_VERSION_0] = 0;
> +	info->priv[CS_HEADER_VERSION_0] = CS_HEADER_CURRENT_VERSION;

Should rename "CS_HEADER_VERSION_0" to "CS_HEADER_VERSION"?  Also
rename "CS_HEADER_VERSION_0_MAX" to "CS_HEADER_VERSION_MAX"?

>  	info->priv[CS_PMU_TYPE_CPUS] = type << 32;
>  	info->priv[CS_PMU_TYPE_CPUS] |= nr_cpu;
>  	info->priv[CS_ETM_SNAPSHOT] = ptr->snapshot_mode;
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index a2a369e2fbb6..394331aa058a 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2443,6 +2443,7 @@ static const char * const cs_etm_global_header_fmts[] = {
>  static const char * const cs_etm_priv_fmts[] = {
>  	[CS_ETM_MAGIC]		= "	Magic number		       %llx\n",
>  	[CS_ETM_CPU]		= "	CPU			       %lld\n",
> +	[CS_ETM_NR_PARAMS]	= "	NR_PARAMS		       %llx\n",
>  	[CS_ETM_ETMCR]		= "	ETMCR			       %llx\n",
>  	[CS_ETM_ETMTRACEIDR]	= "	ETMTRACEIDR		       %llx\n",
>  	[CS_ETM_ETMCCER]	= "	ETMCCER			       %llx\n",
> @@ -2452,6 +2453,7 @@ static const char * const cs_etm_priv_fmts[] = {
>  static const char * const cs_etmv4_priv_fmts[] = {
>  	[CS_ETM_MAGIC]		= "	Magic number		       %llx\n",
>  	[CS_ETM_CPU]		= "	CPU			       %lld\n",
> +	[CS_ETM_NR_PARAMS]	= "	NR_PARAMS		       %llx\n",
>  	[CS_ETMV4_TRCCONFIGR]	= "	TRCCONFIGR		       %llx\n",
>  	[CS_ETMV4_TRCTRACEIDR]	= "	TRCTRACEIDR		       %llx\n",
>  	[CS_ETMV4_TRCIDR0]	= "	TRCIDR0			       %llx\n",
> @@ -2461,24 +2463,127 @@ static const char * const cs_etmv4_priv_fmts[] = {
>  	[CS_ETMV4_TRCAUTHSTATUS] = "	TRCAUTHSTATUS		       %llx\n",
>  };
>  
> +static const char * const param_unk_fmt =
> +	"	Unknown parameter [%d]	       %llx\n";
> +static const char * const magic_unk_fmt =
> +	"	Magic number Unknown	       %llx\n";

If "magic_unk_fmt" is only used once, it's not necessary to define it
as static variable and can directly print it in the place.

> +
>  static void cs_etm__print_auxtrace_info(__u64 *val, int num)
>  {
> -	int i, j, cpu = 0;
> +	int i, j, cpu = 0, version, nr_params;
> +	__u64 magic;
>  
> +	fprintf(stdout, "	Reader Header version	       %llx\n",
> +		(__u64)CS_HEADER_CURRENT_VERSION);

This is redundant, the version will be printed by below loop.

>  	for (i = 0; i < CS_HEADER_VERSION_0_MAX; i++)

>  		fprintf(stdout, cs_etm_global_header_fmts[i], val[i]);
> +	version = val[0];
>  
>  	for (i = CS_HEADER_VERSION_0_MAX; cpu < num; cpu++) {

Considering in the same loop, it needs to handle version 0 and 1
saperately, so it's better to use two functions to encapsulate
metadata dumping:

        int version = val[0];

        for (i = CS_HEADER_VERSION_0_MAX; cpu < num; cpu++) {
                if (version == 0)
                        cs_etm__print_metadata_v0(cpu, val, i);
                else if (version == 1)
                        cs_etm__print_metadata_v1(cpu, val, i);
                else /* Not supported */
                        return;
        }

> -		if (val[i] == __perf_cs_etmv3_magic)
> -			for (j = 0; j < CS_ETM_PRIV_MAX; j++, i++)
> -				fprintf(stdout, cs_etm_priv_fmts[j], val[i]);
> -		else if (val[i] == __perf_cs_etmv4_magic)
> -			for (j = 0; j < CS_ETMV4_PRIV_MAX; j++, i++)
> -				fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
> -		else
> +		/* common header block */
> +		magic = val[i];
> +		fprintf(stdout, cs_etm_priv_fmts[0], val[i++]);
> +		fprintf(stdout, cs_etm_priv_fmts[1], val[i++]);
> +
> +		/* nr param only present in version 1 */
> +		if (version) {
> +			nr_params = val[i];
> +			fprintf(stdout, cs_etm_priv_fmts[2], val[i++]);
> +		}
> +
> +		if (magic == __perf_cs_etmv3_magic) {
> +			/* version 0 - fixed number of params */
> +			if (!version)
> +				nr_params =  CS_ETM_NR_PARAMS_V0;

Redundant space after "=".

> +
> +			/* after common block */
> +			for (j = 3; j < nr_params + 3; j++, i++) {

This is not correct, for the perf data with version 0, you should
start to print from item 2 for CS_ETM_ETMCR; Only for version 1, it
should start from 3 for CS_ETM_ETMCR.

> +				/* if newer record - could be excess params */
> +				if (j >= CS_ETM_PRIV_MAX)

I think we need support backward compatibility, but cannot support
forward compatibility.  So need to report error for this?

> +					fprintf(stdout, param_unk_fmt, j, val[i]);
> +				else
> +					fprintf(stdout, cs_etm_priv_fmts[j], val[i]);
> +			}
> +		} else if (magic == __perf_cs_etmv4_magic) {
> +			/* version 0 - fixed number of params */
> +			if (!version)
> +				nr_params = CS_ETMV4_NR_PARAMS_V0;
> +
> +			/* after common block */
> +			for (j = 3; j < nr_params + 3; j++, i++) {
> +				/* if newer record - could be excess params */
> +				if (j >= CS_ETMV4_PRIV_MAX)
> +					fprintf(stdout, param_unk_fmt, j, val[i]);
> +				else
> +					fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
> +			}
> +		} else {
>  			/* failure.. return */
> +			fprintf(stdout, magic_unk_fmt, magic);
>  			return;
> +		}
> +	}
> +}
> +
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
> +	hdr_version = buff_in[CS_HEADER_VERSION_0];
> +
> +	if (!hdr_version) {
> +	/* read version 0 info block into a version 1 metadata block  */
> +		nr_in_params = nr_params_v0;
> +		metadata[CS_ETM_MAGIC] = buff_in[i + CS_ETM_MAGIC];
> +		metadata[CS_ETM_CPU] = buff_in[i + CS_ETM_CPU];
> +		metadata[CS_ETM_NR_PARAMS] = nr_in_params;
> +		/* remaining block params at offset +1 from source */
> +		for (k = 2; k < nr_in_params; k++)
> +			metadata[k+1] = buff_in[i + k];
> +		/* version 0 has 2 common params */
> +		nr_cmn_params = 2;
> +	} else {
> +	/* read version 1 info block - input and output nr_params may differ */
> +		/* version 1 has 3 common params */
> +		nr_cmn_params = 3;
> +		nr_in_params = buff_in[i + CS_ETM_NR_PARAMS];
> +
> +		/* if input has more params than output - skip excess */
> +		nr_out_params = nr_in_params + nr_cmn_params;
> +		if (nr_out_params > out_blk_size)
> +			nr_out_params = out_blk_size;
> +
> +		for (k = 0; k < nr_out_params; k++)
> +			metadata[k] = buff_in[i + k];
> +
> +		/* record the actual nr params we copied */
> +		metadata[CS_ETM_NR_PARAMS] = nr_out_params - nr_cmn_params;

If we set CS_ETM_NR_PARAMS as self-contained value (it presents all
item numbers from CS_ETM_MAGIC to CS_ETMV4_TRCAUTHSTATUS), and we
can just support backward compatibility and don't support forward
compabitility, I think the logic can be simplized.

Thanks,
Leo

>  	}
> +
> +	/* adjust in offset by number of in params used */
> +	i += nr_in_params + nr_cmn_params;
> +	*buff_in_offset = i;
> +	return metadata;
>  }
>  
>  int cs_etm__process_auxtrace_info(union perf_event *event,
> @@ -2492,11 +2597,12 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
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
> @@ -2512,8 +2618,9 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  	/* First the global part */
>  	ptr = (u64 *) auxtrace_info->priv;
>  
> -	/* Look for version '0' of the header */
> -	if (ptr[0] != 0)
> +	/* Look for version of the header */
> +	hdr_version = ptr[0];
> +	if (hdr_version > CS_HEADER_CURRENT_VERSION)
>  		return -EINVAL;
>  
>  	hdr = zalloc(sizeof(*hdr) * CS_HEADER_VERSION_0_MAX);
> @@ -2552,35 +2659,31 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
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
> +							CS_ETM_NR_PARAMS_V0);
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
> +							CS_ETMV4_NR_PARAMS_V0);
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
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index 4ad925d6d799..fffc6b50beb9 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -24,16 +24,28 @@ enum {
>  	CS_HEADER_VERSION_0_MAX,
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
> +	CS_ETM_NR_PARAMS,
>  };
>  
>  /* ETMv3/PTM metadata */
>  enum {
>  	/* Dynamic, configurable parameters */
> -	CS_ETM_ETMCR = CS_ETM_CPU + 1,
> +	CS_ETM_ETMCR = CS_ETM_NR_PARAMS + 1,
>  	CS_ETM_ETMTRACEIDR,
>  	/* RO, taken from sysFS */
>  	CS_ETM_ETMCCER,
> @@ -41,10 +53,13 @@ enum {
>  	CS_ETM_PRIV_MAX,
>  };
>  
> +/* define fixed version 0 length - allow new format reader to read old files. */
> +#define CS_ETM_NR_PARAMS_V0 (CS_ETM_ETMIDR - CS_ETM_ETMCR + 1)
> +
>  /* ETMv4 metadata */
>  enum {
>  	/* Dynamic, configurable parameters */
> -	CS_ETMV4_TRCCONFIGR = CS_ETM_CPU + 1,
> +	CS_ETMV4_TRCCONFIGR = CS_ETM_NR_PARAMS + 1,
>  	CS_ETMV4_TRCTRACEIDR,
>  	/* RO, taken from sysFS */
>  	CS_ETMV4_TRCIDR0,
> @@ -55,6 +70,9 @@ enum {
>  	CS_ETMV4_PRIV_MAX,
>  };
>  
> +/* define fixed version 0 length - allow new format reader to read old files. */
> +#define CS_ETMV4_NR_PARAMS_V0 (CS_ETMV4_TRCAUTHSTATUS - CS_ETMV4_TRCCONFIGR + 1)
> +
>  /*
>   * ETMv3 exception encoding number:
>   * See Embedded Trace Macrocell spcification (ARM IHI 0014Q)
> -- 
> 2.17.1
> 
