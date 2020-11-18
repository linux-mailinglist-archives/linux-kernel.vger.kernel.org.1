Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701A72B8554
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgKRUHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgKRUHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:07:54 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BB5C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 12:07:53 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id b17so3700034ljf.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 12:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yeKLzuYfSfYjwv9jvXe2h8dCQ8PeIQ4687zDP48KQD4=;
        b=auA3imED+bIoRMFGpqlHbmGJvk5kJIVk9BvJ71Ira2vwQeTwsyJoF2ODXO+9860si8
         gGjs0urQ/Cc2ujf7odeViQab+MFQjbKyera6rW0BZgPgDUbpSn4h0vHZ6Mrw7fnkOS4/
         kyW9BeyxpySDSnlLImvtf8XWUsJ80qtN+eYto7cHVh8iQ5T8p3mk/aCGOwd2ia2g4Wx2
         9WGJTUhcmEpRjMBm7Aboc0RJsXYZVbZpBx4XfjC4B4H3WpCC9/Qp3WdmCbX/du9KoVrC
         tU0ah1OTAK7NJyi7Q291Mdo/fZ60pSDzMEKHw6I9rXgeJb6DgqSwvz3NX0nMCGEqfyq/
         hhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yeKLzuYfSfYjwv9jvXe2h8dCQ8PeIQ4687zDP48KQD4=;
        b=m2az6Vp1y/FflCTLDDGcoHYrHnewoefHUg6ucmVh+faNzPKW/qk873hji7sU2JkIEz
         wQq0IEpcFP+DV2Al80w36ZN08M85y5kdmjaWqG1xZAQYjn3Erlf4LrVSZhsInJLVoVMc
         atVf/s0FBYOrWTpcEl6odN0G0wpwvG3ICyeEzt5X1qeQ/4HeeFnWrTFmEgUYWpTr16W/
         S2b7F1zmAb1jUC54JJhjhs2yBTcbgF57ToAgx1RhCmAbETo+coraVjNbMS8st5aK8khQ
         wODXx73HGrrcSWNbUhG4xTMQYyx7VdsYRD+z4s8Q8DuHKhqL/VzBm1lzVbOP4PyIPJym
         WGXQ==
X-Gm-Message-State: AOAM532WCxHFDUblV8uv9JcV5ELmiIMvs4ydQHrH5Oj5ISWx7bOdvo/F
        SkmCn6QSoRIWqUUgKR9DARActP7wVkRNN/smWPYaBg==
X-Google-Smtp-Source: ABdhPJwJ18EsoGPbvczbpZK4lj+zDySbnfbpX0LfAcTYVKWWJzj2P1bJUMLF8F/dQKOCRgpXcYsePLJ5tnNGIwss8Jo=
X-Received: by 2002:a2e:58a:: with SMTP id 132mr4584575ljf.77.1605730072077;
 Wed, 18 Nov 2020 12:07:52 -0800 (PST)
MIME-Version: 1.0
References: <20201118175726.2453120-1-shakeelb@google.com> <20201118195822.GW12284@dhcp22.suse.cz>
In-Reply-To: <20201118195822.GW12284@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 18 Nov 2020 12:07:40 -0800
Message-ID: <CALvZod4nG-6DBy_sJKbCg+xrYf1DS2ZJ3zkbHQSc4q8iZiPjwQ@mail.gmail.com>
Subject: Re: [PATCH] memcg, kmem: further deprecate kmem.limit_in_bytes
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 11:58 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 18-11-20 09:57:26, Shakeel Butt wrote:
> > The deprecation process of kmem.limit_in_bytes started with the commit
> > 0158115f702 ("memcg, kmem: deprecate kmem.limit_in_bytes") which also
> > explains in detail the motivation behind the deprecation. To summarize,
> > it is the unexpected behavior on hitting the kmem limit. This patch
> > moves the deprecation process to the next stage by disallowing to set
> > the kmem limit. In future we might just remove the kmem.limit_in_bytes
> > file completely.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> I am not against this. I am just not sure whether one year is enough for
> those users who tend to have a more considervative kernel upgrade path.
> I am not worried about SLES user base much as we didn't even enable
> KMEM accounting when it was still guarded by a config option. Not sure
> about others though.
>
> Considering the code cleanup is not that large,

I was thinking of removing the kmem page counter in the followup but
thought of sending this alone to see if now is the right time.

> I would rather wait some
> more. But you can add
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> Maybe we can ask Andrew to put it into mmotm for few releases.
>

Ok with me. I will send the full series and will ask Andrew to keep
the series in mm tree for a couple of releases.
