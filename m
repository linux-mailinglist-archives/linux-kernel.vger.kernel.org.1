Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C221C2F8A12
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 01:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbhAPAvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 19:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbhAPAvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 19:51:49 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794DBC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 16:51:09 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id h10so6550133pfo.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 16:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ewFYxtYqPNzg40mZBd2AGRSAZFUjPc2qJGU6EIbYFbk=;
        b=Rog7Hfpy0pXP7D9eH7CFOkTZWlpSYobXdMpzim/AvTmeEAK644nGkmDhjBpwJ6VijO
         Rk9UDldD1GDcD/pMbMF/oBKpcBlQg5513muIYpyEfrjEQ56ojwX2VaoTdfNpYPT4/ljZ
         TbX5PCxlY23BsnE25htdmmfpHsthaSWsRQmsedoHMpUTAPnAgkACx6yEC4ILdWZF7v5L
         5U5O8UXtn2dglxyeK5kBG/4cb/9YRY1uKnnOIiUFQhaum2Ziv0VtqreQE/AUfKynwegd
         P7N8FdaNmjmhpwPtHrGjJn2MDE2JMaFt80nqoFx4J0ZO/vytGr3Ze8wC2kxZWXESO/hG
         +1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ewFYxtYqPNzg40mZBd2AGRSAZFUjPc2qJGU6EIbYFbk=;
        b=EI0VpO4fjHyFTHHVvYcLHIGVnVb3Ak9IIHkP/Yi6bkGFH/pwzvrfDaapFh87YCt+Bc
         a5M7hKZFMUp90QkP436/uHQ0dC7BqKkIQng+aDZcepw2dOFA38oGoNBVR58z8P/Nt+FZ
         ODOeSenOJzHCNh53RK/QoF1ewZPK9Q7EBHvR5RxOrEeCGmoo5KXH5RMzVjlEGji0N/AW
         A1mbR/b4LX2raG9Ra2dHIxjcd7oZPqUwzMMU0TFE7wuLVyfSvPshQEjQilE3gt8Bke+Y
         f4FKWylpBxNHt42sGjbqxg328EuXZFtrEP0vbAYhehAoitwaFpkhnCCjQN/VKS93t8rr
         WEeQ==
X-Gm-Message-State: AOAM5339SHpCF5bC6A05+9vH3V4mJ/Wj0La+3QPh0Agbo/wu2JgjwRft
        IFjNQoj3vxmTCmQNan3pVhDB5g==
X-Google-Smtp-Source: ABdhPJw3wAHlVjBdHOhDOvq8ZnBqcG/OrKvEEmnyJueNo8Dju6G+4cLk1irhR3gxapaiPg2Hogsdeg==
X-Received: by 2002:a63:1c13:: with SMTP id c19mr15034301pgc.359.1610758269076;
        Fri, 15 Jan 2021 16:51:09 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id c24sm9097502pgi.71.2021.01.15.16.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 16:51:08 -0800 (PST)
Date:   Sat, 16 Jan 2021 08:50:46 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
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
Message-ID: <20210116005046.GB5418@leoy-ThinkPad-X240s>
References: <20210109074435.626855-1-leo.yan@linaro.org>
 <20210109074435.626855-4-leo.yan@linaro.org>
 <96ec434e-4103-02ac-a05a-761a9ca8cb0d@arm.com>
 <CAJ9a7VjtUuRRYBBu63kSXKwrGdB8ZoWJz-bE1g9tMLSbkFVDGg@mail.gmail.com>
 <20210115224658.GC375055@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115224658.GC375055@xps15>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Fri, Jan 15, 2021 at 03:46:58PM -0700, Mathieu Poirier wrote:
> On Mon, Jan 11, 2021 at 12:09:12PM +0000, Mike Leach wrote:
> > Hi Leo,
> > 
> > I think there is an issue here in that your modification assumes that
> > all cpus in the system are of the same ETM type. The original routine
> > allowed for differing ETM types, thus differing cpu ETM field lengths
> > between ETMv4 / ETMv3, the field size was used after the relevant
> > magic number for the cpu ETM was read.
> > 
> > You have replaced two different sizes - with a single calculated size.
> 
> I usually go through an entire patchset before looking at the comments people
> have made.  In this case Mike and I are coming to the exact same conclusion.

Agreed, now this work depends on Mike's patch for extending metadata
version; otherwise if without Mike's patch, it will cause compability
issue.

> I will look at Mike's patch on Monday.

Cool!

Thanks for review,
Leo
