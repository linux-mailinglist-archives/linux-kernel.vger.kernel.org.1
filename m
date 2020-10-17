Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177CE29104D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 09:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437306AbgJQHEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 03:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729897AbgJQHED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 03:04:03 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB20C061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 00:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Message-ID:From:To:Subject:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
        Date:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=e32V1bjhtjzZrlhrOpY90tdI8k8UHEoe3Fu88vVCPT4=; b=WMCdS1T6wcurFNracxb9Sc4VXn
        A4tIKFzZwcb6kMHjJPb+G0cEU8Ie9PO3a+ooFg/PuJnqUZg+pbfoo6ryZ5l/MHUtLc+ZAdR1Dehkf
        EpgDZadYA9trkNdVpt+vlVFwLZYSLcPE5WLT+/9V3385Mk0vGChq2AjZ9cF1N7PUWLXZ0zzbBBwIc
        YZApUPJRZLRCyXbbDw2cQdhzydG+ZKba9ZsMGXkeZSqQkfeRrnUY10hDSHon9UYuDpNksGNcDrWdY
        nftP15GYqP3FFlv8ED9iCHLADRHCtg6LH8KtpNs0QeTMRHto+4mpiA1GFZ86DY4L6c9S+YDMmrWv/
        egsrbGUA==;
Received: from [2001:8b0:10b:1:548d:d93a:89e7:65c0]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTgFw-0001Ys-Ma; Sat, 17 Oct 2020 07:03:56 +0000
Date:   Sat, 17 Oct 2020 08:03:43 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <d090c378-bfb4-34bc-7091-64e2b83925de@kernel.dk>
References: <d090c378-bfb4-34bc-7091-64e2b83925de@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: dmar compile failure in -git
To:     Jens Axboe <axboe@kernel.dk>, joro@8bytes.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   David Woodhouse <dwmw2@infradead.org>
Message-ID: <D8207C14-26C9-420D-9AA4-1E6D3F2F2191@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by merlin.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16 October 2020 22:23:46 BST, Jens Axboe <axboe@kernel=2Edk> wrote:
>Hi,
>
>Ran into this one yesterday:
>
>drivers/iommu/intel/dmar=2Ec: In function =E2=80=98free_iommu=E2=80=99:
>drivers/iommu/intel/dmar=2Ec:1139:41: error: =E2=80=98struct iommu_device=
=E2=80=99 has no
>member named =E2=80=98ops=E2=80=99
> 1139 |  if (intel_iommu_enabled && iommu->iommu=2Eops) {
>      |                                         ^
>make[3]: *** [scripts/Makefile=2Ebuild:283: drivers/iommu/intel/dmar=2Eo]
>Error 1
>make[3]: *** Waiting for unfinished jobs=2E=2E=2E=2E
>make[2]: *** [scripts/Makefile=2Ebuild:500: drivers/iommu/intel] Error 2
>make[1]: *** [scripts/Makefile=2Ebuild:500: drivers/iommu] Error 2
>make: *** [Makefile:1777: drivers] Error 2
>
>which is due to the config I use:


Thanks=2E Should be fixed by https://www=2Email-archive=2Ecom/iommu@lists=
=2Elinux-foundation=2Eorg/msg45697=2Ehtml

