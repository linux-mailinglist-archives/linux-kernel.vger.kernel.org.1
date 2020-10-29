Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EC729ED53
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgJ2Noe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgJ2Nod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:44:33 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E781DC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:44:32 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r9so3418089ioo.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NqBYxd6gdZY+0kETjwOQHnaPSjG1U2WLdxmZrjsdJ4Y=;
        b=SdxoTd/skkrCykVaET1+J+5hCEYXJHflSz6baJJCqEWp1bR12pNZ+YOSnreRIn2z9O
         w4cRr/IZ+DxMUaU9EiSvxQqzJDvx6MfHHJPoruwEc817OGmI+TxD33kEYPNSTzmhDX1Q
         PC4KvTxiTxEpQYDW+N5qq6QTzL+Qfscb3RYSvo/9nuQkpKqE0WkONClDJVKu+CJ3mpLD
         ZDSh0YbnXEq6vKDp6mT3OyjY6QAbmF8OqDOdYuDE8w3IkGBUgQeVU0pRx/moikeS5e5W
         wrLoCFz4RVkIej83adbPWFthi07otZnB+svAFq+7CWLtRx+bT3WR22cfpIFVsJcQfzDj
         R9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NqBYxd6gdZY+0kETjwOQHnaPSjG1U2WLdxmZrjsdJ4Y=;
        b=pl8pDyzOfJRBCXZLraia6uXt3o9sd0ZQaKWWYI7+CTRcgl3z8ObB9H7AJq6Wu/ghv3
         5kNedQIutbKTmyeSiiU2OwLAkLnII+/A+lQ/tBPealPMnDq6AqZ6idmBK5ZjFcmINnmB
         C+O/t48L+0Z0PWcDjJmil+fh6YPlRZy49T0p8JRW01MZimvffYr1KmrcuY4kmGa26VsJ
         ZoacwIk+RADLJbT49Bozyk85mBKZPcDCNtY9EBCbjFF5RRbJlGx4gX60GWXzorOH69NN
         Bb4Ev18DNetA2hTY+gAhGuZtSEUg6LSZeW5vCfYtkL6OPjaVIasaawL8q4UlaBmWjXt5
         JDPA==
X-Gm-Message-State: AOAM531CODfvBX3bSCUqsGSEd7ioDVhy7HBuMTSk1qzoVJCDxKs/ke9S
        U4J43yycCIWQdO5utjz08T/vNg==
X-Google-Smtp-Source: ABdhPJxS73ikw0/v0Vwi1QYdX2THvEu5KuDcpKF+LEfO1IH4NHOmAlTHM7m75YDQvXyuHNhQ8EtJ4A==
X-Received: by 2002:a5d:8543:: with SMTP id b3mr3599153ios.15.1603979072344;
        Thu, 29 Oct 2020 06:44:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:536c])
        by smtp.gmail.com with ESMTPSA id k8sm2347562ilh.8.2020.10.29.06.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 06:44:31 -0700 (PDT)
Date:   Thu, 29 Oct 2020 09:42:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
Subject: Re: [PATCH v20 11/20] mm/lru: move lock into lru_note_cost
Message-ID: <20201029134248.GA599825@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-12-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603968305-8026-12-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 06:44:56PM +0800, Alex Shi wrote:
> We have to move lru_lock into lru_note_cost, since it cycle up on memcg
> tree, for future per lruvec lru_lock replace. It's a bit ugly and may
> cost a bit more locking, but benefit from multiple memcg locking could
> cover the lost.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
