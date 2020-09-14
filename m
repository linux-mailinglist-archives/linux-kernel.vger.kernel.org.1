Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C767326902C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgINPjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgINPhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:37:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20D7C06178B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:37:33 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r24so80413ljm.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4ao+npZ6MxTlYLJj73SuM3MYmDgRwOTBj2VBQ+8aQw=;
        b=QqiQ6xW7AdhcYi1OC2qsAevLzikaA4B2B2HmiF8E4JiJ3lndiY2zyjlmfQdljBEpsu
         wnzt39W7OkhG6hVVv0LU6qArb8GcclfoatunyFpVXrFjrN8WwKHyFrturfPeDR1N4uIg
         O7WvUBHhSaBagCz8j4SJtlrL++cp0DKMDP76VZxD69TxZFiq7XP246R/5nGrcvgM9z+M
         sr+Gh5le/CKY1RrlTeDP9/dVwTXsyll0buo08vjzthzY6ziEoCxtDPi6G88Ipvigmuu/
         ViTE32WfPr4r5OnN1bimsysiOcMNByATfPHjxJ+eTRjx5Si0EMvHdcuOTIFexSCUI8gv
         47hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4ao+npZ6MxTlYLJj73SuM3MYmDgRwOTBj2VBQ+8aQw=;
        b=lLKJX+ogcryO2j2cbo6WuY41wgqYC6E/fGo55FUFWy688N0p9j6BvXAZ/oNG4j9YeJ
         XCloYTXpt1qgSaTTbLfHttAw3JNVMtUYHoXxe08l5iX32+G2qX2W2w0T1MftXpSoij8k
         Y82Oknr8dQgey6ct9tgmkBm6LntB5qwSwIc7oCftoOcdaoRoituYq9sHBfA/EJyWjtj2
         HDxrhxz06aoC1YXzVlezrQhmweZ6OrFNOf1L3OTb1ZqgSy23DY9JDX4Rsj2zjjm748Yd
         Qx9tcZ2O9R6t7rL9Gunw0PVh8vSFBU6eXJEXyqhuO0+O5E7acQ8gh8nDDTcXIZOtkEkW
         6hEA==
X-Gm-Message-State: AOAM530P5NkkkGkEYJOto1qn9SicjDI6gQ5GeX584eu+2YuPow4eyPik
        D286pDJr5gPTZQ2YnL8jxzVvX5yvtOB+M60+E9oFzQ==
X-Google-Smtp-Source: ABdhPJwS8YHP1iUcafEkzqm6r7X9c+DloJI9X6GeP5Nto1Ho7LBEnwm4bfjuMB3M1DwukxWL2rUryFlBIf8BFedMO3E=
X-Received: by 2002:a2e:b4f5:: with SMTP id s21mr5532851ljm.270.1600097852018;
 Mon, 14 Sep 2020 08:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200914024452.19167-1-longman@redhat.com> <20200914024452.19167-4-longman@redhat.com>
In-Reply-To: <20200914024452.19167-4-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 14 Sep 2020 08:37:21 -0700
Message-ID: <CALvZod6e3+F_YfEvTSJv015Z=BgHOMQPiYs0Kg9SMRPMHjJsFw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm/memcg: Unify swap and memsw page counters
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 7:45 PM Waiman Long <longman@redhat.com> wrote:
>
> The swap page counter is v2 only while memsw is v1 only. As v1 and v2
> controllers cannot be active at the same time, there is no point to keep
> both swap and memsw page counters in mem_cgroup. The previous patch has
> made sure that memsw page counter is updated and accessed only when in
> v1 code paths. So it is now safe to alias the v1 memsw page counter to v2
> swap page counter. This saves 14 long's in the size of mem_cgroup. This
> is a saving of 112 bytes for 64-bit archs.
>
> While at it, also document which page counters are used in v1 and/or v2.
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
