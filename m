Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6512F6813
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbhANRr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbhANRr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:47:58 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043E6C061574;
        Thu, 14 Jan 2021 09:47:17 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id e25so5475574wme.0;
        Thu, 14 Jan 2021 09:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nb5OIaE+9/irBEX8UonAVAUkNvxhfUHFAHqCASsD9LE=;
        b=CcOZomcz/46bCrV5yNqqma6oUsvkVY9d5r0ObBAn/dtLhHBczFBzhjKhnWK76DrB+A
         C7J7FL7zR01+cy3JLYEbL82cWktprhs+FFDmNGVtFZPTIPkhdkVzTSc2/Moap9eF0Njj
         9aSAuDXgD2HMCUwD/PudQ0UQ11Q6yFGvpTYvOhk8HznTqN2/7OsyFohvlLG6npdPuIsa
         rxKwJ+XJbwg3raT5pioYyYXj9+FubXx9UTLkkXzp+sppF84ZCaEKSKyfc3NQgMsuD25f
         wcXZK5uH2ntrdOSsFD8MrmNixGNlS+97XDZDIeIz747lxoMFzpyKxOUybO/WDqUUzb07
         bwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nb5OIaE+9/irBEX8UonAVAUkNvxhfUHFAHqCASsD9LE=;
        b=EiOur21YcNB2qL0TKlMbkidLxUWlQtYpX0R1weNge5qeivof15ERbcZ1qShqEL/OnT
         j57+X1zzcVxDN300PnDEVBlvKB8xiAVHQSYonWcf3TV/m1EXQAdVQCEJeNofF5luIj7S
         OeIy43VVEpI80NvdhMwLWzzLSOTaRLXYG/3/SShbosqY3yBaj/Pg46jTYA5R6M9eqTcg
         Zabu86RvZhn/VP+WqmF75pyVb7PmT9p8hwS94BSuHrrienTG2795QF/tVDoIV+tT0xt3
         GmUCQSnIqWPN2gzd/xPCLo55QMabQBSlT9X+zVryEhS0fkQRVq8jwy3kce1BxH9/lU3a
         oXAQ==
X-Gm-Message-State: AOAM530TnzV46ll8LmQGShI95OoW9ihngCUYJfwgYDyr70x/kMGO/nFf
        yC5g3RCUIC4x22Bjzf47OHM=
X-Google-Smtp-Source: ABdhPJwnZ+7PaaHRMKL9BPUhTLW7+ngxGrQSOmX8NA3G0DlrSJlwWD70GXGzrNGoYSPWUo6s4gw9OQ==
X-Received: by 2002:a1c:4c7:: with SMTP id 190mr5043245wme.32.1610646436634;
        Thu, 14 Jan 2021 09:47:16 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700adae03a5d647a4d0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:adae:3a5:d647:a4d0])
        by smtp.gmail.com with ESMTPSA id g18sm5120663wrw.61.2021.01.14.09.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:47:15 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v5 0/6] Fix issues on pf8x00 driver
Date:   Thu, 14 Jan 2021 18:47:08 +0100
Message-Id: <20210114174714.122561-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this patch set aims is to fix some issues contains in the pf8x00 driver.
Some issues are documentation ones, some others are in code.

These issues where found while developing another version of the same
driver. I prefer to share with you the patch for it.

I do these patches on the master branch of the linux-next repository.

1: there is a missing documentation when we build the driver as a
module.

2: nxp,phase-shift documentation was not optimal.

3: nxp,ilim-ma is useless since another property does (nearly) the same.

4: Same than 4, in driver code.

5: It's better to use a linear_range to describe the voltage of bucks.

6: Fix several mistakes in the handle of nxp,phase-shift property.

Changes introduced in v2:
Some patches were mixed (and did not compile separately);
Add path 7 for the handle of nxp,phase-shift property.

Changes introduced in v3:
Remove useless patch 0;
Do requested fixes in patches.

Changes introduced in v4:
Mark nxp,ilim-ma as deprecated since it was already present in a kernel
version.

Changes introduced in v5
Use deprecated: true flag in nxp,ilim-ma description

Thanks,

Adrien Grassein (6):
  regulator: pf8x00: add a doc for the module
  regulator: dt-bindings: pf8x00: fix nxp,phase-shift doc
  regulator: dt-bindings: pf8x00: mark nxp,ilim-ma property as
    deprecated
  regulator: pf8x00: mark nxp,ilim-ma property as deprecated
  regulator: pf8x00: use linear range for buck 1-6
  regulator: pf8x00: fix nxp,phase-shift

 .../regulator/nxp,pf8x00-regulator.yaml       |  17 +-
 drivers/regulator/Kconfig                     |   4 +
 drivers/regulator/pf8x00-regulator.c          | 203 +++++++++++-------
 3 files changed, 136 insertions(+), 88 deletions(-)

-- 
2.25.1

