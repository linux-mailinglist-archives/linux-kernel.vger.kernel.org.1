Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983B91F4239
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 19:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbgFIR3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 13:29:00 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35644 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgFIR26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:28:58 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 059HSgdK084614;
        Tue, 9 Jun 2020 12:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591723722;
        bh=5a2z97hTdAdkh5ZKUO4ayG5VqkUbg5/xHMaTOyqvLAE=;
        h=From:To:CC:Subject:Date;
        b=j2fQQ+aCaMLEvkVZHtvc7KxJ+lY4ZMBNf8aMbTTUzTWHzqhVqcZInwVdgBvqgIMu1
         h8BU6MDR6biZq5W6ENVlzO13dGuDKCdAuSi0BwHb1Bb31SYUyvbIBRJuyBbzdPDrAn
         ujHE+i3MrYSetegtymCXQvHKCWiVuSBX/QQiNqdU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 059HSg5N130134
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Jun 2020 12:28:42 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 9 Jun
 2020 12:28:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 9 Jun 2020 12:28:42 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 059HSg6u003016;
        Tue, 9 Jun 2020 12:28:42 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH 0/2] TAS2563 DSP Firmware Loader
Date:   Tue, 9 Jun 2020 12:28:39 -0500
Message-ID: <20200609172841.22541-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The TAS2563 amplifier has a DSP that can run programs and configurations to
produce alternate audio experiences.  The DSP firmware is not a typical firmware
as the binary may contain various programs and configurations that are
selectable during run time.

These programs and configurations are selectable via files under the I2C dev
node.  There may be a better way to select this through ALSA controls but I was
unable to find a good example of this.  This is why this is an RFC patchset.

Dan

Dan Murphy (2):
  dt-bindings: tas2562: Add firmware support for tas2563
  ASoc: tas2563: DSP Firmware loading support

 .../devicetree/bindings/sound/tas2562.yaml    |   4 +
 sound/soc/codecs/Makefile                     |   2 +-
 sound/soc/codecs/tas2562.c                    |  48 ++-
 sound/soc/codecs/tas2562.h                    |  25 ++
 sound/soc/codecs/tas25xx_dsp_loader.c         | 377 ++++++++++++++++++
 sound/soc/codecs/tas25xx_dsp_loader.h         |  93 +++++
 6 files changed, 530 insertions(+), 19 deletions(-)
 create mode 100644 sound/soc/codecs/tas25xx_dsp_loader.c
 create mode 100644 sound/soc/codecs/tas25xx_dsp_loader.h

-- 
2.26.2

