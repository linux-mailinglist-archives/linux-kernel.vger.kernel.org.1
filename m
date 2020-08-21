Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5F924DFF9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 20:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHUSvs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Aug 2020 14:51:48 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:54806 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725768AbgHUSvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:51:48 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 22202611-1500050 
        for multiple; Fri, 21 Aug 2020 19:51:44 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200821123746.16904-1-joro@8bytes.org>
References: <20200821123746.16904-1-joro@8bytes.org>
Subject: Re: [PATCH v2] mm: Track page table modifications in __apply_to_page_range()
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Joerg Roedel <jroedel@suse.de>, stable@vger.kernel.org
To:     Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>
Date:   Fri, 21 Aug 2020 19:51:42 +0100
Message-ID: <159803590250.29194.13619627284206815276@build.alporthouse.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joerg Roedel (2020-08-21 13:37:46)
> From: Joerg Roedel <jroedel@suse.de>
> 
> The __apply_to_page_range() function is also used to change and/or
> allocate page-table pages in the vmalloc area of the address space.
> Make sure these changes get synchronized to other page-tables in the
> system by calling arch_sync_kernel_mappings() when necessary.
> 
> Tested-by: Chris Wilson <chris@chris-wilson.co.uk> #x86-32
> Cc: <stable@vger.kernel.org> # v5.8+
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

I've doubled check that this patch by itself fixes our x86-32 vmapping
issue. Thanks,
-Chris
