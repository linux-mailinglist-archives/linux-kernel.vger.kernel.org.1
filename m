Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427F428DBAF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgJNIep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729556AbgJNIee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:34:34 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEBEC05111A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 00:19:08 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id r10so3965586ilm.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 00:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dzOJ/swm9JGAByIHn/wEgfUebM+eNtx9/pR8X+4E4is=;
        b=0LYJQWdozCaK1EN3ItjEZqoVtwC5Y2vmWWI7cXZLqMIOGaE3Q3jLXN8eefIqw18imc
         63Np64Sl5g0aPt1Ww6Jl5YY6rmP1CRkWofUimrjqFpp26+KrkUebuTn7xmZcUrNF0awL
         JeMYF9NkGKH8Va2+YfH8wZEqMW+4JSww+jPMIQcSbU1Im9Dk4sdzY/94eMcBXZ4qC+ME
         q0+bCKzUu8LUBrmZmBHBKC1RMDNqEQxfDg/H1twem6upQPVY7le1b4e5NwXSfDipxsXY
         gCPrqO0LQ1fZpDTtYZhHxBV6UGf4bDWxvArR/1uZAFGSA3/jLlEfsNHni7e1ByMlhNMv
         ocYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dzOJ/swm9JGAByIHn/wEgfUebM+eNtx9/pR8X+4E4is=;
        b=thN7DsBzf6vfV0ZH6sNFAk++ZEdwWUlHn9eMASPxQQTLEWvQ0qqCjiUfV3NxXF8SJn
         rlxPF91TTh3QL1y2Y4dHKL+qW6lkH2LcCqSRfWoidZcQZp7PAGIobqHwGWsCY6dttJhQ
         KucKT7cCwEh6QPaOz3BJqfQO+UyDkmugop6uDqiYZvYXwinby6eIs0pBhhgHWJ5Eh9qu
         KOU9aBNbryfVCmijXDriNXtIJL9f5qUtkEYLTZn301ceAO9IYDAOnkUOzOMi7G9bHQaq
         g3+oYEFl8lGgZUGtGqtWfHjETt7/+fuAeACQTo2Uf1qduzUBCtJKfWnVHwLG9oqsq5AQ
         UB/g==
X-Gm-Message-State: AOAM53255ERv0OXsHxFZFzDBeL8/+Pk8dPMWKZXpELKuA34nvGTtYCx9
        TsGGbHM2yTeEyFNUUWahPg7RrTdor5j6ig7XGBamfQ==
X-Google-Smtp-Source: ABdhPJwuTnKmbtckmY7mH0qDFEjoARiEYUtMovUJ9OGm8LgOhAhHFufHuSKcRL3BGBlZP3QHEXQ0W7kvI1j4bFo1uv4=
X-Received: by 2002:a92:bb58:: with SMTP id w85mr2963629ili.40.1602659947570;
 Wed, 14 Oct 2020 00:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201013073055.11262-1-brgl@bgdev.pl> <abd717c9-9eaa-d4bb-3fd8-ff7250d97ab7@linux.intel.com>
In-Reply-To: <abd717c9-9eaa-d4bb-3fd8-ff7250d97ab7@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 14 Oct 2020 09:18:56 +0200
Message-ID: <CAMRc=MdLXaPNUwbUPGJS1AY0pq5je9zsGM7eHShLT=f6mT5Dww@mail.gmail.com>
Subject: Re: [PATCH next] iommu: intel: don't dereference iommu_device if
 IOMMU_API is not built
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 2:49 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> On 10/13/20 3:30 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Since commit c40aaaac1018 ("iommu/vt-d: Gracefully handle DMAR units
> > with no supported address widths") dmar.c needs struct iommu_device to
> > be selected. We can drop this dependency by not dereferencing struct
> > iommu_device if IOMMU_API is not selected and by reusing the informatio=
n
> > stored in iommu->drhd->ignored instead.
> >
> > This fixes the following build error when IOMMU_API is not selected:
> >
> > drivers/iommu/intel/dmar.c: In function =E2=80=98free_iommu=E2=80=99:
> > drivers/iommu/intel/dmar.c:1139:41: error: =E2=80=98struct iommu_device=
=E2=80=99 has no member named =E2=80=98ops=E2=80=99
> >   1139 |  if (intel_iommu_enabled && iommu->iommu.ops) {
> >                                                  ^
> >
> > Fixes: c40aaaac1018 ("iommu/vt-d: Gracefully handle DMAR units with no =
supported address widths")
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> With commit title adjusted to "iommu/vt-d: Don't dereference
> iommu_device if IOMMU_API is not built",
>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
>

Do you want me to resend it again with a changed title or can you fix
it up when applying? Or should someone else pick it up?

Bartosz
