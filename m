Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F3A2DCFA4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgLQKnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgLQKnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:43:19 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DB3C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 02:42:39 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id i7so8360603pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 02:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ISaOxv2M3y6rzTF7V0ZUu/XvyKLY1Lh8tc0RjKV/bE=;
        b=JdIliH6SeXTydvTW28vuoACmBG9WQrqrb7eKRimd1Cl9Rh8HMO0wnx7XJRZaA7s0sN
         dgXttyNW31CGIl4D9+NBOs8ygxpG55qZVW0OepUVtuNnw3MCLFVAP8MXJfyAaEmEMArH
         ud1l8hYWYRDL5TTsIuEMt8tTHpvlXlQG80iRvj6OkWGBKjMjpHnHEcRqFIr6t4P4hGRg
         92iWo0ce2iAyOZv/ULkYH33m4ThMTdyKMzWezF9P85dqlZkW/btdOv1Jfr18pK85a3JX
         DuIGt2ihK02S2meZ+b1yNUwpJafxowwwPbj1PT3Hc/3fWv9yv5zlIYE8AG2IVjjmPq/N
         XxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ISaOxv2M3y6rzTF7V0ZUu/XvyKLY1Lh8tc0RjKV/bE=;
        b=P6sGkvVCxH/s4wZQ2TsXtaNi7eer6Aohw/2WImueijcYqFChDv8oGcLoGnruSFFxJJ
         BM/Adb//jBIs7wmcYmxDchDnDRjlg0KES5iVhD/m+I8jelx4O/GxkZ2C4imVHrINSDXe
         FxzxX0emwXEZyGoFDQqtpXCDnUCLyxmzPSnuJfOiEPuz/GCpNPDNPSW1xZVd7zedJGZk
         9IxdThR3sUGJGUeFLBJKI2O1lxwtNUY9OTGyl/ujVzzJjbkXVYFHcaN/9Je1wbTUKoIE
         ZOjvdwQDR++DNmN6wP5cEjhrD/5rOOTOxKaifO7UI2mJtP7lMhmKPJu244eTakR6ks8E
         IvXQ==
X-Gm-Message-State: AOAM531r/w5t+0kT/z1oMfnXXO8TwaADayRbHc2rYkMY/4i8srzt0dMe
        /D4lPz49rg7MSxuVIBsEjaSnNumoY+b3nU7ILjFfyw==
X-Google-Smtp-Source: ABdhPJyQqONmSuuKMNSnMEKXcxXk9UVbNjaPbYGZ8ABrFQ0kIzVpoir8YmisZWEI9RBFKOOPGshygmfRmOp3NTZUEXA=
X-Received: by 2002:a63:50a:: with SMTP id 10mr9159315pgf.273.1608201758996;
 Thu, 17 Dec 2020 02:42:38 -0800 (PST)
MIME-Version: 1.0
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-12-songmuchun@bytedance.com> <20201217103154.GA8481@linux>
In-Reply-To: <20201217103154.GA8481@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 17 Dec 2020 18:42:02 +0800
Message-ID: <CAMZfGtUesG88wnwN6XEXWSyDFgWFGqNS153sUkXqxZu-U0h9DA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 11/11] mm/hugetlb: Optimize the code
 with the help of the compiler
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 6:32 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Sun, Dec 13, 2020 at 11:45:34PM +0800, Muchun Song wrote:
> >  static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
> >  {
> > -     return h->nr_free_vmemmap_pages;
> > +     return h->nr_free_vmemmap_pages && is_power_of_2(sizeof(struct page));
>
> This is wrong as it will return either true or false, but not what we want:

Yeah, very thanks for pointing that out.

>
>         static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
>         {
>                 return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
>         }
>
> the above will compute to 4096, which is wrong for obvious reasons.

You are right. It is my mistake. Thanks Oscar.

>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
