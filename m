Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381D22B74B8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 04:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbgKRD2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 22:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKRD2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 22:28:34 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B760AC061A48
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 19:28:34 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id g7so541909pfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 19:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnppsZ7cWIbTMEPsAbpATqFowYN5orqZc7MbBDjuppY=;
        b=Z0Pooym/oNFad9Fe/S4QBekCIl4pMLqIVpkTAhSBjg8q8MTG2Hs2M2yTtaycmXUXMB
         DCWzShQbQD9VmvWsQar+Ba/TElkxIPONZ2xofnFJio2KvPpZU+7BpCOc3foRauQMCAQR
         b4qMuD8ipbbNSmgB2zuq4ltocv8d/92XOLEIg+9BURbLZVuJnhTCbpVcXpGJeLE23Zsh
         mNP5Yciiw7lqdZ7FmXJSDoSJDfTPZi9HzUNzYUiNSJMOKHyN0axH+F6Zbxsqf8864OlL
         BptbzgToMZ9iYyY2bFLg/dsjLr3/UvVWv1JYOMp3vP0raDRG2vtMfNH6Xq166w7wxiku
         AXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnppsZ7cWIbTMEPsAbpATqFowYN5orqZc7MbBDjuppY=;
        b=pr+WDpyWhqzSasXP54BhRvh0ZlhEp3SC6q5IVqXHBrNCYffot8wtjITQjZdVUEUsWx
         DnFZI0bOSZOmotLLs2Ej65BX8yRtQLyQR0aM74Fkb0t+FXx3bMyPbDTU9CZbTqU21G0w
         uu2IltUpixd9I9stTxauhKl/iXVfDY7e74NPWvJtX9CwoQ37vf036tWTnwseKjUdpXDH
         MDsNG0T/cpmwDRKnUTSIb8bYsYMvdhoDsB3vQ1Q4LaHJzd5atxEk9/6oq6TXcg7d7yTt
         SfWP5q7YLhzh2bhHk257EKgGS0QDlgMY5R0HJtgGfbw5R2DfrYUJD3SgwKuVLZYfa3SN
         q02Q==
X-Gm-Message-State: AOAM532niPxmvXpQTSlFPVTyN+H9E0hr4ouMUf/bx7uM7qDSl6cGcsZE
        IuCdz0IU1QI+4i/DpwVnrHEvaD/X54a/0qitWoQdCg==
X-Google-Smtp-Source: ABdhPJxFg2bZDDYdW5cu+c+X8qxklQebDNJ6tYNq3D6DCb4Egzt6LNdC6SdIChwp4gckYFi19M+npXEa9Q6dvYouWMU=
X-Received: by 2002:a62:e116:0:b029:18b:d325:153f with SMTP id
 q22-20020a62e1160000b029018bd325153fmr2647216pfh.2.1605670114278; Tue, 17 Nov
 2020 19:28:34 -0800 (PST)
MIME-Version: 1.0
References: <20201113105952.11638-1-songmuchun@bytedance.com>
 <349168819c1249d4bceea26597760b0a@hisilicon.com> <CAMZfGtUVDJ4QHYRCKnPTkgcKGJ38s2aOOktH+8Urz7oiVfimww@mail.gmail.com>
 <714ae7d701d446259ab269f14a030fe9@hisilicon.com> <CAMZfGtWNa=abZdN6HmWE1VBFHfGCbsW9D0zrN-F5zrhn6s=ErA@mail.gmail.com>
 <d04fdbf6c955054fddb152c78bc53db6@suse.de>
In-Reply-To: <d04fdbf6c955054fddb152c78bc53db6@suse.de>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 18 Nov 2020 11:27:50 +0800
Message-ID: <CAMZfGtWMF7ZbPHOZg69VNNO0oiVf=i3pAEVmwsmV32wpbAHYxw@mail.gmail.com>
Subject: Re: [External] RE: [PATCH v4 00/21] Free some vmemmap pages of
 hugetlb page
To:     Oscar Salvador <osalvador@suse.de>
Cc:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
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
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 3:45 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On 2020-11-17 17:29, Muchun Song wrote:
> > Now for the 2MB HugrTLB page, we only free 6 vmemmap pages.
> > But your words woke me up. Maybe we really can free 7 vmemmap
> > pages. In this case, we can see 8 of the 512 struct page structures
> > has beed set PG_head flag. If we can adjust compound_head()
> > slightly and make compound_head() return the real head struct
> > page when the parameter is the tail struct page but with PG_head
> > flag set. I will start an investigation and a test.
>
> I would not overcomplicate things at this stage, but rather keep it
> simple as the code is already tricky enough(without counting the LOC
> thatvit adds).
> We can always build on top later on in order to improve things.

I think that this improvement can be a separate patch. In this case,
it can make the code evolution route clearer.

Thanks.


>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
