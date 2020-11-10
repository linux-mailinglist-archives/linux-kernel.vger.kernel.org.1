Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABCF2ADDBC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbgKJSF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgKJSF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:05:58 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364A5C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:05:58 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q10so12160602pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VL3fCYWDHOkNPzHlwhPIf38FMrCmMGDNWH/B06K1TvA=;
        b=MKb+V0EQ9AxRegSTOKYrVG7Y67ap9JHGaoPT7xDTWX2c/Riab5K2/kmt9tETNhrMuQ
         IlxbZQMnm1v59prjCUxjVGJ0rX+3EKXkqCdLuL3mhFLczaalOOHplQ47jzKrxzYKavfJ
         v9XwQezzpxTHWjTL7XPSFt4YyosKU7ZSg+Y/6R6ugzuDA16ASWAaED2SewGHSygbgR77
         1+2/Y56QVsF56bd11SGcLjlLymJgqrpsbqkUK4iFU7CY+LA45LRhvFC7h+Bm+ALYuNbE
         e9YV6l30ENlW4Zfr7wIHAkrwB4u0kLN6tsANNHdMClB9LCV75CgTHh4Janr60H/n2KhC
         gn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VL3fCYWDHOkNPzHlwhPIf38FMrCmMGDNWH/B06K1TvA=;
        b=E0z/TDz0W9yJTK8tGZmuyq/4TQ/KIdaWWwBObJTlcTcI65e55Dh11qd3bmZqOtk/Y9
         r20SNa6LfGhG5Rj01AOnXM/4TbKcMy7PAJKeNwlIdydBOh+3+8YR38NEq/bIW0llqMnQ
         5raYq/dHc8YH0hR94dUIXPxO8i8A+BV/EexQz9V/twk9nA13Df1Lv8gVmWMatla7GX8J
         mwRJSKlzf5EBjpCfLkExrmZk9T1MFDLgcEWV1gEZVO4Pes7V1Tv30nBsz1qwYQekMwJe
         qn1PHi20WxZVqyiEEHHKVrfpJegslszcXV6BT9VxoyNa1FBpJox8t8peUsE4Kc4pr06H
         iWhg==
X-Gm-Message-State: AOAM530yWhFXNXghW8a5V5GZyQis3ryMJ088KoLRtbIlpVqp9uIyRejN
        Hw9xzgWlR2C5SLh8b4Xw4TuV5g==
X-Google-Smtp-Source: ABdhPJzPJYRWSB1Wl9mm8Th97fS/bVmswYT4Ai0Rq6qb6+Xzp3asFnfY0R4+9hj4yvJUE7cxgeRCFA==
X-Received: by 2002:a62:6103:0:b029:18c:4489:b0ef with SMTP id v3-20020a6261030000b029018c4489b0efmr5356721pfb.4.1605031557737;
        Tue, 10 Nov 2020 10:05:57 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r8sm15854633pgn.30.2020.11.10.10.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 10:05:57 -0800 (PST)
Date:   Tue, 10 Nov 2020 11:05:54 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH RESEND 1/2] perf test: Fix a typo in cs-etm testing
Message-ID: <20201110180554.GE3429138@xps15>
References: <20201110063417.14467-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110063417.14467-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 02:34:16PM +0800, Leo Yan wrote:
> Fix a typo: s/devce_name/device_name.
> 
> Fixes: fe0aed19b266 ("perf test: Introduce script for Arm CoreSight testing")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>

I would CC stable too.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
 
> Resend patches for adding "Fixes" tags.
> 
>  tools/perf/tests/shell/test_arm_coresight.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
> index 8d84fdbed6a6..59d847d4981d 100755
> --- a/tools/perf/tests/shell/test_arm_coresight.sh
> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> @@ -105,7 +105,7 @@ arm_cs_iterate_devices() {
>  		#     `> device_name = 'tmc_etf0'
>  		device_name=$(basename $path)
>  
> -		if is_device_sink $path $devce_name; then
> +		if is_device_sink $path $device_name; then
>  
>  			record_touch_file $device_name $2 &&
>  			perf_script_branch_samples touch &&
> -- 
> 2.17.1
> 
