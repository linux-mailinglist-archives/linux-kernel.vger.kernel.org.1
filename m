Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863FC2F4201
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbhAMCsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbhAMCsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:48:16 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E31C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:47:36 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id u21so900639lja.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RcxIDDTMXkFwa64McahVoZjCSc2zmGlcmghqJwnZ0DA=;
        b=L3c2Klwm1+DVXIz5Wi93xHfsFgw0oj6JSf6ADpOrW1oWvJ36+dvJILaWGiiDDxFscE
         sCGlh5UstNHAEGXrSz22aG1+KXr7B63RD1Ihng/NNa1p3NRtGutjGE+WjOn7WM8Nr/s/
         H3+eaxOIuXk0I1URyhAPOfU0VoKkW9q+VWb3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RcxIDDTMXkFwa64McahVoZjCSc2zmGlcmghqJwnZ0DA=;
        b=MVhg7vNv8bYnJG98J53hvxowgg0GMIXf7XnwvcBHZGCsPeIAknhL2mARhzIWu9xWaN
         v6bHNHdF5vh0gS1HRcQEAXqqde4ELplT1kB6H4WBMmNDPGijccki5+3I1kwxKVTwZg/N
         EGdR6bVafXB6Fjn7TttcPnTde3G7ztY9iLjsI/FdUvgfCYojQgF4sjYzafRfle4cHIwg
         l/7iIQpdH6vxiUivsY0c9IwxBHLjLNGtKhsOkxEYjJP6GccqmTOPNkz2BWoCqwis5h+N
         QDGEw25b/CIlza9AMVOB56lDO6dJI9SpV6vVkNmBdNSHTF9RpAoojH0QJD7Grdjz+8tT
         VkXw==
X-Gm-Message-State: AOAM533Y6GM/5S26tRar13MYWwIMgoBTKunJPGpCqp/RDY7V2t/twT16
        p/x09FxPoNoYEFXA6AzCQWcbKgY3A2335w==
X-Google-Smtp-Source: ABdhPJw/59Q8Y2BtiVz4YPlqeSQJhe0n/BA4OqurZdw5w+gblWLpIaZ5jaqLSn6Yfg6kcV9KrPcZYw==
X-Received: by 2002:a2e:9ad3:: with SMTP id p19mr954119ljj.286.1610506054194;
        Tue, 12 Jan 2021 18:47:34 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id e2sm37044ljp.75.2021.01.12.18.47.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 18:47:33 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id o17so564354lfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:47:32 -0800 (PST)
X-Received: by 2002:a19:7d85:: with SMTP id y127mr831148lfc.253.1610506052678;
 Tue, 12 Jan 2021 18:47:32 -0800 (PST)
MIME-Version: 1.0
References: <20210113024241.179113-1-ying.huang@intel.com>
In-Reply-To: <20210113024241.179113-1-ying.huang@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jan 2021 18:47:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=whn5kVxEitkC0AyzvWRyxbF91rMrO9ZG6JHBNYLckpDDw@mail.gmail.com>
Message-ID: <CAHk-=whn5kVxEitkC0AyzvWRyxbF91rMrO9ZG6JHBNYLckpDDw@mail.gmail.com>
Subject: Re: [PATCH] mm: Free unused swap cache page in write protection fault handler
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 6:43 PM Huang Ying <ying.huang@intel.com> wrote:
>
> So in this patch, at the end of wp_page_copy(), the old unused swap
> cache page will be tried to be freed.

I'd much rather free it later when needed, rather than when you're in
a COW section.

            Linus
