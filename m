Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E363B28DD42
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbgJNJXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731267AbgJNJW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:22:56 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC83C0F26E4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 19:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CaF6pMpXPj5y/q+2oCFYautSjCvrlnVUKiL8TX8FfZ8=; b=Tx7e5f0JRJxaO1FNHRXJzycOiW
        2SWRueV/pUtbwH0R2rUa4ghPihWX1aP8F98evI/gfj1rERqulrxPHJj3LWLHV8NeuDuO7+tWLLQS8
        XGVCDbZ7Gw19J1mmrKJ4SexAmSn1YiFN1EjlYTnX3CLLWOw9owBtsz7T37u41DhY+eu2lmR11hGTR
        pR7DDjLbamnNg3q2dNtv/VPtOE+AYmqATScHnYfywMf9fx00Bw9lUpfxpzXI7YHaZhGaj2jGH1zjh
        UaveJyjRljskx2KYt+wfIFtBJxxtQ03d+kkg3wXdNpTGlZjp8bW5EfxCos19a0GEEUmqDoSGKqB+e
        45lIwUhg==;
Received: from [2601:1c0:6280:3f0::507c] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSWy9-0005zg-D8; Wed, 14 Oct 2020 02:56:49 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: [PATCH 3/3] ASoC: sof: Kconfig: fix Kconfig punctuation and wording
Date:   Tue, 13 Oct 2020 19:56:33 -0700
Message-Id: <20201014025633.4879-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014025633.4879-1-rdunlap@infradead.org>
References: <20201014025633.4879-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add periods at the end of sentences in help text.
Drop "a" in one place where it is not needed.
Fix a verb.
Add some capitalization.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: sound-open-firmware@alsa-project.org
Cc: alsa-devel@alsa-project.org
---
 sound/soc/sof/Kconfig |   42 ++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

--- linux-next-20201013.orig/sound/soc/sof/Kconfig
+++ linux-next-20201013/sound/soc/sof/Kconfig
@@ -2,7 +2,7 @@
 config SND_SOC_SOF_TOPLEVEL
 	bool "Sound Open Firmware Support"
 	help
-	  This adds support for Sound Open Firmware (SOF). SOF is a free and
+	  This adds support for Sound Open Firmware (SOF). SOF is free and
 	  generic open source audio DSP firmware for multiple devices.
 	  Say Y if you have such a device that is supported by SOF.
 	  If unsure select "N".
@@ -16,8 +16,8 @@ config SND_SOC_SOF_PCI
 	select SND_SOC_ACPI if ACPI
 	help
 	  This adds support for PCI enumeration. This option is
-	  required to enable Intel Skylake+ devices
-	  Say Y if you need this option
+	  required to enable Intel Skylake+ devices.
+	  Say Y if you need this option.
 	  If unsure select "N".
 
 config SND_SOC_SOF_ACPI
@@ -28,8 +28,8 @@ config SND_SOC_SOF_ACPI
 	select IOSF_MBI if X86 && PCI
 	help
 	  This adds support for ACPI enumeration. This option is required
-	  to enable Intel Broadwell/Baytrail/Cherrytrail devices
-	  Say Y if you need this option
+	  to enable Intel Broadwell/Baytrail/Cherrytrail devices.
+	  Say Y if you need this option.
 	  If unsure select "N".
 
 config SND_SOC_SOF_OF
@@ -54,12 +54,12 @@ config SND_SOC_SOF_DEVELOPER_SUPPORT
 	bool "SOF developer options support"
 	depends on EXPERT
 	help
-	  This option unlock SOF developer options for debug/performance/
+	  This option unlocks SOF developer options for debug/performance/
 	  code hardening.
 	  Distributions should not select this option, only SOF development
 	  teams should select it.
-	  Say Y if you are involved in SOF development and need this option
-	  If not, select N
+	  Say Y if you are involved in SOF development and need this option.
+	  If not, select N.
 
 if SND_SOC_SOF_DEVELOPER_SUPPORT
 
