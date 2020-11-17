Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B412B7183
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgKQWYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:24:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:37762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgKQWYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:24:37 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A46E620B80;
        Tue, 17 Nov 2020 22:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605651877;
        bh=suTzvgzomH8/b8tydiTPTmWm+Melr0oekXi+74bvqd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WCdcyR/SR4KIUFc87Q15lZQPG0eLCZTDm5gugZz5CIjeBSP2fFDAQDJaaE/Nn3uKV
         XTdtj5/KBydRFrrvervCjb2+uT+nfg6eOfyLYSaRYi+FKBne3QHRHis4FUhdyfrpSh
         Em6GlvID7zmt1rRNV7JRr+sysGX7MPQAC5gVFGy4=
Date:   Tue, 17 Nov 2020 22:24:32 +0000
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, john.stultz@linaro.org,
        bjorn.andersson@linaro.org
Subject: Re: [GIT PULL] iommu/arm-smmu: First batch of updates for 5.11
Message-ID: <20201117222432.GC524@willie-the-truck>
References: <20201110135657.GA17034@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110135657.GA17034@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 01:56:57PM +0000, Will Deacon wrote:
> Please can you pull these Arm SMMU updates for 5.11 so that they can get
> into -next? I think Bjorn is keen to get a bunch of DT updates moving, so
> the sooner we can get this lot out there, the better. Summary in the tag.
> 
> There are a few other patches kicking around on the list, so I may send
> a second pull on top in a couple of weeks or so.

This is now queued on a stable branch for -next targetting 5.11:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/iommu/arm-smmu

Bjorn, is this what you needed?

Cheers,

Will
