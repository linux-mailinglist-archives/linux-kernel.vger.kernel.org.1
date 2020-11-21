Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F4D2BC1DE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 21:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgKUTyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 14:54:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20110 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728466AbgKUTyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 14:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605988441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zt6PGtlR8y/mkqi+5YNjO4Oe9KhPCG+m4BdR6B7XWq0=;
        b=MYtHAcq9SwYezC8vHYaFwpVp1Ed/SmARxqSX9aRFmC1Rg+YgA36qcTTKaNshjrP2iLQ79W
        AOAFFzdxJCsmxWlTchI4SVlAnys0wmSiyqPbsxFiOT6bDZrGlyMN/5rMoTypBwAkFH3n45
        8lNq+U2mY9zW1mt8RfA2pUqzjyZwPKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-slEJZEyBP2qos4b0_OSvVg-1; Sat, 21 Nov 2020 14:53:57 -0500
X-MC-Unique: slEJZEyBP2qos4b0_OSvVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFB5E51D4;
        Sat, 21 Nov 2020 19:53:55 +0000 (UTC)
Received: from mail (ovpn-112-35.rdu2.redhat.com [10.10.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 68A9B5C224;
        Sat, 21 Nov 2020 19:53:52 +0000 (UTC)
Date:   Sat, 21 Nov 2020 14:53:51 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <X7lwT2+uSVGKRApQ@redhat.com>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121194506.13464-2-aarcange@redhat.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 21, 2020 at 02:45:06PM -0500, Andrea Arcangeli wrote:
> +					if (likely(!PageReserved(page)))

NOTE: this line will have to become "likely(page &&
!PageReserved(page))" to handle the case of non contiguous zones,
since pageblock_pfn_to_page might return NULL in that case.. I noticed
right after sending, but I'll wait some feedback before resending the
correction in case it gets fixed in another way.

