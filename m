Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557D929A6AB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894988AbgJ0Igv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:36:51 -0400
Received: from verein.lst.de ([213.95.11.211]:37883 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395068AbgJ0Igu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:36:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B264A67373; Tue, 27 Oct 2020 09:36:47 +0100 (CET)
Date:   Tue, 27 Oct 2020 09:36:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel 0/2] powerpc/dma: Fallback to dma_ops when
 persistent memory present
Message-ID: <20201027083647.GA24318@lst.de>
References: <20201021032026.45030-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021032026.45030-1-aik@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 02:20:24PM +1100, Alexey Kardashevskiy wrote:
> This allows mixing direct DMA (to/from RAM) and
> IOMMU (to/from apersistent memory) on the PPC64/pseries
> platform. This was supposed to be a single patch but
> unexpected move of direct DMA functions happened.
> 
> This is based on sha1
> 7cf726a59435 Linus Torvalds "Merge tag 'linux-kselftest-kunit-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest".
> 
> Please comment. Thanks.

I really don't like your revert.  I'm almost ready to kill of
dma-direct.h, and I really want it private in kernel/dma/, as people
keep adding abuses to drivers.

We have two options here:

 (1) duplicate the code in arch/powerpc/
 (2) add a hook to kernel/dma/

I've not been a fan of (2) in the past, but now that the code is out
of line, and we could make it dependent on a config option only set by
powerpc, I see it as the lesser evil now.
