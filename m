Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CD4279DA3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 05:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbgI0DDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 23:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgI0DDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 23:03:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0D2C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 20:03:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f1so1461279plo.13
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 20:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RtXWyDkCij11zebgLRSScf+c0/+Ske82lJ97GFszwBE=;
        b=S6IsB7OwsUp/R0Bdeuni8+U5UD+lJpHeqcEJIh9nG/KNzXDQ11RbSX3yRExKwGTHYs
         1sCtmRPkysgew7tGI8/DGSKT0hq2wqGnzzrNnRSZrkncyGQ3h04j9NF+JYGC/QwaXK1o
         Zrz7535zQUdUtz0tHtWgH6HN01NiRIo8qJsudJu0J22LXbjjb7rihotgvDm96OvR+NEk
         HQurkGA24eeP9P2wTf/mGjpnB52s1wYCJAhE0wpIp75rb0YBKFBSkIIlsJgHIHeCiBro
         Lf4X+qces5l+qcdwEnBLuPU6EHwfBOeNZ9k93nUqynWtyhuPUP67+BFmFmteN43cqxzR
         h+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RtXWyDkCij11zebgLRSScf+c0/+Ske82lJ97GFszwBE=;
        b=ASeXYIYKynw1utJSgbChXoN3ajQJywoVBy9XaZMReJORqtNL3pLL/MoiljR8nFWg2N
         wtT/HKd92O1lX0+4WAKndzfTkPRvQu5h9p/u+PgpfUtT7k7I8qU0jGfViSB9NHoU6MPP
         z5BGMJi7ffURR5eeZrUJdUzV3IqE3E0sFOFpxkV3B7I/2nhBZVbfxFbSo7ScrNNQ7n4g
         0bTt7TKRhLMoOozXna50QrU9q0F+01HahXUBLCyBBwtPRruLLABUkn43s96Ckqn09zVp
         3l4AbkVhOkc0vZxeEh0+LvMxSwSbAZmHTQfIwBZcfTSjPYwpL03IfBMET8Gd0rfn9Ty7
         UIFw==
X-Gm-Message-State: AOAM533o0fri4GLWlsu8fmOYX17b5T5BeAAU0CscP7p8fXbJm/IgKzvK
        +BS8FwwRBYnIkpVkIO3Vs9KjWQ==
X-Google-Smtp-Source: ABdhPJz9dy2ALqWLDONzuDcqOoB+VpjHz5wAEofMM4n4hJuKQBQW7kOiO/Nz6eS8P0dhb3Pnkcl7ww==
X-Received: by 2002:a17:90a:f3d1:: with SMTP id ha17mr3996432pjb.231.1601175816965;
        Sat, 26 Sep 2020 20:03:36 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id bt13sm2959921pjb.23.2020.09.26.20.03.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Sep 2020 20:03:36 -0700 (PDT)
Date:   Sun, 27 Sep 2020 11:03:29 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] perf: arm_spe: Add new event packet bits
Message-ID: <20200927030329.GB9677@leoy-ThinkPad-X240s>
References: <20200922101225.183554-1-andre.przywara@arm.com>
 <20200922101225.183554-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922101225.183554-3-andre.przywara@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 11:12:22AM +0100, Andre Przywara wrote:
> The ARMv8.3-SPE extension adds some new bits to the event packet
> fields.
> 
> Handle bits 11 (alignment), 17 and 18 (SVE predication) when decoding
> the SPE buffer content.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../util/arm-spe-decoder/arm-spe-pkt-decoder.c  | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index b94001b756c7..e633bb5b8e65 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -346,6 +346,23 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  				buf += ret;
>  				blen -= ret;
>  			}
> +			if (payload & BIT(11)) {
> +				ret = snprintf(buf, buf_len, " ALIGNMENT");
> +				buf += ret;
> +				blen -= ret;
> +			}
> +		}
> +		if (idx > 2) {
> +			if (payload & BIT(17)) {
> +				ret = snprintf(buf, buf_len, " SVE-PARTIAL-PRED");
> +				buf += ret;
> +				blen -= ret;
> +			}
> +			if (payload & BIT(18)) {
> +				ret = snprintf(buf, buf_len, " SVE-EMPTY-PRED");
> +				buf += ret;
> +				blen -= ret;
> +			}

From patch 02 to patch 05, some changes have been included in the
patch set "perf arm-spe: Refactor decoding & dumping flow".  I
refactored the Arm SPE decoder so uses macros to replace the hard code
numbers for packet formats.  So I'd like your changes could rebase on
this refactor patch set, thus can reuse the predefined macros for
decoding.

For this patch, it has been included in the patch [2].  You could see
your implementation is difference for handling "ALIGNMENT", it misses
to check "idx > 2".  It would be very helpful if you could review
patch [2].

Thanks,
Leo

[1] https://lore.kernel.org/patchwork/cover/1288406/
[2] https://lore.kernel.org/patchwork/patch/1288413/

>  		}
>  		if (ret < 0)
>  			return ret;
> -- 
> 2.17.1
> 
