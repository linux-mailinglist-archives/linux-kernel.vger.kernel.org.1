Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419202002D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 09:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgFSHmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 03:42:37 -0400
Received: from verein.lst.de ([213.95.11.211]:52332 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbgFSHmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:42:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0A2F568AFE; Fri, 19 Jun 2020 09:42:34 +0200 (CEST)
Date:   Fri, 19 Jun 2020 09:42:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Commit 25f12ae45fc1 ("maccess: rename probe_kernel_address to
 get_kernel_nofault") causing several OOPSes
Message-ID: <20200619074233.GA3723@lst.de>
References: <alpine.DEB.2.22.394.2006181751270.9276@xps-7390> <20200619065007.GA3041@lst.de> <alpine.DEB.2.22.394.2006182351090.9276@xps-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006182351090.9276@xps-7390>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 11:57:27PM -0700, Kenneth R. Crudup wrote:
> 
> On Fri, 19 Jun 2020, Christoph Hellwig wrote:
> 
> > That is indeed really strange, as that commit is just a rename.
> > Well, Linus also added swapping of the argument order, but again it
> > shouldn't change much.
> 
> Thing is, there's other examples of the previous version in the kernel tree- any
> chance there's a usage conflict (Thunderbolt has a ROM in it, maybe something in
> "probe_roms.c"? (Just guessing, no idea):

Maybe.  But nothing looks strange there.  Just to re-reconfirm, you had to
revert "maccess: rename probe_kernel_address to get_kernel_nofault",
"maccess: make get_kernel_nofault() check for minimal type compatibility"
wasn't enough?

Below is a patch to do a "partial revert" for probe_roms.c.  I'd be
totally surprised if it changes anything from staring at it for while,
but anyway..

diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
index 9e1def3744f220..70ff3267b4f373 100644
--- a/arch/x86/kernel/probe_roms.c
+++ b/arch/x86/kernel/probe_roms.c
@@ -22,6 +22,9 @@
 #include <asm/io.h>
 #include <asm/setup_arch.h>
 
+#define probe_kernel_address(addr, retval)             \
+	copy_from_kernel_nofault(&retval, addr, sizeof(retval))
+
 static struct resource system_rom_resource = {
 	.name	= "System ROM",
 	.start	= 0xf0000,
@@ -99,7 +102,7 @@ static bool probe_list(struct pci_dev *pdev, unsigned short vendor,
 	unsigned short device;
 
 	do {
-		if (get_kernel_nofault(device, rom_list) != 0)
+		if (probe_kernel_address(rom_list, device) != 0)
 			device = 0;
 
 		if (device && match_id(pdev, vendor, device))
@@ -125,13 +128,13 @@ static struct resource *find_oprom(struct pci_dev *pdev)
 			break;
 
 		rom = isa_bus_to_virt(res->start);
-		if (get_kernel_nofault(offset, rom + 0x18) != 0)
+		if (probe_kernel_address(rom + 0x18, offset) != 0)
 			continue;
 
-		if (get_kernel_nofault(vendor, rom + offset + 0x4) != 0)
+		if (probe_kernel_address(rom + offset + 0x4, vendor) != 0)
 			continue;
 
-		if (get_kernel_nofault(device, rom + offset + 0x6) != 0)
+		if (probe_kernel_address(rom + offset + 0x6, device) != 0)
 			continue;
 
 		if (match_id(pdev, vendor, device)) {
@@ -139,8 +142,8 @@ static struct resource *find_oprom(struct pci_dev *pdev)
 			break;
 		}
 
-		if (get_kernel_nofault(list, rom + offset + 0x8) == 0 &&
-		    get_kernel_nofault(rev, rom + offset + 0xc) == 0 &&
+		if (probe_kernel_address(rom + offset + 0x8, list) == 0 &&
+		    probe_kernel_address(rom + offset + 0xc, rev) == 0 &&
 		    rev >= 3 && list &&
 		    probe_list(pdev, vendor, rom + offset + list)) {
 			oprom = res;
@@ -183,14 +186,14 @@ static int __init romsignature(const unsigned char *rom)
 	const unsigned short * const ptr = (const unsigned short *)rom;
 	unsigned short sig;
 
-	return get_kernel_nofault(sig, ptr) == 0 && sig == ROMSIGNATURE;
+	return probe_kernel_address(ptr, sig) == 0 && sig == ROMSIGNATURE;
 }
 
 static int __init romchecksum(const unsigned char *rom, unsigned long length)
 {
 	unsigned char sum, c;
 
-	for (sum = 0; length && get_kernel_nofault(c, rom++) == 0; length--)
+	for (sum = 0; length && probe_kernel_address(rom++, c) == 0; length--)
 		sum += c;
 	return !length && !sum;
 }
@@ -211,7 +214,7 @@ void __init probe_roms(void)
 
 		video_rom_resource.start = start;
 
-		if (get_kernel_nofault(c, rom + 2) != 0)
+		if (probe_kernel_address(rom + 2, c) != 0)
 			continue;
 
 		/* 0 < length <= 0x7f * 512, historically */
@@ -249,7 +252,7 @@ void __init probe_roms(void)
 		if (!romsignature(rom))
 			continue;
 
-		if (get_kernel_nofault(c, rom + 2) != 0)
+		if (probe_kernel_address(rom + 2, c) != 0)
 			continue;
 
 		/* 0 < length <= 0x7f * 512, historically */
