Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FE1277050
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgIXLvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgIXLvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:51:20 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF794C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:51:19 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v12so3281503wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nij/PwpDmOmT8ZNid9jsa0R9PGd/GWpm5CA06AHzYf4=;
        b=SEHt+4r+uPCHQpoZa/Wbn4JwJBSFVkrIFW139zERL2KF/6JpJAF5lRt7+N1EysT/iN
         niB5CjfsARk+gfXnaB2TvNCzRB4Wc3m+ZvntPTGABL+1t1u2mF4xhVI5XyXYrOccAQJz
         gfjKX40SuCMCiJfICb/17Umi1fMUZMDUkPu79gs2vkP0lq0gmwffKcM5qsa7OEvASS54
         eMA4+9SxY59rYTA0XWghxFjfyJPhyn3CHBB9niU5lfWQdRzZvzqHsPpPloqHerpHvYnL
         f/rX1q4KIIRLTnZ3d4VKoWlVtdeupXofNnqeyO5WXTmUsxprek6SQtluGC2JKDfW5Nox
         p0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nij/PwpDmOmT8ZNid9jsa0R9PGd/GWpm5CA06AHzYf4=;
        b=nv2I/HkkYcxd8fWXRxaeKOt4GnLwZNSbz2Nvaelcsx/JCXkodVZ2THd3QE0nDRXBt4
         vUAQ27kF/puUVEI0w2gJ19NUkAMKUJRQhAdnLHkZKagom8ivhaNFcQIdQRfkM5CH6y/B
         EM9vtgZ+8MFpFShHBqujtQRRVBRMViceOxhp0Eu2gcBk+Ih8ujPJJLRmfcJcM6vdWE/l
         ytbqC3M45+TRk8PQsW1TbUbeHF6XIheVc22zMFg/kFkdHQwcRkCz1Qq91exad3t1jrtn
         8husD/XmaV26/7uNySUWEhbLTAsqEGBzZx5n+jzj16JibSUP10ALzjXkOOLWUYLylMFe
         qv1Q==
X-Gm-Message-State: AOAM530OL5Gj+PfwfAKfzVn0vwFvpEqevE64MQQZx6/NTCh552kXBArR
        7XMStk/ZongZyOSdYstiDOtxYqmHfWfn24Xz1/eKiw==
X-Google-Smtp-Source: ABdhPJzhCBlSEE0jw1TCHf+qnnbesb/CWE0fF5+AkItRm0YPwcMYCFojXDQZzsK/GxCD5hnF+OWFGiKk5hx8YvgG8D4=
X-Received: by 2002:a1c:b388:: with SMTP id c130mr4322495wmf.175.1600948278294;
 Thu, 24 Sep 2020 04:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200924040152.30851-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20200924040152.30851-1-walter-zh.wu@mediatek.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 24 Sep 2020 13:51:07 +0200
Message-ID: <CAG_fn=U_dshqBB8HBhGyYnn_vScTOcLJX=mfU+8Wi5wjZL2oYA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] kasan: add workqueue and timer stack for generic KASAN
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> ---
> Documentation/dev-tools/kasan.rst |  5 +++--
> kernel/time/timer.c               |  3 +++
> kernel/workqueue.c                |  3 +++
> lib/test_kasan_module.c           | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> mm/kasan/report.c                 |  4 ++--
> 5 files changed, 66 insertions(+), 4 deletions(-)

While at it, can you remove a mention of call_rcu() from the
kasan_record_aux_stack() implementation, as it is no more
RCU-specific?
