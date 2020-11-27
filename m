Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DAE2C5F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 06:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgK0FGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 00:06:42 -0500
Received: from foss.arm.com ([217.140.110.172]:58156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgK0FGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 00:06:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5909D1478;
        Thu, 26 Nov 2020 21:06:41 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.84.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE3583F70D;
        Thu, 26 Nov 2020 21:06:37 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        steven.price@arm.com, christophe.leroy@csgroup.eu,
        gerald.schaefer@linux.ibm.com, vgupta@synopsys.com,
        paul.walmsley@sifive.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH 0/2] mm/debug_vm_pgtable: Some minor updates
Date:   Fri, 27 Nov 2020 10:36:22 +0530
Message-Id: <1606453584-15399-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains some cleanups and new test suggestions from Catalin
from an earlier discussion.

https://lore.kernel.org/linux-mm/20201123142237.GF17833@gaia/

This series is based on v5.10-rc5 and has been tested on arm64 and x86 but
has only been build tested on riscv, s390, arc etc. It would be great if
folks could test this on these platforms as well. Thank you.

Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Andrew Morton <akpm@linux-foundation.org>

Anshuman Khandual (2):
  mm/debug_vm_pgtable/basic: Add validation for dirtiness after write protect
  mm/debug_vm_pgtable/basic: Iterate over entire protection_map[]

 Documentation/vm/arch_pgtable_helpers.rst |  8 ++--
 mm/debug_vm_pgtable.c                     | 50 +++++++++++++++++------
 2 files changed, 42 insertions(+), 16 deletions(-)

-- 
2.20.1

