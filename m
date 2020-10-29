Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C6F29F095
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgJ2PxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgJ2PxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:53:07 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38707C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:53:07 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 2so3582843ljj.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUp5qMqJOVbZKYoMqJH3XNqp7xnfXB9wzQttcgJOSd8=;
        b=cbK+yBgzyQXmtq+AD9wEnzaVNXe3mfmDrMTEqViTBtdbqHEURNS9luA0TyLL4nib30
         3Boxh9kOZuUY6VQJFAygdY2G/XhItlHRWqpCzGXy0TGt+a6ZGpmx0H5vJyv1/oxNH5Lx
         i/xJv2TVagtyrnp857y3WB+q1jPwQbfDjDVUHXiJlBCpCalLGRWzFFGhmXzUUxQ1HOz1
         PT5Jy/Z6QCT1J2noMaD3WXT+b9QyC3cSxQCoFRfderFo1vjlHqQKFlQZkosRXhQiHzC2
         qzuInwS3JX8FWL4UhHPNiE9oPFFNBjTTBGffzvpUFhyhtsXoDQ3oxDrAUgIf2njzqj5P
         Gp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUp5qMqJOVbZKYoMqJH3XNqp7xnfXB9wzQttcgJOSd8=;
        b=Teq+WPI8RTCC4YxDr4QZIt13GQau+SqUQ9oQDuUXdPm6bB6vZQrGDu6c2E/UrlZEnW
         vj2EhmlsktPCWVuihCHnfInXXGb1Nzjo1KU8d0U9BI4NDIjtO/ojpSx9zkgvHgIE3z3Q
         SgL7gSGmuFla5/qPY5+eCKTduhEPCOwdXSJf6Jn7fwVW6cqeghQ4DZNOAhiIoM4AxEEN
         Aq1eurzF8vSUvrMIRkVf8RTRwKM2jtMuxQSQvrYWHYZVIVsBXGKJKSiNVlVWT7FFLLGc
         Fgbmi6F4osDtpKwnGob2iOretqDIVF2brtByq4e8HcuQDHLqdEt8OaytSVYs4yDl0wQm
         53zg==
X-Gm-Message-State: AOAM5304LlWU8m2tVdFZraCSMu+Jj/9HFCPjOEKH/ISZlyV+wfFfNrSE
        /YN00o5iYtKUE5dPPTwuyIyTLBi/4VoHIWZWwY+VBQ==
X-Google-Smtp-Source: ABdhPJye3zEoAgWwSugrZfe85uL6Pkay9ZQKPWHjAkEPbGsa7tncJVrylxDIVaK+KmISLE0L4reaqNhl84MD847oGco=
X-Received: by 2002:a2e:9f05:: with SMTP id u5mr1988377ljk.192.1603986785403;
 Thu, 29 Oct 2020 08:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201028035013.99711-1-songmuchun@bytedance.com> <20201028035013.99711-3-songmuchun@bytedance.com>
In-Reply-To: <20201028035013.99711-3-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 29 Oct 2020 08:52:54 -0700
Message-ID: <CALvZod5PcvSOszj7L-qbh_mOmKRwsrH+4Er_vQAiRqRf9GhcnA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg/slab: Rename *_lruvec_slab_state to *_lruvec_kmem_state
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>, areber@redhat.com,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 8:51 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The *_lruvec_slab_state is also suitable for pages allocated from buddy,
> not just for the slab objects. But the function name seems to tell us that
> only slab object is applicable. So we can rename the keyword of slab to
> kmem.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
