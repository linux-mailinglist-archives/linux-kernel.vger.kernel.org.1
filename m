Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAD81EB324
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 03:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgFBBur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 21:50:47 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:52495 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbgFBBur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 21:50:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U-Kjvi7_1591062644;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U-Kjvi7_1591062644)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Jun 2020 09:50:44 +0800
Date:   Tue, 2 Jun 2020 09:50:44 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Improve exception handling in iommu_group_alloc()
Message-ID: <20200602015044.GA89266@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <9f8d8308-2056-8e33-7b38-0b7d96e51c3c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f8d8308-2056-8e33-7b38-0b7d96e51c3c@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 02:38:05PM +0200, Markus Elfring wrote:
> > Optimize the error handling to free the resources correctly when
> > failed to allocate an iommu group.
> 
> * I would not categorise the desired completion of exception handling
>   as a software optimisation.
> 
> * Would you like to add the tag ¡°Fixes¡± to the commit message?

Sure.

> 
> * I suggest to avoid the specification of duplicate function calls.
>   Will it be helpful to add a few jump targets?
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162#n455

I don't think it is helpful or readable to add some jump targets here, since the exception handling is very simple here.

