Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CA12DB7E9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgLPAtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgLPAth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 19:49:37 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F4AC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 16:48:56 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id 2so21020149ilg.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 16:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6mFDmw1I8PS3JFjRw4b4c02BTWe1HguSOfmuFknig3M=;
        b=FDkzmCmRv7U2wg2zw+EAx+CxdAq+6wLBIfnI9VTWJ0QTFAD/IaLceZTYU03dfbXJ51
         Gs5FC9apS8hu0vjJRmDFc7FK0EUwMbnkUb6zogXnsP7oIzsLYYAMztekUGgcB3KKlKdf
         Ycvhs+zRTkHFE8vvf5JJPrRvWA0V63qiIQ2b7ZQ0nj3Y3NUg5HeBJwjKkMQb/IMWpoF7
         c/wK+cDTLtrG4QhP8ye2JVSL/Jrld+XVm++vca7dqbGBDchiY7AckMPlnoOGpZ5TLTH5
         Wq0g8xA5aywtcmad7qxYAFZyIEUTfHPzxhWWppGY7HYeAuOdMyaSIPC8ZrZLAVGYR+sF
         LdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6mFDmw1I8PS3JFjRw4b4c02BTWe1HguSOfmuFknig3M=;
        b=GJYc7GhJtrKbDkL6TkDMVvHHq5Am8I1tsAc+PoerPEMBIST4ac4rnd9dSSk43+W6kP
         qkc5I50OKZPRIZ+kGJbkw8sH680Exfu8gJoVDLORzB21oE86ti5/wNrN0RG9tCsRFiRF
         W/rLyMVmmxbPoJuGXB+Igk1O4SPWMgAMBhR8ueUSkf0EMhlEX/GcCmafz8i1duee5T1T
         YJ9fnFS3g6XOWI1SoAsvD81M5+8bUXcwuK/XSeKAXw9MEx9qQtlWs0Ey+KeDQ16y8R7S
         4/uFCYDdHDRkSV9zYL3S0m1Z+6r6hUsyiS9P4xZU+QyLlcieUeNOURki2JZtLNVI6z+e
         S5yg==
X-Gm-Message-State: AOAM533pHu4Z2Gq+T8ZR2lr2hwUsz4j+JwIefWjRlzp9Wx4mv8PzSFXv
        zNA7+hNONKlRPLaJ13D0vlpEyg==
X-Google-Smtp-Source: ABdhPJwJ3tlAKN0VYOI4cTPzdCVeIkYhrdK1qL7WD7Gnn4lqgJHq1sMWLreTINmWj1fQmAg723VRGw==
X-Received: by 2002:a92:da87:: with SMTP id u7mr40654710iln.230.1608079735544;
        Tue, 15 Dec 2020 16:48:55 -0800 (PST)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id r8sm106675ilb.75.2020.12.15.16.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 16:48:54 -0800 (PST)
Date:   Tue, 15 Dec 2020 17:48:50 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] mm: lru related cleanups
Message-ID: <X9lZcn+GTOnzI6Zl@google.com>
References: <20201207220949.830352-1-yuzhao@google.com>
 <54bdbe42-023a-4e32-9b94-173d0ad2dc16@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54bdbe42-023a-4e32-9b94-173d0ad2dc16@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 05:28:08PM +0800, Alex Shi wrote:
> Hi Yu,
> 
> btw, after this patchset, to do cacheline alignment on each of lru lists
> are possible, so did you try that to see performance changes?

I ran a Chrome-based performance benchmark without memcg and with one
memcg many times. The good news is I didn't see any regressions for
these basic cases. But I can't say how much improvements there would
be with hundreds of memcgs.
