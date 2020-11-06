Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AD42A99BF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgKFQoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbgKFQom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:44:42 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB378C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 08:44:40 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id v144so2792206lfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 08:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFLzWInf7oW7bjGKiJqYb2/P1LPe/HLqYvjRIRLjv10=;
        b=RQjhXcPHc5TehIv2m28NXMCfMB8WOK9adl90A+M0wwX8PK6WMj5fVagX1y4Z5YeMsM
         /1FU5uFqyQmCBuHK0ikHPWvQrVgo1mHtafkOOO5k5CY7cpfLKoxGtKeLHpLb3lY/jJ9C
         RVOaNkFwUQJ/bhi8vvvNok/I/RDEDELO9MiyB2iPiBqfmvEnqBk71I2SRpv+Ban9L2fR
         bEjBtwl9BqqVM/kjUvFv7pNt0oKoD9siqOKBcd2O2cqn16cAH4ZoN6taKDYEzbOWoX10
         VtwXLYKrJU5/wPL353TmCD01vVcEl8/usm8BwvYiDbimiB+SodnlttN7tGoOfFR0PgPv
         XXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFLzWInf7oW7bjGKiJqYb2/P1LPe/HLqYvjRIRLjv10=;
        b=A+AXnF7xtHPJN23k0WR4gzLX8WdfQWNVF1aSKzaN+uHLj/3ruR7hZ21RK/sUUREZ7w
         D0lbjuEaJHx56XI9fnzNx0TSW2ZC0fZoowfrtuZtRY8Xg1B6RCkJysHZW8YUezxth1D5
         kHDBvA62ai4Ka9jSPXUzyhKR04E8XrPfXZBMjJnOJiypS+S4T1TPKWC2J5bTzJXYzwFc
         joiyr8davM+AeT5PVlyEpzvu9N5f0nWetW8pYBfRjJYWJYFOHlv3NuxFXmxhExpYSfSm
         6tvSXjfxdIQ2uMcibe9C757URTeVjJsnTRDY823GLp2tT2DEr03WKUaPNyPmI3rY1vhM
         /nLQ==
X-Gm-Message-State: AOAM533LRDKowwRLiorMpO3MUSCDnPeY7w5/kxg9g/H55T9an5OUGFrR
        V9IgV71L6ZCuE6S1L0J0lYHJeX1NPSVn8M0XMOTJbQ==
X-Google-Smtp-Source: ABdhPJzvx9kTQoQU7TzDmsNIEOUAUb40PiYa+6L+oqi+65en5PqDp5J1/BrC6Jd5BAxdLnXTv9yV3MQUHbUbnOhOGX8=
X-Received: by 2002:a05:6512:2154:: with SMTP id s20mr1146709lfr.54.1604681078897;
 Fri, 06 Nov 2020 08:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20201104142516.GA106571@rlk>
In-Reply-To: <20201104142516.GA106571@rlk>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 6 Nov 2020 08:44:26 -0800
Message-ID: <CALvZod7-FnQNqH-REJtrSuo+xfVMyv0os83-MvXS=ciGKZGA4g@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol:rewrite mem_cgroup_page_lruvec()
To:     Hui Su <sh_def@163.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 6:26 AM Hui Su <sh_def@163.com> wrote:
>
> mem_cgroup_page_lruvec() in memcontrol.c and
> mem_cgroup_lruvec() in memcontrol.h is very similar
> except for the param(page and memcg) which also can be
> convert to each other.
>
> So rewrite mem_cgroup_page_lruvec() with mem_cgroup_lruvec().
>
> Signed-off-by: Hui Su <sh_def@163.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
