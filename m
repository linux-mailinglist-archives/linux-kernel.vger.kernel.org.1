Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B627289ABF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 23:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391830AbgJIVfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 17:35:30 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:44516 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388587AbgJIVf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 17:35:29 -0400
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Oct 2020 17:35:28 EDT
Received: from [192.168.0.2] (188-167-68-178.dynamic.chello.sk [188.167.68.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 2216C7A01AC;
        Fri,  9 Oct 2020 23:26:23 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Ben Skeggs <bskeggs@redhat.com>
Subject: nouveau broken on Riva TNT2 in 5.9.0-rc8: GPU not supported on big-endian
Date:   Fri, 9 Oct 2020 23:26:20 +0200
User-Agent: KMail/1.9.10
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202010092326.20482.linux@zary.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I'm testing 5.9.0-rc8 and found that Riva TNT2 stopped working:
[    0.000000] Linux version 5.9.0-rc8+ (zary@gsql) (gcc (Debian 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #326 SMP Fri Oct 9 22:31:40 CEST 2020
...
[   14.771464] nouveau 0000:01:00.0: GPU not supported on big-endian
[   14.771782] nouveau: probe of 0000:01:00.0 failed with error -38

big-endian? WTF? The machine is x86.

It works fine with Debian 5.7 kernel (5.7.10-1~bpo10+1):
[    0.000000] Linux version 5.7.0-0.bpo.2-686 (debian-kernel@lists.debian.org) (gcc version 8.3.0 (Debian 8.3.0-6), GNU ld (GNU Binutils for Debian) 2.31.1) #1 SMP Debian 5.7.10-1~bpo10+1 (2020-07-30)
...
[   23.266196] nouveau 0000:01:00.0: NVIDIA NV05 (20154000)
[   23.288582] nouveau 0000:01:00.0: bios: version 02.05.20.02.00
[   23.288869] nouveau 0000:01:00.0: bios: DCB table not found
[   23.289595] nouveau 0000:01:00.0: bios: DCB table not found
[   23.289956] nouveau 0000:01:00.0: bios: DCB table not found
[   23.290015] nouveau 0000:01:00.0: bios: DCB table not found
[   23.290215] agpgart-intel 0000:00:00.0: AGP 3.0 bridge
[   23.290287] agpgart-intel 0000:00:00.0: bridge is in legacy mode, falling back to 2.x
[   23.290351] agpgart-intel 0000:00:00.0: putting AGP V2 device into 4x mode
[   23.290430] nouveau 0000:01:00.0: putting AGP V2 device into 4x mode
[   23.290565] agpgart-intel 0000:00:00.0: AGP 3.0 bridge
[   23.290627] agpgart-intel 0000:00:00.0: bridge is in legacy mode, falling back to 2.x
[   23.290690] agpgart-intel 0000:00:00.0: putting AGP V2 device into 4x mode
[   23.290768] nouveau 0000:01:00.0: putting AGP V2 device into 4x mode
[   23.290830] nouveau 0000:01:00.0: tmr: unknown input clock freq
[   23.293026] nouveau 0000:01:00.0: fb: 32 MiB SDRAM
[   23.301269] [TTM] Zone  kernel: Available graphics memory: 382728 KiB
[   23.301327] [TTM] Initializing pool allocator
[   23.301414] nouveau 0000:01:00.0: DRM: VRAM: 31 MiB
[   23.301465] nouveau 0000:01:00.0: DRM: GART: 128 MiB
[   23.301518] nouveau 0000:01:00.0: DRM: BMP version 5.6
[   23.301570] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
[   23.303594] nouveau 0000:01:00.0: DRM: MM: using M2MF for buffer copies
[   23.303719] nouveau 0000:01:00.0: bios: DCB table not found
[   23.304904] nouveau 0000:01:00.0: DRM: Saving VGA fonts
[   23.349089] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
[   23.349681] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   23.383066] nouveau 0000:01:00.0: DRM: allocated 1280x1024 fb: 0x4000, bo b10d2f17
[   23.413903] fbcon: nouveaudrmfb (fb0) is primary device
[   23.569851] Console: switching to colour frame buffer device 160x64
[   23.571050] nouveau 0000:01:00.0: fb0: nouveaudrmfb frame buffer device


-- 
Ondrej Zary
