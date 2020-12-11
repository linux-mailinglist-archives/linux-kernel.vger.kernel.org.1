Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0874F2D7817
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 15:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbgLKOnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 09:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405443AbgLKOnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:43:01 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA51CC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:42:20 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id e7so11108569ljg.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D/mqF1yAgf89gXXFnc/6Wo8QAVrqEjqhUSCi4lJHpok=;
        b=sMhJp1rRMqwWoh0rdDBYjXD5YCIIoyzdFdowkqRNRpKFH0bInsVvtrIcC4SNzf63qJ
         7H95qCqr/jCGsDtefaBCuvOz83T/jHj0gcawzlzGlVWgvIeAvLDvoZqhKeNhGzz7Czm4
         cSgkQMUQGLuoHqtOVgPVOotQ/iigPVrbhUbViiOlvOaAL2ZcwIRAM08fXsUP5v1M5p9h
         5/HfAFI/+1U7se7vjBddQtysHqpXKfGwdryo7a0aROLdQQiUyt7KeK74/+xZ9MNnapvI
         dX3ZpTqEfcOllK/+/zZS1+x7ZyaVoaSkc2TQLiLBIa/BcrQVBanoB1gvwoEt4HkBHWeQ
         aTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D/mqF1yAgf89gXXFnc/6Wo8QAVrqEjqhUSCi4lJHpok=;
        b=JBwBzbPH1xnd8JVYAWtkkMNF1GobHp/ZNi+5b9cuy9I/o2nTo7boIqx4DoeYwZcEnt
         Gw/C4FRBIX7wVKFetO4jGFsnXotVLqNUP3dDDuOhKxbPqnxTCbmpltWE7ThukC8YKbRG
         n1K1z11PFhDkoAINR2xGPJBdKsaPJQz0pzW3itfPGs2aNZyo7L7hAZ4Wy2VQlHUcfItD
         Gl2RhfhRK0G9w2gQ3sPeq9uTgOeCHDBpXcLz8IQ/ClXQtujsaugW40RuFmEncfagMc9a
         EGhsKNhSu36rMmZj2XK6KyxPWQ1vX8MTOb+UYBH+q7eH1efSguifg0udt+8XFD85J16z
         8yzQ==
X-Gm-Message-State: AOAM531UAcZHJVoP3fJ0gNQ9OqAOonpD2LlIKavwX0MK7IFTp03YK8br
        616UPAq77uFGDVxIUD6nHMwdKHevg3YyA8AZ
X-Google-Smtp-Source: ABdhPJzcJIlOHE00LmwsPoqdgHndKC6zuF2mjgxSZxKX97GZRkN9/a39oVKPuVvCkr2ndDoBvJADCQ==
X-Received: by 2002:a2e:95ca:: with SMTP id y10mr5248539ljh.440.1607697738788;
        Fri, 11 Dec 2020 06:42:18 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id v2sm904786lfn.163.2020.12.11.06.42.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 06:42:17 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
        mcroce@microsoft.com, sven.auhagen@voleatech.de, andrew@lunn.ch,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH] MAINTAINERS: add mvpp2 driver entry
Date:   Fri, 11 Dec 2020 15:41:47 +0100
Message-Id: <20201211144147.26023-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since its creation Marvell NIC driver for Armada 375/7k8k and
CN913x SoC families mvpp2 has been lacking an entry in MAINTAINERS,
which sometimes lead to unhandled bugs that persisted
across several kernel releases.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6f474153dbec..db88abf11db2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10513,6 +10513,13 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/marvell/mvneta.*
 
+MARVELL MVPP2 ETHERNET DRIVER
+M:	Marcin Wojtas <mw@semihalf.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/marvell-pp2.txt
+F:	drivers/net/ethernet/marvell/mvpp2/
+
 MARVELL MWIFIEX WIRELESS DRIVER
 M:	Amitkumar Karwar <amitkarwar@gmail.com>
 M:	Ganapathi Bhat <ganapathi.bhat@nxp.com>
-- 
2.29.0

