Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952332ADDCF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbgKJSIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731212AbgKJSId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:08:33 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B05C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:08:32 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id x13so12132385pfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wB3QqkiVD+VrdFXWFJqguAObuEzlRQZR81UlesXyjjs=;
        b=JrUBp/O6Jh67wN3ajz0XAini/nxQAsb7xaZPqxVYDKCnrol6kQ3HOy4tTai7u9YNnR
         +/rBckmt8xICvZe5P0BnwMPN/4nloFFFhUCEH+Ds75V7Hwc6dzDaRKhb9c8Yc4j3vs8C
         HC3fxF9H5VKssxeMgLA13JBGdnei4ISEcvVHoM5SbUUmjdw1mYrRun58Wvo7XJ6zZzFS
         NoWr6XIao3RfjgOWteQtka2FYzMaPJSLPempBEQdNZA/gR1/rBbVwZI/PY4w1LgdH5D3
         U5ScoTM6i9oX6uZGDB31Fn0klrZYXx4tO28dl+xJtk5dHxYyokSXGuyRi6hKF8NYCn0q
         9amw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wB3QqkiVD+VrdFXWFJqguAObuEzlRQZR81UlesXyjjs=;
        b=PhLWxRq0lYFxpqsXzaB/4VilKkiCFJS0sWEDFkT75Cws9mOSyOTNPyj2C/2Pa18tQa
         hnV2Gu8becd+P/cXtKtKiSo/XSuLLdjR1ZIP3aA+7PCNebBAuaMhC82iWn3ieRknmOhh
         jWYYeV3s17A5nf4yFz1MtUjxmYBNlV9sWL9DKFSTztaINaTZe0ySTMXli+izABQDxbSx
         EhLRRHxrNRjxwLjW8vvg5+jVfAiBhaSHKFQUTkYoJ5VSb/eoWFbnnXFxnvv5aOB3xgbE
         m52icAj7e0/xLbgT/mlhd14rLtj+WDvJuGvvgtC9G3h9/fj36jfdsYwyCNUML1MH/Dg6
         6FpQ==
X-Gm-Message-State: AOAM532YNCYcE+lDqixHdOTi5vv1Lm88R4+qu29bEI0xwieKSWaCuqjI
        SmUOOAN257JatXSdIkW2CtZo2g==
X-Google-Smtp-Source: ABdhPJwNEB1MhEIicFaQFFjChiHHuMLuV94gIY8uBr9K2uKjBiZd0VDFXD7vcL71WN8t1UEV4ZXVqg==
X-Received: by 2002:a17:90a:880c:: with SMTP id s12mr311690pjn.159.1605031712527;
        Tue, 10 Nov 2020 10:08:32 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y8sm14872305pfe.33.2020.11.10.10.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 10:08:31 -0800 (PST)
Date:   Tue, 10 Nov 2020 11:08:29 -0700
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
Subject: Re: [PATCH RESEND 2/2] perf test: Update branch sample parttern for
 cs-etm
Message-ID: <20201110180829.GF3429138@xps15>
References: <20201110063417.14467-1-leo.yan@linaro.org>
 <20201110063417.14467-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110063417.14467-2-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 02:34:17PM +0800, Leo Yan wrote:
> Since the commit 943b69ac1884 ("perf parse-events: Set exclude_guest=1
> for user-space counting"), 'exclude_guest=1' is set for user-space
> counting; and the branch sample's modifier has been altered, the sample
> event name has been changed from "branches:u:" to "branches:uH:", which
> gives out info for "user-space and host counting".
> 
> But the cs-etm testing's regular expression cannot match the updated
> branch sample event and leads to test failure.
> 
> This patch updates the branch sample parttern by using a more flexible

s/parttern/pattern

> expression '.*' to match branch sample's modifiers, so that allows the
> testing to work as expected.
> 
> Fixes: 943b69ac1884 ("perf parse-events: Set exclude_guest=1 for user-space counting")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/tests/shell/test_arm_coresight.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here too I would CC stable.  With the above:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
> index 59d847d4981d..18fde2f179cd 100755
> --- a/tools/perf/tests/shell/test_arm_coresight.sh
> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> @@ -44,7 +44,7 @@ perf_script_branch_samples() {
>  	#   touch  6512          1         branches:u:      ffffb22082e0 strcmp+0xa0 (/lib/aarch64-linux-gnu/ld-2.27.so)
>  	#   touch  6512          1         branches:u:      ffffb2208320 strcmp+0xe0 (/lib/aarch64-linux-gnu/ld-2.27.so)
>  	perf script -F,-time -i ${perfdata} | \
> -		egrep " +$1 +[0-9]+ .* +branches:([u|k]:)? +"
> +		egrep " +$1 +[0-9]+ .* +branches:(.*:)? +"
>  }
>  
>  perf_report_branch_samples() {
> -- 
> 2.17.1
> 
