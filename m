Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0412F2993E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780187AbgJZReI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:34:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:43870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1780080AbgJZReH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:34:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7B66ADDB;
        Mon, 26 Oct 2020 17:34:06 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 0/3] optimize handling of memory debugging parameters
Date:   Mon, 26 Oct 2020 18:33:55 +0100
Message-Id: <20201026173358.14704-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently have several kernel parameters that affect page allocator wrt
debugging and hardening, some also with config options: init_on_alloc,
init_on_free, page_poison, debug_pagealloc.

These options generally have their own static keys, but sometimes a decision
for e.g. clearing a page depends on multiple options, and the handling is not
as efficient as it could be. This series addresses that by centralizing the
decisions into a new init_mem_debugging() function that enables individual
static keys, and most paths now rely on a single static key check. Subtle
dependency on the order of parameters is also eliminated (Patch 1). The result
is more efficient and hopefully also more readable code.

Vlastimil Babka (3):
  mm, page_alloc: do not rely on the order of page_poison and
    init_on_alloc/free parameters
  mm, page_poison: use static key more efficiently
  mm, page_alloc: reduce static keys in prep_new_page()

 drivers/virtio/virtio_balloon.c |   2 +-
 include/linux/mm.h              |  36 ++++-----
 init/main.c                     |   2 +-
 mm/page_alloc.c                 | 126 ++++++++++++++++++--------------
 mm/page_poison.c                |  40 ++--------
 5 files changed, 97 insertions(+), 109 deletions(-)

-- 
2.29.0

