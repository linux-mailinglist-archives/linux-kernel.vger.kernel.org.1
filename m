Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A3C2D5BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 14:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389245AbgLJNbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 08:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389191AbgLJNa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:30:57 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3205CC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 05:30:17 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id f24so6615239ljk.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 05:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Y1/pCcVVUBfv3HtE9L8Hpubgn3eVeV8xQvQ2V1/F7c=;
        b=pZ+LO5QJlGoNVILFpKMp61lgJEapSo4Muukuh4BzipvJOvo7UPK7aH63a8QDnxRBRu
         8gdyFlum+HyecIZxcXR/tVzeSeV2oVn0hHElChzBWdkeHvdlIW8Uqs2ZMtiXeLcKboNX
         Y9pw53BAa+K9bojIdDQcBL5D0DZrr/6UGIexYlLoGWBd0WiRJ1UPLbUEQubEp1N4VijA
         fsy8eWPZrsVKpwlQrvd2Ah28UmLWQzk3zf+OVAsCzO6vSxuhAZzJzNgXNiE6ul7N25ON
         5JOB4ki6qLEC3XbQz5lvH87lt82jzoD3/ApNDoff3s3m+a8G9rVKIfRbbg3mk3mUz+CY
         0fwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Y1/pCcVVUBfv3HtE9L8Hpubgn3eVeV8xQvQ2V1/F7c=;
        b=bFKxD3UVRJdkr1bNchNmhWtq0vYjPktst2xJNiNMxCNTqzfj74aERa7poHE0Z6XyCn
         MfaFAs+3A/okmJXsNEY+N4n4smrRM619dxf6xyUjnUosfNUZh9NJIkdqcpSGqpbMhELe
         A/p29Eq5gmymQjDParTu7J1stJBs0kl41p5Txc2DfGRT+kI5xS6HTFNPbRqYaZhnk2/P
         /D0dlYTXr8ojOcOlO4vTdlw4ObNKmVF0+Z8tjJrQ7KmWQ5MkBYwsqECXbEvsVnJGV0Zx
         SwaR23vkSwhv/XZYQ38VCYIrwkdSwSmgsFLUisUhPAu2m8Gu18/gPfQN9KQF8Sn7L1Ci
         vQ7Q==
X-Gm-Message-State: AOAM531k4oIzlf2Y+GeXJDoCproGCcsevvNVEKPoYmnLQ3jcM6SO8Fmk
        hMMrrg0vevEd+RN08GKJBV10gsgjmORPTw65EU0=
X-Google-Smtp-Source: ABdhPJz6/LInmyWBeicZXN1hFtBzjWA/tL2UzztmxE+KuDFoSVDLuD2xYTfWuigL789vYz9/QvF9K1XfZxYfUdtq60w=
X-Received: by 2002:a2e:1657:: with SMTP id 23mr3024716ljw.12.1607607015736;
 Thu, 10 Dec 2020 05:30:15 -0800 (PST)
MIME-Version: 1.0
References: <20201207133024.16621-1-jgross@suse.com> <20201207133024.16621-3-jgross@suse.com>
 <CAKf6xpuqdY=TctOjNsnTTexeBpkV+HMkOHFsAd4vxUudBpxizA@mail.gmail.com>
 <72bc4417-076c-78f0-9c7e-5a9c95e79fb2@suse.com> <20201210111454.dxykvyktzwr3fjyk@Air-de-Roger>
 <7425aed6-ff6f-873a-b629-b9c7058e9b13@suse.com>
In-Reply-To: <7425aed6-ff6f-873a-b629-b9c7058e9b13@suse.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Thu, 10 Dec 2020 08:30:04 -0500
Message-ID: <CAKf6xpvxLiBfWKUecbbWW4DZr-gcPeo5PADtiYzwPft8NQ2aeA@mail.gmail.com>
Subject: Re: [PATCH 2/2] xen: don't use page->lru for ZONE_DEVICE memory
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        open list <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 6:40 AM J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wro=
te:
>
> On 10.12.20 12:14, Roger Pau Monn=C3=A9 wrote:
> > On Tue, Dec 08, 2020 at 07:45:00AM +0100, J=C3=BCrgen Gro=C3=9F wrote:
> >> On 07.12.20 21:48, Jason Andryuk wrote:
> >>> On Mon, Dec 7, 2020 at 8:30 AM Juergen Gross <jgross@suse.com> wrote:
> >>>>
> >>>> Commit 9e2369c06c8a18 ("xen: add helpers to allocate unpopulated
> >>>> memory") introduced usage of ZONE_DEVICE memory for foreign memory
> >>>> mappings.
> >>>>
> >>>> Unfortunately this collides with using page->lru for Xen backend
> >>>> private page caches.
> >>>>
> >>>> Fix that by using page->zone_device_data instead.
> >>>>
> >>>> Fixes: 9e2369c06c8a18 ("xen: add helpers to allocate unpopulated mem=
ory")
> >>>> Signed-off-by: Juergen Gross <jgross@suse.com>
> >>>
> >>> Would it make sense to add BUG_ON(is_zone_device_page(page)) and the
> >>> opposite as appropriate to cache_enq?
> >>
> >> No, I don't think so. At least in the CONFIG_ZONE_DEVICE case the
> >> initial list in a PV dom0 is populated from extra memory (basically
> >> the same, but not marked as zone device memory explicitly).
> >
> > I assume it's fine for us to then use page->zone_device_data even if
> > the page is not explicitly marked as ZONE_DEVICE memory?
>
> I think so, yes, as we are owner of that page and we were fine to use
> lru, too.

I think memremap_pages or devm_memremap_pages (which calls
memremap_pages) is how you mark memory as ZONE_DEVICE.  i.e. they are
explicitly marked.

memremap_pages
  memmap_init_zone_device (with ZONE_DEVICE)
    __init_single_page
      set_page_links
        set_page_zone

grep only finds a few uses of ZONE_DEVICE in the whole tree.

Regards,
Jason
