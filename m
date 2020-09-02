Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF14D25B28D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 19:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgIBRB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 13:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbgIBRBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:01:21 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05EB22067C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 17:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599066081;
        bh=6yjT6ZS10fnUtMjwA1XoU0GbCjkDXFW9ulJCCRleHBg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tV+cRHio9GEkX3cFlV9edDeKrgG/+hSDla9vqa/9y7DEVjDg7tnb2/sKclUk+9kYu
         D83q4IyuZAsAoQl2yYWBKLpMwlB2/I3XncYmX61CfhZ4aRGp4/eXCetHgh8YEqnH3I
         SHnGsxOFnLYTNKK1PpYa/lHU9u2NQC8POJronUQY=
Received: by mail-oo1-f41.google.com with SMTP id t3so8361ook.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 10:01:20 -0700 (PDT)
X-Gm-Message-State: AOAM532tcLeUhRMdIUIPoKUiAJL4JAyYqcIhYTvpr/dK96vnMPOjLMHG
        iAcpYdU9dEu7ZAC+9wOuIcfJsOdW3TGFu4OlfA==
X-Google-Smtp-Source: ABdhPJzK5jTbvl0c7p1sZ69fDsi7r4M753KwPlZdnWZiWPquW8zuxSc64CDXsQfWGzK4afcJbbpXrjyZ8F9xwoPukrc=
X-Received: by 2002:a4a:d306:: with SMTP id g6mr6219822oos.25.1599066080326;
 Wed, 02 Sep 2020 10:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200828205614.3391252-1-robh@kernel.org> <20200828205614.3391252-6-robh@kernel.org>
 <20200831091134.GC406859@krava>
In-Reply-To: <20200831091134.GC406859@krava>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 2 Sep 2020 11:01:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLcDm-WZdByr4AYJMGD1pZ_+8RUgRvpjLhMvEgrTbq_sA@mail.gmail.com>
Message-ID: <CAL_JsqLcDm-WZdByr4AYJMGD1pZ_+8RUgRvpjLhMvEgrTbq_sA@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] libperf: Add support for user space counter access
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 3:11 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Aug 28, 2020 at 02:56:10PM -0600, Rob Herring wrote:
>
> SNIP
>
> >
> > +void *perf_evsel__mmap(struct perf_evsel *evsel)
> > +{
> > +     int ret;
> > +     struct perf_mmap *map;
> > +     struct perf_mmap_param mp = {
> > +             .mask = -1,
> > +             .prot = PROT_READ | PROT_WRITE,
> > +     };
> > +
> > +     if (FD(evsel, 0, 0) < 0)
> > +             return NULL;
> > +
> > +     map = zalloc(sizeof(*map));
> > +     if (!map)
> > +             return NULL;
> > +
> > +     perf_mmap__init(map, NULL, false, NULL);
> > +
> > +     ret = perf_mmap__mmap(map, &mp, FD(evsel, 0, 0), 0);
> > +     if (ret) {
> > +             free(map);
> > +             return NULL;
> > +     }
> > +
> > +     evsel->mmap = map;
> > +     return map->base;
> > +}
>
> so this only maps first page, I think we should use different
> name and keep perf_evsel__mmap for some generic map with size
>
> perf_evsel__mmap_user
> perf_evsel__mmap_zero
> ...?
>
> not sure.. or we could add size argument

Adding a size arg is simple enough to do and saves the hard naming problem. :)

Rob
