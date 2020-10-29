Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165EA29ED02
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgJ2NfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgJ2NfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:35:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4146C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:35:01 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n15so2822629wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KpTzlVayUqmIgARPOMPHIPf+pVQBXZ57u27MnCRyRl4=;
        b=bHBQYcj8neeWwxu6NrAHcOkwrOtEZGmaAjWKrh8jI1JhyZORzyCnXt3On6YqLd0N6p
         tErqMaeHRpKVhnOsWX3ipgXBeAanJDaLg2D8M4OQev81G0DQIHUklusbFlwpETgl05pA
         9uzcGGNCaO4+1Zg9YIBIK8jKoXD+ErnUL7DN3jIGsEqoYlvUdmyR609Qw/hR5IczuWjV
         VOAARd7lzT6kY3GvtELMpY3LsYW8LByBImUhKXyPeXliSUfxfhqOAPaLA5/E3P/6e0Cw
         EAEc+4wV66ab4E6oPsOs9CQKokMSZ7Skmwwz6q3RzYKcpQ3sF5XwenicLyIEirLdcuLc
         LAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KpTzlVayUqmIgARPOMPHIPf+pVQBXZ57u27MnCRyRl4=;
        b=O2mXsjOZ1EpovZRgyvwAusZsi31anqziDu7O5Ds5GXs8bPjdd9SGBiPkWKP0QluXjF
         8F77gg2G5cB+3n+RSta5rDPNWaqDjEf4fhjE9Y/zoLmUd86n2LEPR3BnTSEk3zV4Blmr
         9sejLitJmQqXCsN3HkgSDrX4Rv9D4dNJLyKb4LLcSjUN588JSI0vRRx75Cr3/UalLIWc
         pqVKSE3w3IxPDGxyhGTuQ104UT6Ii5FXN9qi6ejWF8IIfgI81o2giWI/ZXIfAoRiUoij
         hQvSo91Bl/+pCVb5An8ToN+a1PCZ8s9VRyz9kbRQ9yYucyROz4gO8hiq3iLzPWqIeMtv
         DgRA==
X-Gm-Message-State: AOAM531Qp0B0v8QOJnIORJoRAFIdBkpzGYOjk8Jl2YLU7a8GFsOsxMA+
        lAqMIzvwWB73wE6QCmK9ObdJO8X8HYD3b/otayn6Iw==
X-Google-Smtp-Source: ABdhPJzoa2kj33P5RHtMoZgDs5yNcjZnapoviF7YdfZYL3bAMykZSBtyBQnjKWARVTGdeTQXxtRcORTM2XC5tC0dDY8=
X-Received: by 2002:a5d:69d1:: with SMTP id s17mr5830591wrw.398.1603978500435;
 Thu, 29 Oct 2020 06:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201026145114.59424-1-songmuchun@bytedance.com>
 <20201026145114.59424-4-songmuchun@bytedance.com> <20201029102913.GA31881@linux>
In-Reply-To: <20201029102913.GA31881@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 29 Oct 2020 21:34:22 +0800
Message-ID: <CAMZfGtVrKrvn0J7jVYjppRv_mF3y-e8RnL7aQRsqPLjfXH8T5Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 03/19] mm/hugetlb: Introduce a new
 config HUGETLB_PAGE_FREE_VMEMMAP
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
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 6:29 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Mon, Oct 26, 2020 at 10:50:58PM +0800, Muchun Song wrote:
> > The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
> > whether to enable the feature of freeing unused vmemmap associated
> > with HugeTLB pages. Now only support x86.
>
> Why this needs to be a config thing?
> If this space-memory-optimization does not come with a trade-off,
> why does the user have to set this instead of coming by default?

Now we only support x86_64. If we want to support other archs. We
need some arch special code to support this feature. In the future,
if this patch series is merged to mainline, I will implement this
optimization for other archs. At that time we can remove the
HUGETLB_PAGE_FREE_VMEMMAP.

Thanks.

>
>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
