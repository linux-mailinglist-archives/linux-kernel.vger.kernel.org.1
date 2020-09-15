Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64E926B74E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgIPAVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgIOOVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:21:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1038AC061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 07:21:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so3581362wrv.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 07:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M0CRdTYVYc/U7fysKoWQV0wj2VPNEE4muh/srS7OLm0=;
        b=bIz/qMbLKItZuCECmgJiND27QuOQaYIKjHTV/Er7jU53TBbJnm/G6VDFIogRCkbHsy
         JPajcLTsuWRdC/0sOwKIWU/n3CmBIx0K2/gXqNmyK9GRZr08b2e3dEk/mxL2UHCt4KZm
         f56Un+tnsWdrhzAvj1KespuhPag13sz+8CpsO67cYdotmsnc/3oG6WWFqE9EfCz3m5HF
         ocYMByWkdvhwRJ6ry8VWK309gvWAcQAp/IElAW71Bk8wzOEH0MFP78J7X/HSatjKHowV
         LJZZs/hHMsN6aNzy/sLpqLRXrU9c7um1j5xSK3xT2lmJkHJwkhlHz6T4shnfKxAu4Kaw
         M4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M0CRdTYVYc/U7fysKoWQV0wj2VPNEE4muh/srS7OLm0=;
        b=RC5NgpSNhvYws3nQNOSNsFHvOHkfCGo+2rVlkCnc6xHllEkxKWSGxlbpttWQc353r3
         C72BKzw4DYYNe+aB0ggW5GsN1NV2ayUsCv1urzG5HlpuxSUy791QpPFZASoIItBE7zf3
         4gHKpSOsqIkW7Ky3j1rtxim5q9iUlU24WEq/vOxh/JOxQTRVGeBl/ghhxsefagxkhcnU
         Hg6QnTWl2G88RKHL6LRRvZdds4MKY8YhUJSehG7LMUGArUCvi/vKf3jezku2jez0N39j
         f8lEayfS1xY5t8sB9MBM4d+4tHgJvo//IA/k88Wbck5tIrUG0cMuRhpLgb5AJF+lXYI9
         Muww==
X-Gm-Message-State: AOAM5335NyHpnK925sfny07xS8gcKNHwj0D2q0agl7nrH/u0iULxg9bd
        yFtBIbCAgcn19/N4UPNoMXi7ig==
X-Google-Smtp-Source: ABdhPJz7AsnxbhTnOadmbKyAmvlVXDYp5iixwoaOgOYfqnVaNg+KuYT5+0TX5Te0hJCGigoNRGUBSA==
X-Received: by 2002:adf:f5ce:: with SMTP id k14mr21052586wrp.286.1600179686724;
        Tue, 15 Sep 2020 07:21:26 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d2sm27821482wro.34.2020.09.15.07.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 07:21:26 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: meson: add aml-s905x-cc v2 support
Date:   Tue, 15 Sep 2020 16:19:19 +0200
Message-Id: <20200915141921.57258-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds initial support for the libretech aml-s905x-cc v2.

Jerome Brunet (2):
  dt-bindings: arm: amlogic: add support for libretch s905x cc v2
  arm64: dts: meson: initial support for aml-s905x-cc v2

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../meson-gxl-s905x-libretech-cc-v2.dts       | 318 ++++++++++++++++++
 3 files changed, 320 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts

-- 
2.25.4

