Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BD227FFA5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbgJAM7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731952AbgJAM7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:59:54 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A500C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 05:59:53 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 24D1E26F; Thu,  1 Oct 2020 14:59:51 +0200 (CEST)
Date:   Thu, 1 Oct 2020 14:59:49 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 00/13] iommu: amd: Add Generic IO Page Table Framework
 Support
Message-ID: <20201001125949.GG30426@8bytes.org>
References: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
 <20200924103448.GO27174@8bytes.org>
 <c4b95103-8c66-6a9b-af18-a7c40d9dd943@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4b95103-8c66-6a9b-af18-a7c40d9dd943@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 05:50:37PM +0700, Suravee Suthikulpanit wrote:
> 
> 
> On 9/24/20 5:34 PM, Joerg Roedel wrote:
> > Hi Suravee,
> > 
> > On Wed, Sep 23, 2020 at 10:14:29AM +0000, Suravee Suthikulpanit wrote:
> > > The framework allows callable implementation of IO page table.
> > > This allows AMD IOMMU driver to switch between different types
> > > of AMD IOMMU page tables (e.g. v1 vs. v2).
> > 
> > Is there a reason you created your own framework, there is already an
> > io-pgtable framework for ARM, maybe that can be reused?
> > 
> 
> Actually, this is the same framework used by ARM codes.
> Sorry if the description is not clear.

Ah, right, thanks. I think this should spend some time in linux-next
before going upstream. Can you please remind me after the next merge
window to pick it up?

Thanks,

	Joerg
