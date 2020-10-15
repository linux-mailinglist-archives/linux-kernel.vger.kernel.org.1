Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0080E28F59E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389600AbgJOPOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388086AbgJOPOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:14:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186DBC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 08:14:35 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h4so2267098pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YHjNIfrhyoCm/Psk4GioZy8dQ3akvQVb9fMjKdutGnY=;
        b=ynM3Ho9gDDAnvcIuzIadIV7Wt+RtcpmfjDdBOWj5dK4EbcIQbrxgUBmV1gxyyGW2E1
         cZPQvkON/ulqjMOIJ2yqPAOpNVb2cOW633CC1FqcZli+pKQp4Fr64KeF/0XtZZndioBY
         rO+eh2cwnP9k0QL8PxP5hbB0WNsHDYGNrnhXLbgjKHqP4/EiaNDMibpYgbnZ6mdleLcz
         KP9EkAdqVfLdeNnqfy/mV4eioox09dfqyF7vvJmLWmysAi71gNbkhWmLc6DS8auSJ5gK
         mNd4CmIRg2urd6qiaG9Cr+tmG330eZ48AbHc20pxVujx+Wx1NzHA5L3r92eJTHMro4Cb
         M6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YHjNIfrhyoCm/Psk4GioZy8dQ3akvQVb9fMjKdutGnY=;
        b=nP1RjzG8J4Ilh6tKW15fYb8RCarqiTKbUnot4NTQD8lu5hzJD5Ulft0WXtYPlBoYlH
         0OM9u934RtTfnOy1AW3UkUm7aNDqtIomENa3OITmnhTdBdvebOsI/fFXs/zm49FWT7Y1
         k1si2xlvmwobVm3p24wudDrRT4N0vuCgf+3Bv5uxs0PDiul5zyS1nnHvykohWXH7AL02
         H//ie5wvDSSsxCKK6nE0bmDuXYN0/WLKqIIu0sRgShVanmt0PSMByH5QB8vMyhqyyJ7i
         u4pbwLFvAIquNbvUNejR6L3KDvP/ghxLLyQ3S9Cpn3NwRD+UF0y8Vb9S0V/3O6Jt1f98
         McJw==
X-Gm-Message-State: AOAM531fg6iw8D4NoIzZGTx+WlrTZW4sm+XQZTOkNOLBskx1HsdgkBJE
        FeCK9mx9znMieb4f/bBpCwWWRQ==
X-Google-Smtp-Source: ABdhPJwhZWgwoufWc6ZN7F18b3ffDiL15T+aOGRaEyHDwKe2kDYwUQ1LrVmnIKMgvv0HB6AuYY37SA==
X-Received: by 2002:a17:90a:4b84:: with SMTP id i4mr4588788pjh.132.1602774874507;
        Thu, 15 Oct 2020 08:14:34 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id u69sm3823612pfc.27.2020.10.15.08.14.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Oct 2020 08:14:33 -0700 (PDT)
Date:   Thu, 15 Oct 2020 23:14:27 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/8] perf c2c: Sort cacheline with LLC load
Message-ID: <20201015151427.GC462@leoy-ThinkPad-X240s>
References: <20201015145041.10953-1-leo.yan@linaro.org>
 <20201015150506.GB2959014@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015150506.GB2959014@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 12:05:06PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Oct 15, 2020 at 03:50:33PM +0100, Leo Yan escreveu:
> > If the memory event doesn't contain HITM tag (like Arm SPE), it cannot
> > rely on HITM display to report cache false sharing.  Alternatively, we
> > can use the LLC access and multi-threads info to locate the potential
> > false sharing's data address, and if we connect with source code and
> > analyze the multi-threads' execution timing, if can conclude load and
> > store the same cache line at the meantime, thus this can be helpful for
> > resolve the cache false sharing issue.
> > 
> > This patch set is to enable the display with sorting on LLC load
> > accesses; it adds dimensions for total LLC hit and LLC load accesses,
> > and these dimensions are used for shared cache line table and pareto.
> > 
> > This patch set is dependend on the patch set "perf c2c: Refine the
> > organization of metrics" [1].
> > 
> > [1] https://lore.kernel.org/patchwork/cover/1321499/
> 
> Ok, that one is applied and will appear publicly as soon as it goes thru
> my usual set of build tests.

Thank you, Arnaldo!

Leo
