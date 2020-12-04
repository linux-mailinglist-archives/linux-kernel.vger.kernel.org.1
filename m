Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1172CF3BD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 19:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387521AbgLDSOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 13:14:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44466 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387419AbgLDSOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607105589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4jiiSi2OMHYLdag0OnlL3n5HoKBr3a25AnpGnahrkVE=;
        b=SvXVNBygKR31p1cXqk4HD1B62iGDvVMXwh+TL4VVnj3IoCJLV3DHcSBN3mbBpvIX+LSYsz
        G9pHusU4aR1AkD0+cudBnLQoeHbTJ0lIkLO555xtLQ6rpTtOH0XDn/NF/VwE5UjI9zcu3v
        wm3sXQCfeVQzmF0pl819AM+HycBDDrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-96BjG46sM5uJfziFAbbziQ-1; Fri, 04 Dec 2020 13:13:05 -0500
X-MC-Unique: 96BjG46sM5uJfziFAbbziQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33890858180;
        Fri,  4 Dec 2020 18:13:03 +0000 (UTC)
Received: from mail (ovpn-112-211.rdu2.redhat.com [10.10.112.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E24931A8A5;
        Fri,  4 Dec 2020 18:12:56 +0000 (UTC)
Date:   Fri, 4 Dec 2020 13:12:56 -0500
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
Message-ID: <X8p8KNJXD3aK9TkF@redhat.com>
References: <20201201125927.GB11935@casper.infradead.org>
 <20201201223033.GG3277@xz-x1>
 <X8bZk3jTGU8QyJWc@redhat.com>
 <alpine.LSU.2.11.2012021410260.4989@eggly.anvils>
 <20201202234117.GD108496@xz-x1>
 <alpine.LSU.2.11.2012022119010.11674@eggly.anvils>
 <20201203180234.GJ108496@xz-x1>
 <X8lADgHCRqlQi3Xa@redhat.com>
 <20201204023051.GL108496@xz-x1>
 <X8m2qv9h7+e79UjJ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8m2qv9h7+e79UjJ@redhat.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 11:10:18PM -0500, Andrea Arcangeli wrote:
> from the pte, one that cannot ever be set in any swp entry today. I
> assume it can't be _PAGE_SWP_UFFD_WP since that already can be set but
> you may want to verify it...

I thought more about the above, and I think the already existing
pte_swp_mkuffd_wp will just be enough without having to reserve an
extra bitflag if we encode it as a non migration entry.

The check:

if (!pte_present && !pte_none && pte_swp_uffd_wp && not_anonymous_vma && !is_migration_entry)

should be enough to disambiguate it. When setting it, it'd be enough
to set the pte to the value _PAGE_SWP_UFFD_WP.

Although if you prefer to check for:

if (!pte_present && !pte_none && swp_type == 1 && swp_offset == 0 && not_anonymous_vma && !is_migration_entry)

that would do as well.

It's up to you, just my preference is to reuse _PAGE_SWP_UFFD_WP since
it has already to exist, there are already all the pte_swp_*uffd*
methods available or uffd-wp cannot work.

Thanks,
Andrea

