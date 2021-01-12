Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BD72F32A6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387818AbhALOHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:07:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbhALOHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:07:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67B0A22E03;
        Tue, 12 Jan 2021 14:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610460416;
        bh=ITq/LkYN7klcTIozQxotrJJ+ewuGctygU1/NFQ1kAu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g2StjuwU2GxfEqJD2YjahkkhBOS72mDlIL+XhkzVCwbNHqcn7zek8/RgaUA+oNQLr
         LGBhqJq8Fl+K8AFGiVD8Yr/dC6oVena91GstafkWBr9UvqXvSlx+VMR2sXR3C1cw4F
         Fnj30lUtz3wsfczlVbVJXWkwpGLyqyegRc6/E640tx/Wm0R5ZOZAlPvolSwQj6Yvlz
         /3aFYczXMA8mbMUuEbXktRaJ6Dn+xvaSRBX21dPSgvAMhjJgfQB6u4hRNUZGCtZciH
         F9F3xGs/9j1L2j7tWt0h2+prvWdzXGoXP23vfjhaLbZeCkyfT6E0w1bbigBc2gPjVp
         eQhAm5fr0j2zg==
Date:   Tue, 12 Jan 2021 14:06:52 +0000
From:   Will Deacon <will@kernel.org>
To:     Xiangyang Yu <yuxiangyang4@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/qspinlock: Modify comments to adapt to code
 modification.
Message-ID: <20210112140651.GD9277@willie-the-truck>
References: <20201228031855.1991595-1-yuxiangyang4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228031855.1991595-1-yuxiangyang4@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 11:18:55AM +0800, Xiangyang Yu wrote:
> The function 'pv_wait_head_or_lock' comment is not modified in
> commit 625e88be1f41 ("locking/qspinlock: Merge 'struct __qspinlock'
> into 'struct qspinlock'"). Fix it.
> 
> Signed-off-by: Xiangyang Yu <yuxiangyang4@huawei.com>
> ---
>  kernel/locking/qspinlock_paravirt.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
