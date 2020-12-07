Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732372D1093
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgLGMcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:32:00 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43065 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgLGMcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:32:00 -0500
Received: by mail-lj1-f193.google.com with SMTP id e7so4508954ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 04:31:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CegbQ8ICiCzl54W3L4/51QGOQ8lnKvui2ZpRWTC454E=;
        b=cneFBIVU3UmrxRGyq3slaPdFCjF3r/PQQF164qx10v7wg4laNd7xAdOB0K+Kh8tkr4
         JGeJ5s7t04AsaCd9iO02NopAC9JBkCdAxW4mtzAxuhHRYcWIuyLfS3I1ZY3DSAFtQwIO
         MOd39IzABFvKoyEDvz05xM7ZrExwjQW/eDaAniBJiXhX5jFKkEbrnaa52Y7DCi1dbXrL
         J8It3myjE62+ALJCoCoQ/JECZuz4mNwsWzXp7j4AJWVpTr7VFJSrMTckVpT9yTShi2Lv
         ix1ysMcZKL5tRBqMa4rY2QwkYLBT0U2epFJonP1nU/R5eqphtoeb4OWekEGFR9HyR6Yt
         re3A==
X-Gm-Message-State: AOAM531bbT2Qr/FZ97yi72DLR2XSd9qMzdmNiiDDiTCgk1u4Zwt48ksD
        uLx7MApeO6kR6+1kASp3a9ktkA01P4z2XsHiKY0=
X-Google-Smtp-Source: ABdhPJzaNUger+DRoF/C5Yjhv4RtYDEQzWKrvCWcC8NyTCLjixXDCaz0BBQ+htAqCzKget1+G+ACKBZ1Q6Zk0NbFZXM=
X-Received: by 2002:a2e:b013:: with SMTP id y19mr8672135ljk.50.1607344278275;
 Mon, 07 Dec 2020 04:31:18 -0800 (PST)
MIME-Version: 1.0
References: <20201206144527.1670483-1-chanho61.park@samsung.com>
 <CGME20201207105410epcas2p3f9210689886172422d27870f25a79df3@epcas2p3.samsung.com>
 <20201207105359.GA4198@willie-the-truck> <001101d6cc90$3b491310$b1db3930$@samsung.com>
In-Reply-To: <001101d6cc90$3b491310$b1db3930$@samsung.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 7 Dec 2020 21:31:06 +0900
Message-ID: <CAM9d7chU0SP79cjuZOBg1Rhe2NYaxAOnKzdQ+XQ65fenTzak0A@mail.gmail.com>
Subject: Re: [PATCH] perf arm pmu: fix build error on MUSL libc
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     Will Deacon <will@kernel.org>, Chanho Park <parkch98@gmail.com>,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Khem Raj <raj.khem@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanho,

On Mon, Dec 7, 2020 at 8:58 PM Chanho Park <chanho61.park@samsung.com> wrote:
>
> Hi Will,
>
> > Looks like other files just include this unconditionally, but have a
> > comment explaining why. See util/branch.h and util/event.h. Maybe we
> > should do the same for util/pmu.h, which is already included here?
>
> I found below files which perf includes <linux/perf_event.h>. Instead of
> doing same for all, we'd better put this only for
> tools/include/uapi/linux/perf_event.h.

It's a copy of the kernel header, I'm not sure we want to add something there.

Thanks,
Namhyung
