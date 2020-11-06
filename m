Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253E92A9BFA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgKFSY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:24:29 -0500
Received: from verein.lst.de ([213.95.11.211]:52626 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgKFSY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:24:29 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9DA7368B02; Fri,  6 Nov 2020 19:24:24 +0100 (CET)
Date:   Fri, 6 Nov 2020 19:24:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Ashish Kalra <ashish.kalra@amd.com>, hch@lst.de,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, luto@kernel.org, peterz@infradead.org,
        dave.hansen@linux-intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, brijesh.singh@amd.com,
        Thomas.Lendacky@amd.com, ssg.sos.patches@amd.com
Subject: Re: [PATCH v3] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201106182424.GA9330@lst.de>
References: <20201104220804.21026-1-Ashish.Kalra@amd.com> <20201104221452.GA26079@char.us.oracle.com> <20201104223913.GA25311@ashkalra_ubuntu_server> <20201105174317.GA4294@char.us.oracle.com> <20201105184115.GA25261@ashkalra_ubuntu_server> <20201105190649.GB5366@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105190649.GB5366@char.us.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 02:06:49PM -0500, Konrad Rzeszutek Wilk wrote:
> .
> > > Right, so I am wondering if we can do this better.
> > > 
> > > That is you are never going to get any 32-bit devices with SEV right? That
> > > is there is nothing that bounds you to always use the memory below 4GB?
> > > 
> > 
> > We do support 32-bit PCIe passthrough devices with SEV.
> 
> Ewww..  Which devices would this be?

There is still some new broken shit like that that keeps appearing.
GPU is pretty famouts for supporting less than 64-bit addressing,
even if it isn't all the way down to 32-bit.
