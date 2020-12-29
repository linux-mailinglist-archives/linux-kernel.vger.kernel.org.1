Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02172E6D00
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 02:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgL2B1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 20:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgL2B1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 20:27:21 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D53FC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 17:26:41 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n7so8352421pgg.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 17:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ufSrrzh41Q077QMWsqy7ZP1R6UiY9n6LliaxG/kwQc8=;
        b=In9/PG+TbzdgDmZV2Pvl9pmxWw/ArC+yoMKYd6wIkDufMvYnHCRwFkT1QVFBRxLUKg
         mtUZ8vlGFNE+j/6bZ0EupzqvUjxphJyUy+KmgrDDQDmxVn7otuHGFN3QGV06DzbFGXPs
         Z8mCI+GvFpBmH0F58RLl5djbxrlaBKZni2VoG7Nevx+vTmdkMiw5BWz4LV5jjMctgHlO
         x/cXOBSsBKzPCAtEY1UgKg6D0QhoiyTf4HrkQnMo4rJ5ADPZZiX8sNK15GdDJ8skwLwW
         EueLH5QkqhiK1RHwTQEvaeoFL4pd/01lZvmb/fmB770LXnPtZtBbGk30ktTTH0hAiJH+
         fsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ufSrrzh41Q077QMWsqy7ZP1R6UiY9n6LliaxG/kwQc8=;
        b=kPiY0eV8HCSYVGdi0QimrtB13+ObGlaQIllNQ/Bxc3Q39xUfowpJNbLhClbmeGWJQ7
         xTd3Wvyt4AcnPIjR2uqb9yE2hO9BsY7lU4gtZizpFQBcmQfpANCfXrQZoQBS5MTv9Tl9
         2hPyeMafpLLZH7psze53ym4eV+bGru794jCJPfY/Sj2NEJeaVXMY/+ECEYeM29kE1Y06
         eZNQfMglrsrihRsfmYSZP33faQu5+PbUXkS5gOWutCdQsAc3OpcWpokc8TbEKL4yJTwR
         9zSq6mWx3vuOUFf1a9fQFijH2/qDkXTR6zX/z3bEq1/8uPR9ZvGbQbBT1GWhXguPNtpo
         Motg==
X-Gm-Message-State: AOAM530jDcvLBVDaKJuLb261HTlZqxvheGcepCVEAutB7uzXlKEeJRCI
        ESzai+pxib1Qk1WLOyMrjmOkHA==
X-Google-Smtp-Source: ABdhPJzWSNweqKbidm5ydK5L4niqIET7u5o/5r4LGAgUwBK8QtTInRpyJ4jsLFPIoU7daQRzHqPROA==
X-Received: by 2002:a63:6e45:: with SMTP id j66mr46499142pgc.238.1609205200761;
        Mon, 28 Dec 2020 17:26:40 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id js9sm1382769pjb.2.2020.12.28.17.26.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Dec 2020 17:26:40 -0800 (PST)
Date:   Tue, 29 Dec 2020 09:26:31 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Ian Rogers <irogers@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        He Zhe <zhe.he@windriver.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] perf arm64: Support SDT
Message-ID: <20201229012630.GB28115@leoy-ThinkPad-X240s>
References: <20201225052751.24513-1-leo.yan@linaro.org>
 <20201228125443.GA521329@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228125443.GA521329@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 09:54:43AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> This one made it into 5.11
>  
> > Arnaldo Carvalho de Melo (1):
> >   perf probe: Fix memory leak in synthesize_sdt_probe_command()
>  
> These were now merged in perf/core.
> 
> > Leo Yan (2):
> >   perf probe: Fixup Arm64 SDT arguments
> >   perf arm64: Add argument support for SDT

Thanks, Arnaldo.
