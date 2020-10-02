Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B5F281782
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbgJBQKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:10:22 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:23505 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBQKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:10:22 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2020 12:10:21 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601655021; x=1633191021;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0xm80mI835j7RsnCf27YVapcCw5rmNqJqXj1F/aXJDg=;
  b=wI6GKhyqVsG1dFAxqG5bAsdJVmdLur23avUBNrqDHn6TZWLgDzzd6kmP
   Z432zZ4m8Qr8jbrrr2JKECVMX2zKbi5Bwj2gtNoSXANue+S43ma3FcB4m
   tircAsJdBWAhgk0+WO/ZHaXPThz3xzM568i1v74pTYZK0hKKHXna7vkyc
   6IM+fv/7y3Ll+l7w5Fz6Emi1MKP6xbD38/Y6Gu2U7o8VuDp5vzWHT4zb0
   SZIu8ON316eEW4sDKoTMuG3+maciz/K8MvTUqK9x2NO8QrzEUyUpck+xP
   BS+NFlzE/9mxxpAyLjaRCFhaIrjEz+4VtN9MmR/5302pt4gyFGFtc2MXD
   w==;
IronPort-SDR: ERktlbb9SHgHSVs1WBh0+wVf8cBcyCqMHlQ0klUWs2eYzPAhkilLDtnZI034NRrW9SYYQ4y/SF
 TBt+4s0vOUCoF5b4iAub8CAdJeF3LMSgCGhCflj+y1KckMaVv/gZBLSs2WmVc58cyh3/TqQkXH
 Btow4/O+EkpNSg0nOIOalDBdDP4fM/TsYK+FIfb/683JBP/fxGXObqLI650Ts7AjwLadhu+s60
 iWqR7T1NuXSHaJz0MBE7xdmY2NnPhp7ejDVlFqG3q+dq4fomyPqB35UrgOLkvtpTTyRNxT4CC9
 +EA=
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="91238271"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Oct 2020 09:03:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 2 Oct 2020 09:03:14 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 2 Oct 2020 09:02:32 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH 0/2] Add driver for Microchip S/PDIF RX
Date:   Fri, 2 Oct 2020 19:03:03 +0300
Message-ID: <20201002160305.815523-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sony/Philips Digital Interface Receiver (SPDIFRX) is a serial port
compliant with the IEC-60958 standard. Among its caracteristics, we
mention the following:
 - SPDIF/AES-EBU Compatible Serial Port
 - 32 Samples FIFO
 - Data Width Configurable to 24 bits, 20 bits or 16 bits
 - Packed and Unpacked Data Support for System Memory Optimization
 - Line State Events Report and Source of Interrupt
 - Line Error Rate Report
 - Full Memory Map of 192 bits for Channel 1 and Channel 2 Status and
   User Data
 - First 32-bit Status A, Status B Change Report and Source of Interrupt
 - Line Digital Filter
 - Register Write Protection
 - Abnormal Software Access and Internal Sequencer Integrity Check Reports

This interface is available in Microchip's SAMA7G5 SoC.

Codrin Ciubotariu (2):
  dt-bindings: sound: add DT bindings for Microchip S/PDIF RX Controller
  ASoC: mchp-spdifrx: add driver for SPDIF RX

 .../bindings/sound/mchp,spdifrx.yaml          |  73 ++
 sound/soc/atmel/Kconfig                       |  13 +
 sound/soc/atmel/Makefile                      |   2 +
 sound/soc/atmel/mchp-spdifrx.c                | 954 ++++++++++++++++++
 4 files changed, 1042 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml
 create mode 100644 sound/soc/atmel/mchp-spdifrx.c

-- 
2.25.1

