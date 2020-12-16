Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDDA2DC8CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 23:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgLPWLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 17:11:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgLPWLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 17:11:22 -0500
Date:   Wed, 16 Dec 2020 22:10:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608156641;
        bh=pMzv+JoqVSavT0fDnRVtzJjQVRMLsgeN6YHxEmEbm34=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=q9uK919gpDoM6Dko6VXEW/KKv29xDOai5/JxFtDZQU1ToV9WqJ/GL48U+UbSjK6a9
         u498mBRX6Ydu6cL0VLZm/zvfO/+MrChUtashGSbMVuuj9NHdB26C2YKtN4bNCCwkwF
         HeK4hqcfusDZfkHRsxuk3JIeL4TlLSlxYB0FL0sDTtNrrgPB3EYKwNiQIoYz4ZDMhU
         pBDwPyAyBB3jg7QFPJn4ofMUCGks8wHFZhYTJJIl59VK8vAmA5w12cYPaaW9yZid5f
         Qp1pBeD8mxs8wiyDhBljbKRk0bzQvp1YCI5AYHjWrSw4qWixLIMRdxzuxxH/R4qNvi
         xfQ2ClrLwS6gw==
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [GIT PULL] IOMMU updates for 5.11
Message-ID: <20201216221035.GA16915@willie-the-truck>
References: <20201214234518.GA14575@willie-the-truck>
 <20201216185352.GA16598@willie-the-truck>
 <CAHk-=wijH15u2KfpON3VCECQODAVNJ6DtgQajDaKo+PB_c-L3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wijH15u2KfpON3VCECQODAVNJ6DtgQajDaKo+PB_c-L3g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 02:02:00PM -0800, Linus Torvalds wrote:
> On Wed, Dec 16, 2020 at 10:54 AM Will Deacon <will@kernel.org> wrote:
> >
> > I'm hoping to wind down a bit next week (ho ho ho), so I just wanted to
> > check whether this had got caught in your spam filters, whether you wanted
> > me to change something or whether you're just snowed under in pull requests.
> 
> No, it didn't get lost, and I just merged it. It's just that everybody
> has been very good about sending their pull request early, so I've had
> my hands busy, and I've gone roughly by subsystem (and today got
> around to block drivers and iommus etc).

Brill, cheers. I didn't realise you were going by subsystem, so that's
why I was getting worried.

Will
