Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691F81A6915
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 17:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbgDMPrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 11:47:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45362 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728597AbgDMPrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586792841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I4bWrwiElnw+d7X99Bis3FxuOxIFuXPdODeS5fzReoQ=;
        b=VJDBnUhG1NLfdSHtC8ODFPj9zgEvePYE40coc4/RhZGxi8h3kOlYyp2fnhxy+PaGSsUAmG
        S4uDySpYEL+D8b8VwvqfiWJm9K7iSk55ZHw1atanft+9nMjHTXbt3JFW/mbo1PZXjjzBux
        aADvFeHJFnRO12eHapykTDMN+KnIbTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-hZu3iWvfOrGndcnQ8Et5Ng-1; Mon, 13 Apr 2020 11:47:19 -0400
X-MC-Unique: hZu3iWvfOrGndcnQ8Et5Ng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B8E4107ACC7;
        Mon, 13 Apr 2020 15:47:18 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D576C60BE1;
        Mon, 13 Apr 2020 15:47:14 +0000 (UTC)
Date:   Mon, 13 Apr 2020 09:47:14 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [RFC PATCH 0/4] mm: Add PG_zero support
Message-ID: <20200413094714.432b5841@w520.home>
In-Reply-To: <7a064e81-6bc1-b3e7-5f82-292ffa392058@intel.com>
References: <20200412090728.GA19572@open-light-1.localdomain>
        <f9a3be0b-fe8d-ca25-f0df-4b9fd1f0fed5@intel.com>
        <20200413084915.1bae0007@w520.home>
        <7a064e81-6bc1-b3e7-5f82-292ffa392058@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020 08:14:32 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 4/13/20 7:49 AM, Alex Williamson wrote:
> >> VFIO's unconditional page pinning is the real problem here IMNHO.  They
> >> don't *really* need to pin the memory.  We just don't have good
> >> paravirtualized IOMMU support or want to pay the runtime cost for
> >> pin/unpin operations.  You *could* totally have speedy VM startup if
> >> only the pages being accessed or having DMA performed to them were
> >> allocated.  But, the hacks that are in place mean that everything must
> >> be pinned.  
> > Maybe in an SEV or Secure Boot environment we can assume the VM guest
> > OS uses the IOMMU exclusively for DMA, but otherwise the IOMMU is
> > optional (at least for x86, other archs do require IOMMU support
> > afaik).  Therefore, how would we know which pages to pin when there are
> > only limited configs where we might be able to lean on the vIOMMU to
> > this extent?  Thanks,  
> 
> You can delay pinning until the device is actually used.  That should be
> late enough for the host to figure out whether a paravirtualized IOMMU
> is in place.

So the guest enables the bus master bit in the command register and at
that point we'd stall the VM for an indeterminate length of time while
we potentially pin all memory, and hope that both the user and the host
has the resources to account and allocate that memory, otherwise the
VM suddenly crashes?  All of this potentially taking place in the
pre-boot environment to support option ROMs as well.  A delay starting
the VM seems a lot more predictable.  Thanks,

Alex

