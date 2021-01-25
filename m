Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1773047BE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 20:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389027AbhAZF5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbhAYMkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:40:37 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65A6C0617AB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 04:32:08 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id r38so2875036pgk.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 04:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECcZXTiq168nlNhR7ZlqDDfbZIIxsXgGrmSQrRFKW1k=;
        b=Ph4WYGn2BsoGsFlVUnxP3hj1VCYxYacseAW5OCLeblJYeuG6yu8s2kOfPKEe1xrBHP
         Kvmuq9KxZ2+muLC0d/R5BiHA2WC5v0Hv85KR6xMMw1JqzIxHpZPr1qPOO3HsD7aSUO0T
         BmjzqkDTnMkNb47FKaRVXulU2QoYBXcFFYeLrtVufuq3/10W2RtYZftnMiSDr+up8FOo
         RtVIBdv1rcBVrDMYWzRMFR5jn8g/XDdBEQ94kEIlQsf1K9d0Hs3Ge+yhC/YnCm0w5RM6
         mNhCqldAM5m+kJLkSCaadYu4ZaczmwJS3OwlJ917t55v5AkhUyPwGOMyk8eO+44Z4bBZ
         LkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECcZXTiq168nlNhR7ZlqDDfbZIIxsXgGrmSQrRFKW1k=;
        b=mNOnA53s+9haxprqIqRRE2D0OgkFMyD2kEdm/uSUyQKdxnuFGnAqDPtGRxQ2043EB0
         u5OgCN2Ix+USFIchxGMjjdR5W1UZmavYjJ/vxupHHjDO+LI6/Pax/jl9IMA3bXHCdfUC
         IOgL0ZzxJdN5AULlTd9PWFizNpc4snr5WYC21SL8SpnYCikF2ces7/BWIv/mMT0zdsKB
         bn6xXx8affXqd2zHQNYJq/nLH3XRij6rw/fdUttS/pztvi4DwNHwiBQ5AARsMLQ6md9P
         2YvkCqu2xeXsH4jnHZAppStbe3clzr75r7o9gvN09hWnvu3JTPQRUP01/IUow2COU2ya
         lvTA==
X-Gm-Message-State: AOAM531GlHpQbufIDJvzQRMZeflM/PVcYUMKDqU1PJMgirNbL+9rNAzW
        cWtRvz0FIdoYkVHxR3l54tSyxvXbqP8D183Y3S9dNg==
X-Google-Smtp-Source: ABdhPJxv7O9hvhAigWaoL82tnMBoDZgg+H4lyx4pRubFGd/QUUt0UnNO1EEo+PnyWnmbi+w8Cm1zJisMoarJUFLjK7E=
X-Received: by 2002:a63:1f21:: with SMTP id f33mr419885pgf.31.1611577928305;
 Mon, 25 Jan 2021 04:32:08 -0800 (PST)
MIME-Version: 1.0
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-10-songmuchun@bytedance.com> <7550ebba-fdb5-0dc9-a517-dda56bd105d9@redhat.com>
 <20210125120827.GA29289@linux>
In-Reply-To: <20210125120827.GA29289@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 25 Jan 2021 20:31:31 +0800
Message-ID: <CAMZfGtWaBSA7yHD218h0p_5+9OgCveYemF6xn3cKA6SopjhjVQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v13 09/12] mm: hugetlb: add a kernel
 parameter hugetlb_free_vmemmap
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 8:08 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Mon, Jan 25, 2021 at 12:43:23PM +0100, David Hildenbrand wrote:
> > > -   if (end - start < PAGES_PER_SECTION * sizeof(struct page))
> > > +   if (is_hugetlb_free_vmemmap_enabled() ||
> > > +       end - start < PAGES_PER_SECTION * sizeof(struct page))
> >
> > This looks irresponsible. You ignore any altmap, even though current
> > altmap users (ZONE_DEVICE) will not actually result in applicable
> > vmemmaps that huge pages could ever use.
> >
> > Why do you ignore the altmap completely? This has to be properly
> > documented, but IMHO it's not even the right approach to mess with
> > altmap here.
>
> The goal was not to ignore altmap but to disable PMD mapping sections
> when the feature was enabled.
> Shame on me I did not notice that with this, altmap will be ignored.
>
> Something like below maybe:

Yeah, Thanks a lot.

>
> int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>                 struct vmem_altmap *altmap)
> {
>         int err;
>         bool populate_base_pages = false;
>
>         if ((end - start < PAGES_PER_SECTION * sizeof(struct page)) ||
>             (is_hugetlb_free_vmemmap_enabled() && !altmap))
>                 populate_base_pages = true;
>
>         if (populate_base_pages) {
>                 err = vmemmap_populate_basepages(start, end, node, NULL);
>         } else if (boot_cpu_has(X86_FEATURE_PSE)) {
>         ....
>
>
> >
> > --
> > Thanks,
> >
> > David / dhildenb
> >
> >
>
> --
> Oscar Salvador
> SUSE L3
