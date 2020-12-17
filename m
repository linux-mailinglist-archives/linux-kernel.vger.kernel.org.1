Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2E72DD1ED
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 14:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgLQNJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 08:09:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:47136 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbgLQNIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 08:08:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A688ACF9;
        Thu, 17 Dec 2020 13:08:08 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 1/5] mm: Introduce ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
Date:   Thu, 17 Dec 2020 14:07:54 +0100
Message-Id: <20201217130758.11565-2-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20201217130758.11565-1-osalvador@suse.de>
References: <20201217130758.11565-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use self-hosted memmap array, the platform needs to have
support for CONFIG_SPARSEMEM_VMEMMAP and altmap.
Currently, only arm64, PPC and x86_64 have the support, so enable those
platforms with ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE.

ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE will be checked later on to see whether
we can enable this feature or not.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/arm64/Kconfig   | 4 ++++
 arch/powerpc/Kconfig | 4 ++++
 arch/x86/Kconfig     | 4 ++++
 mm/Kconfig           | 3 +++
 4 files changed, 15 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 33446269f692..2daa29ab9057 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -307,6 +307,10 @@ config ARCH_ENABLE_MEMORY_HOTPLUG
 config ARCH_ENABLE_MEMORY_HOTREMOVE
 	def_bool y
 
+config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
+	def_bool y
+	depends on MEMORY_HOTPLUG && SPARSEMEM_VMEMMAP_ENABLE
+
 config SMP
 	def_bool y
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 107bb4319e0e..30322105f145 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -527,6 +527,10 @@ config ARCH_ENABLE_MEMORY_HOTPLUG
 config ARCH_ENABLE_MEMORY_HOTREMOVE
 	def_bool y
 
+config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
+        def_bool y
+        depends on MEMORY_HOTPLUG && SPARSEMEM_VMEMMAP_ENABLE
+
 config PPC64_SUPPORTS_MEMORY_FAILURE
 	bool "Add support for memory hwpoison"
 	depends on PPC_BOOK3S_64
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 42d84d86f1f4..742b29169b47 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2443,6 +2443,10 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
 	def_bool y
 	depends on MEMORY_HOTPLUG
 
+config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
+	def_bool y
+	depends on X86_64 && MEMORY_HOTPLUG && SPARSEMEM_VMEMMAP_ENABLE
+
 config USE_PERCPU_NUMA_NODE_ID
 	def_bool y
 	depends on NUMA
diff --git a/mm/Kconfig b/mm/Kconfig
index 7af1a55b708e..6156114b7974 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -183,6 +183,9 @@ config MEMORY_HOTREMOVE
 	depends on MEMORY_HOTPLUG && ARCH_ENABLE_MEMORY_HOTREMOVE
 	depends on MIGRATION
 
+config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
+	bool
+
 # Heavily threaded applications may benefit from splitting the mm-wide
 # page_table_lock, so that faults on different parts of the user address
 # space can be handled with less contention: split it at this NR_CPUS.
-- 
2.26.2

