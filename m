Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BDF2DDDA5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 05:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbgLREKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 23:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgLREKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 23:10:23 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CC8C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 20:09:43 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id x4so681114vsp.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 20:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9byciT1BCh8W9nA7HrbMleToXPe0FpybN4cW/XadFtU=;
        b=B9itbX4Vo+n4YH8n9UkLax6UehJrfdktSn1LudQxxDHogX2Vdg0L1WWNVDffZ4mlJx
         iMK7Co+VvDX/oSEqKlE1T4FqtMlP59mzHhvx6Dft3DbYOogTIJkcBA6SJvZf8oL2gnx/
         RtBQxhASoOg8XNDJlBaqKBoL67tDLxunG/iHXUEFKFTIkeMr8D8kZtJcaQf4DSgGPKNy
         K0BVzRCKEw8f/Fi4ls375p6ThCbXWiZun5ZRhBaadwzLAmo6eA/xr5xhEE1HFwA6EVJV
         Dj9+V9lidcxV+cP8ztMhRBe1t+WRiykEbtfw2V+WiZqFAaqVaFlBPMclwfORHxDEPLqZ
         GMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9byciT1BCh8W9nA7HrbMleToXPe0FpybN4cW/XadFtU=;
        b=G5JZPzqGH1nfvYIhQRczBRwlydNCIRd+Mszoni9b3lduED3Du7i2IH0BUNtBSPefBn
         9CIg7VXhuLcDorhVntAvTv9aJtkh6JEaRd8lPxomzdtKBKxe4TiIkQwqa0a7Cyw5jEyn
         HWi5dSXbRPfFmiGkBQuYF18Q97T32u3WkOyeLNIA1U3oNtHlt0lGCHEpXAWdixIePEYV
         ly3Q97fbqZxEYU+hRplXcHd4PFWc+OoNYfakvOfujvbnKd96ULO+3Ofxju68ynbNGk5h
         J34G4rhe19ZLVl4BH0sW80cPdNwWDuFumS6mwOqcBid4Tu57Kl45YVqqxWBTDn0ArIk3
         vpVQ==
X-Gm-Message-State: AOAM531NwcL9ju4f2sSINaBgmVHHvQgSsHTBxSUbIxGo/yKBX6L5eKMJ
        mUBMdZ8ZoPxvXCdAQji+tqJGKPs164lKkJSgHGo=
X-Google-Smtp-Source: ABdhPJxkKi6cVWnnmuV6x0VXzwrkXbZvGpWWuqE08oQFpITlofVlejRkDBL/Rz4+6wl88Baai0h0+ysXk08Biww3ijI=
X-Received: by 2002:a05:6102:a07:: with SMTP id t7mr2288748vsa.30.1608264582522;
 Thu, 17 Dec 2020 20:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20201217020311.491799-1-yuxiangyang4@huawei.com> <20201217022306.GB15600@casper.infradead.org>
In-Reply-To: <20201217022306.GB15600@casper.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 18 Dec 2020 09:39:30 +0530
Message-ID: <CAFqt6zYeDstXBHP+DCyBdmL4vDFBGekv7jrknU5c175sKVax4w@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Fix warning: no previous prototype
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Xiangyang Yu <yuxiangyang4@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 7:53 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Dec 17, 2020 at 10:03:11AM +0800, Xiangyang Yu wrote:
> > Fixed the warning when building with warnings enabled (W=1),
> > This function is only used in filemap.c, so mark this function
> > with 'static'.
>
> Good grief, no.  Look at the git history before proposing a patch.

revert "mm/filemap: add static for function __add_to_page_cache_locked"
Revert commit 3351b16af494 ("mm/filemap: add static for function
__add_to_page_cache_locked") due to incompatibility with
ALLOW_ERROR_INJECTION which result in build errors.

>
