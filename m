Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A01B2D4A05
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 20:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbgLITZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 14:25:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39130 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729345AbgLITZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:25:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607541816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1JiCuAJtsnJo9IaenHy9QA62PZ6HCKOgtQt5HnnymsY=;
        b=Yyq4HwOJPLrjVO2o1Rmn3sTvS8F0B2b7fbntMrXbBUN6u+eMU+yak0KcJbCPmw7zvezWJO
        Rk51QoygsiOrKz6gZfIAkBkO3ASQHinT2xQEtUic0dwfqmlv7WGQ9NcniuwRm/6Wf194fH
        p7ymoXeBQKiydOisj10749JoJXUXeU0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-GjPhdllHMO6FtPVnWrfWtQ-1; Wed, 09 Dec 2020 14:23:34 -0500
X-MC-Unique: GjPhdllHMO6FtPVnWrfWtQ-1
Received: by mail-lj1-f197.google.com with SMTP id a23so2599963lji.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 11:23:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1JiCuAJtsnJo9IaenHy9QA62PZ6HCKOgtQt5HnnymsY=;
        b=dESkV8HyO5ABm0yzkyeL6s7g9JqPj/DcTng5i32qhIzpxkSZj49s5yk9sD4fw3ke5v
         KKvHXplKxLZM/gTQr5nTYncnex70Du/zCY64ozd++QrQN+SBKZw0E/jlyKEdsIsANoYI
         0ftSIrX1fXaU6BQMFKMeQsMh88w3cNNwwY4FpCa6M4XAGxCsQAWRVymukiMGDKiOnh7I
         GsyghC4o6rWnpdWAv0YUT9VDOf3sy/h3LEiTyDo4l22wqpngovC/ZnQTXrZBejReCrTO
         0GDTW+kp1/Bdqdj/gviPcfzVNSOPR/sBxUSR38NShOrVEA4W6yhrDwFTX4yzeJaRGV4G
         +gqw==
X-Gm-Message-State: AOAM532zsMqSAY76YRoAP6/RdRIrhI6WXAC3l3rS956ivUZa9qiPO+uU
        KM5CEaUeTvoY2wHxWHmGKABCerEl9tE6Tldz+b3RiLBuKfV+d6mk3kbya0TpJXff+40i1gbAw75
        8+4fWw2ySTssR19FtFawJhJz1vUqjNCITz5BL8CCB
X-Received: by 2002:a19:3c5:: with SMTP id 188mr1461085lfd.202.1607541812610;
        Wed, 09 Dec 2020 11:23:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGoODFbEOcKQz/ScpB8oV7Mi7tniiV7k9AAEt8DGQLQC64ieiPFOacte5n9SNYVXZHhEFWrD/sl1+aaOWjS04=
X-Received: by 2002:a19:3c5:: with SMTP id 188mr1461076lfd.202.1607541812435;
 Wed, 09 Dec 2020 11:23:32 -0800 (PST)
MIME-Version: 1.0
References: <20201209141237.GA8092@willie-the-truck> <CAHk-=wht4inbTVVMt2TNDxR_cVjSNaBU3JYyKtRMVovWePb65g@mail.gmail.com>
 <20201209185020.GC8778@willie-the-truck> <87tusulrog.fsf@redhat.com> <CAHk-=wg370+69ZoXFdUABwwqNaej3hrjcqAsb56J++h2oXKJpg@mail.gmail.com>
In-Reply-To: <CAHk-=wg370+69ZoXFdUABwwqNaej3hrjcqAsb56J++h2oXKJpg@mail.gmail.com>
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Wed, 9 Dec 2020 12:23:06 -0700
Message-ID: <CALzcddv8DfL67uZCEWK-d=uMFJD34=kaWEHVcHoXMvrStaoe2w@mail.gmail.com>
Subject: Re: [GIT PULL] IOMMU fix for 5.10 (-final)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 12:18 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Dec 9, 2020 at 11:12 AM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
> >
> > Since the field in the device table entry format expects it to be n
> > where there are 2^n entries in the table I guess it should be:
> >
> > #define DTE_IRQ_TABLE_LEN 9
> > #define MAX_IRQS_PER_TABLE (1 << DTE_IRQ_TABLE_LEN)
>
> No, that "DTE_IRQ_TABLE_LEN" is not the size shift - it's the size
> shift value in that DTE field, which is shifted up by 1.
>
> That's why the current code does that
>
>    #define DTE_IRQ_TABLE_LEN       (9ULL << 1)
>
> there..
>
> Which was why I suggested that new #define that is the *actual* shift
> value, and then the DTE thing and the MAX_IRQS_PER_TABLE values would
> depend on that.
>
>            Linus
>

Yes, when I read it my head was translating it as setting them both to
512 and then
I forgot that it gets shifted over 1. Which considering I was the once
who noticed the
original problem  of it still being 8 was a nice brain fart. This
should be fixed like you suggest.

