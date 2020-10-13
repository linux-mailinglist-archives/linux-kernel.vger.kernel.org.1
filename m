Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7A428C96B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 09:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390183AbgJMHbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 03:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390018AbgJMHbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 03:31:50 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A65FC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 00:31:49 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u19so21230192ion.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 00:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8elHjBbADG4GvNsj3EdxmL1/azNofpsxhsXHwpi5wJA=;
        b=HE5Fni69H1Ts6Mzf1OQbVCJMsO8eQBZnLWNM0ziUwR+JlnIg2a3QorWVs2mrz+c3h8
         h3W+NZjEAyEYYukEbjm8NWQ1xMk07TaiTfNxkw5EmxNel2XO1zyjomJNwCl9u8IaDLQe
         h/s5YsBQNbfwkgR64Kyw8bIw7lasOtsxLYtNKqgkkzrscYBLDqWq88++1W3XF09SY0YQ
         /FWo72n2fPbON4xhTo8eKMLs7my40Z210SuIrOGw1iHQjP6egEQ/qVccsTWn1JbLr9IQ
         /cH15YIIxG17YX+JktQTeVqoLmPZeO4G/jLc0gGSCvxN4PxEKJj52CAXuW1DFrEvPQCy
         15Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8elHjBbADG4GvNsj3EdxmL1/azNofpsxhsXHwpi5wJA=;
        b=L7gB0EoWSb8YYKe1yF+PN0pSFUgXLHcPfq39SWhkNB1bfjlIoEfpXpHiBA0hgCD3Sn
         86clEydVyAMsiSU0FhFITfxcyO3rn+L672iNmrr21S01EKDfxn2ru2Rt0M4jvRSnmuWk
         zrL4K1liWJXYA7kX+CcBdMRITyxRYDB90FEGoTBjzYoFZw3fZzhvo0TGhOUZhBN4A9Id
         c3YioDYKSD6+ETJAzIKyNjjzhnhBETU0Cmlii+d0M9CE9SEWd74gS4kMaA5zneIOxMIf
         4Pi6BLOHjL+aLzjrOigwWWwoQj6FwExyo4R+HFfx78ihANaYT/38sS0wNnM71y183I20
         ITnQ==
X-Gm-Message-State: AOAM5320gM8ue0sEpsLdPMwi5NNmJv1OKf5hiSdIOharA4BtLt0o5XKi
        5BY78G437ey0Kv1U3E49VnCzJ/OBUjOyRG0YolBaC1tL3kU=
X-Google-Smtp-Source: ABdhPJxFDGTT23DHZldxhxBqbTDCnu+xE4jDOIuZxypsqEVuC9tkxUB1XkFuAIA+s2uKw9aoiLtEszSPYQy+WIgizfk=
X-Received: by 2002:a6b:ef0e:: with SMTP id k14mr19321354ioh.131.1602574308924;
 Tue, 13 Oct 2020 00:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201012123105.32652-1-brgl@bgdev.pl> <0071e295-51c7-3496-df59-c5712cef93a2@linux.intel.com>
In-Reply-To: <0071e295-51c7-3496-df59-c5712cef93a2@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 13 Oct 2020 09:31:38 +0200
Message-ID: <CAMRc=MfNQGfW-jS4SNLxhmU6D8aN5f31N7qJkPjJ6izvXxXORg@mail.gmail.com>
Subject: Re: [PATCH next] iommu: intel: make DMAR_TABLE select IOMMU_API
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

On Tue, Oct 13, 2020 at 3:33 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi,
>
> On 10/12/20 8:31 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Since commit c40aaaac1018 ("iommu/vt-d: Gracefully handle DMAR units
> > with no supported address widths") dmar.c needs struct iommu_device to
> > be defined. We need to unconditionally select IOMMU_API when DMAR_TABLE
> > is selected. This fixes the following build error when IOMMU_API is not
> > selected:
> >
> > drivers/iommu/intel/dmar.c: In function =E2=80=98free_iommu=E2=80=99:
> > drivers/iommu/intel/dmar.c:1139:41: error: =E2=80=98struct iommu_device=
=E2=80=99 has no member named =E2=80=98ops=E2=80=99
> >   1139 |  if (intel_iommu_enabled && iommu->iommu.ops) {
>
> Thanks!
>
> How about making it symmetric with the registration code?
>
>         if (intel_iommu_enabled && !iommu->drhd->ignored)
>
> Best regards,
> baolu
>

Sounds good, just sent out a patch.

Bartosz
