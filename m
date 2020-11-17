Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DEC2B7178
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgKQWWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:22:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:37182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbgKQWWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:22:33 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 256C920678;
        Tue, 17 Nov 2020 22:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605651752;
        bh=BkGt+44VK/Hsa4hyKjPNouLZQNX3V18+l8zXTgVURcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L/BSdz3NJvUY/xkgcPvM62jPhjYYtOZKFF8W8fE+KE2hEnzTUlgF3ytopaqpW3NGc
         QhMc0b/GrlAC4gYuw0XvYFQ88Mfq3C0tCOQEcqPr0YwPVL5JGUm5nwStNmUX8O8f3O
         fmeW0/Gu3AjnTppszbXmEvSm1CSLSVJu36EkvlDQ=
Date:   Tue, 17 Nov 2020 22:22:27 +0000
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: IOMMU Maintainership
Message-ID: <20201117222227.GB524@willie-the-truck>
References: <20201117100953.GR22888@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117100953.GR22888@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:09:53AM +0100, Joerg Roedel wrote:
> Luckily Will Deacon volunteered to handle incoming IOMMU patches and
> send them upstream. So please Cc him on any patches that you want to
> have merged upstream for the next release and on important fixes for
> v5.10. The patches will go through another tree for the time being, Will
> can share the details on that.

Thanks Joerg, and please try to get some rest.

As for the temporary new workflow; I'll be queueing IOMMU patches on
branches in the arm64 tree and merging them into a non-stable branch
(for-next/iommu/core) which will go into -next. I'll send a separate pull
for the IOMMU bits when the time comes.

If you have IOMMU patches targetting 5.10 or 5.11, then please CC me to
make sure I don't miss them. Alex, Robin and Lu have also offered to help
with review and I can pull from them too.

Will
