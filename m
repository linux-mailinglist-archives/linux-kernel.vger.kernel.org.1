Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA18A1E1068
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 16:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403974AbgEYOXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 10:23:09 -0400
Received: from 8bytes.org ([81.169.241.247]:44590 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403965AbgEYOXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:23:07 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 40130303; Mon, 25 May 2020 16:23:06 +0200 (CEST)
Date:   Mon, 25 May 2020 16:23:04 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.8
Message-ID: <20200525142304.GE5221@8bytes.org>
References: <20200521173944.GM6608@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521173944.GM6608@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 06:39:44PM +0100, Will Deacon wrote:
> Hi Joerg,
> 
> Please pull these Arm SMMU updates for 5.8. The branch is based on your
> 'core' branch from a little while ago.
> 
> Summary in the tag.
> 
> Cheers,
> 
> Will
> 
> --->8
> 
> The following changes since commit 1b032ec1ecbce6047af7d11c9db432e237cb17d8:
> 
>   iommu: Unexport iommu_group_get_for_dev() (2020-05-05 14:36:14 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates
> 
> for you to fetch changes up to 0299a1a81ca056e79c1a7fb751f936ec0d5c7afe:
> 
>   iommu/arm-smmu-v3: Manage ASIDs with xarray (2020-05-21 14:54:06 +0100)

Pulled, thanks Will.
