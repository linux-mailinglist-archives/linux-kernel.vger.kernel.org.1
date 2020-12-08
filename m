Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF222D30BA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbgLHRNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbgLHRNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:13:16 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB2FC06179C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 09:12:36 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id y19so12644009lfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 09:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bnx49xFSvA7q3rgIKoEpfKZQJyDfrQ+btFsm1ai/FT0=;
        b=JihjsAonP1AKn20jbkLUY4mpmXSySX+rP2HMcmnqKhDmGRo2U3313PQR4RgwtPqJZP
         V6UfCH7fHr2bqTCNsojyQzj4uPaoXLmZwc+YVu43F6u3Kcnm6pWxSqJmf3/1ZjijAXUG
         bE9H2H1f46qcjUgGFBqR3LEHDJ/UyFKl1btIyrTnlVTAkZG+CT8p7OVML870e6dc7jpp
         CBMVZ26RvlI3XfWeZBMm/LQZ25mrvczdjXufWEWd7FLXqUafCn12+afXeyASN/++5hBJ
         nWFu4nC4C/LpRS+K93Erneo1JrUwVOsQOY7N8drsj9DMI7WLuY7fT11/iYTknFOpqrzz
         KDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnx49xFSvA7q3rgIKoEpfKZQJyDfrQ+btFsm1ai/FT0=;
        b=SCapSH6Y8OD26KNOpKNmwNCQX1Y/r4ULGSoJR8tFjPd3rirgAsPRAgKSRrA89HUZxc
         0buWpBeIFL3tseWPsRGixJmPEkt+fVawjJtRxeArxO11puAg8Lyt5Fugs4t5AesTRKyX
         oUn/RZAVLurQiJH0cZvMgZ5uIrm906tmZSGUpbO1QG9/XbZAFK2o/5WZy4MxGvwa8WBV
         Ojwzej/4SsFFmCZEkHQ1OfaY6MBQu3D0IYs65MbDY2Uj5Zsnhr9/DejKy6NI09UgG5rE
         o2jcds1plcfzI2n9tuKzcxgNTxa18/QwnAK0BsI3f34d9G6BNf5FR+7uqPu4fI1NrHjo
         cOAQ==
X-Gm-Message-State: AOAM533GjOnGD7qrrvuDK9wA7+RMZdkQheTfC9jybZkOeu2Vbz/Rr6Y3
        hpy7XGzfvWWhPKHRtFI1oKKX1IjSr+xXRjty5xyawA==
X-Google-Smtp-Source: ABdhPJxaNrPWz97bRVdzz5ZQvgE29Mdjc4AC5iEBrElK/INA22veT35CFfeLF8RTemZsCi3dm/3yxgR+JvKOisuRlKY=
X-Received: by 2002:a05:6512:1082:: with SMTP id j2mr5683700lfg.347.1607447554225;
 Tue, 08 Dec 2020 09:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20201207142204.GA18516@rlk> <CALvZod45tRyx+7VagQQ=9SqabNR5Y=f0U0T0AFtOFWdzUgJbxQ@mail.gmail.com>
 <20201208060747.GA56968@rlk>
In-Reply-To: <20201208060747.GA56968@rlk>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 8 Dec 2020 09:12:23 -0800
Message-ID: <CALvZod56cWta66q4w4ndiPmgfVGkViAFfivh8L8eUBPqJRWFCg@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: simplify kmem cgroup charge/uncharge code
To:     Hui Su <sh_def@163.com>, Michal Hocko <mhocko@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Michal Hocko

Message starts at https://lkml.kernel.org/r/20201207142204.GA18516@rlk

On Mon, Dec 7, 2020 at 10:08 PM Hui Su <sh_def@163.com> wrote:
>
> On Mon, Dec 07, 2020 at 09:28:46AM -0800, Shakeel Butt wrote:
> > On Mon, Dec 7, 2020 at 6:22 AM Hui Su <sh_def@163.com> wrote:
> >
> > The reason to keep __memcg_kmem_[un]charge_page functions is that they
> > were called in the very hot path. Can you please check the performance
> > impact of your change and if the generated code is actually same or
> > different.
>
> Hi, Shakeel:
>
> I objdump the mm/page_alloc.o and comapre them, it change the assemble code
> indeed. In fact, it change some code order, which i personally think won't have
> impact on performance. And i ran the ltp mm and conatiner test, it seems nothing
> abnormal.

Did you run the tests in a memcg? The change is behind a static key of
kmem accounting which is enabled for subcontainers.

>
> BUT i still want to check whether this change will have negative impact on
> perforance due to this change code was called in the very hot path like you
> said, AND saddly i did not find a way to quantify the impact on performance.
> Can you give me some suggestion about how to quantify the performance or some
> tool?
>

At least I think we can try with a simple page allocation in a loop
i.e. alloc_page(GFP_KERNEL_ACCOUNT). I will think of any existing
benchmark which exercises this code path.

Michal, do you have any suggestions?
