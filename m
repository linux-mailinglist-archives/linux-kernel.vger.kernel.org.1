Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFDD2FBD1A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390471AbhASRAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389193AbhASQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:59:24 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE31C061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:58:44 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id z6so7117019qtn.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZrHO+yIyrdnmaVFMwMvHwDYxfdcxIe8NtcCENOohqSk=;
        b=IjO3yV9X3nKmpNx8G+WcMwGh4WEgM94OpZUe3C4BCxS9AKRrGEhbWZO7OTjbH7Ne3x
         hBn/tqmq9p/SRMGTavW8121ebd0zIeiAp/LuvwT6FMfCYkBE04QBVr87DOd2YF1dJ5XU
         VGAQcehIYy7JkkebnKqVX9kRX0Qn0F76T8Y/cDI+QGt0gljuxp0EF85EX96ntV+03wOk
         7KbKWoG2E/FhQykR4/gb9nAj7FAsU+Ia39sjuA/EFf/99riTedyctkT0L4TZQXUZwWmk
         JAQBPrNevBWhtXC2xw3srAkrdbawiF+K0gCtNuEOPdxq0l1YTimU5KpCR879RCLBNVad
         7RkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZrHO+yIyrdnmaVFMwMvHwDYxfdcxIe8NtcCENOohqSk=;
        b=R3aIcraTWiu3Vbbq7Z6h+cMYTd59BElKg1RQ3pSp9JHMeHwFxWChHm7C6LnJw+OA+X
         9tMw0zEg/hSKTg3o9cRmp79FcQszRyjABCXd7V4MBM2NJet+FBDNWf6JGKT2j/ALFK8N
         ml1xKjjhmOZWTj39jSPh8w2o5BE9rN9w/yqno4Yrh9wit9U3l3y63npEX7eYs+sxeYSW
         KTkgbd/5ma87HPkGSNSbdWvy4XUHxbDUpouBmRSf4gWOrHviy95/DU6GfQyGOOop3rZq
         vJKm1m852en4nmF/yxIR/Eb/co+05/g4sydPNjRZ3TDP/z2yiwkLxSHWMlYFUSlu0zSQ
         ADOw==
X-Gm-Message-State: AOAM531h5FowCPMd7VVf0hepJd3utnE0ZLd3MimAUmApH00Ek+nMa2qh
        7+U9ml+fUwqRkubNSGyeSc7GNQ==
X-Google-Smtp-Source: ABdhPJzsyWLPgohCl7XB5LwIp8dV/Pk3lXKhNGMeii0fsyJDhxQqGVWDod3V+nlOOW8bx/cWiERhNg==
X-Received: by 2002:a05:622a:28d:: with SMTP id z13mr5136519qtw.87.1611075523954;
        Tue, 19 Jan 2021 08:58:43 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id m21sm8279408qtq.52.2021.01.19.08.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:58:43 -0800 (PST)
Date:   Tue, 19 Jan 2021 11:58:42 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: skip propagate percpu vmstat values to
 current memcg
Message-ID: <YAcPwhl//jF/WpHu@cmpxchg.org>
References: <20210119052744.96765-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119052744.96765-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 01:27:44PM +0800, Muchun Song wrote:
> The current memcg will be freed soon, so updating it's vmstat and
> vmevent values is pointless. Just skip updating it.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Oof, that's pretty subtle! Somebody trying to refactor that code for
other purposes may not immediately notice that optimization and add
potentially tedious bugs.

How much does this save? Cgroup creation and deletion isn't really
considered a hot path. It takes global locks and such...
