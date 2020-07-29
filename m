Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15A7231E66
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 14:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgG2MS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 08:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgG2MS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:18:56 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19D4C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 05:18:56 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6EBC13EC; Wed, 29 Jul 2020 14:18:55 +0200 (CEST)
Date:   Wed, 29 Jul 2020 14:18:53 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Move driver files into their own
 subdir
Message-ID: <20200729121853.GB23653@8bytes.org>
References: <20200727120510.GA20662@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727120510.GA20662@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 01:05:11PM +0100, Will Deacon wrote:
> As requested in [1], here is a second Arm SMMU pull request for 5.9, moving
> the driver files into their own subdirectory to avoid cluttering
> drivers/iommu/.

Pulled, thanks a lot, Will.

