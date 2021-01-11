Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED372F1B99
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387966AbhAKQ4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731149AbhAKQ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:56:53 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC96C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:56:07 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id be12so148955plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sq2FqrzDyoQz9BNrYG3sZPVfF1ZaYE0pB1skj9ELFjc=;
        b=onrBw1GPHkgynAnAEeSSbPWi21Krue7y5Rhppl5Q7EyJqoIg3uViib/enI60U0SpG5
         86Cd9fRvacZZO3GTdg5LTL3kN/Ynd7cVPDu7WVQWSyPd4cowrbhJ43fqGuaFTzaa8Tbs
         T4Umg3Uej6PrrSW9byEJIojRYLftXr5Kk1L39qrK0Hm3HpcODM5OHoX7FJnnIo4bl8CJ
         zEPeQrAo5Y6K3s2j3HMkRnPYUNNYgvaTnnBToe4Zmrr764ynX7/eIlP8J5rkPEYrfNPh
         jGeGkKfezWJbv9BI9WzUiMIwelyNYaT2vMBhcufypl0ET9MfVLzvqq8Mz1VLRadBfV9n
         XIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sq2FqrzDyoQz9BNrYG3sZPVfF1ZaYE0pB1skj9ELFjc=;
        b=k1wkDOgJ/lXUwuYOTHJjBhdGinM/ROHC6QaZfO6bEMuOilsRn29mixYZDQ+stAFQCq
         S13rqYpC4OsSxHqtOn1ORFzimq0ioCmyQDCIPRCChVBTZ0st2SVG7M6igqGLqiD9zMuG
         b6WZ/+eJOQdqJrmu4UK3Ks8fSTKTmyhLVgA2I9vHv2F/ER5JKXvNI6kgYpLM6a7b2TYG
         xdMZVU1I1aKo+h120kY6YBLsSVYBoFuoj324/BpkVG0/7Ptz8Tm8WLe2+chNBhScln6T
         sSshhfQsX4Y8MRzUfo/w8UiDUp2LIU3GuV4lbq4LJqj9gxiBqK6l4RyaL98qR+M0Rkrs
         8fFQ==
X-Gm-Message-State: AOAM5339tYe6M1CQZiMyvRY1AvGFgk+0E5lyIl5Bo0nTOBlky++gogSq
        cq3OMczwYqXo8lmuTPn91IkIlg==
X-Google-Smtp-Source: ABdhPJw5Ga1bQgrMJQN1BQDx7WNtwLOuNJl3y3VbY7TEzg1avaAboesxUzYk01s/y/E+/kYsj4no5w==
X-Received: by 2002:a17:902:a401:b029:dc:3e1d:234a with SMTP id p1-20020a170902a401b02900dc3e1d234amr223959plq.48.1610384167224;
        Mon, 11 Jan 2021 08:56:07 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id a29sm160231pfr.73.2021.01.11.08.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 08:56:06 -0800 (PST)
Date:   Mon, 11 Jan 2021 09:56:04 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>, acme@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf tools: Update OpenCSD to v1.0.0
Message-ID: <20210111165604.GA144935@xps15>
References: <20210108142752.27872-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108142752.27872-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 04:27:52PM +0200, James Clark wrote:
> Replace the OCSD_INSTR switch statement with an if to
> fix compilation error about unhandled values and avoid
> this issue again in the future.
> 
> Add new OCSD_GEN_TRC_ELEM_SYNC_MARKER and
> OCSD_GEN_TRC_ELEM_MEMTRANS enum values to fix unhandled
> value compilation error. Currently they are ignored.
> 
> Increase the minimum version number to v1.0.0 now
> that new enum values are used that are only present
> in this version.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Al Grant <al.grant@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/build/feature/test-libopencsd.c           |  4 ++--
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 15 ++++-----------
>  2 files changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
> index 1547bc2c0950..52c790b0317b 100644
> --- a/tools/build/feature/test-libopencsd.c
> +++ b/tools/build/feature/test-libopencsd.c
> @@ -4,9 +4,9 @@
>  /*
>   * Check OpenCSD library version is sufficient to provide required features
>   */
> -#define OCSD_MIN_VER ((0 << 16) | (14 << 8) | (0))
> +#define OCSD_MIN_VER ((1 << 16) | (0 << 8) | (0))
>  #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
> -#error "OpenCSD >= 0.14.0 is required"
> +#error "OpenCSD >= 1.0.0 is required"
>  #endif
>  
>  int main(void)
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index cd007cc9c283..3f4bc4050477 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -419,19 +419,10 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
>  	packet->last_instr_subtype = elem->last_i_subtype;
>  	packet->last_instr_cond = elem->last_instr_cond;
>  
> -	switch (elem->last_i_type) {
> -	case OCSD_INSTR_BR:
> -	case OCSD_INSTR_BR_INDIRECT:
> +	if (elem->last_i_type == OCSD_INSTR_BR || elem->last_i_type == OCSD_INSTR_BR_INDIRECT)
>  		packet->last_instr_taken_branch = elem->last_instr_exec;
> -		break;
> -	case OCSD_INSTR_ISB:
> -	case OCSD_INSTR_DSB_DMB:
> -	case OCSD_INSTR_WFI_WFE:
> -	case OCSD_INSTR_OTHER:
> -	default:
> +	else
>  		packet->last_instr_taken_branch = false;
> -		break;
> -	}
>  
>  	packet->last_instr_size = elem->last_instr_sz;
>  
> @@ -572,6 +563,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  	case OCSD_GEN_TRC_ELEM_EVENT:
>  	case OCSD_GEN_TRC_ELEM_SWTRACE:
>  	case OCSD_GEN_TRC_ELEM_CUSTOM:
> +	case OCSD_GEN_TRC_ELEM_SYNC_MARKER:
> +	case OCSD_GEN_TRC_ELEM_MEMTRANS:
>  	default:
>  		break;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Arnaldo please consider.

Thanks,
Mathieu

>  	}
> -- 
> 2.28.0
> 
