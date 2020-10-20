Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5F4293694
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 10:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388222AbgJTIQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 04:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgJTIQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 04:16:17 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A96C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:16:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w11so619602pll.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YUU8mr8nH7NTwfBl+ViIHuGpwWTsXo+9f5g9/+klgFY=;
        b=AStaUvR7SQ+Ttk5ZIoDxg1jAZKQwTPq0KjNw/UsA7p+SB8QlS+f0HBJ2Qd5I44Kmre
         zDwlo1M+G6LxXcETrA4SbJ8vbPkh966lPpChJ5aWV9Vvy4nFDClVyVmfqypQx6rOGWDq
         6sB0Nci3t31kFXp+gH91llwhqWuRlKip6GxHqFQBaxLGtRqlZa3q2yAUfe/XzR0qShdb
         gHnvj7g62mfzcwy8qi4qwSp05FnnYxkfjYUy35xtISDYExMRyOE2G6XGIB11H6nFzNUo
         Rfy/BNvajjFkP7cKKec8MlsJGBVZyqqjwxOhVnKKmRdOV4NZk5mIgfL/pI5cIuyA2ht8
         lI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YUU8mr8nH7NTwfBl+ViIHuGpwWTsXo+9f5g9/+klgFY=;
        b=UnhAiG8ALNqt6tcFiVkQd9EAxRlhvu9uxjPLp4VvMvZZdkfTwf+zKSqHS3Lgrpa4Ki
         mqx/U6khZ6tjQYq/szM2Hew3eDRM6ToWdIq56Fp2dlQl+GyGM/H7YQzZqUznzo6Npu6r
         GwRyf09VE6KS9gPmEcDZWT7Mi/FgpU0uVuWJVAUk1adRVEZYOPsthQgIdImSCwwgLWZW
         wLnLe89kr4p02rzAsU5VIQA0vg6+22Mr1YZdxUGNAZUUKkEdAjVv/3aD/fBrFuY+mQPa
         +u5aG2Hteq1Uz9m7gWwtasHPf/23oD12N0xjzBoYl/ntGblsHSZXY+58stg39Ut4Sr0s
         EtEg==
X-Gm-Message-State: AOAM533IlT0v77FE5Qdgyt7z4bPatmO9LD/EL7ivIgWXRJcVGMmkcAnT
        PM23RvZQLOSB+LBV7K3uN29VEg==
X-Google-Smtp-Source: ABdhPJyH/dXjCH4pKwVBtivnDviDpv92JhFKAAuwkDUDKc3pWkuQhEABVF2ioj2n7r3J3Dpd91OeKQ==
X-Received: by 2002:a17:90b:ed3:: with SMTP id gz19mr1819153pjb.53.1603181776738;
        Tue, 20 Oct 2020 01:16:16 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id i30sm1406375pgb.81.2020.10.20.01.16.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Oct 2020 01:16:16 -0700 (PDT)
Date:   Tue, 20 Oct 2020 16:16:10 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, kan.liang@linux.intel.com,
        mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH V9 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20201020081610.GE13630@leoy-ThinkPad-X240s>
References: <20201001135749.2804-1-kan.liang@linux.intel.com>
 <20201001135749.2804-2-kan.liang@linux.intel.com>
 <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
 <20201009093750.GD29594@willie-the-truck>
 <20201009095300.GI2628@hirez.programming.kicks-ass.net>
 <20201020024925.GB13630@leoy-ThinkPad-X240s>
 <20201020071945.GW2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020071945.GW2611@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 09:19:45AM +0200, Peter Zijlstra wrote:
> On Tue, Oct 20, 2020 at 10:49:25AM +0800, Leo Yan wrote:
> > I can see there have another potentail customer to use page-size is
> > Arm SPE, but Arm SPE is hardware trace based sample but not interrupt
> > based sample.  For this case, I think this patch set cannot be
> > directly applied to the AUX trace data.
> 
> IIRC SPE is decoded in userspace, at which point we simply cannot access
> this data.

Yes, it's decoded in userspace.

Thanks for clarification!
Leo
