Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB91D2A27A3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgKBKCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgKBKCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:02:07 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68EAC0617A6;
        Mon,  2 Nov 2020 02:02:05 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 62so3069057pgg.12;
        Mon, 02 Nov 2020 02:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hjVvpyyxFXY/mnaQcH3/4tNtgq+0JaZgfDmiu1uL+8=;
        b=YaenSvDJVQxzOs27TeMZ/GRbAPEqid+uEbgrEpYa1JImaZ071Mg6FsF5vFwBao+8UM
         CcL4YWNL/peTicu2qda5h6QUhFMFMq6GFJL4rHV4W7wykjX7utiJDrPLqu2RykQRLzEN
         A47UMLcrJXQZTc8v9keIkPY9DMK+ih4vmPNmHqrLhbJd4FvuHQX+H++0w4YlZ0hTQVWq
         b9EdHNpiTjaOe5+6WFkkVMKvHQzfn3bexOFq7GHpeHzePvUOfTQbCqs0LyxNT7+NZIze
         3aYIh/1ajFa6ZZtmcVhGdEF1JykNQaeoEIqerAOGw+Z16bL6uo4FuKhqfQC51b85cRDt
         FuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hjVvpyyxFXY/mnaQcH3/4tNtgq+0JaZgfDmiu1uL+8=;
        b=RbUoD1E3ikgETkT4OgAmA8uBfMKCbMPhbX0CZdeP6DaWLWFKnB0p3hdiva53giK1Sp
         iOdUU0EYUkRiR/KQOBHDeXxYqjdJPwNqiVMc9/wcfHYOgNOfAtnwi38HclZkYzHcuH5t
         U1UjVMaqKeuUs0qBZ8clp7+EGdzmixMKGsOjzMt1A4fFNfwlV4yodTsDJRnexqa/dn+h
         wi5FNjU1Bg+LEbCHNNj+beT7vqXcs7iVJJ5P0zG1dZt44XNv7mDwEEA2wTyMXwOwyFj6
         83JJuyk3jqRYrGvyI6B349ypBaUWUlE9R8zo4pRLOML/bQcUw+VbhOsoP9/Fc3ypWhHV
         Kgkg==
X-Gm-Message-State: AOAM533y/KIa4QYaSDQpGZezSjIeVpeUOVjjccsMaHF307B0KKAtzlaB
        A7scTh2b8KNHpprb6hCU2bw=
X-Google-Smtp-Source: ABdhPJy4ahWoB3Q2ZDyMVfLprwz4ho7gg2gCC1p7hsC+Vl942tfUWW51a3KfJFkDx1q2b0zzik5vdw==
X-Received: by 2002:a62:6dc2:0:b029:152:637c:4cf5 with SMTP id i185-20020a626dc20000b0290152637c4cf5mr20847453pfc.15.1604311325472;
        Mon, 02 Nov 2020 02:02:05 -0800 (PST)
Received: from ruantu-3.localdomain ([103.230.142.242])
        by smtp.gmail.com with ESMTPSA id u7sm13283084pfn.37.2020.11.02.02.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 02:02:04 -0800 (PST)
From:   Yu-Tung Chang <mtwget@gmail.com>
To:     robh+dt@kernel.org
Cc:     mripard@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yu-Tung Chang <mtwget@gmail.com>
Subject: [PATCH v1 0/1] ARM: dts: sun8i: h3: Add initial NanoPi R1 support
Date:   Mon,  2 Nov 2020 18:01:56 +0800
Message-Id: <20201102100157.85801-1-mtwget@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add FriendlyArm NanoPi R1 support.

Wiki:
http://wiki.friendlyarm.com/wiki/index.php/NanoPi_R1

Schematic:
http://wiki.friendlyarm.com/wiki/images/a/ab/NanoPi_R1_V1.0_1809-Schematic.pdf

v1:
- use SPDX header
- rename led node to led-[0-9]
- rename sdio-wifi node to wifi
- use "function" and "color" properties for led node
- modify usb_otg->dr_mode property to otg
- add aliases for uart1, emac, wifi

Yu-Tung Chang (1):
  ARM: dts: sun8i: h3: Add initial NanoPi R1 support

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts      | 169 ++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts

-- 
2.29.0

