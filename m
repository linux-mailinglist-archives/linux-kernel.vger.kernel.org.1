Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1D520A614
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 21:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406760AbgFYTq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 15:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgFYTq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:46:57 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC907C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:46:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d15so5146585edm.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AefTn81PCzGoV6RydnPvgSzeIlVQ4BF3GxcojiBqKZA=;
        b=AxlvF/uwBUXEWSNxZBaEe3m164Hbx4XTV0ok9IVSxL3WwUjg0S14qEk5V3q/m1YWCX
         f/GApWn9oUv85ISrxZVua0JeuaEE/fku6jYvspd/F9ORpVrPKEDZkcfPvYZZgWHC5JGe
         LsMx7B62R7EW+lTgAQq/HpTS9RtvhuU/1dPHEwBWzipKG6LeNXhdwqh+m9nEr9KDt6HX
         9Mim9gnY2xk1RZOi8rC+xmsJeikzLvTJW3KJzpkyOS86DlL45jlvPq6LcbX5EEK248p1
         cuc9ZHE1pHwXQzIhVQTWhAJFmYSpdnH8wEpNGkoa3y0SrdJLdDoVtBi1yOigY0csiUFa
         Imtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AefTn81PCzGoV6RydnPvgSzeIlVQ4BF3GxcojiBqKZA=;
        b=R9BqGkfZe0C0kMc4YmeL2HuoKkbVo3XSzLcqK0HXlNdMcEYBR2FikEI6zul7+SrTL7
         DClhYKoo3XWpSuLYjCy2ii3oAlXoWZErMbtk50my6PCaVPjjTlZ9cKHInUDinNmw4UJA
         m7kVwK7qxx3VZLmTfp645FE3QWFnsbAYhsXNuH44PIAEaqEOn9q/IC0dECP/o9kTuYGI
         I8EeimhSMt6wG+FOSmc4SZ2oMynjCNkbesWMqdIkd63Rtovtnk1ZXRgRECRBN3niRK0T
         IWiDReWuPAM5boZOZwp5xBs9kBMHlLZJLsb8wYuYJwyALfKuTlN1a7mkBGE8bCuKx5ea
         0Tuw==
X-Gm-Message-State: AOAM530evh4XQSUjlJYafgHAB6VoBiW8/+6JaQLBDHYTm6/glM74c7a1
        9abRXHnA8MTD4woiHMnT6XYxhasU8G3FsJWGlQl20w==
X-Google-Smtp-Source: ABdhPJy7r4zUfBbgkWGwZe/U0m7RIacDfnm09kXSX9vVu6c/1xpVMZWQHAtCnB5foW5Wa5QRjexSRvZowQeJGc1NoY4=
X-Received: by 2002:a05:6402:459:: with SMTP id p25mr33041747edw.383.1593114415366;
 Thu, 25 Jun 2020 12:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4gMQsBSQ-kXM6H_zz96ZTJ5F0XnDfq6_mZTn4t9JwmEpA@mail.gmail.com>
 <4D73CD59-BFD5-401A-A001-41F7BF5641BA@redhat.com>
In-Reply-To: <4D73CD59-BFD5-401A-A001-41F7BF5641BA@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 25 Jun 2020 12:46:43 -0700
Message-ID: <CAPcyv4hnsUoavnzX8q5VReiLXrOsOYW0Ef5GDKxQtS+6pQLy4A@mail.gmail.com>
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>, Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:53 PM David Hildenbrand <david@redhat.com> wrote=
:
>
>
>
> > Am 25.06.2020 um 01:47 schrieb Dan Williams <dan.j.williams@intel.com>:
> >
> > =EF=BB=BFOn Wed, Jun 24, 2020 at 3:44 PM Wei Yang
> > <richard.weiyang@linux.alibaba.com> wrote:
> > [..]
> >>> So, you are right that there is a mismatch here, but I think the
> >>> comprehensive fix is to allow early sections to be partially
> >>> depopulated/repopulated rather than have section_activate() and
> >>> section_deacticate() special case early sections. The special casing
> >>> is problematic in retrospect as section_deactivate() can't be
> >>> maintained without understand special rules in section_activate().
> >>
> >> Hmm... This means we need to adjust pfn_valid() too, which always retu=
rn true
> >> for early sections.
> >
> > Right, rather than carry workarounds in 3 locations, and the bug that
> > has resulted from then getting out of sync, just teach early section
> > mapping to allow for the subsection populate/depopulate.
> >
>
> I prefer the easy fix first - IOW what we Here here. Especially, pfn_to_o=
nline_page() will need changes as well.

Agree, yes, let's do the simple fix first for 5.8 and the special-case
elimination work later.
