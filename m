Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3932E06A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 08:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgLVHNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 02:13:09 -0500
Received: from foss.arm.com ([217.140.110.172]:60728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgLVHNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:13:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4FB130E;
        Mon, 21 Dec 2020 23:12:23 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.86.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2CBCE3F718;
        Mon, 21 Dec 2020 23:12:19 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: [RFC 0/2] arm64/mm: Fix pfn_valid() for ZONE_DEVIE based memory
Date:   Tue, 22 Dec 2020 12:42:22 +0530
Message-Id: <1608621144-4001-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes pfn_valid() for ZONE_DEVICE based memory and also improves
its performance for normal hotplug memory. While here, it also reorganizes
pfn_valid() on CONFIG_SPARSEMEM. This series has been slightly tested on the
current mainline tree.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (2):
  arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
  arm64/mm: Reorganize pfn_valid()

 arch/arm64/mm/init.c | 46 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

-- 
2.20.1

