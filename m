Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1640268305
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 05:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgINDLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 23:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgINDLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 23:11:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7FDC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 20:11:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f18so11361732pfa.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 20:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOjlPnEGfverOe/NjTfHJ965zGyyw9hgsDwthm8fBO8=;
        b=uWCczg2zelk3J2BSLQ0zws70nqO2Qrj0gvnO2vtQuHmsmUewjkzP6BOyKhWOf7bsi8
         UxCD19k7Z758PpS4M50tNgLTQwxa9bOY8iPkIfDyrjLrEFk4nSL8nUc3ffp6wzJc6nsb
         E03dGwR/aCB100q8leNRNfS4ITrdZTJe/8y1gqWskcEYHWYUhYK8GHzuPEWBD7TsiZyg
         kt40GXGfTlyabPEXkpvLvGwXQ3qPFXMzZ/uipyK3nqbnpikV+i+cl3SF6sBhLbbMLdyH
         7wQVgvUgWfQqg7oH4zJ5tY3mT6tIDnAqP4SAPXwI1/t1YyF1qL/qRE9vxh1J8fzllJG9
         vmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOjlPnEGfverOe/NjTfHJ965zGyyw9hgsDwthm8fBO8=;
        b=iIoFZDjsDc0J5J6J5K0WKaoenlWe/5rvAXTWrBdtpRpRdTZ/SYTww6ux3uS977BqEV
         ICTSqb57rBXZRJKXjkjqCULJ7T4QGIqfy3bvGcn5GM/afG2av53MhDXeat7EslsG7YI+
         DQhO3hwoM1XQIf5ly+rGY7SXr90GOaCNO4kWKTyFbL/90+8KnkceMJP1CWx6wz/OefBX
         zm8GclzOzEbmke6GcPncZdzezWOqW5TVIq44eXTzAQ1D5UvjQN9CCPaeEXHDtyA/acGB
         sdumQxcERe5e6+ME9kshLCr1WHH3Im+4GcYtbRD1o5QhPlkc6KMEnytWCE1YputPq3dS
         Vfxw==
X-Gm-Message-State: AOAM531p2wPukZYQDNfZcK3oO2OQxpxZoYGbZheeBmfko5iwpEm4dO++
        k6yV43100CQ06HZPPrD5T+QksManU31ae1C4+je0rw==
X-Google-Smtp-Source: ABdhPJx4FxwJQZgfVBSb1/npUEzqRxM2ff4oVtXhlJsuhFTOCVKCUma7soUXDoNfMVUVcCe0LgqVZ4ylVmc3fCaZL+0=
X-Received: by 2002:a17:902:a605:b029:d0:cbe1:e714 with SMTP id
 u5-20020a170902a605b02900d0cbe1e714mr12582624plq.34.1600053060539; Sun, 13
 Sep 2020 20:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200913070010.44053-1-songmuchun@bytedance.com> <20200913170913.GB2239582@chrisdown.name>
In-Reply-To: <20200913170913.GB2239582@chrisdown.name>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 14 Sep 2020 11:10:24 +0800
Message-ID: <CAMZfGtVBFCodKuNKzG8TxKjeuC1_hF_YKdqMTmX5ENE_FfDmzw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3] mm: memcontrol: Add the missing
 numa_stat interface for cgroup v2
To:     Chris Down <chris@chrisdown.name>
Cc:     tj@kernel.org, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>, corbet@lwn.net,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 1:09 AM Chris Down <chris@chrisdown.name> wrote:
>
> Muchun Song writes:
> >In the cgroup v1, we have a numa_stat interface. This is useful for
> >providing visibility into the numa locality information within an
> >memcg since the pages are allowed to be allocated from any physical
> >node. One of the use cases is evaluating application performance by
> >combining this information with the application's CPU allocation.
> >But the cgroup v2 does not. So this patch adds the missing information.
> >
> >Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >Suggested-by: Shakeel Butt <shakeelb@google.com>
> >Reported-by: kernel test robot <lkp@intel.com>
>
> This is a feature patch, why does this have LKP's Reported-by?

In the v2 version, the kernel test robot reported a compiler error
on the powerpc architecture. So I added that. Thanks.

-- 
Yours,
Muchun
