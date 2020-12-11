Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048FE2D7BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 17:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390525AbgLKQxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 11:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390353AbgLKQxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:53:12 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E1AC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 08:52:31 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id a1so11670144ljq.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 08:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gcYa6L8/Uvmo8K/EulzmKdbBwrm2l0qNtAQPuKYVhqY=;
        b=U/7El6pBOXXYoZfPWWJm/jWo8/q8rucNE5gS5ABbrNaANd2ktZGueaG/SQqFTqvo0R
         1n1TDNAKdmoZ0xLNmerGdfW4HizQYpSO7zqmiPbA4HKhlXOdwhP4AVBboErVf0/81ZTG
         CieavYHs9d9joPYucrh2vPIDFPgfyFw/2YAdBe6mQVzQ8FQuqQDKYKtBQOecHWEDv3r/
         DSdOYBCAmS9TdegDPmj3TVUzLyuDHxEJjgxwuqYCq9I2zccXiA0pMr2LjalHQqvxIEOP
         5o6okyl4fcKV5ACoDUpNgyh/lh/MXxdtkyvibrEApC5s2My39S9c1Hu7NTz+/F04XFWe
         sb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gcYa6L8/Uvmo8K/EulzmKdbBwrm2l0qNtAQPuKYVhqY=;
        b=fNlpMfvV2TIJ54x1HP5RUJlRk2yfaDJjaYKlqsujYnm6hAjZsozE1u8nOEClDvNrY8
         u2yBzjrLGWsJ62VTNwTQan3Apm9robmbUjNHiagqo69JscoKa/2b+ARVyPHxwgO8qPnB
         L1nrGpuiBf1HmXLTGTwDxwFsJ/i6N9UYa/Kbr3QshXY3hFFJmmwgwCs/EjYekiz+qk5z
         NekvvZMinaz1AoM6igZZ4EWPoqw+U2eblwdIsuNCehRxlyyDdK1Hpobwqskce1HJ7jAh
         2QOJgn2RCX9hGP+7KaOisD2fR4w2XH7fmyeDq6AiSkN3Xw9qMAkJi7b4cirY8rLx5670
         gnRw==
X-Gm-Message-State: AOAM533Tk/CnfVmx8MKPCt5Jq4KzD+H6vvyaVDE4tkW0rcgRWfb51EFk
        JdqsQ3wwNXRufAMylkU2XDdFaAaOrNTubELS
X-Google-Smtp-Source: ABdhPJye9T5ssjW8E4P4GjH7FfhvM4AF2Z7qy2IXAxEr3xcVcZvzwNt1lx/ahswXlmOuVwPVDngHew==
X-Received: by 2002:a05:651c:2da:: with SMTP id f26mr5829320ljo.134.1607705549818;
        Fri, 11 Dec 2020 08:52:29 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id h23sm860741lfc.246.2020.12.11.08.52.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 08:52:29 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
        mcroce@microsoft.com, sven.auhagen@voleatech.de, andrew@lunn.ch,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v2] MAINTAINERS: add mvpp2 driver entry
Date:   Fri, 11 Dec 2020 17:51:14 +0100
Message-Id: <20201211165114.26290-1-mw@semihalf.com>
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
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6f474153dbec..975f24409b35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10513,6 +10513,14 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/marvell/mvneta.*
 
+MARVELL MVPP2 ETHERNET DRIVER
+M:	Marcin Wojtas <mw@semihalf.com>
+M:	Russell King <linux@armlinux.org.uk>
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

