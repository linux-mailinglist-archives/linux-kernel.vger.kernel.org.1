Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1C72DD83A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 19:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbgLQSXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 13:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730167AbgLQSXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 13:23:34 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40528C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 10:22:54 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o13so36764538lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 10:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NUD7gJA5lhMFnM/41VDmQs/Ea6kW133DDlTS4YuhSr8=;
        b=duD8Q/ZhTOv/pTgvO2qH536A7bKcX3BMXIjJ4srwYUsZSpZ4bqcbcbv/pghu/tC6JF
         hS0A4KbA1VabvHN6uhoxqA2JLFAQ/9KX8ZtEgLxxTP4lPd9ThjRBFuu5jfFgbJyP7oiW
         U17LTowLNvNoL2glQph+EwCFBlZLhqkjc5dVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NUD7gJA5lhMFnM/41VDmQs/Ea6kW133DDlTS4YuhSr8=;
        b=Q5Tis5gGXr/ztrjstz612qs2lCf0YkCJ6C0RwReZ0WKymCKs0dAY/gnt0kpZnP5tJo
         26AhlGbtagcpW2EBfmOW3TpdZrF7gA/t4mSNenayrqhsA0MmtV5ujqm2hKKxrseNxCOl
         2p1E1uw3UTDYSq4xvTZ10Z6bPBRnjuvoMm/7Xg+ERbMgOMhOn63EI9nnFyrueZzvjZ1h
         1YZVl3Vt+ld9V9gJC8HMB6e5Di9nWBNR7gqOS/j4o6H9P41T5i5jcU5t99zTqmWPzWWu
         lZhoiVP+9E7wBMt84y8yhi1nei8cmCfXIXuw/4U4YHjD4Rx0gYONnMsSLynWp76VfMJ7
         U2Pw==
X-Gm-Message-State: AOAM530S66YnJsxWBd84S8UISqDYmuRNAB1dUe82VsU+u2MUoK3/RF0p
        QykRe9DVuyiYL0cY7IkNU6VECGypyVuEXw==
X-Google-Smtp-Source: ABdhPJznIUn1uB7EixM2WIkQ9kEtnee3ddT1x3vViJe6HX1abFa/ca7V+3XqjSihpsQVP9E/0yRqmw==
X-Received: by 2002:ac2:46f4:: with SMTP id q20mr17036lfo.316.1608229372026;
        Thu, 17 Dec 2020 10:22:52 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id a15sm664146lfr.68.2020.12.17.10.22.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 10:22:50 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id o13so36764128lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 10:22:50 -0800 (PST)
X-Received: by 2002:a05:6512:338f:: with SMTP id h15mr21990lfg.40.1608229369683;
 Thu, 17 Dec 2020 10:22:49 -0800 (PST)
MIME-Version: 1.0
References: <20201209163950.8494-2-will@kernel.org> <CAHk-=wgos=vgteG52=J=rVSeq6-Y2g2+Kn1=xV=wYjVzM6O9UQ@mail.gmail.com>
 <20201209184049.GA8778@willie-the-truck> <CAHk-=wgVqGh402dxfhR=bx2QSH=+4kq9doarNmD77baqDKdiUg@mail.gmail.com>
 <20201210150828.4b7pg5lx666r7l2u@black.fi.intel.com> <CAHk-=wiU8ktvak2hCj2TWJ6wMSwVsUSvi5Bjf4i1JGvpGmyUZw@mail.gmail.com>
 <20201214160724.ewhjqoi32chheone@box> <CAHk-=wi80Qp6nZC0yyewhnqvrmPx2h_yWvfq4A25ONb7z9BywQ@mail.gmail.com>
 <20201216170703.o5lpsnjfmoj7f3ml@box> <CAHk-=wiVRMADHC0qjTFAVx2Pp0DN-fT-VPC10boDdX0O4=h01w@mail.gmail.com>
 <20201217105409.2gacwgg7rco2ft3m@box>
In-Reply-To: <20201217105409.2gacwgg7rco2ft3m@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Dec 2020 10:22:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiyPTnQ9E1dT9LJtNxeVmLaykursk_MSecUqFjSb3gwAw@mail.gmail.com>
Message-ID: <CAHk-=wiyPTnQ9E1dT9LJtNxeVmLaykursk_MSecUqFjSb3gwAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries when prefaulting
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 2:54 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> Also if the range doesn't have a mappable page we would setup a page
> table into the PMD entry. It means we cannot have huge page mapped there
> later. It may be a bummer: getting the page table out of page table tree
> requires mmap_write_lock().
>
> We also take ptl for cold page cache. It may increase ptl contention, but
> it should be negligible with split-ptl.

Both good points.

I doubt the second one is really noticeable, since if it isn't cached
you're going to have all the costs of actually getting the page, but
the first one sounds fairly fundamental.,

But I think both issues could be easily fixed by doing that
"xas_is_value()" and checking for 'head' being non-NULL early.

In fact, maybe that should be done as part of that early setup loop.
So that early code that is now

+       head = xas_find(&xas, end_pgoff);
+       if (!head) {
+               rcu_read_unlock();
+               return;
+       }
+
+       while (xas_retry(&xas, head))
+               head = xas_next_entry(&xas, end_pgoff);

could/should perhaps be something more along the lines of

+       head = xas_find(&xas, end_pgoff);
+       for (; ; head = xas_next_entry(&xas, end_pgoff)) {
+               if (!head) {
+                       rcu_read_unlock();
+                       return;
+               }
+               if (likely(!xas_retry(&xas, head))
+                       break;
+       }

instead. So that if we don't find any cached entries, we won't do
anything, rather than take locks and then not do anything.

Then that second loop very naturally becomes a "do { } while ()" one.

Hmm?

               Linus
