Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDCD28D121
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 17:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbgJMPT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 11:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgJMPT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 11:19:58 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB129C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 08:19:57 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b6so105023pju.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 08:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qhi/vR1Y4s1cr/nOmC2PdNe3HKi5OUUwuI1+17/oAmY=;
        b=WP6ia4C7vw5UVIa5tUnJSdZkLtL4tMAE/Rv/tg/3iHGHy8eN27fa4OsyVk89F9NHfX
         jzAziGK486c9yltyz0iHtCFkTa9664/5Sy9VN5dt5SUOffikYjqelNNf6SYDIV53F7Od
         ZDruK/DWYTBsRNpbsMrYKnhgxW8/4dJl6DSHpREq+566tV1uwP7uBkp6pKSYjQ99tGuf
         gQNjFHBeUvcHSlFLUPYhUId5W0NVi/5j8y3hMIAXPPYGqJkP/CUt8kB9XqGMwOZt/fwA
         6gJDcseMH4fkkNhc8bz4R4DBmNBVZayagLtUyjy3vj9/o7jH9TCnnqGSDPhsov3xOIg5
         Jf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qhi/vR1Y4s1cr/nOmC2PdNe3HKi5OUUwuI1+17/oAmY=;
        b=RZZDWw4qLW+aHCIrKP9akuLAYQhxF9MgitA2ck9wzs0EYb1qY/72wWKDWTKtDDyRXc
         xloVxzsoGRX5t+Qj58vjPwgs0dhH3+R5Cuzq8e4Tvi34rE1qzsCJbHms6fqbls+48dNV
         hw+YWag2WnHjVti3q3E11Y9JjVT+7cP5A91ZXik6G6ONbChdrRcj5Lei13mFk4IDBnRz
         t2RG1jlb38vEAdCvA+lOqJdjrAie45Dy6A/mTdmHGYbiGWkP4VPrKzMqQqU37a/a0hpZ
         xho5Uj5hYmtlUYaUJuj5suvTdnzelBpGhrsvPpwWp1NW8bvJx7v72yqECCD31+NmT84N
         nSFA==
X-Gm-Message-State: AOAM532xaR/83V5gSdZqElb/sSx2GckuXzfKlvWEXjxcIL41bNLRu1tk
        ev7AOafdOWGey3JUTq5FLhDqf4i18SVgAHWR
X-Google-Smtp-Source: ABdhPJw1FCrK7FeRpkeuwkS9RM66H/PSSVQQA9mcntsSXNpMCVazKJlY47d6dvB1rheORojTh6gxpQ==
X-Received: by 2002:a17:90a:dc06:: with SMTP id i6mr250032pjv.162.1602602397412;
        Tue, 13 Oct 2020 08:19:57 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id b10sm22149894pgm.64.2020.10.13.08.19.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Oct 2020 08:19:56 -0700 (PDT)
Date:   Tue, 13 Oct 2020 23:19:51 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org, Al Grant <Al.Grant@arm.com>
Subject: Re: [PATCH v2 00/14] perf arm-spe: Refactor decoding & dumping flow
Message-ID: <20201013151951.GB24974@leoy-ThinkPad-X240s>
References: <20200929133917.9224-1-leo.yan@linaro.org>
 <20201013145332.GG1063281@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013145332.GG1063281@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Oct 13, 2020 at 11:53:32AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > Changes from v1:
> > - Heavily rewrote the patch 05 for refactoring printing strings; this
> >   is fundamental change, so adjusted the sequence for patches and moved
> >   the printing string patch ahead from patch 10 (v1) to patch 05;
> > - Changed to use GENMASK_ULL() for bits mask;
> > - Added Andre's patch 13 for dumping memory tagging;
> > - Refined patch 12 for adding sub classes for Operation packet, merged
> >   some commit log from Andre's patch, which allows commit log and code
> >   to be more clear; Added "Co-developed-by: Andre Przywara" tag to
> >   reflect this.
> 
> Ok, so I'll wait for v3, as Leo indicated he'll respin.

Yes, please hold on and I will send out patch set v3 according to
Andre's reviewing.

Thanks,
Leo
