Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400972F5B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbhANHnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbhANHnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:43:42 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F9DC061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 23:43:02 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id c132so3222554pga.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 23:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Soe49DcitaMnxGv6+C2k+vo4zd53+VFfz4ymQ3PNcmw=;
        b=LWdY5M8fFcxUWLE8OIdkCW3d+0os9691qBqfUyQyEqIt62V/hEhoz1S2j9sa+FBb9V
         /YE3qiLtcz/E1/uWd6sJOuSv6ukrPMTqmdFQ/fBn+pYQLRWwlDDIZ65txEAXYz/patqm
         mx4tt8QW5Q9L1LW1rcuWVXqoHaeKEyIFYS+iKbInXVuo7YKjFYBiL+NrjqwqQeXMS4Qo
         Ye7PnYxqt2q+Aawi2sSL8EkgH9aHFeysrn1PP2h2FfR6f+WGKr12Zjai988lWLvbZynm
         7FlvmGGKJkpFe2AAmoSOAmQjFDbDtllMcs3d7fNVkGRGxurIwtXi1MfrhyCMJce5XwRn
         3n8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Soe49DcitaMnxGv6+C2k+vo4zd53+VFfz4ymQ3PNcmw=;
        b=otSt3OQbZ3Lp2FWytEKYTl7XLWUT/iPnmiMZlLLyf/Upm4S4oqt+cKjsIM52NMV17k
         Epfy594NKKgpn59TAXO6uPDHiVsGMOz1nLha6okabBNu8nGXfxkNH50zuQDyrbprUmDk
         hiRsMMPRU0rKf0suy4FY1Cd8WNrB/RlMZ8474RMN1gUc/XhhQFCa6wAR11c6ZysiOtzt
         OR2/33N5+wLwbdvrMsyWSDV5fmutLfVkmBd/fG0ztyMPR6YDMDEj0J1aSb9w+u9nUvIZ
         zTzJGbVRGwP9WVU9m7Ym5cuoMsGLsenjuigr5kYRt2Im+VaP3T3sBnOsS9zY6IbgRnX2
         jx1w==
X-Gm-Message-State: AOAM530S2SvS+kuHRjmxA7gkwSEuCzu+Wmm8OvWdI3tbYXAp5uWspTi3
        VrfovI84xQHoGzJHS5XfwyjDFg==
X-Google-Smtp-Source: ABdhPJyZd3ioHumKvGYgbe6Lm6Fyiw4I6nDJaifhBgBdvMpp2BUNaW3zStt7FRgQfEgqNVw/V+VDJg==
X-Received: by 2002:a63:987:: with SMTP id 129mr6224319pgj.251.1610610182239;
        Wed, 13 Jan 2021 23:43:02 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id bf3sm4948891pjb.45.2021.01.13.23.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 23:43:01 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:42:56 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Joe Perches <joe@perches.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] perf c2c: Refactor display filter
Message-ID: <20210114074256.GA189511@leoy-ThinkPad-X240s>
References: <20210114033939.164538-1-leo.yan@linaro.org>
 <20210114033939.164538-4-leo.yan@linaro.org>
 <07e9ed776de833ab89fafdb76164e038e47f6d7c.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07e9ed776de833ab89fafdb76164e038e47f6d7c.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Wed, Jan 13, 2021 at 11:35:23PM -0800, Joe Perches wrote:
> On Thu, 2021-01-14 at 11:39 +0800, Leo Yan wrote:
> > When sort on the respective metrics (lcl_hitm, rmt_hitm, tot_hitm),
> > macro FILTER_HITM is to filter out the cache line entries if its
> > overhead is less than 1%.
> > 
> > This patch introduces static function filter_display() to replace macro;
> > and refines its parameter with more flexbile way, rather than passing
> > field name, it changes to pass the cache line's statistic value and the
> > sum value.
> []
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> []
> > +static u8 filter_display(u32 val, u32 sum)
> > +{
> > +	double ld_dist;
> > +
> > +	if (sum) {
> > +		ld_dist = ((double)(val) / (sum));
> > +		if (ld_dist < DISPLAY_LINE_LIMIT)
> > +			return HIST_FILTER__C2C;
> > +	} else {
> > +		return HIST_FILTER__C2C;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> style:
> 
> It's generally better to test and return early and unindent the remainder.
> Also, parentheses aren't necessary around now not-macro args.
> 
> {
> 	if (sum == 0 || ((double)val / sum) < DISPLAY_LINE_LIMIT)
> 		return HIST_FILTER__C2C;
> 
> 	return 0;
> }

Will refine for this; thanks for suggestion.

Leo
