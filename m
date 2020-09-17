Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979E926D086
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIQBV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:21:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:32822 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQBVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:21:54 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id BAC2F20B7178;
        Wed, 16 Sep 2020 18:21:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BAC2F20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600305713;
        bh=nkJcObrrUzxPOBpjkc201BKfzAnytpT+T4w6EejmQyA=;
        h=From:To:Cc:Subject:Date:From;
        b=H3NEooazxxwzvB4lqsq/ifViYHr5rfdrvA2yZeKpWCRNyWTYQ0jXiS36v9i1xbFRH
         lxaD5uu+D9ytjK+5YtXdUhEqpWQqopMv8jXHGoXFgJ+fY3K8F/K7URGhOwaloBJsWr
         IaCYKIa3GsUvwE98Q/fFMvwpZy85yPYSTDBVgitU=
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Michal Hocko <mhocko@suse.com>,
        Allen Pais <apais@microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [v3 0/2] recalculate min_free_kbytes post memory hotplug
Date:   Wed, 16 Sep 2020 18:21:47 -0700
Message-Id: <1600305709-2319-1-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3
--------
[v2 1/2]
- removed symptoms references from changelog

[v2 2/2]
- addressed following issues Michal Hocko raised:
  . nr_free_buffer_pages can oveflow in int on very large machines
  . min_free_kbytes can decrease the size theoretically

v1 -> v2
--------
- addressed issue Kirill A. Shutemov raised:
  . changes would override min_free_kbytes set by user

Vijay Balakrishna (2):
  mm: khugepaged: recalculate min_free_kbytes after memory hotplug as
    expected by khugepaged
  mm: khugepaged: avoid overriding min_free_kbytes set by user

 include/linux/khugepaged.h |  5 +++++
 mm/khugepaged.c            | 16 +++++++++++++---
 mm/memory_hotplug.c        |  3 +++
 mm/page_alloc.c            |  2 +-
 4 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.28.0

