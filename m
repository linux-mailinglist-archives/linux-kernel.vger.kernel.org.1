Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84E9276F07
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 12:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgIXKwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 06:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgIXKwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 06:52:04 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F75C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 03:52:03 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D8328295; Thu, 24 Sep 2020 12:52:01 +0200 (CEST)
Date:   Thu, 24 Sep 2020 12:52:00 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jon.Grimm@amd.com, brijesh.singh@amd.com
Subject: Re: [PATCH v2 0/3] amd : iommu : Initial IOMMU support for SNP
Message-ID: <20200924105200.GP27174@8bytes.org>
References: <20200923121347.25365-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923121347.25365-1-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 12:13:44PM +0000, Suravee Suthikulpanit wrote:
> Suravee Suthikulpanit (3):
>   iommu: amd: Use 4K page for completion wait write-back semaphore
>   iommu: amd: Add support for RMP_PAGE_FAULT and RMP_HW_ERR
>   iommu: amd: Re-purpose Exclusion range registers to support SNP CWWB

Applied, thanks. I am slightly concerned about the re-purposing of the
exclusion-range registers based on a feature bit being set. This makes
the hardware incompatible to older IOMMU drivers which do not check the
FEATURE_SNP bit.

It will probably work in this case, as the firmware on systems with
IOMMU-SNP support will not declare exclusion ranges at all and
exclusion-ranges in the IOMMU hardware have been a bad idea since
forever, but it would have been nicer if hardware actually
provided a bit to enable this behavior.

Regards,

	Joerg
