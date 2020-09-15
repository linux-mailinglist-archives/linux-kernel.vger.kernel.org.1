Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6650F269AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 03:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgIOBFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 21:05:16 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9259 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgIOBFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:05:14 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6012be0000>; Mon, 14 Sep 2020 18:02:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 14 Sep 2020 18:05:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 14 Sep 2020 18:05:14 -0700
Received: from nvdebian.localnet (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Sep
 2020 01:05:12 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>,
        "Ralph Campbell" <rcampbell@nvidia.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/doc: add usage description for migrate_vma_*()
Date:   Tue, 15 Sep 2020 11:05:10 +1000
Message-ID: <2077765.OaWJzLOgzI@nvdebian>
In-Reply-To: <20200910172514.GN87483@ziepe.ca>
References: <20200909212956.20104-1-rcampbell@nvidia.com> <20200910105657.6007c5ca@lwn.net> <20200910172514.GN87483@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600131774; bh=swLcarL+SErbGe4glwQXQ2j09SBuEg2MIzY+X2J3l/E=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding:Content-Type:
         X-Originating-IP:X-ClientProxiedBy;
        b=omD2/CikmXtQsewRW5Xcm6oLfynqUJws+0m9UxbArOKZ0GcmdQre2epYqgYYw8iY1
         1x9LjsDoKmZRL9kIaukuFDfwbS6Km5frbBRyNf9YV0fjqIjsrcWvGFsxJ59HXFf0h1
         jToV31axdAx0lqMhhQ6XL2SNOas1CrCe1MroFFMgJtg3bsZ52RlDfJCeIIiM47vvXU
         XGYPrk+OgKNVYE+wNkYb/3T9iUL5KFvqaQMa+GG0nBGgvDf1vwHUsOTv2m3qRv2SPM
         mD4H8N1RDdROB9zI0eUB4hRzp8LU86Dhmtmv/p8ECXlAsDvwmP+KNpTiEcm5Zuucsq
         x4VpKil5RbPIQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 11 September 2020 3:25:14 AM AEST Jason Gunthorpe wrote:
> On Thu, Sep 10, 2020 at 10:56:57AM -0600, Jonathan Corbet wrote:
> > On Wed, 9 Sep 2020 14:29:56 -0700
> > 
> > Ralph Campbell <rcampbell@nvidia.com> wrote:
> > > The migrate_vma_setup(), migrate_vma_pages(), and migrate_vma_finalize()
> > > API usage by device drivers is not well documented.
> > > Add a description for how device drivers are expected to use it.
> > > 
> > > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > > 
> > > There shouldn't be any merge conflict with my previous patch which
> > > touched hmm.rst but since Jonathan Corbet took my last patch, perhaps he
> > > would like to take this one through his tree too.
> > 
> > I'm happy to take it, but it certainly needs an ack from somebody who
> > understands HMM better than I do.
> 
> Ralph wrote all the in kernel tests for this API, so I think he is
> well positioned to write the documentation :)

I have recently read through most of the code to get back up to date with 
recent HMM developments and the documentation here didn't conflict with my 
understanding based on the code. The description of pgmap_owner is good as 
it's usage wasn't immediately clear on the first code read through. So feel 
free to add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>
 
> Jason




