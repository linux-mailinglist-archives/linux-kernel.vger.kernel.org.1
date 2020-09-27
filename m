Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE32279DBF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 05:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgI0Dap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 23:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730250AbgI0Dap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 23:30:45 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00E1C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 20:30:44 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so6409055pff.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 20:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3K1i/39gs/1aIs4bF2Mo38xKHGoVp+y8wUqaA4xOLDk=;
        b=CE5Hv2JBdLDwVG1wWdgfaq4I825/wpS9dQECV5O/hpikSp+Xzxd+LsAodLz0MYy0vc
         xLX6300XzXEMvVsVEGW40LLnataiEzcaY98n/FTwScXmCxJSB3cOD8P7nypVDZXuTbpt
         IMGSyn5xD65d1apDeZRc7SG2ReNCEtkER325hKh1QnP63COWCjRQ0684qqvP/Lqu3R4K
         Qwzw50q2G0IXXGBzhYZ64k56PoGP8Tqb9pnJH3szw1gRaLFNtJP7gBaxFg831/zk5hUZ
         7WG8vzStUCgy6I1Y9oKKwGFF/7goYWcNPJ7nIlQ+HFMr6jxNFjRowFHFQPy093qfPxT1
         l1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3K1i/39gs/1aIs4bF2Mo38xKHGoVp+y8wUqaA4xOLDk=;
        b=JfYGannxQQ3jwtJz8rrGG+bWQXonKJHiibCejVhHQZV5v1oVB1+Pope6BFmqNYn6AK
         43YPnzroMRNHTYTqCxDW9eGn2BHOkJM7/AkHm+z+XY4QV1EbjQy2r27gPU6UMo+grADv
         uHxSLIIv6p1OYjf8PLaloZTAwniSUJU0c0NRKDF0PIWO/WbwqInIv+lrYEIrsgvJjmBW
         THZT7i+y6Oqi1UGeJgTmUIv5WhpUu1Bls9aUA9iqt6Ob29uoRiFbchDH4C6fCKvN12n1
         qaPmJZjxgj7HuCtcgE7ZijJq481xnkFcF4Dj2uVrSioHFSsW3rTlWFt+DORt07bBeOUG
         NQog==
X-Gm-Message-State: AOAM533cc+hLzGVScQkg6cMN1B+QxYlOk3Mp2ZENi5/3FPtCqD9X4CAv
        nqSb+QfNxhq9hdaOxBP8iSZ3mg==
X-Google-Smtp-Source: ABdhPJxVsMoz6p3mpIexGgYww17zE4ZhFd9E1yos95NmZo1H5jUPUoG2nh2EbV4KWGDB44FFwz05uA==
X-Received: by 2002:a63:1644:: with SMTP id 4mr4654361pgw.232.1601177444268;
        Sat, 26 Sep 2020 20:30:44 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id w14sm6505117pfu.87.2020.09.26.20.30.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Sep 2020 20:30:43 -0700 (PDT)
Date:   Sun, 27 Sep 2020 11:30:35 +0800
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
Subject: Re: [PATCH 5/5] perf: arm_spe: Decode SVE events
Message-ID: <20200927033035.GE9677@leoy-ThinkPad-X240s>
References: <20200922101225.183554-1-andre.przywara@arm.com>
 <20200922101225.183554-6-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922101225.183554-6-andre.przywara@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On Tue, Sep 22, 2020 at 11:12:25AM +0100, Andre Przywara wrote:
> The Scalable Vector Extension (SVE) is an ARMv8 architecture extension
> that introduces very long vector operations (up to 2048 bits).
> The SPE profiling feature can tag SVE instructions with additional
> properties like predication or the effective vector length.
> 
> Decode the new operation type bits in the SPE decoder to allow the perf
> tool to correctly report about SVE instructions.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 48 ++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index a033f34846a6..f0c369259554 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -372,8 +372,35 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  	}
>  	case ARM_SPE_OP_TYPE:
>  		switch (idx) {
> -		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
> +		case 0: {
> +			size_t blen = buf_len;
> +
> +			if ((payload & 0x89) == 0x08) {
> +				ret = snprintf(buf, buf_len, "SVE");
> +				buf += ret;
> +				blen -= ret;
> +				if (payload & 0x2)
> +					ret = snprintf(buf, buf_len, " FP");
> +				else
> +					ret = snprintf(buf, buf_len, " INT");
> +				buf += ret;
> +				blen -= ret;
> +				if (payload & 0x4) {
> +					ret = snprintf(buf, buf_len, " PRED");
> +					buf += ret;
> +					blen -= ret;
> +				}
> +				/* Bits [7..4] encode the vector length */
> +				ret = snprintf(buf, buf_len, " EVLEN%d",
> +					       32 << ((payload >> 4) & 0x7));
> +				buf += ret;
> +				blen -= ret;
> +				return buf_len - blen;
> +			}
> +
> +			return snprintf(buf, buf_len, "%s", payload & 0x1 ?
>  					"COND-SELECT" : "INSN-OTHER");
> +			}
>  		case 1:	{
>  			size_t blen = buf_len;
>  
> @@ -403,6 +430,25 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  				ret = snprintf(buf, buf_len, " NV-SYSREG");
>  				buf += ret;
>  				blen -= ret;
> +			} else if ((payload & 0x0a) == 0x08) {
> +				ret = snprintf(buf, buf_len, " SVE");
> +				buf += ret;
> +				blen -= ret;
> +				if (payload & 0x4) {
> +					ret = snprintf(buf, buf_len, " PRED");
> +					buf += ret;
> +					blen -= ret;
> +				}
> +				if (payload & 0x80) {
> +					ret = snprintf(buf, buf_len, " SG");
> +					buf += ret;
> +					blen -= ret;
> +				}
> +				/* Bits [7..4] encode the vector length */
> +				ret = snprintf(buf, buf_len, " EVLEN%d",
> +					       32 << ((payload >> 4) & 0x7));
> +				buf += ret;
> +				blen -= ret;

The changes in this patch has been included in the patch [1].

So my summary for patches 02 ~ 05, except patch 04, other changes has
been included in the patch set "perf arm-spe: Refactor decoding &
dumping flow".

I'd like to add your patch 04 into the patch set "perf arm-spe:
Refactor decoding & dumping flow" and I will respin the patch set v2 on
the latest perf/core branch and send out to review.

For patch 01, you could continue to try to land it in the kernel.
(Maybe consolidate a bit with Wei?).

Do you think this is okay for you?

Thanks,
Leo

[1] https://lore.kernel.org/patchwork/patch/1288413/

>  			} else if (payload & 0x4) {
>  				ret = snprintf(buf, buf_len, " SIMD-FP");
>  				buf += ret;
> -- 
> 2.17.1
> 
