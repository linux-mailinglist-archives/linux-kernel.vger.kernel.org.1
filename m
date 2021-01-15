Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8432F88C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbhAOWrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 17:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbhAOWrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:47:42 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D3EC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:47:02 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cq1so5886980pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JScurv9s+g/j4cSgsjSfeApqRxZJVnspOC9oDDMdzV8=;
        b=QIYx26ideOsBXsSY4n1u+JFURQ+CW4hUm/VKt7rCaz66a7+EuABzbDsJpmuYribIr1
         hpYawTby4rQkczz+szEfDnaKwsmFE15Mulm0O5lmQFiyzfPIDfXMzDHDtOIJvVWajEvs
         4GUi2m1XJFwEqpuJHwty+GD0mlo6lLUj5QNR71lqJXeVokiIQPvS9WdBulPAJN8Azy0G
         6fN8D9XgNFqfyZmSYEzQHtKEmlDDWS5J3FwYUwhnjzWYVURe8d1u+Dngq4/BZ7QE76IR
         17reMI+/p0wR8eVk7kou+m8DA69KTwszMp8sUyaG52kKG4Oaju2vgUBH6YJqWszgHFRR
         X80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JScurv9s+g/j4cSgsjSfeApqRxZJVnspOC9oDDMdzV8=;
        b=WXCPZl4ITceD9ylVBGUAo/RcJt7lFALG85pZ5iUWCpPRY4KRJF5c1u6J5TVpPu7aOW
         Od+hsfCMIOJ+3DG9z30KEYMzoJsbTA99W2fBJakyq3Vy3qwTcoTTvEykWRMR6KJiz0EU
         1Z/FpflYYyKVwu6Pb7qMS7gSt5MLsV6YMbDFLvOyYfSTF5EPJwdSkIDOrWqbriWP7YXQ
         zjjH8ZygGF5LaVb0Vw9vjqqzXAEP3Xj0L2/gtjwiw0DMfndYw1TRJSK7OCiJueXc0YaX
         wk6xdK9R/b6BHRSQTMcQURkitpTFwc7deU8yKZlfvBaiI1Zbo8Hz62nM1UqDXBRblmfM
         ruCA==
X-Gm-Message-State: AOAM531qvHLTrKff+FZO30CnFRt5fJGrR9vt33/rOb5DwlN4UCjB0TJV
        X+3iXqBRnZ4RxDpKJN80lLC5eQ==
X-Google-Smtp-Source: ABdhPJxbrXCZ8HcfuarcaDF09II/yNwXUL3lpJaE3INuF0u61UTDLSj51c/bjftnpZEXklfRZ4xprw==
X-Received: by 2002:a17:90a:a88e:: with SMTP id h14mr12649790pjq.59.1610750821674;
        Fri, 15 Jan 2021 14:47:01 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id l197sm9165931pfd.97.2021.01.15.14.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 14:47:00 -0800 (PST)
Date:   Fri, 15 Jan 2021 15:46:58 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/7] perf cs-etm: Calculate per CPU metadata array size
Message-ID: <20210115224658.GC375055@xps15>
References: <20210109074435.626855-1-leo.yan@linaro.org>
 <20210109074435.626855-4-leo.yan@linaro.org>
 <96ec434e-4103-02ac-a05a-761a9ca8cb0d@arm.com>
 <CAJ9a7VjtUuRRYBBu63kSXKwrGdB8ZoWJz-bE1g9tMLSbkFVDGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VjtUuRRYBBu63kSXKwrGdB8ZoWJz-bE1g9tMLSbkFVDGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 12:09:12PM +0000, Mike Leach wrote:
> Hi Leo,
> 
> I think there is an issue here in that your modification assumes that
> all cpus in the system are of the same ETM type. The original routine
> allowed for differing ETM types, thus differing cpu ETM field lengths
> between ETMv4 / ETMv3, the field size was used after the relevant
> magic number for the cpu ETM was read.
> 
> You have replaced two different sizes - with a single calculated size.

I usually go through an entire patchset before looking at the comments people
have made.  In this case Mike and I are coming to the exact same conclusion.

I will look at Mike's patch on Monday.

> 
> Moving forwards we are seeing the newer FEAT_ETE protocol drivers
> appearing on the list, which will ultimately need a new metadata
> structure.
> 
> We have had discussions within ARM regarding the changing of the
> format to be more self describing - which should probably be opened
> out to the CS mailing list.
> 
> Regards
> 
> Mike
> 
> 
> On Mon, 11 Jan 2021 at 07:29, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >
> > On 1/9/21 7:44 AM, Leo Yan wrote:
> > > The metadata array can be extended over time and the tool, if using the
> > > predefined macro (like CS_ETMV4_PRIV_MAX for ETMv4) as metadata array
> > > size to copy data, it can cause compatible issue within different
> > > versions of perf tool.
> > >
> > > E.g. we recorded a data file with an old version tool, afterwards if
> > > use the new version perf tool to parse the file, since the metadata
> > > array has been extended and the macro CS_ETMV4_PRIV_MAX has been
> > > altered, if use it to parse the perf data with old format, this will
> > > lead to mismatch.
> > >
> > > To maintain backward compatibility, this patch calculates per CPU
> > > metadata array size on the runtime, the calculation is based on the
> > > info stored in the data file so that it's reliable.
> > >
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> >
> > Looks good to me.
> >
> > Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >
> 
> 
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
