Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998CB2EA6BF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 09:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbhAEIyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 03:54:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10108 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbhAEIyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 03:54:40 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D95qh1qtbz15p3M;
        Tue,  5 Jan 2021 16:53:04 +0800 (CST)
Received: from localhost (10.174.151.88) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Tue, 5 Jan 2021
 16:53:48 +0800
From:   Lin Feng <linfeng23@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <weidong.huang@huawei.com>, <hogan.wang@huawei.com>,
        <wangxinxin.wang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <ebiederm@xmission.com>, <ardb@kernel.org>,
        Lin Feng <linfeng23@huawei.com>
Subject: [PATCH] x86/kaslr: try process e820 entries if can not get suitable regions from efi
Date:   Tue, 5 Jan 2021 16:53:46 +0800
Message-ID: <20210105085346.995-1-linfeng23@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.88]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On efi64 x86_64 system, the EFI_CONVENTIONAL_MEMORY regions will not
be mapped when making EFI runtime calls. So kexec-tools can not get
these from /sys/firmware/efi/runtime-map. Then compressed boot os
can not get suitable regions in process_efi_entries and print debug
message as follow:
	Physical KASLR disabled: no suitable memory region!
To enable physical kaslr with kexec, call process_e820_entries when
no suitable regions in efi memmaps.

Signed-off-by: Lin Feng <linfeng23@huawei.com>

---

I find a regular of Kernel code and data placement with kexec. It
seems unsafe. The reason is showed above.

I'm not familiar with efi firmware. I wonder if there are some risks
to get regions according to e820 when there is no suitable region
in efi memmaps.
---
 arch/x86/boot/compressed/kaslr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b92fffbe761f..dbd7244b71aa 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -685,6 +685,7 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 {
 	struct efi_info *e = &boot_params->efi_info;
 	bool efi_mirror_found = false;
+	bool efi_mem_region_found = false;
 	struct mem_vector region;
 	efi_memory_desc_t *md;
 	unsigned long pmap;
@@ -742,12 +743,13 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 		    !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
 			continue;
 
+		efi_mem_region_found = false;
 		region.start = md->phys_addr;
 		region.size = md->num_pages << EFI_PAGE_SHIFT;
 		if (process_mem_region(&region, minimum, image_size))
 			break;
 	}
-	return true;
+	return efi_mem_region_found;
 }
 #else
 static inline bool
-- 
2.23.0

