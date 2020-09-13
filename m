Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B09C268078
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 19:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgIMRJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 13:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgIMRJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 13:09:16 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF60C061787
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 10:09:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w2so8539334wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 10:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NHSyG/ZtG9S0n0YZM7cSzTFQ+FkKUxE2tX0ghcDmfZ0=;
        b=kXjiBqYL6OViT3ewAjh9aCHJsTXRTaC9OZ01erzxJzAY0iuwHOa6mBt/6RPf+22jJd
         g+UbRQyTmu2YclZLlFGpfI5q/gvpZ+Fu5Z73vb11F0o9mGNsGXQvXPXxKQod18U4WBU1
         HxqWnKX+7mSCl2lhKU7uexA73WmMS93491Q9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NHSyG/ZtG9S0n0YZM7cSzTFQ+FkKUxE2tX0ghcDmfZ0=;
        b=siQ/KxllOh4BsecokmFPfa+qDaQFsoMsvI4PhjeRbN3HoKDTkcH61nrrWWYmKfvVsN
         x/iq26C6P+704kwKXBIKUp5EiZJ/GDti7FOl2X0u1gpPiGN3H3miik23ckTBoiIzv/vO
         tLN+pdm4qrf/f0ZUJBv8Y+UaueB7QHH3P+AP+hzkKYnEvmmWKGlRHkEe8lQML4HT7I1A
         zLukV2IqPUM/wSJS8aPzrqCef0NZ//mPmfYgsCBPgua8Ee4OQHHpvQNBZCa9jcP6EABW
         xMblVbu9XYZ0BzuWSfOpRZ9y5Q7Qj1ovqRqxxwfb/nTcjRwjiTt9TKuya7fXOlpIFe7R
         vIUg==
X-Gm-Message-State: AOAM533XsHayhttPAF0qx1qWDxwoOdd/GGcP/si0DOtQCX0DkW1T5RDx
        KEmRt71UBdygwAzHcafr3C/cMg==
X-Google-Smtp-Source: ABdhPJwL1luvqQq2GdA/kvbVc2X5wQ2OPvXWO9D/pL7y3epijMqdaCQIrgYZQ16AcG8kZ+Tp9tpJIA==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr11236947wmb.101.1600016954047;
        Sun, 13 Sep 2020 10:09:14 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id q18sm15870487wre.78.2020.09.13.10.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 10:09:13 -0700 (PDT)
Date:   Sun, 13 Sep 2020 18:09:13 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        corbet@lwn.net, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] mm: memcontrol: Add the missing numa_stat interface
 for cgroup v2
Message-ID: <20200913170913.GB2239582@chrisdown.name>
References: <20200913070010.44053-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200913070010.44053-1-songmuchun@bytedance.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Muchun Song writes:
>In the cgroup v1, we have a numa_stat interface. This is useful for
>providing visibility into the numa locality information within an
>memcg since the pages are allowed to be allocated from any physical
>node. One of the use cases is evaluating application performance by
>combining this information with the application's CPU allocation.
>But the cgroup v2 does not. So this patch adds the missing information.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>Suggested-by: Shakeel Butt <shakeelb@google.com>
>Reported-by: kernel test robot <lkp@intel.com>

This is a feature patch, why does this have LKP's Reported-by?
