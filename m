Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C9025E502
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 04:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgIEB6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 21:58:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38104 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgIEB6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 21:58:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id g4so9223992wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 18:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7Eamq9cg981AGri1bOMIVAPIotJNeKL9IsG9QWOvJw=;
        b=sJq/lXNRrhDDqoyzBUyqJZppt+c04Mg8RUbWzYYUxiXCHZLiDIO0GeBBnMj6P7MxmF
         s5Z9Pu5AL4QoEE4Ddndbod5nTCM4pklp+wjq8sccmIfpbKkSdET22TA0hFCBF7swGlEm
         j9Kt/jZtjfXsr7cLoQu2zjFbZkImCaZIM5sr0TPIr30S1AhxJaPnow+ycjJrKbUh91XB
         vGZBFcJiEHqs2BvAYeyC6hiwhnqkd72QuOeXV8f8vWLPfJgRq5oZWoc3rD/Wj+RNo2xS
         rN6lbOreTzZfNkHFHG2WSaqQe54bGDF3axg99a6JMhe4y0uIm56ZQH07spb489lPELMo
         jIMA==
X-Gm-Message-State: AOAM530dc7SH1mG9t81AGNcuJ6tAoVTTENbvrM0/l5cuYBZYHeJZiVAN
        C5l7iDQ1BC5ieAkhgCJfYiDFyqQzGKbfv2sXJn8=
X-Google-Smtp-Source: ABdhPJwA4izuAAFtb7e8P8WgBpWJRHQFsisR7OWmsTJmySJAWPdhDZw/geYS0lsRvgU4HVJejC71prSdjeRYPDPMLeY=
X-Received: by 2002:adf:a3c9:: with SMTP id m9mr10167134wrb.80.1599271132074;
 Fri, 04 Sep 2020 18:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200904032142.516333-1-namhyung@kernel.org> <CAP-5=fXjeCBemNivMb6+9AH-PETTqTghaZHniOohd_1ms1rU2A@mail.gmail.com>
 <CAM9d7cgQAj-md=ZPKGD7iHEBYDnFqCfB1CO8moRih52MFoP6XQ@mail.gmail.com> <20200904162831.GU3495158@kernel.org>
In-Reply-To: <20200904162831.GU3495158@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 5 Sep 2020 10:58:41 +0900
Message-ID: <CAM9d7cjQWzwpcWCg7DdE3iiCM0=c0j9jZWQqgzyaET0vuoTvow@mail.gmail.com>
Subject: Re: [PATCH] perf metric: Fix some memory leaks
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Sat, Sep 5, 2020 at 1:28 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> Humm, I assume all those fixes were for csets in a single Linux version,
> right? Otherwise I think it'd be better to have a fix per Fixes tag, so
> that they would go to the kernel sources where those bugs were fixed.

$ git name-rev --tags 9afe5658a6fa8 4ea2896715e67 71b0acce78d12 b18f3e365019d
9afe5658a6fa8 tags/v5.9-rc1~66^2~135
4ea2896715e67 tags/v5.9-rc1~66^2~55
71b0acce78d12 tags/v4.15-rc1~160^2~38^2~36
b18f3e365019d tags/v4.15-rc1~160^2~38^2~37

I'll split it to two - one for v4.15 and another for v5.9.

Thanks
Namhyung
