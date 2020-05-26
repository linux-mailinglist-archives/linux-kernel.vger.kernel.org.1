Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5461A7423
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 09:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406320AbgDNHEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 03:04:32 -0400
Received: from inva020.nxp.com ([92.121.34.13]:57212 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406276AbgDNHE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:04:29 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 377AC1A0317;
        Tue, 14 Apr 2020 09:04:26 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9161F1A0300;
        Tue, 14 Apr 2020 09:04:20 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 834104028B;
        Tue, 14 Apr 2020 15:04:13 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/7] ASoC: Add new module driver for new ASRC
Date:   Tue, 14 Apr 2020 14:56:00 +0800
Message-Id: <cover.1586845137.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new module driver for new ASRC in i.MX8MN, several commits
are added for new property fsl,asrc-format

Shengjiu Wang (7):
  ASoC: fsl_asrc: rename asrc_priv to asrc
  ASoC: dt-bindings: fsl_asrc: Add new property fsl,asrc-format
  ASoC: fsl-asoc-card: Support new property fsl,asrc-format
  ASoC: fsl_asrc: Support new property fsl,asrc-format
  ASoC: fsl_asrc: Move common definition to fsl_asrc_common
  ASoC: dt-bindings: fsl_easrc: Add document for EASRC
  ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers

changes in v8
- change get_pair_priv_size to pair_priv_size variable

changes in v7
- updated according to Nicoin's comments.
- add get_pair_priv_size to replace PAIR_PRIVATE_SIZE

changes in v6
- updated according to Nicoin's and Rob's comments.

changes in v5
- Add new property fsl,asrc-format, rather than change fsl,asrc-width
  to fsl,asrc-formt.
- code change for above change.

changes in v4
- Add several commit for changing DT binding asrc-width to asrc-format
- rename asrc_priv to asrc

changes in v3
- add new commit "ASoC: fsl_asrc: Change asrc_width to asrc_format"
- modify binding doc to yaml format
- remove fsl_easrc_dma.c, make fsl_asrc_dma.c useable for easrc.

changes in v2
- change i.MX815 to i.MX8MN
- Add changes in Kconfig and Makefile

 .../devicetree/bindings/sound/fsl,asrc.txt    |    4 +
 .../devicetree/bindings/sound/fsl,easrc.yaml  |  101 +
 sound/soc/fsl/Kconfig                         |   11 +
 sound/soc/fsl/Makefile                        |    2 +
 sound/soc/fsl/fsl-asoc-card.c                 |   24 +-
 sound/soc/fsl/fsl_asrc.c                      |  305 +--
 sound/soc/fsl/fsl_asrc.h                      |   74 +-
 sound/soc/fsl/fsl_asrc_common.h               |  106 +
 sound/soc/fsl/fsl_asrc_dma.c                  |   54 +-
 sound/soc/fsl/fsl_easrc.c                     | 2114 +++++++++++++++++
 sound/soc/fsl/fsl_easrc.h                     |  651 +++++
 11 files changed, 3212 insertions(+), 234 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.yaml
 create mode 100644 sound/soc/fsl/fsl_asrc_common.h
 create mode 100644 sound/soc/fsl/fsl_easrc.c
 create mode 100644 sound/soc/fsl/fsl_easrc.h

-- 
2.21.0

