Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FED2BC1CE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 20:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgKUTpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 14:45:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728402AbgKUTpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 14:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605987916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/n9qzU93yjpwWqpZ4t1OnDoSkIDxpyCWRVsrij+PqBU=;
        b=cemCWQ7oly83tjEpQa/ROAt9TQDAU0N6t3y3arP0+DmrNBq9rv7ABe2pf/RTGZFThIt0QJ
        PMYXOMNvsnr534+SWP7R6Ha/9OcNHDM9ackK4JawGBKyf7S95gzm034/EL0QH3qRcJAAnf
        Fddrcnx/4VxCmYKFCfRdxIGdYe3K+X8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-FDfrJ_tzPVSMkHwmKiKa3g-1; Sat, 21 Nov 2020 14:45:12 -0500
X-MC-Unique: FDfrJ_tzPVSMkHwmKiKa3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A872151D8;
        Sat, 21 Nov 2020 19:45:10 +0000 (UTC)
Received: from mail (ovpn-112-35.rdu2.redhat.com [10.10.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A24E18996;
        Sat, 21 Nov 2020 19:45:07 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/1] VM_BUG_ON_PAGE(!zone_spans_pfn) in set_pfnblock_flags_mask
Date:   Sat, 21 Nov 2020 14:45:05 -0500
Message-Id: <20201121194506.13464-1-aarcange@redhat.com>
In-Reply-To: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After hitting this twice on two different systems, I'm now running
with the tentative fix applied, but it's not a meaningful test since
it's non reproducible.

However it is possible to inject this bug if you do "grep E820
/proc/iomem" and then find a phys addr there with a struct page
(i.e. pfn_valid) in a zone, with this change:

	min_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 1));
+	if (cc->zone is the zone where the e820 physaddr has a pfn_valid)
+	   min_pfn = physaddr_of_E820_non_RAM_page_with_valid_pfn >> PAGE_SHIFT;

I didn't try to inject the bug to validate the fix and it'd be great
if someone can try that to validate this or any other fix.

Andrea Arcangeli (1):
  mm: compaction: avoid fast_isolate_around() to set pageblock_skip on
    reserved pages

 mm/compaction.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

