Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766342C3A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 08:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgKYHds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 02:33:48 -0500
Received: from ns2.chip.baikal.ru ([94.125.187.42]:55096 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726489AbgKYHds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 02:33:48 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2020 02:33:46 EST
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        kernel test robot <lkp@intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mtd: physmap: physmap-bt1-rom: Fix __iomem addrspace removal warning
Date:   Wed, 25 Nov 2020 10:26:40 +0300
Message-ID: <20201125072640.23516-1-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201112180037.6754-1-Sergey.Semin@baikalelectronics.ru>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse is unhappy with us casting the __iomem address space pointer to
a type with no address space attribute specified:

"sparse warnings: (new ones prefixed by >>)"
>> drivers/mtd/maps/physmap-bt1-rom.c:78:18: sparse: sparse: cast removes address space '__iomem' of expression

Indeed we perform the __iomem-less type casting but to an integer
variable. The integer variable isn't dereferenced then, so the casting is
safe and won't cause any problem. But in order to make sparse happy and
keep the code coherent let's fix the warning by converting the local
"shift" and "chunk" variables to the "unsigned int" type (since their
value won't ever exceed three) and cast the __iomem-pointers to uintptr_t.
Add the same fix to the bt1_rom_map_read() method for unification.

Fixes: b3e79e7682e0 ("mtd: physmap: Add Baikal-T1 physically mapped ROM support")
Link: https://lore.kernel.org/lkml/202011021254.XC70BaQT-lkp@intel.com/
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>

---

Link: https://lore.kernel.org/lkml/20201120113929.0aff2f32@canb.auug.org.au/
Changelog v2:
- Cast the pointers to uintptr_t instead of unsiged int so not to
  cause the "cast from pointer to integer of different size" warning on
  64-bits platforms.
---
 drivers/mtd/maps/physmap-bt1-rom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/maps/physmap-bt1-rom.c b/drivers/mtd/maps/physmap-bt1-rom.c
index 27cfe1c63a2e..a35450002284 100644
--- a/drivers/mtd/maps/physmap-bt1-rom.c
+++ b/drivers/mtd/maps/physmap-bt1-rom.c
@@ -31,12 +31,12 @@ static map_word __xipram bt1_rom_map_read(struct map_info *map,
 					  unsigned long ofs)
 {
 	void __iomem *src = map->virt + ofs;
-	unsigned long shift;
+	unsigned int shift;
 	map_word ret;
 	u32 data;
 
 	/* Read data within offset dword. */
-	shift = (unsigned long)src & 0x3;
+	shift = (uintptr_t)src & 0x3;
 	data = readl_relaxed(src - shift);
 	if (!shift) {
 		ret.x[0] = data;
@@ -60,7 +60,7 @@ static void __xipram bt1_rom_map_copy_from(struct map_info *map,
 					   ssize_t len)
 {
 	void __iomem *src = map->virt + from;
-	ssize_t shift, chunk;
+	unsigned int shift, chunk;
 	u32 data;
 
 	if (len <= 0 || from >= map->size)
@@ -75,7 +75,7 @@ static void __xipram bt1_rom_map_copy_from(struct map_info *map,
 	 * up into the next three stages: unaligned head, aligned body,
 	 * unaligned tail.
 	 */
-	shift = (ssize_t)src & 0x3;
+	shift = (uintptr_t)src & 0x3;
 	if (shift) {
 		chunk = min_t(ssize_t, 4 - shift, len);
 		data = readl_relaxed(src - shift);
-- 
2.29.2

