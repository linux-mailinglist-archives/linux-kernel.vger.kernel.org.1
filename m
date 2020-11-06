Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E4F2A8C72
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732729AbgKFCKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731060AbgKFCKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:10:05 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A54C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 18:10:03 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c20so2891678pfr.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cDO9mCj2hwl9oMBPZH/M1L0eFZaMR68Ji9hXfESWvn4=;
        b=P784tU/dhbhAs9DHcE/I8MP+dpI0epJyOO+84MKcH3zeFDU1hKZFWEvhaDEhmO1Naf
         rwnZqcKHz36r6AStENKGLi25caC0VT/SDrsutJyzGr0oqNouY7YM29uU+s+we/1mO4qb
         sxBpPEhMgr+6mtsBSsIR7xUOQz8fAh7Ebsu9TXwd0a24Lfg/lcNIIJj5FsaqLadhV75u
         SkH41kHsVpTquJV8B1HsrD0khh32rQMBPT7ewPyCqeWirXS0kTo9TsY1Ps/H+q09ZfZD
         DTp1173ZF6fjSMCZHA/8ye+W2NNVOAa+I5qdaI3zZjLcaDwMrfWRcYuxfyvgwykY1LHc
         b+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cDO9mCj2hwl9oMBPZH/M1L0eFZaMR68Ji9hXfESWvn4=;
        b=ZcapnU67sRcMs9JDQisYjPrggwklJNe839zG969hW+xarGiE+9koBkjSAmGqxsXV2j
         HxkRKvFLsskcToPjtnXowltuOok6dLyb/tX6HFu9m8rIhk8s1KerBW9d9YETnZrfMA1u
         HEymcDb5cypgmRpjJlwUdH+KvIYdBSKdfKLqMpvATGoKmNYZNrGaiIxjVCkhIE/cf0ki
         7WgRyAGWN/qmWsEyXW1IXAM09cfzKBOjLHLgumQLujcNnWqXqZgN6/wmrdxFQ4hTCStp
         NyHScWOp9tQnX+zsWIy4aRJX/yNzwI9aUgOVi8vR7rVhiR2/22cT60pig4tWgeuGjR4R
         qhXw==
X-Gm-Message-State: AOAM532lrGutwp8YuHDuKmyq885+ATRws0nOrj4WJ5bcrb7GIs3Z03+L
        W8/Ny3cbqnv1o6QV1uu+Iuzo+Q==
X-Google-Smtp-Source: ABdhPJz9b8fRxksdazFXZ/dc9LclzBcwOSJ2QWSRnOIhYvaU+ptKKw7kWPjx2swJyisBo7oPgRIGow==
X-Received: by 2002:a17:90a:182:: with SMTP id 2mr5056300pjc.21.1604628603343;
        Thu, 05 Nov 2020 18:10:03 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id b29sm4037784pff.194.2020.11.05.18.09.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 18:10:02 -0800 (PST)
Date:   Fri, 6 Nov 2020 10:09:57 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Walker <robert.walker@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] perf cs-etm: Support thread stack and callchain
Message-ID: <20201106020957.GB13572@leoy-ThinkPad-X240s>
References: <20200220052701.7754-1-leo.yan@linaro.org>
 <160461665604.60232.10802283348863949674@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160461665604.60232.10802283348863949674@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Nov 05, 2020 at 02:50:56PM -0800, Stephen Boyd wrote:
> Quoting Leo Yan (2020-02-19 21:26:52)
> > This patch series adds support for thread stack and callchain; this patch
> > set depends on the instruction sample fix patch set [1].
> > 
> > This patch set get more complex, so before divide into small groups, I'd
> > like to use this patch set version to include all relevant patches, hope
> > this can give whole context for related code change.
> 
> Was this split up into small groups and sent again? I didn't see
> anything when searching lkml.

No, this patch series is the last one for upstreaming; since I worked
on other stuffs, so didn't continue to upstream to the mainline kernel.

IIRC, there have a concern for a pontential breakage for perf cs-etm
testing, so falls to backlog.  Let me check with Mathieu/Mike offline
for how to proceed for this patch set.  Thanks for bringing up.

Leo
