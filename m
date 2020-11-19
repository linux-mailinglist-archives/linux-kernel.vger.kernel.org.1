Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E9F2B9A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgKSR7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:59:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728330AbgKSR7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605808753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RIoVsFHcxQBEphSpxz/IoFEkDGp+2Q03g3zLSzBSnXg=;
        b=c9OEFWWmp2wLgx3NFBKNLDVgiqIm/Q+4q5u9k0TqLCA2PKeLX6XWNyO4KCrGsOkPet5LPj
        u44eEfApiKNT3BthCdnNjFQx8oKwiMz6WCLyvEP7Obg3wXqDMNvgXMmScDGE4cOWlMfWCE
        zLfg1wLFqb0+STboqDQ9ohv17VRnYBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-l3wsqm0bMSiAcBt8sHBeFw-1; Thu, 19 Nov 2020 12:59:11 -0500
X-MC-Unique: l3wsqm0bMSiAcBt8sHBeFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D2839CC00;
        Thu, 19 Nov 2020 17:59:10 +0000 (UTC)
Received: from mail (ovpn-113-32.rdu2.redhat.com [10.10.113.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23DAE60855;
        Thu, 19 Nov 2020 17:59:03 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] x86: restore the write back cache of reserved RAM in iounmap()
Date:   Thu, 19 Nov 2020 12:59:01 -0500
Message-Id: <20201119175902.17394-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

We identified some PCD set on the direct mapping causing hardly
reproducible performance issues and this patch fixes the ultimate root
cause.

The caller for now has been tweaked to avoid triggering this case (now
that we know about it) however if the observations on the proposed fix
aren't correct, it'd be great if we could still do some other change
to ioremap/iounmap and perhaps the other memtype APIs, to be sure
those PCD/PWT leftovers won't happen again a few years from now in
another place.

For example one more complex alternative would be to use the
page_mapcount of reserved pages (currently unused) to do proper
refcounting on the overlapping ioremap so you can resync the kernel
direct mapping to write back only at the very last iounmap.

Or a much simpler alternative that would remain fully neutral for
overlapping ioremaps, would be to overwrite all page_count of reserved
RAM in a way that if they're ever freed later it'll trigger a crash
during __free_pages.

==
// SPDX-License-Identifier: GPL-2.0-only
/*
 *  ioremap.c
 *
 *  Copyright (C) 2020  Red Hat, Inc.
 *
 *  Reproducer for bug io iounmap.
 */

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/mm.h>
#include <asm/io.h>

#define NR_PAGES 512
#define REPRODUCE

static struct page *pages[NR_PAGES];
static void __iomem *map[NR_PAGES];

int init_module(void)
{
	int i;
	for (i = 0; i < NR_PAGES; i++) {
		pages[i] = alloc_pages(GFP_KERNEL|__GFP_NOWARN, MAX_ORDER-1);
		if (!pages[i])
			break;
		__SetPageReserved(pages[i]);
#ifdef REPRODUCE
		map[i] = ioremap(page_to_phys(pages[i]), 1L<<(MAX_ORDER-1));
		WARN_ON_ONCE(!map[i]);
#endif
	}

	return 0;
}

void cleanup_module(void)
{
	int i;
	for (i = 0; i < NR_PAGES; i++) {
		if (map[i])
			iounmap(map[i]);
		if (!pages[i])
			break;
		__ClearPageReserved(pages[i]);
		__free_pages(pages[i], MAX_ORDER-1);
	}
}

MODULE_LICENSE("GPL");
==

Andrea Arcangeli (1):
  x86: restore the write back cache of reserved RAM in iounmap()

 arch/x86/mm/ioremap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

