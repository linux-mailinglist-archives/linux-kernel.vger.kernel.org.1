Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A652CF4F3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 20:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgLDTjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 14:39:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725923AbgLDTjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 14:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607110663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YkMVep6lpTapkyPhQc3/pDFiWvkLP0M38PqZ1b/p6cc=;
        b=aVeHBVF2urGZZAMdj+Bopg/RqszsznZgiuLFhRbu0vffMXxS82sP69miLQk1Ytc+uYKHsR
        VlHfsmbIoA/1thuKVz7uUcVaB1KhDW/a0MsMWN3u5x72VetBIm51P7cATRRLtcRIwnXUyp
        xn3dSqe0tVT5vM/lRWqWEqrCe/XkElw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-49K0YkFOOdK5vozU-UX4RA-1; Fri, 04 Dec 2020 14:37:40 -0500
X-MC-Unique: 49K0YkFOOdK5vozU-UX4RA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71C67107AFD3;
        Fri,  4 Dec 2020 19:37:18 +0000 (UTC)
Received: from mail (ovpn-112-211.rdu2.redhat.com [10.10.112.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3587560861;
        Fri,  4 Dec 2020 19:37:18 +0000 (UTC)
Date:   Fri, 4 Dec 2020 14:37:17 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm: Don't fault around userfaultfd-registered regions
 on reads
Message-ID: <X8qP7QEQTKrhZo57@redhat.com>
References: <X8bZk3jTGU8QyJWc@redhat.com>
 <alpine.LSU.2.11.2012021410260.4989@eggly.anvils>
 <20201202234117.GD108496@xz-x1>
 <alpine.LSU.2.11.2012022119010.11674@eggly.anvils>
 <20201203180234.GJ108496@xz-x1>
 <X8lADgHCRqlQi3Xa@redhat.com>
 <20201204023051.GL108496@xz-x1>
 <X8m2qv9h7+e79UjJ@redhat.com>
 <X8p8KNJXD3aK9TkF@redhat.com>
 <20201204192329.GP108496@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204192329.GP108496@xz-x1>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 02:23:29PM -0500, Peter Xu wrote:
> If we see [1]:
> 
>   if (!pte_present && !pte_none && pte_swp_uffd_wp && not_anonymous_vma && !is_migration_entry)
> 
> Then it's fundamentally the same as:
> 
>   swp_entry(0, _UFFD_SWP_UFFD_WP) && !vma_is_anonymous(vma)

Yes conceptually it's the same, but in practice it's different value
in the raw pte if you set  swp_offset  to _UFFD_SWP_UFFD_WP.

Setting swp_offset to _UFFD_SWP_UFFD_WP is just confusing, it's better
magic type 1 offset 0 then to even touch _UFFD_SWP_UFFD_WP if you
reserve the magic value in the swap entry.

pte_swp_uffd_wp or _UFFD_SWP_UFFD_WP are the raw pte value.

swp_entry(0, _UFFD_SWP_UFFD_WP) is not the raw pte value, and it has
to be first converted to the raw pte value with swp_entry_to_pte, so
the _UFFD_SWP_UFFD_WP gets shifted left.

If we use _UFFD_SWP_UFFD_WP it looks much cleaner to keep it in the
pte, not in the swp entry, since then you can use the already existing
methods that only can take in input the pte_t (not the swp_entry_t).

Thanks,
Andrea

