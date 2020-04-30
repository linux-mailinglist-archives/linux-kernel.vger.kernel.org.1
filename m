Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199E71BF829
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 14:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgD3MXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 08:23:37 -0400
Received: from 8bytes.org ([81.169.241.247]:40718 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbgD3MXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:23:36 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 85D3A3E2; Thu, 30 Apr 2020 14:23:35 +0200 (CEST)
Date:   Thu, 30 Apr 2020 14:23:32 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] drivers/iommu: properly export iommu_group_get_for_dev
Message-ID: <20200430122332.GP21900@8bytes.org>
References: <20200430120120.2948448-1-gregkh@linuxfoundation.org>
 <20200430121753.GA22842@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430121753.GA22842@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 01:17:53PM +0100, Will Deacon wrote:
> Thanks, not sure how I managed to screw this up in the original patch!
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Joerg -- can you pick this one up please?

Yes, will send it as a fix for 5.7, but note that this function will be
unexported in 5.8.


Regards,

	Joerg

