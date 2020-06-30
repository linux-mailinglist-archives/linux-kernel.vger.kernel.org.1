Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BEF20F1E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 11:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbgF3JnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 05:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbgF3JnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:43:13 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DFFC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 02:43:13 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4775726B; Tue, 30 Jun 2020 11:43:12 +0200 (CEST)
Date:   Tue, 30 Jun 2020 11:43:10 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: Move Kconfig and Makefile bits down into
 intel directory
Message-ID: <20200630094310.GF28824@8bytes.org>
References: <20200612231100.293734-1-jsnitsel@redhat.com>
 <20200612231100.293734-2-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612231100.293734-2-jsnitsel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerry,

On Fri, Jun 12, 2020 at 04:10:59PM -0700, Jerry Snitselaar wrote:
> Move Intel Kconfig and Makefile bits down into intel directory
> with the rest of the Intel specific files.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
>  drivers/iommu/Kconfig        | 86 +-----------------------------------
>  drivers/iommu/Makefile       |  8 +---
>  drivers/iommu/intel/Kconfig  | 86 ++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel/Makefile |  7 +++

The patches do not apply to v5.8-rc3, can you please rebase them and
resend?

Thanks,

	Joerg
