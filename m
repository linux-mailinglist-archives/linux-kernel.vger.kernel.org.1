Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BA72C5721
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390872AbgKZOaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390058AbgKZOaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:30:07 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF7FC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:30:07 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id p6so1222598plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0L7WDn4c+lxchC+xjVq+u88V55+qxyY9D+Pl1x35ne4=;
        b=duF77mx7AcBiQorj8rajPPNE1mQuY0vlnrnIbq7LygV8HY8P3LS6vLt4GZNc7qonyb
         RtNunHNOxdIZEMRDkdNj0LjIwFuYGUp/3sxyivquhGLsGzVL6DreEAjkSfCIbsXpOVjb
         4ECMZ+wstnmf8FfXmEt6p1h6PGmJsK2Jd4W5zuVkKA7qhMNeYpIKOD4OvwqqBOSble9/
         m25hOF1D0lJxUdLF3BxTqCn3pQqbR4RftXHb5rsr7XcHLF/FxtUxatlDdqMgonxu/8zk
         nnlSnXEVHZZQJEiZZOwd7sVntj2qeC6M7bi0SE+fQqQq2Jp2fXvhUWl1TRur0FbZrE7u
         Wp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0L7WDn4c+lxchC+xjVq+u88V55+qxyY9D+Pl1x35ne4=;
        b=kLKwwEUY/YkmJhtKoLNyc9CZ36z7cZySfTJjCUXd83bKZGivb8XJRl6FMaey/bIbkK
         ttcLqtyo9ILc920jLGiYNsOL+Jqx+fyluYtXwIalIkhjLZEpWSZ0UyUEZLa93Nh76gUz
         CzUPzr6DDCc0PF90Minn+lt5XmxbOCVts7fAgGdLMkzaWLrld3QEj4e402uR4dOKBRak
         IQm7W60N+AM+m31M3j48sZ3pqEV9jjsAoE8NafjLbFO3cTqA9FJJn6L3B2LYMyiz7vvm
         ujn73tPOCP+pXu2AVMYT5WAGBS2v/dtqaDDiRsLhnXMXzRjh3txfozEgv4L5F+NGZoxf
         805g==
X-Gm-Message-State: AOAM530ME+XS2AzZdsJuQlGCjvhvOlthaWkwG9+qkDTILkupcYVf0kho
        aNRW8MhQVXOtJJuN6rdDcJNAOQ==
X-Google-Smtp-Source: ABdhPJws1koU2wzA490BqEvWmOoxJ7N/uu2MChvTbLjLIuJJCGztd2pi5pn2uouo12a7rEX9BCqXrw==
X-Received: by 2002:a17:902:6b07:b029:da:138c:7622 with SMTP id o7-20020a1709026b07b02900da138c7622mr3044447plk.16.1606401007190;
        Thu, 26 Nov 2020 06:30:07 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.127.239.100])
        by smtp.gmail.com with ESMTPSA id x16sm6565012pjh.39.2020.11.26.06.30.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Nov 2020 06:30:06 -0800 (PST)
Date:   Thu, 26 Nov 2020 22:30:00 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 00/16] perf arm-spe: Refactor decoding & dumping flow
Message-ID: <20201126143000.GA27722@leoy-ThinkPad-X240s>
References: <20201119152441.6972-1-leo.yan@linaro.org>
 <20201125141755.GB16159@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125141755.GB16159@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 02:17:56PM +0000, Will Deacon wrote:
> On Thu, Nov 19, 2020 at 11:24:25PM +0800, Leo Yan wrote:
> > This is patch set v9 for refactoring Arm SPE trace decoding and dumping.

[...]

> > I also manually built the patches for arm/arm64/x86_64 and verfied
> > every single patch can build successfully.
> 
> I'm unable to test this, so I'm please that you can! Anyway, it all looks
> fine from a quick look:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> so I think Arnaldo can pick this up when he's ready.

Thanks for review, Will.

I will consider to enable automatic method (e.g. using container) for
the cross compilation perf tool with new patches.

Thanks,
Leo
