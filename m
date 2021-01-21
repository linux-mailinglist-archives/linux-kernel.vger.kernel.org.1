Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA30A2FE729
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbhAUKJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:09:22 -0500
Received: from gentwo.org ([3.19.106.255]:52784 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbhAUKJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:09:08 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id A245C3F04E; Thu, 21 Jan 2021 10:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id A030D3EFF6;
        Thu, 21 Jan 2021 10:08:17 +0000 (UTC)
Date:   Thu, 21 Jan 2021 10:08:17 +0000 (UTC)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 1/1] arm64/sparsemem: reduce SECTION_SIZE_BITS
In-Reply-To: <43843c5e092bfe3ec4c41e3c8c78a7ee35b69bb0.1611206601.git.sudaraja@codeaurora.org>
Message-ID: <alpine.DEB.2.22.394.2101211004540.100764@www.lameter.com>
References: <cover.1611206601.git.sudaraja@codeaurora.org> <43843c5e092bfe3ec4c41e3c8c78a7ee35b69bb0.1611206601.git.sudaraja@codeaurora.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021, Sudarshan Rajagopalan wrote:

> But there are other problems in reducing SECTION_SIZE_BIT. Reducing it by too
> much would over populate /sys/devices/system/memory/ and also consume too many
> page->flags bits in the !vmemmap case. Also section size needs to be multiple
> of 128MB to have PMD based vmemmap mapping with CONFIG_ARM64_4K_PAGES.

There is also the issue of requiring more space in the TLB cache with
smaller page sizes. Or does ARM resolve these into smaller TLB entries
anyways (going on my x86 kwon how here)? Anyways if there are only a few
TLB entries then the effect could
be significant.

