Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D153A2D619D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391127AbgLJQVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387830AbgLJQVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:21:07 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5BAC061793
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:20:26 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id g18so4679727pgk.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gOoShQoy2wQXY3FUgpRmJNV81X7XkJlcJzzP39yH8B4=;
        b=LQDH7cHHyuvDFABjfdf9FCcJAaWrzP3BR5lBscpduE8+d/2f9mGS6XkaQKV0I60pqs
         dNpfH8d0p1VK1cyAjKTaqlC5y3T808RJwN9j3zhRg/y9AEzktUHWw3XIMzzOnQGlkIMb
         b4zsyh1x5M7w/lo/hNoZWTX6mjHZvhogI5SyMNajkwzm79JnfCyDV9rN3geEZVvVO0PE
         QuKQKh6TyvxlTr7Gc0QAKbe5kd3kwVS0eqIVfQ5F6V17xzPNzcJ0t2jmgEzR1W50cgBC
         t91uBNVmv8sHk1Lu39R8Dk2cdY6wbDcZ+k//sf9r0sxS5O3DnV4bQebIkJxjkwuBXsuK
         +P6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gOoShQoy2wQXY3FUgpRmJNV81X7XkJlcJzzP39yH8B4=;
        b=TeP+i6Wm9pzh8Mt+Tmq4X35oeruWtxAWVB2ALUzBt6jsiBFY0iwEzXaR8HLKKSWStm
         rEp+1rUcCTwHg+PaGTr+77hADu91/OS+gzeB0LqdGwsFSRAxGBzy9e+6ApX+xIegZspN
         4Paa/F5/NhgU2Htqm842/JiOEhlKQq75FtmqgIRETj2yILKc+bD88sSOL1dLOLk44Ln0
         kaPqVynuAhVxRIE06zD3Bu7P/p603Cky+wNqkYZqBtDp5r6DgX9kVxmEC7IrHdGi+h9q
         Z0eTPiG9+9SYOrfvWZG+CwyZvVu067HR5R3gz3AtQwNZugBsv92hXpDPJx0OHf3kqhhp
         3Eyw==
X-Gm-Message-State: AOAM530p2BmTdcEpwcabkFJ3zDVltcHeVXolx2w7NdMf8+14GStEVinR
        uWKUrwNa4j27uowBrCrIsL47SwO6wskIQe1m1xzS/Q==
X-Google-Smtp-Source: ABdhPJyFWG17IHNoAP1Thl1Hpjqvi91RsLyQZI9OQ0R4iCDqarpGl7qDkLFnU7RvxsSo3ZJbFWt8ym48Dt8Rp1jptMQ=
X-Received: by 2002:a62:4e4e:0:b029:19e:aaab:8be with SMTP id
 c75-20020a624e4e0000b029019eaaab08bemr5287563pfb.59.1607617226427; Thu, 10
 Dec 2020 08:20:26 -0800 (PST)
MIME-Version: 1.0
References: <20201210035526.38938-1-songmuchun@bytedance.com>
 <20201210035526.38938-13-songmuchun@bytedance.com> <375d6bad6bb37e3626f71bfabc20b384@suse.de>
 <CAMZfGtUQOXmuRumv48MYGCYh_JZn4bMPPz8HW2ExgTPCfFMMnw@mail.gmail.com>
 <20201210131608.GA7811@localhost.localdomain> <CAMZfGtX842XJC+C_OeptH4Ru_Q-qV1=5vCq_PgPJmuyTGKO_rg@mail.gmail.com>
In-Reply-To: <CAMZfGtX842XJC+C_OeptH4Ru_Q-qV1=5vCq_PgPJmuyTGKO_rg@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 11 Dec 2020 00:19:50 +0800
Message-ID: <CAMZfGtUH00bxOptddY0i2Zt2HJsy8C-QgN0aqXGOi=u4-f_MjQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 12/12] mm/hugetlb: Optimize the code
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

On Thu, Dec 10, 2020 at 9:29 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Thu, Dec 10, 2020 at 9:16 PM Oscar Salvador <osalvador@suse.de> wrote:
> >
> > On Thu, Dec 10, 2020 at 08:14:18PM +0800, Muchun Song wrote:
> > > Yeah, you are right. But if we do this check can make the code simple.
> > >
> > > For example, here is a code snippet.
> > >
> > > void func(void)
> > > {
> > >         if (free_vmemmap_pages_per_hpage())
> > >                 return;
> > >         /* Do something */
> > > }
> > >
> > > With this patch, the func will be optimized to null when is_power_of_2
> > > returns false.
> > >
> > > void func(void)
> > > {
> > > }
> > >
> > > Without this patch, the compiler cannot do this optimization.
> >
> > Ok, I misread the changelog.
> >
> > So, then is_hugetlb_free_vmemmap_enabled, free_huge_page_vmemmap,
> > free_vmemmap_pages_per_hpage and hugetlb_vmemmap_init are optimized
> > out, right?
>
> Yes, that's right. I have disassembled to make sure of this. Thanks.

Hi Oscar,

Because this is an optimization for code, I leave it in this
separate patch. Do you still suggest squash this with
patch#10? Thanks.

>
> >
> > --
> > Oscar Salvador
> > SUSE L3
>
>
>
> --
> Yours,
> Muchun



-- 
Yours,
Muchun
