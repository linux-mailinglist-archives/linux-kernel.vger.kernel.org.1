Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBBE207AB4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 19:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405690AbgFXRty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 13:49:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36808 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405567AbgFXRtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:49:53 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OHncJN129668;
        Wed, 24 Jun 2020 12:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593020978;
        bh=GQd+Z4d61ITa8uShtWtQT27n98wRJ7wBkLgnFyuD8QQ=;
        h=From:To:CC:Subject:Date;
        b=P28MKkozZebzd/ElNZfAXIfA3jLS0FUhNLoTqkQu6aJh/ZyyPrcItWln+sq7Y6mgX
         rGcC5UUaN06dUkwrlJ5iUuFroMqnSdWk8gwdm6bMCzlgZsyrc4cGV9tqk75Z+XpGga
         x7+16E1dOkJ8YF1EJ567pUwsytgUf9OSe0kpZAyc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OHncxN081958;
        Wed, 24 Jun 2020 12:49:38 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 12:49:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 12:49:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OHncWh008583;
        Wed, 24 Jun 2020 12:49:38 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v6 0/7] TAS2562 issue fixes and slot programming 
Date:   Wed, 24 Jun 2020 12:49:25 -0500
Message-ID: <20200624174932.9604-1-dmurphy@ti.com>
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

This series fixes issues tih the shut-down gpio device tree allocation and a
code format issue found.

While working on a project slot programming for the tx and rx paths needed to be
enabled.  In addition the vsense slot programming needed to be configurable and
not directly a simpler adder to the isense slot.

Finally the yaml conversion patch was moved to be the last patch in the series
so that the fixes can be applied and the yaml can be reviewed appropriately
and does not hold up the rest of the fixes.

Dan

Dan Murphy (7):
  dt-bindings: tas2562: Fix shut-down gpio property
  ASoC: tas2562: Update shutdown GPIO property
  ASoC: tas2562: Fix format issue for extra space before a comma
  ASoC: tas2562: Add rx and tx slot programming
  dt-bindings: tas2562: Add voltage sense slot property
  ASoC: tas2562: Add voltage sense slot configuration
  dt-bindings: tas2562: Convert the tas2562 binding to yaml

 .../devicetree/bindings/sound/tas2562.txt     | 34 -------
 .../devicetree/bindings/sound/tas2562.yaml    | 77 ++++++++++++++++
 sound/soc/codecs/tas2562.c                    | 88 +++++++++++++++----
 sound/soc/codecs/tas2562.h                    |  4 +
 4 files changed, 151 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/tas2562.txt
 create mode 100644 Documentation/devicetree/bindings/sound/tas2562.yaml

-- 
2.26.2

