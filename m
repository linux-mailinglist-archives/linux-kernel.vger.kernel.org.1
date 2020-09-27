Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537A2279DB3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 05:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbgI0DT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 23:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgI0DT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 23:19:26 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD4BC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 20:19:26 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c3so1492888plz.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 20:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pYHa4pq8WjgGJhNepMFy8huvsV4VYtWl9GfWXd1YlPQ=;
        b=D+ccqI2fZDyCKEDKrqABnGxR6/8Rz7HvpQo9JSDsSzof+ST+CyTJKN2QCXcQwt7ohK
         dD88cCOLb4wuAF2eul0s//60TpNW6jQk+w5jTT/nd1urFHaw4MqO1kdOzsaH5Nk5113U
         GrtyCoBSu+wK+HIFOEMtmE8dU4xEvUYjxBYm3qKYsAUHcbUvO8KJHV0wAvevy3NBJcs+
         Rfln/p4uyfKPIy27otoyyK++M6n093RX9CfaDSq31EYk0/pkLKlQJ7MsP7rRaoBFBx4G
         jkkAi62kMihkFcOjFdP1axQVX+FGkp4zU2Qa3yIKJVmUyESAz/bamDO3LO9taF+9Mlt7
         9dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pYHa4pq8WjgGJhNepMFy8huvsV4VYtWl9GfWXd1YlPQ=;
        b=lLNcpXgyIHzlqje4lcjblRgBSZTPwDT+OVDQWkR+EsEAFVuIKWYu7cOAZVRvQH1/+Q
         kMNrBxYAg/uk5Q1jPllZUjr1MrBqWDmzQaBUUdz0Yg+Nr0ToKc6pXCKNqrJNNBg9QgO8
         3Z5fEQ1gLdl4Dkl24Yzyhxld6a213F0beGR+mhKva8rnZt44xqo9LtaKbF7JKHEuxdtF
         u7OQVSec9vNZREqw6chRP80jgFxDj+B+ZmgRm3QHONtqp6Jjpuu7I85sVdktZElY17ar
         dB0KZYE/qQGKLa6SA71Ah/0UbfcJFH9ueuU7agHh2STHi0t9F003HfytuVZG5ooyMXp4
         GPiA==
X-Gm-Message-State: AOAM531lyZOfhMRlPNM2aW3jQBwXZsC2IW7iIgpL+MbwPJFnZteS4lK8
        1LexnToUOuwoJIdSWOKvO09cDA==
X-Google-Smtp-Source: ABdhPJxUlUIPQ2IR0bNFQsZcSFXMdKiqLqSqb0TiqrZ5PklX00NF5wmHLrcpPnaGY/Eh1KBAxlMN2g==
X-Received: by 2002:a17:902:be0f:b029:d2:83e9:5d6b with SMTP id r15-20020a170902be0fb02900d283e95d6bmr2252721pls.75.1601176766349;
        Sat, 26 Sep 2020 20:19:26 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id r16sm2784436pjo.19.2020.09.26.20.19.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Sep 2020 20:19:25 -0700 (PDT)
Date:   Sun, 27 Sep 2020 11:19:18 +0800
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
Subject: Re: [PATCH 4/5] perf: arm_spe: Decode memory tagging properties
Message-ID: <20200927031918.GD9677@leoy-ThinkPad-X240s>
References: <20200922101225.183554-1-andre.przywara@arm.com>
 <20200922101225.183554-5-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922101225.183554-5-andre.przywara@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 11:12:24AM +0100, Andre Przywara wrote:
> When SPE records a physical address, it can additionally tag the event
> with information from the Memory Tagging architecture extension.
> 
> Decode the two additional fields in the SPE event payload.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../util/arm-spe-decoder/arm-spe-pkt-decoder.c  | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 943e4155b246..a033f34846a6 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -8,13 +8,14 @@
>  #include <string.h>
>  #include <endian.h>
>  #include <byteswap.h>
> +#include <linux/bits.h>
>  
>  #include "arm-spe-pkt-decoder.h"
>  
> -#define BIT(n)		(1ULL << (n))
> -
>  #define NS_FLAG		BIT(63)
>  #define EL_FLAG		(BIT(62) | BIT(61))
> +#define CH_FLAG		BIT(62)
> +#define PAT_FLAG	GENMASK_ULL(59, 56)
>  
>  #define SPE_HEADER0_PAD			0x0
>  #define SPE_HEADER0_END			0x1
> @@ -447,10 +448,16 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>  			return snprintf(buf, buf_len, "%s 0x%llx el%d ns=%d",
>  				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
>  		case 2:	return snprintf(buf, buf_len, "VA 0x%llx", payload);
> -		case 3:	ns = !!(packet->payload & NS_FLAG);
> +		case 3:	{
> +			int ch = !!(packet->payload & CH_FLAG);
> +			int pat = (packet->payload & PAT_FLAG) >> 56;
> +
> +			ns = !!(packet->payload & NS_FLAG);
>  			payload &= ~(0xffULL << 56);
> -			return snprintf(buf, buf_len, "PA 0x%llx ns=%d",
> -					payload, ns);
> +			return snprintf(buf, buf_len,
> +					"PA 0x%llx ns=%d ch=%d, pat=%x",
> +					payload, ns, ch, pat);
> +			}

Reviewed-by: Leo Yan <leo.yan@linaro.org>

>  		default: return 0;
>  		}
>  	case ARM_SPE_CONTEXT:
> -- 
> 2.17.1
> 
