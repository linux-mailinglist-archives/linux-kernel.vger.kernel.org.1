Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7841526CC11
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgIPUiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgIPRHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:07:55 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECBAC0073EB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 07:01:25 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r24so6037873ljm.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 07:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FRVhtc4HDJxT3tTI+nfU2Ow8g0YNTmg1aLTrLZ5GLkM=;
        b=IW54L6C4ApDTRtMrNEJ761WHUDzNh6f0cykv+LQNw3a0CjeHsQ5WSlC5Rdd1ExMO1N
         9cCPBei85IFqoJiNivM/NsFjjRh0jMmXkZvXl8+m0RgCRmfbb0TDaCnnF+l+ISliosij
         42xhIIF5dTIWSliQDXT+pkI5fyEf/ayHu3Oe+m5BM/34X2OuEb+ump86QIYqpwjOVL0Q
         utbl8fBVgonNijf4+Ewdp5i0r8yGAwtjnqQrqxGFjRKnjSlI1VxDbO2bQgpDvt96hDmy
         9e+2V7Ns6VSmkb05MGw2jc+JMVAoe/cs/p230z+fFQn8RLdvy+31kVUd7E1C0vbywnX1
         A1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FRVhtc4HDJxT3tTI+nfU2Ow8g0YNTmg1aLTrLZ5GLkM=;
        b=qwyTRi/S77nxJRGNZB2DZ9b0tu2G7r9RoMWRE1LLqKpCj4VHxikoUEWHZ8R8rgSAM7
         HrAzqWt+xfoHNa78KYGcfZQyEtwJQ5nfetkdzZ5DVdkkoPBe4mj2/kbIRPe57hZp4NMg
         7O1ArNYGt8jetGMfOWe25q8vMHn8huJ+cBJq7CBGj7u3qCnCCE9Ud/84ps3RcqyASeUi
         Xi9DUTxbqfF2cy3QU+qAdfz6uWyCdtonVCz9jsdIE36ge9TLTOLkqIYQ+ZSMXasjLDM4
         cXnP7NQplmzSdub1GY3OcQYXyh9/4j4mbpFfDsIXaeZgtw2YiY/lC0Tmzoniz5l6uvGf
         JLIA==
X-Gm-Message-State: AOAM533a282qwPEvo9YW3hVo06Aihd8amBNdjubksMnuGfq2+Z+4dq+l
        5d04XqCwzDmGkuxcruCwyrLFgk49CiLhJIi+/GUn1Q==
X-Google-Smtp-Source: ABdhPJy/DTVcQ+MZ5ulLyFNlm25DBhllwomvUrKSO5bS287if90RTyimJrDNB1ExublVr5ZgN3rtY0o/m8FHLOOU8Ks=
X-Received: by 2002:a2e:b4f5:: with SMTP id s21mr8927547ljm.270.1600264883043;
 Wed, 16 Sep 2020 07:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200916100030.71698-1-songmuchun@bytedance.com>
In-Reply-To: <20200916100030.71698-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 16 Sep 2020 07:01:11 -0700
Message-ID: <CALvZod63j475FM1p_DLOEtKmjFZ=-RbGG0eL1zTH+j4VqCrAeg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] mm: memcontrol: Fix missing suffix of workingset_restore
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 3:00 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> We forget to add the suffix to the workingset_restore string, so
> fix it. And also update the documentation of cgroup-v2.rst.
>
> Fixes: 170b04b7ae49 ("mm/workingset: prepare the workingset detection infrastructure for anon LRU")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
