Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73375263C89
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 07:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgIJFjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 01:39:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35023 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgIJFjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:39:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id y15so4483853wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 22:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h28yCpMqjTx42+9sKkj9v/1Q8KRAf6Z0CfZQB2q4PMg=;
        b=qJP50gAOAWcTP3fCegsYOF0UtyZm8z6WSibih4iELyJ144MXwA3XOFO7hKKhsKK/vz
         42Er752P4TgscNDbOfEITAJV+RHYcPpMCivt7IiN4dcaVFqincaob/qgi/YY305BDdSX
         grDpKhHTbNlmETNuFIqKb5H2c7VMIXTN1peQJPkf0fs0tDLjbsEWRzSfzzlJSKJPZoFq
         HdtDOMYDyB1dvN5l4eGqxK4p3ZAmHHNhZkVOrQROkMcu9jI2GxOYdDMVNB52m449Xiha
         EYWU3d1gAfXq6ZmeCip/NUvbHNug24XvadolkUaaklbkPgPO7j3pRxF8y8hbKSvqNOzF
         y8wQ==
X-Gm-Message-State: AOAM5334pLTSBo/PWRQ/qliyOP8fLFmZ0bCJ4ViHgK900/Wz9tw0Q5En
        TGRRzKais4FKIzzuA/kvQHaQe0+pQ3JSp/7sYMg=
X-Google-Smtp-Source: ABdhPJyHxzM3qxhNqiwQaWSQKJMbTXpBMcGbCcgNgoIrQkYc5eFAhWJrFN8cAFSpiVXJ9xvf84qvPQ4RXiOxgP7NBHo=
X-Received: by 2002:a05:600c:4142:: with SMTP id h2mr6587414wmm.128.1599716349451;
 Wed, 09 Sep 2020 22:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200910032632.511566-1-irogers@google.com> <20200910032632.511566-2-irogers@google.com>
In-Reply-To: <20200910032632.511566-2-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 10 Sep 2020 14:38:58 +0900
Message-ID: <CAM9d7cjiL92Y8pCurXUpVznDUYZ8F2N0H-fSW4sPi8=M3gGSfQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] perf metricgroup: Fix typo in comment.
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 12:26 PM Ian Rogers <irogers@google.com> wrote:
>
> Add missing character.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung

> ---
>  tools/perf/util/metricgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 8831b964288f..662f4e8777d5 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -150,7 +150,7 @@ static void expr_ids__exit(struct expr_ids *ids)
>  }
>
>  /**
> - * Find a group of events in perf_evlist that correpond to those from a parsed
> + * Find a group of events in perf_evlist that correspond to those from a parsed
>   * metric expression. Note, as find_evsel_group is called in the same order as
>   * perf_evlist was constructed, metric_no_merge doesn't need to test for
>   * underfilling a group.
> --
> 2.28.0.526.ge36021eeef-goog
>
