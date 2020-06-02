Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A4B1EB587
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 07:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgFBF4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 01:56:43 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:48031 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgFBF4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:56:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U-LpR9d_1591077399;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U-LpR9d_1591077399)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Jun 2020 13:56:40 +0800
Date:   Tue, 2 Jun 2020 13:56:39 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     iommu@lists.linux-foundation.org,
        =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: iommu: Improve exception handling in iommu_group_alloc()
Message-ID: <20200602055639.GB89266@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <9f8d8308-2056-8e33-7b38-0b7d96e51c3c@web.de>
 <20200602015044.GA89266@VM20190228-100.tbsite.net>
 <b31fbcd1-b5f8-992b-a994-2a950ab36b61@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b31fbcd1-b5f8-992b-a994-2a950ab36b61@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 07:01:02AM +0200, Markus Elfring wrote:
> >> * I suggest to avoid the specification of duplicate function calls.
> >>   Will it be helpful to add a few jump targets?
> >>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162#n455
> >
> > I don't think it is helpful or readable to add some jump targets here,
> > since the exception handling is very simple here.
> 
> Do you disagree to the application of the Linux coding style then
> for the recommended exception handling?

No, that's not what I mean. My point is the exception handling in this
patch is simple and no need to add 'goto' statement which does not help
to improve readability. And I agree it is helpful for the cases where a
function exits from multiple locations and more same cleanup work need
to do.

