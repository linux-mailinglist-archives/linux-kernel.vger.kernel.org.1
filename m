Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987831A801E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 16:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391113AbgDNOoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 10:44:25 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:36994 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391047AbgDNOoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:44:10 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9B2F340443;
        Tue, 14 Apr 2020 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1586875449; bh=CyQLY6qA9b5hLjN1QZuqQF+tTWfcH+oMNp9NHfFqATo=;
        h=From:To:Cc:Subject:Date:From;
        b=DrTqvCEdWVVYU7NdGBLWNrjs+MH9B2O5Rb2ohpc1in5xryOIb4U2EbiL0Ef/wkcwH
         Ki6Z1BAHuoCMQ36goSJCv8xY48STOzlRx3+2FtESSqdA68MYyHVzYLMvk+BMNHgwj0
         kWe78JO7FcyPIDJeUnguuEpHsEyw7e/1ci17vyCB2AN6uzAeotF9wxkmuAQl+Bjy3b
         oTUemcFSQDQ4lXMnofiTX/KdQl6MpFlbXjznW9j1XFBnym0SoXlVjC/kroqNOZaR6G
         MEMi5MoKzduGVQ5EHHHMBami3dMKcLYJArQCsE4lM31psZxZkphYiY/UsITV8xKLbe
         fC1z3rJUXgOfQ==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.225.48.89])
        by mailhost.synopsys.com (Postfix) with ESMTP id 653FBA005C;
        Tue, 14 Apr 2020 14:44:04 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     dri-devel@lists.freedesktop.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 0/2] DRM: ARC: add HDMI 2.0 TX encoder support
Date:   Tue, 14 Apr 2020 17:44:00 +0300
Message-Id: <20200414144402.27643-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v1->v2:
 * use DT Schema format please (.yaml files) for DT bindings

Eugeniy Paltsev (2):
  DRM: ARC: add HDMI 2.0 TX encoder support
  dt-bindings: Document the Synopsys ARC HDMI TX bindings

 .../display/bridge/snps,arc-dw-hdmi.yaml      | 131 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/Makefile                      |   2 +-
 drivers/gpu/drm/arc/Kconfig                   |   7 +
 drivers/gpu/drm/arc/Makefile                  |   1 +
 drivers/gpu/drm/arc/arc-dw-hdmi.c             | 126 +++++++++++++++++
 6 files changed, 272 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/snps,arc-dw-hdmi.yaml
 create mode 100644 drivers/gpu/drm/arc/arc-dw-hdmi.c

-- 
2.21.1

