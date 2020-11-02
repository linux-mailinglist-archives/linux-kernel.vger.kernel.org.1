Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CC82A2D7E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgKBO54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgKBO54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:57:56 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F29C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:57:55 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id l2so11712860qkf.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 06:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LgtTnYQjyfB/tvtX7Obe3tHFyLR4gaadfhSyBfkKBRk=;
        b=u3MKuRwVhK4RPBR8vi0L57e2BRl8edLpePSlQKR/rgnmT7MWEMjFpG/ob0ub0Szs8g
         m0h5qrsU1apxI8Tsq7Li6/NS+aEBTxANfsskkM/c4JJtJrJSqLcDxpQpKJ3iwAutKn5j
         FGF19TEoo8LNsR9Ri/zrzjXWptqKaPU4+KeVIR6xA+/qsgfQSBUuj/HmAfvYp0Qa2LQa
         yzNkJCG+EaGCklYRjgaXlAA1HCSisugx85RtYGUVJELZRXfl/H2OXj1/b8SCZM9y5s80
         r3/KGrVVcIsN5MXUGB+d6y1ajZFhMJxCT5IAYFuMGI8eeRXjd+B/KAf+fUOCBYSqdhaJ
         uCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LgtTnYQjyfB/tvtX7Obe3tHFyLR4gaadfhSyBfkKBRk=;
        b=YMEQHLOKAPRciuOG5A+u4I1NY6JBG8fe/oKenMWJspy34ro5ZqXSLSCzRdk1qThrmR
         ANbLf3L3qe0wbU3eyD4GZGTC+HhU+Y7OghgjGCeK2e+WHhsNo6x/D6WBk+d0E5G9E8Ya
         WIhUWHClg9bgng2R2zK4aQJaI1vD1+jSnVzkvScz+S/uWHHwmPNBzoRl92w2brvyx/5q
         Q/N9wNUPl0rlIs8p6jlQxBn17fRUDVcAGBcYKW6WX75tHoeTJXdO052NHS4T6z6DaYRd
         MgP6HoxRI9JH2sE5/mLcrm+C+tDZfbIulDPIGflMUJAZUyjqGUbKqp2ReXjMI21loqI8
         16GA==
X-Gm-Message-State: AOAM531mSkql2Kz5HoUExwztXDLyE8nFl/8zUl4O2ifjxsrO/kEimj9N
        /IcM0oQjUIu31xf8LfHwGlk4Fg==
X-Google-Smtp-Source: ABdhPJwKsFnjqFLDaBcCggIr6gLD6v/DDIos0c3xRucCRm/vxotTaHDx0p92M/nypttK+fuPggIOlg==
X-Received: by 2002:a37:6591:: with SMTP id z139mr15676674qkb.105.1604329075025;
        Mon, 02 Nov 2020 06:57:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2f6e])
        by smtp.gmail.com with ESMTPSA id k145sm7842609qke.79.2020.11.02.06.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:57:54 -0800 (PST)
Date:   Mon, 2 Nov 2020 09:56:09 -0500
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
        shy828301@gmail.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v20 14/20] mm/mlock: remove __munlock_isolate_lru_page
Message-ID: <20201102145609.GG724984@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-15-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603968305-8026-15-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 06:44:59PM +0800, Alex Shi wrote:
> The func only has one caller, remove it to clean up code and simplify
> code.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
