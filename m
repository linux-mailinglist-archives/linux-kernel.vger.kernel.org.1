Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521772ECBBD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 09:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbhAGI22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 03:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbhAGI2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 03:28:25 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F807C0612FE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 00:27:16 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 23so12646364lfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 00:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l690XN5TZWtKSPCjHwhvoVvMjHxWHQ7pwZ5Jd08fsFY=;
        b=dV+Tuusb7E7Yqr7fLGv44TNbCL67UDmlpS/QdSuBQ8OZnaO5qfQpAjNrtsTNsYgXIK
         6BrdwNNzofeju+4zhU3IpZnhItc6mWLLZJ1aBZT7I6JGAOLleVHO0tiDhEvIL8iH/oIA
         p+J3jMzJqfDZFB0jFe1GHJd9HI1eB49C8dkij5A/sEDffnHaHxgptuIC/b18Uba9jWTD
         Yv/jJfsytp5x3D1JphFPK6KPsD4gStxL+8M9M8xonzxbia2OPFhXTrxxNQ4uEALz+uMu
         nnhOm01fjolMAoJgQmVQ7E0mPIHSTpVWwC8IqV2E97qygorKcPDCGwu1OOeux6aY5KVu
         4S/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l690XN5TZWtKSPCjHwhvoVvMjHxWHQ7pwZ5Jd08fsFY=;
        b=jMAmkXy4bMyVcDN5oFpHTIVnCzumqJ7AMrUiEWiRmxYfChyg0Ogm95OvfzP15r50tQ
         5q7F8cEisPyGc1mexLqET+9imsytY7Kd6Znu+jOQKflHpSRn+1gIgO68rQDVLUtebDSJ
         yFSc+WrJxBOLr9OQYQbArW0ZKwWyczBoSr+VkGi7dw8bdb2vHE3tLGBB4gFa614Hy7fB
         Wg2oXYgssg94QxU8x7BB+4q2Ns0TIko9gjKuSFUl8C0PLDw8YKg58bV3cjsEyZMTsNOu
         IYcXbttRf68HSgrTQHOkTx/jhVeGwG20piNirotqj/v1Wg6vTK5pu2pGQLsk5ZuVZvXn
         yD5g==
X-Gm-Message-State: AOAM531mXg9mCtG6qsyxc7N/EZKa7um5qvMXP0IRYOLCAFOqmTMX5Fl9
        qyhAfzTxPSgd0wca1YJQspisVzLcz2n7+/GIjzk5mA==
X-Google-Smtp-Source: ABdhPJws8tIhskSL7AY+UM7Guk7kFAT1zqkcsDQlU1/hgiXcZjKBbjCETB+YXDNsXXJKmq3r0pIqaUyjbGQtp3y9uV0=
X-Received: by 2002:a19:2d0a:: with SMTP id k10mr3770872lfj.286.1610008035054;
 Thu, 07 Jan 2021 00:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20210107015726.54362-1-qianjun.kernel@gmail.com>
In-Reply-To: <20210107015726.54362-1-qianjun.kernel@gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 7 Jan 2021 09:27:04 +0100
Message-ID: <CAKfTPtDWVoSsXL6Zh6ZNW7eeHsoZxVBHa2fkY7rNm1mA-tbyXg@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/fair:Avoid unnecessary assignment to cfs_rq->on_list
To:     qianjun.kernel@gmail.com
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jan 2021 at 02:57, <qianjun.kernel@gmail.com> wrote:
>
> From: jun qian <qianjun.kernel@gmail.com>
>
> Obviously, cfs_rq->on_list is already equal to 1 when cfs_rq->on_list
> is assigned a value of 1, so an else branch is needed to avoid unnecessary
> assignment operations.
>
> Signed-off-by: jun qian <qianjun.kernel@gmail.com>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04a3ce20da67..ef6ebd95443d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -305,8 +305,8 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>
>         if (cfs_rq->on_list)
>                 return rq->tmp_alone_branch == &rq->leaf_cfs_rq_list;

if cfs_rq->on_list == 1, list_add_leaf_cfs_rq() returns and will not
unnecessary set cfs_rq->on_list

so your change is useless but makes the code less readable

> -
> -       cfs_rq->on_list = 1;
> +       else
> +               cfs_rq->on_list = 1;
>
>         /*
>          * Ensure we either appear before our parent (if already
> --
> 2.18.2
>
