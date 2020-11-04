Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D292A6B45
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 18:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbgKDRBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 12:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgKDRBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 12:01:22 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD10C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 09:01:22 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id r7so19964031qkf.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 09:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=etqFAurUJDSd19LJRgQeMrJKrf7mPzvCgyUjOeBZwDk=;
        b=ES+N86515B56XodKDYWHJ6tTw+f4nct5ajluD4TsKqk6ihVSOr3ho3WXDMqBsc1nH6
         k08i2yVKNfYWndRFpSgEOLsmfnjHftjDfID7V/1kviFzkyAXE4cSwlspsMdANTYqCrhF
         uTIjSURiPNH3jNp0zyCLAnL7z0A6cYHNx8sFjmGuJtUj6+xy/zRrWzAX8lql8mBtIDb9
         dm5TvYpbBO8y9H+NI4o+Tp2FaBP4aWVkM3LxevBq0q0WwhB/Mc1gAGvcj0Q405XUs1Ly
         WVZSd6WgDkmEuy0DpgwhI9qDKyKkYSlR+XBiZ7AVLZxpWup5vJfx/cNJuYMoaS5wQ124
         SHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=etqFAurUJDSd19LJRgQeMrJKrf7mPzvCgyUjOeBZwDk=;
        b=Y5lMEm8jbqA/+1ywHKLdKs1YKYJhtVU8yQzXzl/17gODOvQOvwXvy+wC1d60lI2hFe
         djpBUdYgd9J8RwN+0L33N/2rghPMyWS0DDRUZZQE2Q4yOybGnSoOFXvwPtpFwnHhxwFx
         fR7StiqMsik00JG0mOuzwuUjsm/s5DFBAZ01zEgGJl4lej5YMsbrrMSdZlcVOdN7Ibas
         ywcJv9qF/DwfI96vwxXlpVw/IyVf2tERV70p6RmtcDF4txRXL1q+70N36nOo89cjYFn0
         dnP7yY3t4n8MNsQbtk7PKeuj729lAf3S4ETtLr7M4/nn46fdXYz7UYtxgdBQ0fxZYYjy
         2gBQ==
X-Gm-Message-State: AOAM530gtVGUKqUIWeBmi8VZBcX60a0eufX3dkIZBINni+El0YCodAVX
        xTcbNNQExK65JgeHUGGp9dFcvw==
X-Google-Smtp-Source: ABdhPJy4ELJ5A+0c+aiIpO/0PWwqwBfJHYTp6Wgubcwb0Sa+XPFIikhEv/wbMn4Qpk4k3eOwTOnkeA==
X-Received: by 2002:a37:ef05:: with SMTP id j5mr27458100qkk.223.1604509281779;
        Wed, 04 Nov 2020 09:01:21 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:9e9e])
        by smtp.gmail.com with ESMTPSA id m6sm2796993qki.112.2020.11.04.09.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 09:01:20 -0800 (PST)
Date:   Wed, 4 Nov 2020 11:59:35 -0500
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
Subject: Re: [PATCH v20 00/20] per memcg lru lock
Message-ID: <20201104165935.GA744831@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <811216d4-4972-4721-d6b9-1028c02f4290@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <811216d4-4972-4721-d6b9-1028c02f4290@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 07:55:39PM +0800, Alex Shi wrote:
> @@ -1380,6 +1383,14 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
>         return lruvec;
>  }
> 
> +/**
> + * lock_page_lruvec - return lruvec for the locked page.

I would say "lock and return the lruvec for a given page"

> + * @page: the page
> + *
> + * This series functions should be used in either conditions:
> + * PageLRU is cleared or unset
> + * or, page->_refcount is zero

or page is locked

The other changes look good to me, thanks!
