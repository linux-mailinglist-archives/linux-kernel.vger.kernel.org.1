Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8CA29DBF0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389231AbgJ1Wq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731884AbgJ1WqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:46:13 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43448C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:46:13 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id bn26so1195606ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0jVxeGv6lE9HxG3ioZ1jNMfiO7oQfXoYg0ePUwTMDgQ=;
        b=Y47tug5b8PS5GVPWZ5arNveYafl4JnStVgSr/qZmy4WMW6wLuDTGfKhQt582GpTP9n
         VaX4J1iOOfcC9cqURSGuBTpjB5MHJyq1mNBcQTvCskhYUqF6bkLCy5AQk3k1tAi11Zlj
         InKArBY6f0SHcVV6CdqF5hqhWXzbBTzIbMK8EO/b0Trpp/V1bwmsJ5iTQXadbQUpXO93
         gVT6KwN/yGKCVG9w8JM2XKakHZ2v7HUoGkEUjlIlnzZp8L9L71mAsvpQuk9v+oa7XOAs
         tqHKWRGPBACtP/01HsIquOdIS4+cs+Ld2MZqc5GHCGyGS6uhT0AJb9uwlt6FqK25Kryw
         iFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0jVxeGv6lE9HxG3ioZ1jNMfiO7oQfXoYg0ePUwTMDgQ=;
        b=OHy8tau3AvEfG4kYXwWKx2UNInR+CbFzwDE5isBT04D7XMyoC+q6Aqo+5Q67m/n66u
         iHU/yhq81EijHzhLZU/MhU5uUHUFzTxewGUoP+UtYIDf/gBrXuyxjfn9xMEIQsniBdmP
         xVFZ253cvFMbzoqoQJivUR8cKUz5WPP+kCmtZYboFcjJUXrKLe0a3jYnEGT+b9MOkFGd
         +3GNiarPhCukPUkytlGOcjB/f0ojoIQPjJjGzaFpSCuGbPK1N5OjUuy4cvJMMQNjirwT
         AxmlXl083VgqcwrtcimoJlaW0dKT3T6Hbg5fMd5rSoVqeTVT/1MwuhorGj9COqa9DhfK
         yAUw==
X-Gm-Message-State: AOAM533yfXRDHNaQ+Fnvf+doxlFhD+OqwpXH6I9cuWv4byxLL/OvZ5uN
        DliMGbjiF+f8ynDllqOwwO+/O9f1zGdMOwh5iTC5S0GNTQ==
X-Google-Smtp-Source: ABdhPJwEzZ6iuiYaqP3D8WgJUCMcZ88Ip3ZyPs/mRAVgBH9lthbImUjuYFxHiRFl7WkTjg/dMh67mJNU6KVwr/0CDdc=
X-Received: by 2002:a17:906:af87:: with SMTP id mj7mr5178601ejb.178.1603848385218;
 Tue, 27 Oct 2020 18:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <7081a5b9c7d2e8085c49cec2fa72fcbb0b25e0d7.1600778472.git.rgb@redhat.com>
 <CAHC9VhSPk2RiMsnjTKw02_+_1Kagm06m+-r=ooNruT+fuuixYQ@mail.gmail.com>
 <20200923144852.GK822320@madcap2.tricolour.ca> <CAHC9VhRu4KEyp+e0tbSbObL1y0+90z_Znp+0z-hmnj5V68bh0w@mail.gmail.com>
In-Reply-To: <CAHC9VhRu4KEyp+e0tbSbObL1y0+90z_Znp+0z-hmnj5V68bh0w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Oct 2020 21:26:14 -0400
Message-ID: <CAHC9VhTBxdtC8YF_Vze54WQgfhf3kH+2RAGnsjzf2whwJw8SOA@mail.gmail.com>
Subject: Re: [PATCH ghak120 V5] audit: trigger accompanying records when no
 rules present
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 1:47 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Sep 23, 2020 at 10:49 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2020-09-23 10:29, Paul Moore wrote:
> > > I've gone over this revision a couple of times now and it looks okay,
> > > but past experience is whispering in my ear that perhaps this is
> > > better to wait on this for the next cycle so it gets a full set of
> > > -rcX releases.  Thoughts?
> >
> > I thought I had lots of time since we were just at the end of the
> > previous cycle when this failed the previous time...  Ran out yet
> > again...  (there were two weeks of PTO and a devel system rebuild in
> > there somewhere...)
>
> We are at -rc6 and assuming v5.9 is released after -rc7 that would
> give this roughly a week and a half in v5.9-rcX; considering the
> history of this patch (reverted, obvious problems in development) I'm
> not confident -rc6 provides enough soak time (even if we go to -rc8 I
> remain skeptical).  In addition, we've got a history of not taking new
> work that isn't a bug-fix past the -rc5/-rc6 timeframe.  This is why
> I'm debating holding this until after the merge window.
>
> > It isn't my call.
>
> I asked for your thoughts on the matter, surely you have the liberty
> to comment on your own opinion :)

I never heard back on this, but the patch is in audit/next now.

-- 
paul moore
www.paul-moore.com
