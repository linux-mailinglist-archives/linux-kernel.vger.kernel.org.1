Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7999A2ECC2B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbhAGJCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbhAGJCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:02:37 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAB3C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 01:01:57 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q4so3153262plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 01:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7IFTVMzZ+aecicXR0s8XBfFgUlitNACcIOq23fQzejY=;
        b=WuAdrPbD88PrGbyE3Tl9KLmQ5F2OP1aIHh+gkjDtptyrjJcEgtFkUEYH/YUKPQmINI
         V1Jao6+pUYML7SgHjgD1l/79KOR+NjPZyD42AcdmSxkQQkSVfUeJcXgElaBPQX81lE8C
         LGlKbWattF/+LUCULuAn/mJroCVzzRWlDtBwrD1B6GT8MFv8KS4CcsxUshxLhUEvtVts
         UgujmbAFRmoSmkdzv2+gBrhopz8J8qXaWw4ym1Bc4Yi1CQDOkzLbXQrB/gZRIjLij5wQ
         QAJ0x15bQZ+6FqtRoqrv+fjC5igdWocWxEJv23eDqjDuBpvDqk9kBa8kAiPJZSrNMiby
         zb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7IFTVMzZ+aecicXR0s8XBfFgUlitNACcIOq23fQzejY=;
        b=APgaYvznMUx7I77KIsOu83eG7SQgcDZwGqtCX8wICZTePbZBcqgXjUhZ2Mrh3Tjbdg
         IyiX0oc2JzuD4M5RH6T0ZoRuAovr9qrmc2dGMMQqNxzJqIwch/GoCCN2hYQEyCT6f59C
         S9yBwzigpwu9W6+KHTErctneeV4fvHXM2Meu2No+eEMU7lg+oeLBPgKtcIx57ACj8cyU
         SXpkt8Oqe9ElljL/0lWmD3btwU3iB3Uo7viieujCUSzPIanEtSCczz0amRP2izfAdGdw
         9mGeCvim2exgGX2gy+tF26FygPFbt1gOeFRO8ycWXMDSGaqDQLweXo0nqnHcGFTA2qzH
         dSvg==
X-Gm-Message-State: AOAM530BhFa/tXZd1TB6Kq+haXaxbwAoMbGGh+4+lCQ3gZW5GJWFUQIv
        Qc7csh2CC3jWbTVF6bJYfstWJmjalmxriF0LPiLiyA==
X-Google-Smtp-Source: ABdhPJyKrW23ttJk7n2Ob5ozrUR8dhuf/eEW558orMpos4uiFr8Pred9DHJB6CePKRgjqFCH1SDrrc1qVpL4OxtFjps=
X-Received: by 2002:a17:90a:ba88:: with SMTP id t8mr8307085pjr.229.1610010117074;
 Thu, 07 Jan 2021 01:01:57 -0800 (PST)
MIME-Version: 1.0
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-5-songmuchun@bytedance.com> <20210106170754.GU13207@dhcp22.suse.cz>
 <CAMZfGtWg0J5syATXMpP8RYOz=w0gJNYz_=UrT3ueMspQjNY7BQ@mail.gmail.com> <20210107083902.GB13207@dhcp22.suse.cz>
In-Reply-To: <20210107083902.GB13207@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 7 Jan 2021 17:01:16 +0800
Message-ID: <CAMZfGtWwHOVCvFUvm-r74k1GEEujW_HniLFOMKbykny7Cu09eA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 4/6] mm: hugetlb: add return -EAGAIN for dissolve_free_huge_page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 4:39 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 07-01-21 11:11:41, Muchun Song wrote:
> > On Thu, Jan 7, 2021 at 1:07 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 06-01-21 16:47:37, Muchun Song wrote:
> > > > When dissolve_free_huge_page() races with __free_huge_page(), we ca=
n
> > > > do a retry. Because the race window is small.
> > >
> > > Is this a bug fix or mere optimization. I have hard time to tell from
> > > the description.
> >
> > It is optimization. Thanks.
> >
> > >
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > ---
> > > >  mm/hugetlb.c | 26 +++++++++++++++++++++-----
> > > >  1 file changed, 21 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > [...]
> > > > @@ -1825,6 +1828,14 @@ int dissolve_free_huge_page(struct page *pag=
e)
> > > >       }
> > > >  out:
> > > >       spin_unlock(&hugetlb_lock);
> > > > +
> > > > +     /*
> > > > +      * If the freeing of the HugeTLB page is put on a work queue,=
 we should
> > > > +      * flush the work before retrying.
> > > > +      */
> > > > +     if (unlikely(rc =3D=3D -EAGAIN))
> > > > +             flush_work(&free_hpage_work);
> > >
> > > Is it safe to wait for the work to finish from this context?
> >
> > Yes. It is safe.
>
> Please expand on why in the changelog. Same for the optimization
> including some numbers showing it really helps.

OK. Changelog should be updated. Do you agree the race window
is quite small? If so, why is it not an optimization? Don=E2=80=99t we diss=
olve
the page as successfully as possible when we call
dissolve_free_huge_page()? I am confused about numbers showing.
Because this is not a performance optimization, but an increase in
the success rate of dissolving.

Thanks.

>
> --
> Michal Hocko
> SUSE Labs