@@ -72,13 +72,13 @@ config SND_SOC_SOF_NOCODEC_SUPPORT
 	  This adds support for a dummy/nocodec machine driver fallback
 	  option if no known codec is detected. This is typically only
 	  enabled for developers or devices where the sound card is
-	  controlled externally
-	  This option is mutually exclusive with the Intel HDAudio support,
-	  selecting it may have negative impacts and prevent e.g. microphone
+	  controlled externally.
+	  This option is mutually exclusive with the Intel HDAudio support.
+	  Selecting it may have negative impacts and prevent e.g. microphone
 	  functionality from being enabled on Intel CoffeeLake and later
 	  platforms.
 	  Distributions should not select this option!
-	  Say Y if you need this nocodec fallback option
+	  Say Y if you need this nocodec fallback option.
 	  If unsure select "N".
 
 config SND_SOC_SOF_STRICT_ABI_CHECKS
@@ -92,8 +92,8 @@ config SND_SOC_SOF_STRICT_ABI_CHECKS
 	  is invoked.
 	  This option will stop topology creation and firmware load upfront.
 	  It is intended for SOF CI/releases and not for users or distros.
-	  Say Y if you want strict ABI checks for an SOF release
-	  If you are not involved in SOF releases and CI development
+	  Say Y if you want strict ABI checks for an SOF release.
+	  If you are not involved in SOF releases and CI development,
 	  select "N".
 
 config SND_SOC_SOF_DEBUG
@@ -114,8 +114,8 @@ config SND_SOC_SOF_FORCE_NOCODEC_MODE
 	  though there is a codec detected on the real platform. This is
 	  typically only enabled for developers for debug purposes, before
 	  codec/machine driver is ready, or to exclude the impact of those
-	  drivers
-	  Say Y if you need this force nocodec mode option
+	  drivers.
+	  Say Y if you need this force nocodec mode option.
 	  If unsure select "N".
 
 config SND_SOC_SOF_DEBUG_XRUN_STOP
@@ -137,12 +137,12 @@ config SND_SOC_SOF_DEBUG_VERBOSE_IPC
 config SND_SOC_SOF_DEBUG_FORCE_IPC_POSITION
 	bool "SOF force to use IPC for position update on SKL+"
 	help
-	  This option force to handle stream position update IPCs and run pcm
+	  This option forces to handle stream position update IPCs and run PCM
 	  elapse to inform ALSA about that, on platforms (e.g. Intel SKL+) that
 	  with other approach (e.g. HDAC DPIB/posbuf) to elapse PCM.
 	  On platforms (e.g. Intel SKL-) where position update IPC is the only
 	  one choice, this setting won't impact anything.
-	  if you are trying to debug pointer update with position IPCs or where
+	  If you are trying to debug pointer update with position IPCs or where
 	  DPIB/posbuf is not ready, select "Y".
 	  If unsure select "N".
 
@@ -161,7 +161,7 @@ config SND_SOC_SOF_DEBUG_ENABLE_FIRMWARE
 	help
 	  The firmware trace can be enabled either at build-time with
 	  this option, or dynamically by setting flags in the SOF core
-	  module parameter (similar to dynamic debug)
+	  module parameter (similar to dynamic debug).
 	  If unsure, select "N".
 
 config SND_SOC_SOF_DEBUG_IPC_FLOOD_TEST
@@ -190,7 +190,7 @@ config SND_SOC_SOF
 	select SND_SOC_SOF_NOCODEC if SND_SOC_SOF_NOCODEC_SUPPORT
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 	  The selection is made at the top level and does not exactly follow
 	  module dependencies but since the module or built-in type is decided
 	  at the top level it doesn't matter.
@@ -199,7 +199,7 @@ config SND_SOC_SOF_PROBE_WORK_QUEUE
 	bool
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 	  When selected, the probe is handled in two steps, for example to
 	  avoid lockdeps if request_module is used in the probe.
 
