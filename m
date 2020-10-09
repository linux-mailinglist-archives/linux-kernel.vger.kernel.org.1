Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382E728866E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 11:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387398AbgJIJ5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 05:57:04 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:49781 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgJIJ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 05:57:04 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MeCd5-1jtgm823R1-00bJ5Q; Fri, 09 Oct 2020 11:56:31 +0200
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Roman Zippel <zippel@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] m68k: remove unused mach_max_dma_address
Date:   Fri,  9 Oct 2020 11:56:21 +0200
Message-Id: <20201009095621.833192-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nxmiSwUOEAeABo5t/cKm4uWRMTmlv9wSbS5uqck4IY2g0IhuQcN
 8w6ZGPREJZaz8ZmN+OwlbBk+q3PdBO7z+1WxTwQV0kpO84yz7y9l/5xUYqzbx7giDRyx1Q0
 YtSOaQ2bieHlXW3vjhbz1a1vFxzddoQ5Fg2jWVPLCxR3wz263UXij8GD6sgFemvQRnuG+SK
 W6BL1a04YSadakOiotGWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KTzw1BdG5sI=:IshWJV3cohzv7vIMPbvHR2
 i6Z4GLhW1F1euiA0hMHBTh+My6xlBokMG/hnCPK4651ZWGqua6ZBrboUiIWFuASZrFJQlmK95
 J2sZvBTPa6XuDmX/RZtVQo80O/B+BNBV8h3bGWN4hdpf1t4paodi2SUQRxnlMFAMPiVB5ev/K
 1vL/gnl2ozv9UJ2ySFtdMqPQeqoqOhr/9kfCq4ndtKFvYuibmPHdn6gXRAUeFNumT+uZaPsju
 3RjjZypiAgYIP4qP6HKRxhY0sy6BvdD8LFUk5oInaX/SFCXcI+l6Cu+oH+imA8C9p5sl7regx
 sKNC30Kqnm2I1GcBs6ai93V1ZkQCxeBbYyXSN2XOnaqwDlGXX1OF8bI+wrJJZraOCf7KpJPhB
 hnKtpHwYd/9O7XuxvsIP5fCNGWC8cugSNX4z5KK4JU3GScAP6i2nQHuYTFqpjw/nmm/QSYQry
 hySEky9kH2d8AXxUSqB9iDzo/WQnT3cVhcT7ANq7Y1FeAbruJMjembEomcY4L5zXS+q0obqSn
 6jPa+Sap7MlccTYzqU0nz4/++srFs0nSbmDOKArMLHp8ts8ekTcLMv9rM+3XFxJ93fuNWfhly
 64PyWaennOU+IhIUu8OmneZN7magw2cm4aEkTJZcgW1XxPqRQV+zK2Xz0E/bryoLBNLNVqQZL
 Bce/uhRaPznWDK4VFAiEAjPml9UZ4cor3VDvPBokIMLetsLeCjk4nnwOkT+74Djev6vx+YhXB
 3zH+OQK2LuATd3Nb5qanzZVnSoSKD4X3NRpO5AtEaw7NeAhqp7CjAllJWxKqfNItyyMCqzHca
 qf32ymGf0OLlGr8Sg7fqb/XimxBvYMdq0e1aUAodyV8ujbu3HMw8mWS9x8aUMkfs7RTMgy0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This information is unused since the discontinuous memory support
has been introduced in 2007.

Fixes: 12d810c1b8c2 ("m68k: discontinuous memory support")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 arch/m68k/amiga/config.c        | 8 --------
 arch/m68k/apollo/config.c       | 1 -
 arch/m68k/atari/config.c        | 1 -
 arch/m68k/bvme6000/config.c     | 1 -
 arch/m68k/hp300/config.c        | 1 -
 arch/m68k/include/asm/machdep.h | 1 -
 arch/m68k/kernel/setup_mm.c     | 1 -
 arch/m68k/mac/config.c          | 1 -
 arch/m68k/mvme147/config.c      | 1 -
 arch/m68k/mvme16x/config.c      | 1 -
 arch/m68k/q40/config.c          | 5 -----
 arch/m68k/sun3x/config.c        | 2 --
 12 files changed, 24 deletions(-)

diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index 8f23b2fab64c..15aea6267ebe 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -385,14 +385,6 @@ void __init config_amiga(void)
 	mach_init_IRQ        = amiga_init_IRQ;
 	mach_get_model       = amiga_get_model;
 	mach_get_hardware_list = amiga_get_hardware_list;
-
-	/*
-	 * default MAX_DMA=0xffffffff on all machines. If we don't do so, the SCSI
-	 * code will not be able to allocate any mem for transfers, unless we are
-	 * dealing with a Z2 mem only system.                  /Jes
-	 */
-	mach_max_dma_address = 0xffffffff;
-
 	mach_reset           = amiga_reset;
 #if IS_ENABLED(CONFIG_INPUT_M68K_BEEP)
 	mach_beep            = amiga_mksound;
diff --git a/arch/m68k/apollo/config.c b/arch/m68k/apollo/config.c
index 762da5d7a415..2ebe5b6d229b 100644
--- a/arch/m68k/apollo/config.c
+++ b/arch/m68k/apollo/config.c
@@ -150,7 +150,6 @@ void __init config_apollo(void)
 
 	mach_sched_init=dn_sched_init; /* */
 	mach_init_IRQ=dn_init_IRQ;
-	mach_max_dma_address = 0xffffffff;
 	mach_hwclk           = dn_dummy_hwclk; /* */
 	mach_reset	     = dn_dummy_reset;  /* */
 #ifdef CONFIG_HEARTBEAT
diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
index 7ec3161e8517..43b4e764a1ac 100644
--- a/arch/m68k/atari/config.c
+++ b/arch/m68k/atari/config.c
@@ -205,7 +205,6 @@ void __init config_atari(void)
 	mach_get_model	 = atari_get_model;
 	mach_get_hardware_list = atari_get_hardware_list;
 	mach_reset           = atari_reset;
-	mach_max_dma_address = 0xffffff;
 #if IS_ENABLED(CONFIG_INPUT_M68K_BEEP)
 	mach_beep          = atari_mksound;
 #endif
diff --git a/arch/m68k/bvme6000/config.c b/arch/m68k/bvme6000/config.c
index 50f4d01363df..8afaa73ec802 100644
--- a/arch/m68k/bvme6000/config.c
+++ b/arch/m68k/bvme6000/config.c
@@ -101,7 +101,6 @@ void __init config_bvme6000(void)
     bvme6000_set_vectors();
 #endif
 
-    mach_max_dma_address = 0xffffffff;
     mach_sched_init      = bvme6000_sched_init;
     mach_init_IRQ        = bvme6000_init_IRQ;
     mach_hwclk           = bvme6000_hwclk;
diff --git a/arch/m68k/hp300/config.c b/arch/m68k/hp300/config.c
index a161d44fd20b..ce1eb3d3d55d 100644
--- a/arch/m68k/hp300/config.c
+++ b/arch/m68k/hp300/config.c
@@ -260,7 +260,6 @@ void __init config_hp300(void)
 #ifdef CONFIG_HEARTBEAT
 	mach_heartbeat       = hp300_pulse;
 #endif
-	mach_max_dma_address = 0xffffffff;
 
 	if (hp300_model >= HP_330 && hp300_model <= HP_433S &&
 	    hp300_model != HP_350) {
diff --git a/arch/m68k/include/asm/machdep.h b/arch/m68k/include/asm/machdep.h
index 49bd3266b4b1..e564101790ab 100644
--- a/arch/m68k/include/asm/machdep.h
+++ b/arch/m68k/include/asm/machdep.h
@@ -27,7 +27,6 @@ extern void (*mach_halt)( void );
 extern void (*mach_power_off)( void );
 extern unsigned long (*mach_hd_init) (unsigned long, unsigned long);
 extern void (*mach_hd_setup)(char *, int *);
-extern long mach_max_dma_address;
 extern void (*mach_heartbeat) (int);
 extern void (*mach_l2_flush) (int);
 extern void (*mach_beep) (unsigned int, unsigned int);
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index ab8aa7be260f..ade96b1ad946 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -99,7 +99,6 @@ EXPORT_SYMBOL(mach_set_rtc_pll);
 void (*mach_reset)( void );
 void (*mach_halt)( void );
 void (*mach_power_off)( void );
-long mach_max_dma_address = 0x00ffffff; /* default set to the lower 16MB */
 #ifdef CONFIG_HEARTBEAT
 void (*mach_heartbeat) (int);
 EXPORT_SYMBOL(mach_heartbeat);
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index a621fcc1a576..beaade4a0e13 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -140,7 +140,6 @@ void __init config_mac(void)
 	mach_reset = mac_reset;
 	mach_halt = mac_poweroff;
 	mach_power_off = mac_poweroff;
-	mach_max_dma_address = 0xffffffff;
 #if IS_ENABLED(CONFIG_INPUT_M68K_BEEP)
 	mach_beep = mac_mksound;
 #endif
diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
index 490700aa2212..ead0e51ecd42 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -80,7 +80,6 @@ void __init mvme147_init_IRQ(void)
 
 void __init config_mvme147(void)
 {
-	mach_max_dma_address	= 0x01000000;
 	mach_sched_init		= mvme147_sched_init;
 	mach_init_IRQ		= mvme147_init_IRQ;
 	mach_hwclk		= mvme147_hwclk;
diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
index 5b86d10e0f84..79896c331d55 100644
--- a/arch/m68k/mvme16x/config.c
+++ b/arch/m68k/mvme16x/config.c
@@ -268,7 +268,6 @@ void __init config_mvme16x(void)
     char id[40];
     uint16_t brdno = be16_to_cpu(p->brdno);
 
-    mach_max_dma_address = 0xffffffff;
     mach_sched_init      = mvme16x_sched_init;
     mach_init_IRQ        = mvme16x_init_IRQ;
     mach_hwclk           = mvme16x_hwclk;
diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index 4627de3c0603..58566262127d 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -185,11 +185,6 @@ void __init config_q40(void)
 
 	/* disable a few things that SMSQ might have left enabled */
 	q40_disable_irqs();
-
-	/* no DMA at all, but ide-scsi requires it.. make sure
-	 * all physical RAM fits into the boundary - otherwise
-	 * allocator may play costly and useless tricks */
-	mach_max_dma_address = 1024*1024*1024;
 }
 
 
diff --git a/arch/m68k/sun3x/config.c b/arch/m68k/sun3x/config.c
index d806dee71a9c..37121a0f1253 100644
--- a/arch/m68k/sun3x/config.c
+++ b/arch/m68k/sun3x/config.c
@@ -44,8 +44,6 @@ void __init config_sun3x(void)
 
 	sun3x_prom_init();
 
-	mach_max_dma_address = 0xffffffff; /* we can DMA anywhere, whee */
-
 	mach_sched_init      = sun3x_sched_init;
 	mach_init_IRQ        = sun3_init_IRQ;
 
-- 
2.26.2

