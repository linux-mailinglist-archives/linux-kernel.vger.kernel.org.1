Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CA226C72C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgIPSUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:20:40 -0400
Received: from ms.lwn.net ([45.79.88.28]:41576 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727869AbgIPSUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:20:19 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 889BD2B2;
        Wed, 16 Sep 2020 18:20:15 +0000 (UTC)
Date:   Wed, 16 Sep 2020 12:20:14 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     <linux-mm@kvack.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Ralph Campbell" <rcampbell@nvidia.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/doc: add usage description for migrate_vma_*()
Message-ID: <20200916122014.48c85e20@lwn.net>
In-Reply-To: <2077765.OaWJzLOgzI@nvdebian>
References: <20200909212956.20104-1-rcampbell@nvidia.com>
        <20200910105657.6007c5ca@lwn.net>
        <20200910172514.GN87483@ziepe.ca>
        <2077765.OaWJzLOgzI@nvdebian>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 11:05:10 +1000
Alistair Popple <apopple@nvidia.com> wrote:

> > Ralph wrote all the in kernel tests for this API, so I think he is
> > well positioned to write the documentation :)  
> 
> I have recently read through most of the code to get back up to date with 
> recent HMM developments and the documentation here didn't conflict with my 
> understanding based on the code. The description of pgmap_owner is good as 
> it's usage wasn't immediately clear on the first code read through. So feel 
> free to add:
> 
> Reviewed-by: Alistair Popple <apopple@nvidia.com>

OK good enough, I've applied this.

Thanks,

jon
