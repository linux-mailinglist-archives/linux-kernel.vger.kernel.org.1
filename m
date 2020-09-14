Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EEF2688B5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgINJoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgINJoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:44:18 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCA1C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 02:44:18 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a9so5238076pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 02:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGDsMtjT75Ugek6NrpYH7erjKE1iSP2qJww8COSquYg=;
        b=HhMdSpnkADQbF2sSvs3sIX8fhooLzGiLBz161wSqKDCUNcYonR4wNaLeWxZnCWXHaY
         rjpxg6mYbaTGCHJstqUMJnjKWERUBNehqsiRQaw6ft+IyndVXaUmEpljumQZINJq7P/u
         Lq6Sgw63X7gxlg2/d5Nrq8YkwmlT1u3NwckogBa9s1PUv5tvzoYfXjmT2BtxsvC1qIeL
         FOKcCh0i9AqESKney8bXcS+c7GdGeu5MiDtDERDa2wPyXcXEexz+P0r4OffDlM7z5cUv
         ZVrwVQrtZc4aRfUUDLyBdHxB9C9N/n4+bwwb2xspLrq8/TE5UJgjCN7NEiu6XSmzXCRR
         h/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGDsMtjT75Ugek6NrpYH7erjKE1iSP2qJww8COSquYg=;
        b=k2AVkBfFkVhZYWHuuWEYjMniRsFjz2977+gdS2nnK5CuTDA+osMyk0GKGAnO9sVsek
         QcAkAN9y/0v1OJJWxgL/iXlJzdGUGcAusyVLlCPHb9EgmiIjs84HQ78qOxT38Evv2ETv
         stACkbUAe3TLK1ub9F77EbSVvUw8Gm8TdpmVSorllSDwUM+dO3Gsi2tgG+jrudp0EStr
         DNsq96n5v+A35eAzcn0pQqDRrF6poSKbK6GIcNtWx0VMRdTK92gj+l6y8BGFfqs85VEt
         CX/9o8jIsPCQwTdVgO+I8onRfFHzjE3NRDvYmPSjPA/H7IeROpSoyoH+bdy5TKcK1dn3
         qMkA==
X-Gm-Message-State: AOAM532PcOQm0HMhVEIjkp0D2vv5dxqi606Sa/0sPAGPBTe3A3VsVwXe
        TrTYo1UeRbbXnluMzCQKzsv0z5R5TLHZLJCE2TmfRw==
X-Google-Smtp-Source: ABdhPJz4pmKPQyktsr1gurufUbLpfuebuRWaNUBtQfOPubEyG+vUyruElznQcZJ4OyglwBPwl8Tnqxp0FKWJ0SUREsQ=
X-Received: by 2002:a17:90a:b78b:: with SMTP id m11mr13304541pjr.13.1600076657810;
 Mon, 14 Sep 2020 02:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200912155100.25578-1-songmuchun@bytedance.com>
 <20200912174241.eeaa771755915f27babf9322@linux-foundation.org>
 <CAMZfGtXNg31+8QLbUMj7f61Yg1Jgt0rPB7VTDE7qoopGCANGjA@mail.gmail.com> <20200914091844.GE16999@dhcp22.suse.cz>
In-Reply-To: <20200914091844.GE16999@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 14 Sep 2020 17:43:42 +0800
Message-ID: <CAMZfGtXd3DNrW5BPjDosHsz-FUYACGZEOAfAYLwyHdRSpOsqhQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: Fix out-of-bounds on the
 buf returned by memory_stat_format
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 5:18 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 14-09-20 12:02:33, Muchun Song wrote:
> > On Sun, Sep 13, 2020 at 8:42 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Sat, 12 Sep 2020 23:51:00 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > > The memory_stat_format() returns a format string, but the return buf
> > > > may not including the trailing '\0'. So the users may read the buf
> > > > out of bounds.
> > >
> > > That sounds serious.  Is a cc:stable appropriate?
> > >
> >
> > Yeah, I think we should cc:stable.
>
> Is this a real problem? The buffer should contain 36 lines which makes
> it more than 100B per line. I strongly suspect we are not able to use
> that storage up.

Before memory_stat_format() return, we should call seq_buf_putc(&s, '\0').
Otherwise, the return buf string has no trailing null('\0'). But users treat buf
as a string(and read the string oob). It is wrong. Thanks.

> --
> Michal Hocko
> SUSE Labs



-- 
Yours,
Muchun
