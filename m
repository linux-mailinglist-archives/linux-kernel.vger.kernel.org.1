Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8A32877E8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbgJHPsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:48:32 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:55725 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgJHPs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:48:29 -0400
Received: from localhost.localdomain ([192.30.34.233]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MWSFB-1jskwY2rRj-00Xu9o; Thu, 08 Oct 2020 17:47:42 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/13] parisc: use legacy_timer_tick
Date:   Thu,  8 Oct 2020 17:46:42 +0200
Message-Id: <20201008154651.1901126-5-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201008154651.1901126-1-arnd@arndb.de>
References: <20201008154651.1901126-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JdVsDzGIawLwj8GEUcu7QzV/eSgsFBBvS0zSunz+ouzZc2Q42gH
 wrq8P/ptdFN5PdXAnSdPK0jcmjjMVf2vwLGkyGbU+4+wf7ii7gGAJOpJxhpL50KcY/HrtG/
 cWCdxngFkr9agKUW7Hbh21FchDr+S7YHVvrOZTcGziVShhOCTL4Yu5VjfVRuTZfOWZaoUva
 CcYs2SG7EoaTpdxAmfUzA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KZruJGxefIk=:xe3mRoOuTB6CmdWXSfBp/W
 OxmZ6VsiGfShkMH1AvQb3F7fr+iAbCgSbX/UM3s0vTBpZDkM3oEuD5h0UsiHP/2qzs5gcY436
 Odm6b+I7fFLD0OMLDqKzkb7D5hORDXcGk5ob+C5YMe2wObJw3Mg1zgKV+mzBdfSj6yOeTfhqS
 478MASLcP8Qqc1N2NOJ1ukQvGIhiucZTuHdhGPmlRwGPiuZUZ6+j4yT/C/SpkMX6ehPnH9okK
 jNOCK7+HVIxxlbKtzOi0YSwT/ikQAHBRKYToKMUpbGRZwDQdHDqL9/LHFNW7rLG7gCpCBrvP2
 IZoBoAN3Wm1FHx/NN3jHYSTfrX9PGYtgT4ACQ0XseAi4iNuQCFfd7ztsA8H+sO4wmaCaJUXRR
 PD9WCPi16Zrizrhvyp3gswizEF+Gbxmu0cjCcNrIJhWPLmrpXv+3TK3us04jpfQHInW/ogqV1
 a/24PqyLY/NvbJwxO+HTYnbhXFzIM9cLmw66It7D8ThBhFAmNaP1Pbpm5COVz9YL0HTC0dpzc
 yE96fToR2MNVWM3i5dVUmxrTBMhwlHfkayyb6bXBtbltsf3ZCAVL8xCBPOo3zEe8YLXufyg7G
 BHUMrmSx5xE1mVF0ssKoLh8Uz+fjmXMrIo7je9EU68kjozzKmFbWQKWrAT33olxXvB23K+pYr
 T+kVW32AGwSkx+1fZWkpQJoBud4RhdI62tZEkmNV+sTPHbNG0yi3kg5g3rQrSjCSvkE32R1Aj
 8p5Rws7nG8SCU2qhjGQghuOCDq/ACf0+pkOC7fbNgfdsA6I/Nu/MlU8ZVo91WaRyePMWSA1BI
 sW1IR23mPOEb2kT3spdqoIRUDps68oE2qN17RLFhr92t9xFlIeoxQ+6gys/MRXh5YzG8K1B
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

parisc has selected CONFIG_GENERIC_CLOCKEVENTS since commit 43b1f6abd590
("parisc: Switch to generic sched_clock implementation"), but does not
appear to actually be using it, and instead calls the low-level
timekeeping functions directly.

Remove the GENERIC_CLOCKEVENTS select again, and instead convert to
the newly added legacy_timer_tick() helper.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/features/time/clockevents/arch-support.txt | 2 +-
 arch/parisc/Kconfig                                      | 2 +-
 arch/parisc/kernel/time.c                                | 9 +++------
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/Documentation/features/time/clockevents/arch-support.txt b/Documentation/features/time/clockevents/arch-support.txt
index 8287b6aa522e..61a5c9d68c15 100644
--- a/Documentation/features/time/clockevents/arch-support.txt
+++ b/Documentation/features/time/clockevents/arch-support.txt
@@ -21,7 +21,7 @@
     |       nds32: |  ok  |
     |       nios2: |  ok  |
     |    openrisc: |  ok  |
-    |      parisc: |  ok  |
+    |      parisc: | TODO |
     |     powerpc: |  ok  |
     |       riscv: |  ok  |
     |        s390: |  ok  |
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index b234e8154cbd..78b17621ee4a 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -52,7 +52,7 @@ config PARISC
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select GENERIC_SCHED_CLOCK
 	select HAVE_UNSTABLE_SCHED_CLOCK if SMP
-	select GENERIC_CLOCKEVENTS
+	select LEGACY_TIMER_TICK
 	select CPU_NO_EFFICIENT_FFS
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
diff --git a/arch/parisc/kernel/time.c b/arch/parisc/kernel/time.c
index 04508158815c..889aaaa555ea 100644
--- a/arch/parisc/kernel/time.c
+++ b/arch/parisc/kernel/time.c
@@ -70,8 +70,6 @@ irqreturn_t __irq_entry timer_interrupt(int irq, void *dev_id)
 	/* gcc can optimize for "read-only" case with a local clocktick */
 	unsigned long cpt = clocktick;
 
-	profile_tick(CPU_PROFILING);
-
 	/* Initialize next_tick to the old expected tick time. */
 	next_tick = cpuinfo->it_value;
 
@@ -86,10 +84,9 @@ irqreturn_t __irq_entry timer_interrupt(int irq, void *dev_id)
 	cpuinfo->it_value = next_tick;
 
 	/* Go do system house keeping. */
-	if (cpu == 0)
-		xtime_update(ticks_elapsed);
-
-	update_process_times(user_mode(get_irq_regs()));
+	if (cpu != 0)
+		ticks_elapsed = 0;
+	legacy_timer_tick(ticks_elapsed);
 
 	/* Skip clockticks on purpose if we know we would miss those.
 	 * The new CR16 must be "later" than current CR16 otherwise
-- 
2.27.0

