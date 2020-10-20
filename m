Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D40C293687
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 10:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbgJTIOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 04:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387535AbgJTIOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 04:14:39 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB92C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:14:39 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p11so625376pld.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AFcda7odfwIZRJuvG5/lff365X7of50KQS00c7xL62M=;
        b=lYlNHSoBH+9JCTy1oF/Nvg3QjMqJKkS0Y0Wg5/hEI7JGHvnMxWb3fO3AQzVZITZ5iV
         QiRtOe9z566LUsqKPo5YCIg+9L0dJj1mIdfdLWp9G7SJG4ACW2HJREI7QouUiT+2b0tV
         +nhNVd+wOhdokwAbNEU127DDdZIhneVoQRbbreLCcWZCLolU8U7obang7SiyD/1/iJ5g
         oRytI5jMU6DDgge4f46zcPqlNpVvMfWQEsYh1TkaD1qBkBWol6KKOY2LfXvFXHsY9aDb
         1pzu/a6U/v7hMtp3pY17GVvuYO9rv7hXxi39Snc3w3Hafun+c+pIUDcFQ1p2PgMYRXqU
         iUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AFcda7odfwIZRJuvG5/lff365X7of50KQS00c7xL62M=;
        b=Obx/A8/TUnm6V6RBZOqStAqXY7AEjb+/5o3o3aYpLp5qEjZvimL4v6eMBiCc8xBzp1
         DmHssDsZdq+160lsjewKka16FxevMYKT0o2jAaCPR3YraSkqILJZgtv8hNm6F+2Dx1Cm
         35cUzhPDhHAcrh5oS2qwj72PWwxKh0SURSk0PT7X4sbwAiJM5QpAx/3npPBSAgEnh4iH
         5meSsJSJGKuIiS5StJhg2bX1wUS7u8BBGvzwXVfYPh0wZPRHd2d4I3BJzS/tysEMg/fI
         W3tiWhokff1518BFR79WoYTfg4OJsEExjQ7Mj+psr2QH8r7q6aDYbJ2F6k0oPYwIk7GN
         d80A==
X-Gm-Message-State: AOAM533uLmV/CIqIBPgIhUBjwDdnyrQT1EZ8dlr/82uJP3YPwfamx8Cg
        gLf4565EbUBfXTVhw9J/HZrfP+4+Rp/tPpmQn8Y=
X-Google-Smtp-Source: ABdhPJy8A9Hz0zH9f3HSDE6WuZzp5z+XAhZFDKStme3Qn7v9MuY3fe+ZqKzI8kv7vBrFKCGbt+Z+LQ==
X-Received: by 2002:a17:90b:19c9:: with SMTP id nm9mr1802606pjb.6.1603181678759;
        Tue, 20 Oct 2020 01:14:38 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id c17sm1404415pfj.220.2020.10.20.01.14.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Oct 2020 01:14:38 -0700 (PDT)
Date:   Tue, 20 Oct 2020 16:14:32 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 7/8] perf c2c: Add option '-d llc' for sorting with
 LLC load
Message-ID: <20201020081432.GD13630@leoy-ThinkPad-X240s>
References: <20201015145041.10953-1-leo.yan@linaro.org>
 <20201015145041.10953-8-leo.yan@linaro.org>
 <20201020072603.GD2084117@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201020072603.GD2084117@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 09:26:03AM +0200, Jiri Olsa wrote:
> On Thu, Oct 15, 2020 at 03:50:40PM +0100, Leo Yan wrote:
> > Except the existed three display options 'tot', 'rmt', 'lcl', this patch
> > adds option 'llc' so that can sort on LLC load metrics.  The new
> > introduced option can work as a choice if the memory event doesn't
> > contain HITM tags.
> > 
> > For the display with option 'llc', both the "Shared Data Cache Line
> > Table" and "Shared Cache Line Distribution Pareto" have difference
> > comparing to other three display options.
> > 
> > For the "Shared Data Cache Line Table", instead of sorting HITM metrics,
> > it sorts with the LLC hit metrics "tot_llchit".  In this case, users
> > should be interested in LLC related statistics, so the dimensions of
> > total LLC hit is used to replace HITM related dimensions.
> > 
> > For Pareto, every single cache line shows the metrics "cl_llc_hit"
> > instead of "cl_rmt_hitm", and the single cache line view is sorted by
> > metrics "tot_llchit".
> 
> hi,
> I'm getting compilation error on newer gcc:
> 
>   CC       builtin-c2c.o
> builtin-c2c.c: In function ‘perf_c2c__report’:
> builtin-c2c.c:1979:9: error: ‘sort_str’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>  1979 |  return hpp_list__parse(&c2c_hists->list, output, sort);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> builtin-c2c.c:2900:27: note: ‘sort_str’ was declared here
>  2900 |  const char *output_str, *sort_str;
>       |                           ^~~~~~~~

Sorry for this building error.  I didn't detect this error on both
Arm64 and x86;  will fix it.

Thanks,
Leo
