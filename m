Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F52B279DA7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 05:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgI0DLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 23:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgI0DLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 23:11:38 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495E4C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 20:11:38 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mm21so1605177pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 20:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0UfH9eRraEVgZKOuQu7sJcJvRTvgOA60O/YTqb2eMrM=;
        b=BsNueg1pgJvc+f7TS4R8Zje0xgPeWkcbF62Z70oN9BZMouu6Cmt0mkYBEylYNlLG2y
         FULbmtn144XZbJ2UwmZHetb7mP+j8OjYNgc9X1/6DcYbPxfHmE18GFM7Bz6mzqynwWhi
         Z55/gzBvPJcMILWtP6epGbKrrD3oULudijSuntraSP8PRMLHGDN1Isxv2swGOigFbX31
         TbZxYJpmq8emKE3JMibQn/ykW+b8x3mnmB5F40tZlEwMmDqWShRPKUisGSSR/l0Ujdyr
         LXpgoyf7tTXifSaiF+8pAzyjOOne9zMUvuYbcDBHbRnY0uqtWkM75VYeg9eaompnxBAl
         GbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0UfH9eRraEVgZKOuQu7sJcJvRTvgOA60O/YTqb2eMrM=;
        b=BIfl0nqfNOPBBQ3oYSX1KpWKMZHkomhwApt5P5a3suTPhabipB2QuQsvHgGuRPESIs
         N2PPjvohIdlJLcmV6Wmic8DaPTySXEEQR5/cH5oFuSGKztrUsNznZRmjH6GiNS6yn68/
         SFVYu9WytFiBR/Tkla07uga4KiYwU+X5SWAa9T67argPZvtyOUTBXFB9TFfZH7bvgcYS
         qWuCUhTxDR6ltK96IAqosZ7Ir/h12VY1mbMZYd2BNvyXF7xdTfPDNo2Bha0orZCVmoqq
         WGiZeL8doh6OD9BMs1I6CuO4ExrgRua7N5Cpfd4saLjZnB1Bmw/UrYDKUPUpLDG4sQ3E
         0hcA==
X-Gm-Message-State: AOAM531o3et/z2veOJfoFdHD2NENR8XvKbiK8L49V3MaawkoB/Vat8CW
        3xB+F3+uRy9RGGG8pcAtQPHqOA==
X-Google-Smtp-Source: ABdhPJyP2kpxG7RCxYTlO2NTEpaUaXyLtulFj4qb9fouH3x/abMKPBLxOrxHw6y3bjTct5OOZmGcDg==
X-Received: by 2002:a17:90a:d512:: with SMTP id t18mr3956605pju.106.1601176297690;
        Sat, 26 Sep 2020 20:11:37 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id j14sm2792855pjz.21.2020.09.26.20.11.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Sep 2020 20:11:37 -0700 (PDT)
Date:   Sun, 27 Sep 2020 11:11:27 +0800
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
Subject: Re: [PATCH 3/5] perf: arm_spe: Add nested virt event decoding
Message-ID: <20200927031127.GC9677@leoy-ThinkPad-X240s>
References: <20200922101225.183554-1-andre.przywara@arm.com>
 <20200922101225.183554-4-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922101225.183554-4-andre.przywara@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 11:12:23AM +0100, Andre Przywara wrote:
> The ARMv8.4 nested virtualisation extension can redirect system register
> accesses to a memory page controlled by the hypervisor. The SPE
> profiling feature in newer implementations can tag those memory accesses
> accordingly.
> 
> Add the bit pattern describing this load/store type, so that the perf
> tool can decode it properly.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index e633bb5b8e65..943e4155b246 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -398,6 +398,10 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  					buf += ret;
>  					blen -= ret;
>  				}
> +			} else if ((payload & 0xfe) == 0x30) {
> +				ret = snprintf(buf, buf_len, " NV-SYSREG");
> +				buf += ret;
> +				blen -= ret;

This change has been included in the patch "perf arm-spe: Add more sub
classes for operation packet" [1].

Thanks,
Leo

[1] https://lore.kernel.org/patchwork/patch/1288412/

>  			} else if (payload & 0x4) {
>  				ret = snprintf(buf, buf_len, " SIMD-FP");
>  				buf += ret;
> -- 
> 2.17.1
> 
