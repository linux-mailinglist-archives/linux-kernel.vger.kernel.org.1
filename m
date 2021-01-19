Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3512FBBFE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389809AbhASQIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391333AbhASQD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:03:56 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76055C061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:03:04 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id d11so9339777qvo.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TM2UANy2tYSfS16CNFNtc6ZYmSBMwIhfN2bmoRAQy/E=;
        b=vUnaP/HV/ZyFrQEmjEKRV/SW5rXzpeBW+ixj2OQ8dArHacVI6FcyWUWkJPrT/C6mb4
         G7EWjhdJFweBHhKmkyx39vxB2vEdVBvahpplSE0aUvNbtYPMaQ6QXuxnSCO/pivj6ujd
         rg/BinKkRiWJcU7jRfzeoCmGqfmPpRoXVjoG85HTKQ7xnQwz3eirCrhFGdxF7sROGHsD
         Os8kg4/mMrJYG8zptgY5v5IoRZqsLQY+VfBKKdmWLDxBh5XwgXx9W6UORnLi96Dh++l/
         l4RMzVJW2MAqriEGqiqcspnG4cQeWYXnDAxMHLv/ygQz23WK7AT7ygMHBLmlxmv15sHP
         Pp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TM2UANy2tYSfS16CNFNtc6ZYmSBMwIhfN2bmoRAQy/E=;
        b=P+5JO5LvTEgRBn5iRuCETbGD3a7J5m+u0BeYjVP7ir4ea30fI/Qf9wVm/vR0WTsdUz
         hQC/lpYVxGzRETqHefPJrlkMSKs1JrOTbkUshsUIejvLM+kMB4HwAFm7VJ/bKWWRHov3
         QSSfoycWvJz7s7KcVUdqRlIEkG6v1tFTda/vBEU2RP60eidWyk0CRcU3cVuwqF3BEbN8
         /bil4UgbbQG0NGbf63ZKK5FLUPoNjqXKaFmFg0MnbwsjAXWKyH5eLDm1UU0ylkLpU7bq
         RhBklzP+AYElsfbJV8BRBzsvv+3+LQlvos+zl2zVG3EWzuFXniwa8dmUYwo564JmjP4D
         ykUA==
X-Gm-Message-State: AOAM531YNsk1PJrPYPyOaWMjQ6v2Ge+7yBJv3bnYu+Q44hlsqztRityp
        kDvof4a5U11aJw9C157BoEI=
X-Google-Smtp-Source: ABdhPJzTt8aUyrRZnN4qJSpxhpvdPv18uNq/nvvHAB6Ah2ACdDugLXEzTqQUIbIvipef6v/RhJ2I5w==
X-Received: by 2002:a0c:80ca:: with SMTP id 68mr5127186qvb.28.1611072183602;
        Tue, 19 Jan 2021 08:03:03 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:4cbf])
        by smtp.gmail.com with ESMTPSA id v67sm182519qkd.94.2021.01.19.08.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:03:02 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Jan 2021 11:02:18 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: Re: [PATCH] workqueue: keep unbound rescuer's cpumask to be default
 cpumask
Message-ID: <YAcCivvOTpgWsie+@mtj.duckdns.org>
References: <20210116065753.2163-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116065753.2163-1-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 02:57:53PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> When we attach a rescuer to a pool, we will set the rescuer's cpumask
> to the pool's cpumask.  If there is hotplug ongoing, it may cause
> the rescuer running on the dying CPU and cause bug or it may cause
> warning of setting online&!active cpumask.
> 
> So we have to find a reliable way to set cpumask when attaching
> rescuer.
> 
> When the pool is percpu pool, we have easy way to reliably
> set cpumask with the help of %POOL_DISASSOCIATED.
> 
> But when it is unbound rescuer, the problem becomes harder, because
> we can't neither use get_online_cpus() here nor test cpu_active_mask
> without synchronization.
> 
> Atfer investigation, and noticing the unbound nature of the unbound
> rescuer, we decide to make it use the wq's default pwq's cpumask so
> that we don't need to set the rescuer's cpumask when attaching.
> 
> To implement it, we have to set unbound rescuer's cpumask to the
> default pwq's cpumask when creation and maintain it when hotplug
> or the default pwq is changed.

Yeah, this approach makes sense to me. It doesn't look like all problems are
resolved but for the rescuer behavior part, please feel free to add

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
