Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C102FEF93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbhAUP5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:57:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729541AbhAUPzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:55:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25AE822C9F;
        Thu, 21 Jan 2021 15:54:12 +0000 (UTC)
Date:   Thu, 21 Jan 2021 15:54:10 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 1/1] arm64/sparsemem: reduce SECTION_SIZE_BITS
Message-ID: <20210121155410.GH21811@gaia>
References: <cover.1611206601.git.sudaraja@codeaurora.org>
 <43843c5e092bfe3ec4c41e3c8c78a7ee35b69bb0.1611206601.git.sudaraja@codeaurora.org>
 <alpine.DEB.2.22.394.2101211004540.100764@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2101211004540.100764@www.lameter.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 10:08:17AM +0000, Christoph Lameter wrote:
> On Wed, 20 Jan 2021, Sudarshan Rajagopalan wrote:
> 
> > But there are other problems in reducing SECTION_SIZE_BIT. Reducing it by too
> > much would over populate /sys/devices/system/memory/ and also consume too many
> > page->flags bits in the !vmemmap case. Also section size needs to be multiple
> > of 128MB to have PMD based vmemmap mapping with CONFIG_ARM64_4K_PAGES.
> 
> There is also the issue of requiring more space in the TLB cache with
> smaller page sizes. Or does ARM resolve these into smaller TLB entries
> anyways (going on my x86 kwon how here)? Anyways if there are only a few
> TLB entries then the effect could
> be significant.

There is indeed more TLB pressure with smaller page sizes but this patch
doesn't change this.

-- 
Catalin
