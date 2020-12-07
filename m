Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92A42D11D6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgLGNYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:24:53 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33333 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgLGNYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:24:53 -0500
Received: by mail-lf1-f68.google.com with SMTP id l11so18087221lfg.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 05:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBUhwvqwvpW0vRUzhuMp0u9o06yENhFCHO1qvqSQG6w=;
        b=Jul7YYstbqd+tySXduyahIC8OdNO5XqjhFtq6Qqfa5591NG0rqAC8z27kUS/ebTuiE
         O/1q34zfEokFo4RzL8L8rqRXcI9oTUBULJDShVcAlUIy0nfLe/Xnruw/HoSwCL9QV0+J
         zFLbjr8e2Xrdpp1c6V8FBzL36rofmco6SXHVchxdz/G4c/rU2UaMTf+Y/geqlXZ2tvQI
         XbrwgKP2835+voTGIBRpZHISzmPbogtfAK9sm0qtsia8CD6iq5HbmWpVPigaucQRZiRP
         Sfaf+XPNVhEhMLBUyk4X9fXcKdt3Key6bMPw3GHQPUC+TP55dvNeWm43L01VwT7hU6JI
         ZYYg==
X-Gm-Message-State: AOAM530DWjBpl1N+k3Bo7jFimKPrHAKto5ipW+mu0mWFpGoTBSuHgrsi
        8xRSona4HwIareSUBBZu9rvXKN8fQBvLZNHXYwk=
X-Google-Smtp-Source: ABdhPJyVOREkF08IbKeQt0xhbgoHY9Ir9e5MjrQM8BkySBg8eM2pCWFBmc8IdTrCYyI3R8SpwxGRO9KBdrfhoomP6q8=
X-Received: by 2002:a05:6512:3587:: with SMTP id m7mr8469321lfr.149.1607347450778;
 Mon, 07 Dec 2020 05:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20201202073953.3811709-1-irogers@google.com> <20201202073953.3811709-5-irogers@google.com>
In-Reply-To: <20201202073953.3811709-5-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 7 Dec 2020 22:23:59 +0900
Message-ID: <CAM9d7ciWzaqP2i=Agx9JxGCw4C3gQ=UUW+cMwWvAPjecd6C2=Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] perf metric: Add utilities to work on ids map.
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 4:40 PM Ian Rogers <irogers@google.com> wrote:
>
> Add utilities to new/free an ids hashmap, as well as to union. Add
> testing of the union. Unioning hashmaps will be used when parsing the
> metric, if a value is known then the hashmap is unnecessary, otherwise
> we need to union together all the event ids to compute their values for
> reporting.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
[SNIP]

What about adding a comment that it should not access ids1 and ids2
after this function since they can be released?

> +struct hashmap *ids__union(struct hashmap *ids1, struct hashmap *ids2)
> +{
> +       size_t bkt;
> +       struct hashmap_entry *cur;
> +       int ret;
> +       struct expr_id_data *old_data = NULL;
> +       char *old_key = NULL;
> +
> +       if (!ids1)
> +               return ids2;
> +
> +       if (!ids2)
> +               return ids1;
> +
> +       if (hashmap__size(ids1) <  hashmap__size(ids2)) {
> +               struct hashmap *tmp = ids1;
> +
> +               ids1 = ids2;
> +               ids2 = tmp;
> +       }
> +       hashmap__for_each_entry(ids2, cur, bkt) {
> +               ret = hashmap__set(ids1, cur->key, cur->value,
> +                               (const void **)&old_key, (void **)&old_data);
> +               free(old_key);
> +               free(old_data);
> +
> +               if (ret)
> +                       break;
> +       }
> +       hashmap__free(ids2);
> +       return ids1;
> +}
