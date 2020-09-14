Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780262693E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgINRog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgINMFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:05:41 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBA4C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:05:40 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u13so11398093pgh.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GsOIVPKx7/GKwttOx4gkrBI8E8JMmQp3RWxUAc5wfcY=;
        b=G1oJRVfApka43Z3M51QifLTqy6wQ/iKgboQET0cTsUGhqa2VvUp8zDM8KlmGoMSTn2
         4Nrv8KQBR0s4z0UdeuHvXlON0PxsuBLT2bR5RsbPH5Ds+0mk4ZSITL47v4bUSSrYxRf+
         3JbtyFmqXOdHv5OcDFVVpHHmldqYsBpLMfDiqL+XHgcz8n+Rw6WA48PDWy7xI28TERZO
         OX3Ivrdkp571bX+Qwd4tBKr+MUvOr2dhIor2S9JPGrGrcy3jqr9YXy3I4nvalNuVLHrq
         pXLybs29hC36HQhOnDUctrx6f05OvpzbtddhDB62gOnd0DXz75rX20WGUGWvRC2TiNCL
         7h3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GsOIVPKx7/GKwttOx4gkrBI8E8JMmQp3RWxUAc5wfcY=;
        b=jSBT5qT73ltSg95EwfwAWvK5LfSNZO06tImeZ/pUILD6Eu3GwgsLyklNbBN3dKytys
         uw5iZXeohmKOFBoZB+NZrObBYj5QRAtJji43AlvYplBHmdu/EKn4/IXcVUemK9oIVnnF
         aQuNXfSZvHOrRdL1IKOTr+w98SrPI5AzgDcO091fSvGiX44izl/euGOzWcD00ZFLhvUP
         Bv6Tj5N1nSgmZFK9uGq5ZZXJuJ3KN7TI7AcO+ZVAGXUo0XW/skH3FooZnM7d5j9jCXcf
         04kV9cYrj2z/wPucFlSVoCJkEFNiukOxUzq3tvoXOMqEjy6f15QyHIc7VIElcm2SrolC
         S3nw==
X-Gm-Message-State: AOAM5325Q3C/X1rkNzi8UE/7Uo03IwSvAnQBZ2vumLApccc8uTPd6sW5
        dLL9Hg1Lw1NLVBcyAhHDdamaNZ8n1pz0JgJ8UrQCFw==
X-Google-Smtp-Source: ABdhPJy0PPAh9+CRT36/WnNcBPpBRgPC600c1hQtAsuYJZS5GFpKJtb5l5v2LAjd1XIksmtFfFkruvL0x/daNTrYq1o=
X-Received: by 2002:a17:902:a605:b029:d0:cbe1:e714 with SMTP id
 u5-20020a170902a605b02900d0cbe1e714mr14271096plq.34.1600085139550; Mon, 14
 Sep 2020 05:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200912155100.25578-1-songmuchun@bytedance.com>
 <20200912174241.eeaa771755915f27babf9322@linux-foundation.org>
 <CAMZfGtXNg31+8QLbUMj7f61Yg1Jgt0rPB7VTDE7qoopGCANGjA@mail.gmail.com>
 <20200914091844.GE16999@dhcp22.suse.cz> <CAMZfGtXd3DNrW5BPjDosHsz-FUYACGZEOAfAYLwyHdRSpOsqhQ@mail.gmail.com>
 <20200914103205.GI16999@dhcp22.suse.cz> <CAMZfGtWBSCFWw7QN66-ZLTb8oT7UALkyaGONjcjB93DyeeXXTA@mail.gmail.com>
 <20200914115724.GO16999@dhcp22.suse.cz>
In-Reply-To: <20200914115724.GO16999@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 14 Sep 2020 20:05:03 +0800
Message-ID: <CAMZfGtUBAO8AApzuDZZviCUpPyy4-JTCpXTRSzimq=K9aG467g@mail.gmail.com>
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

On Mon, Sep 14, 2020 at 7:57 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 14-09-20 19:46:36, Muchun Song wrote:
> > On Mon, Sep 14, 2020 at 6:32 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 14-09-20 17:43:42, Muchun Song wrote:
> > > > On Mon, Sep 14, 2020 at 5:18 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Mon 14-09-20 12:02:33, Muchun Song wrote:
> > > > > > On Sun, Sep 13, 2020 at 8:42 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > > > >
> > > > > > > On Sat, 12 Sep 2020 23:51:00 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> > > > > > >
> > > > > > > > The memory_stat_format() returns a format string, but the return buf
> > > > > > > > may not including the trailing '\0'. So the users may read the buf
> > > > > > > > out of bounds.
> > > > > > >
> > > > > > > That sounds serious.  Is a cc:stable appropriate?
> > > > > > >
> > > > > >
> > > > > > Yeah, I think we should cc:stable.
> > > > >
> > > > > Is this a real problem? The buffer should contain 36 lines which makes
> > > > > it more than 100B per line. I strongly suspect we are not able to use
> > > > > that storage up.
> > > >
> > > > Before memory_stat_format() return, we should call seq_buf_putc(&s, '\0').
> > > > Otherwise, the return buf string has no trailing null('\0'). But users treat buf
> > > > as a string(and read the string oob). It is wrong. Thanks.
> > >
> > > I am not sure I follow you. vsnprintf which is used by seq_printf will
> > > add \0 if there is a room for that. And I argue there is a lot of room
> > > in the buffer so a corner case where the buffer gets full doesn't happen
> > > with the current code.
> >
> > Thanks for your explanation. Yeah, seq_printf will add \0 if there is a
> > room for that. So I agree with you that the "Fixes" tag is wrong. There
> > is nothing to fix. Sorry for the noise.
> >
> > I think that if someone uses seq_buf_putc(maybe in the feature) at the
> > end of memory_stat_format(). It will break the rule and there is no \0.
> > So this patch can just make the code robust but need to change the
> > commit log and remove the Fixes tag.
>
> Please see my other reply. Adding \0 is not really sufficient. If we
> want to have a robust code to handle the small buffer then we need to
> make sure that all counters will make it to the userspace. Short output
> is simply a broken result. Implementing this properly is certainly
> possible, the question is whether this is worth addressing. It is not
> like we are adding a lot of output into this file and it is quite likely
> that the code is good as it is.

Got it. Thanks.

> --
> Michal Hocko
> SUSE Labs



-- 
Yours,
Muchun
