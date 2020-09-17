Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA9626E333
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgIQSGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:06:15 -0400
Received: from mail.ispras.ru ([83.149.199.84]:47882 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgIQSFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:05:46 -0400
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 14:05:45 EDT
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id 1BB264089F1B;
        Thu, 17 Sep 2020 17:55:32 +0000 (UTC)
Date:   Thu, 17 Sep 2020 20:55:32 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
cc:     linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
In-Reply-To: <b01994db-da9b-d8e6-e0c1-1af35dd62191@amd.com>
Message-ID: <alpine.LNX.2.20.13.2009172052480.29869@monopod.intra.ispras.ru>
References: <20200529200738.1923-1-amonakov@ispras.ru> <56761139-f794-39b1-4dfa-dfc05fbe5f60@amd.com> <alpine.LNX.2.20.13.2006011132530.16067@monopod.intra.ispras.ru> <dba1e37a-1ed7-ef7f-7252-2ebd1d6bde8c@amd.com> <alpine.LNX.2.20.13.2006152346320.21123@monopod.intra.ispras.ru>
 <b01994db-da9b-d8e6-e0c1-1af35dd62191@amd.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020, Suravee Suthikulpanit wrote:

> > > Instead of blindly moving the code around to a spot that would just work,
> > > I am trying to understand what might be required here. In this case,
> > > the init_device_table_dma()should not be needed. I suspect it's the IOMMU
> > > invalidate all command that's also needed here.
> > > 
> > > I'm also checking with the HW and BIOS team. Meanwhile, could you please
> > > give
> > > the following change a try:
> > Hello. Can you give any update please?
> > 
> > Alexander
> > 
> 
> Sorry for late reply. I have a reproducer and working with the HW team to
> understand the issue.
> I should be able to provide update with solution by the end of this week.

Hello, hope you are doing well. Has this investigation found anything?

Thanks.
Alexander
