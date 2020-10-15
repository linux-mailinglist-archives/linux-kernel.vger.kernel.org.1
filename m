Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4965728F76C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 19:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390103AbgJORDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 13:03:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389893AbgJORDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602781408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MZ+HtkW9/US8p9eIWMS1JqM01+ysPLOkWvnGLPTK0bk=;
        b=R+LB2SGo8dEJimaEO+igBX8TTV0sHwqTNBwQ20njW5cuf4k5clkvBtrlH+4tBAsL79/Fuo
        Z8Li29hIpaBOh4u/WoPdO/c7jsDJXtgf7Ly4pK7R6nU4+DWN3h7+ta4Qt0FivHbN1i34iG
        8mFrK0fCFphFBd/f3qgjmpwHNOoMkHU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-nl5heo7BNFG4wAmcHSERNg-1; Thu, 15 Oct 2020 13:03:26 -0400
X-MC-Unique: nl5heo7BNFG4wAmcHSERNg-1
Received: by mail-qt1-f197.google.com with SMTP id t40so2310396qtc.19
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 10:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZ+HtkW9/US8p9eIWMS1JqM01+ysPLOkWvnGLPTK0bk=;
        b=b6j36fmMfGWV/gRH9uOsG+yhg9wqyDBhuD4yYLMa8vDhUXgjeR10iz+7lJ0Ro6tuCb
         AomORfzOoPEZJcat7x1OE1JmJ+yeA2WKpzzFwE5k69OmfVXX/1Wclggi2sgf/1/QTYkW
         38CvRmjMd5+9MXSZZ352INW9otspdETRJayuP4EJ4qdCCZKquzRjFvjAjVtVSkDkij42
         qRa+fn+UV162HSGP6/iz6zeMfYXVsRDR7AIbUegRSZvpFxnQcwbsmABHMeoFkVVaeK1c
         lKIiFELPIswsUQbvAcqiZVgjLz15KOHoZY0scxT5Y/rJYPNVH+1airCgV5+PzSk7IjfR
         rFRw==
X-Gm-Message-State: AOAM532uJKu4hKYB0t5AoxtL7UuFWWbv/ktDT4ylbxc+//EIBtS6qpWt
        MAYQkC/ME4UR/2XsiNRVpOmjzfROyliPwKePv2/4SAIXKlzjNNcTEFaur9cv4tya+qnjChbe+vJ
        ObYRLC8rafZw97+BBxsolTGEKbESIIpQZyE6SyW4f
X-Received: by 2002:a05:620a:1668:: with SMTP id d8mr5081784qko.192.1602781405503;
        Thu, 15 Oct 2020 10:03:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9/19KaH9fBtSabelwlRB2jV6hDoMo13yhmIvM2xtY6dLjjAeCvxgABDoRY001mtnGcqtc06Nfdel1kicxM30=
X-Received: by 2002:a05:620a:1668:: with SMTP id d8mr5081767qko.192.1602781405261;
 Thu, 15 Oct 2020 10:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201014075419.19974-1-keitasuzuki.park@sslab.ics.keio.ac.jp> <CACO55ttZCVZM2v1oWRq7mzZy3DVDe3h1fH80D6RNFM3xR4VjuQ@mail.gmail.com>
In-Reply-To: <CACO55ttZCVZM2v1oWRq7mzZy3DVDe3h1fH80D6RNFM3xR4VjuQ@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 15 Oct 2020 19:03:14 +0200
Message-ID: <CACO55ttfu1xbQ6e1rk0KZkNdJ7Jik91u0vp=e046hf6D7g1Z9Q@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH RFC] drm/nouveau: fix memory leak in nvkm_iccsense_oneinit
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     takafumi@sslab.ics.keio.ac.jp, David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 6:32 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> Ben, I think this is like the 5th patch tackling this issue, I think
> we should merge one of those.
>

maybe I just confused that with reports, but it seems to turn up quite
a bit and maybe I should have pushed more of it as well...

Anyway, the patch itself looks good.

Reviewed-by: Karol Herbst <kherbst@redhat.com>

> On Thu, Oct 15, 2020 at 6:23 AM Keita Suzuki
> <keitasuzuki.park@sslab.ics.keio.ac.jp> wrote:
> >
> > struct pw_rail_t is allocated as an array in function nvios_iccsense_parse,
> > and stored to a struct member of local variable. However, the array is not
> > freed when the local variable becomes invalid, and the reference is not
> > passed on, leading to a memory leak.
> >
> > Fix this by freeing struct pw_rail_t when exiting nvkm_iccsense_oneinit.
> >
> > Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
> > ---
> >  drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> > index fecfa6afcf54..8ba8d8e3f52a 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> > @@ -280,8 +280,10 @@ nvkm_iccsense_oneinit(struct nvkm_subdev *subdev)
> >                         }
> >
> >                         rail = kmalloc(sizeof(*rail), GFP_KERNEL);
> > -                       if (!rail)
> > +                       if (!rail) {
> > +                               kfree(stbl.rail);
> >                                 return -ENOMEM;
> > +                       }
> >
> >                         rail->read = read;
> >                         rail->sensor = sensor;
> > @@ -291,6 +293,7 @@ nvkm_iccsense_oneinit(struct nvkm_subdev *subdev)
> >                         list_add_tail(&rail->head, &iccsense->rails);
> >                 }
> >         }
> > +       kfree(stbl.rail);
> >         return 0;
> >  }
> >
> > --
> > 2.17.1
> >
> > _______________________________________________
> > Nouveau mailing list
> > Nouveau@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/nouveau
> >

