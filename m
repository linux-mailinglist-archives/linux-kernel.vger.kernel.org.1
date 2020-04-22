Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864C91B36FA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 07:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDVFxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 01:53:13 -0400
Received: from verein.lst.de ([213.95.11.211]:50236 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgDVFxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 01:53:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6FFF268C4E; Wed, 22 Apr 2020 07:53:11 +0200 (CEST)
Date:   Wed, 22 Apr 2020 07:53:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, Ralph Campbell <rcampbell@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        dri-devel@lists.freedesktop.org,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        intel-gfx@lists.freedesktop.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH hmm 4/5] mm/hmm: remove HMM_PFN_SPECIAL
Message-ID: <20200422055311.GC22366@lst.de>
References: <0-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com> <4-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 09:21:45PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> This is just an alias for HMM_PFN_ERROR, nothing cares that the error was
> because of a special page vs any other error case.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
