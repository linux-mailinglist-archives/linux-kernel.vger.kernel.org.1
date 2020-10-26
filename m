Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAA4298780
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 08:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769808AbgJZHfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 03:35:46 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:34081 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1768408AbgJZHfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 03:35:45 -0400
Received: by mail-pf1-f181.google.com with SMTP id o129so163926pfb.1;
        Mon, 26 Oct 2020 00:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+i2ZlhR3b0Er71SY9bYb8Ka8p9qIWWGIB2GLx3viGtw=;
        b=FC1oEmHmqmY07wzOxKG/Vgo553H/vhMUdwoBflh0aaGRumO5ZdOx8l06C2aozufKji
         ZY5JJIDe7pwoYfo5Imqztcn+hpina9gb77FgjpLEB/iX52brJsfl/JOtfztlvSkhdQTK
         I3P0s2c+PYhVvEiBRXV8NTHjs1rhy71KDfdCAJI53lUAr/igCclHng9NfZO0C/HZtdtl
         VwLua20vTDMjILgTeX+iLEEFo5NjcSZK8a1mAXpPfUy6ssQ0UppyKFObW3rjXihTXoZp
         m9m+9lU8eYpPYh6ZHW/as/r4biyaFJQfRx1uLrLLLfUIwfxOIR99iA9kx3mj7mKTo6gd
         z29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+i2ZlhR3b0Er71SY9bYb8Ka8p9qIWWGIB2GLx3viGtw=;
        b=EARQ6cOmTaIlX6th8WtpkRvwH56EoN6kOHaAWMUMSI8eoNG5sWLf3vs3aShBmIkgZZ
         d1zcsPOk+J/Uxx9nvRNt4ssS5zuYBsK79+o3u+S4h8AVTAaPJhnM8Ovra92w8dgK6x4u
         nESMfsIYiPt9fkPRYJ6MQItt3e1Q0GAEYWAuhV4tB1CIFRBS+G5GPaczJ4r955h4NLaM
         bIkJaVakrE2376PP9NX/6KKrpzzrbzFMoG/rRJMtg6XPBOIBV6iEOYaZsHakysblU/cY
         V/CGHE4f35E4cvgwZoCTXxRkNKpeGDgHCAPTffpXhOYl+VTKfcc9zN/6p1EUDSAT128Y
         t33w==
X-Gm-Message-State: AOAM530qUe5nQvQxFuD3a+rIOVk/rGTD4FkgpZSy1kxUfIjVLLHxkxnY
        VL4jtwUdr8Tii5tYM4xnpI7MVNu8UgukzFKa
X-Google-Smtp-Source: ABdhPJyKjTcv+NB2442ZD275Zc2SMrFQXo+a4qGY+Lh91Dys6wP3sFk7p9MN6jXDesDS7DmLSbZORA==
X-Received: by 2002:a65:4302:: with SMTP id j2mr12188353pgq.177.1603697745008;
        Mon, 26 Oct 2020 00:35:45 -0700 (PDT)
Received: from ruantu-3.localdomain ([103.230.142.242])
        by smtp.gmail.com with ESMTPSA id r6sm11363177pfg.85.2020.10.26.00.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 00:35:44 -0700 (PDT)
From:   Yu-Tung Chang <mtwget@gmail.com>
To:     robh+dt@kernel.org
Cc:     mripard@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yu-Tung Chang <mtwget@gmail.com>
Subject: [PATCH v3 0/1] ARM: dts: sun8i: add FriendlyArm ZeroPi support
Date:   Mon, 26 Oct 2020 15:35:35 +0800
Message-Id: <20201026073536.13617-1-mtwget@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add FriendlyArm ZeroPi support.

Wiki:
http://wiki.friendlyarm.com/wiki/index.php/ZeroPi

Schematic:
http://wiki.friendlyarm.com/wiki/images/7/71/ZeroPi_20190731_Schematic.pdf

v1:
- Remove the extra spaces in description text.

v2:
- Remove the ehci0 and ohci0 device nodes.
- Remove the usbphy->usb0_id_det-gpios property.

v3:
- Enable RGMII RX/TX delay on PHY.

Yu-Tung Chang (1):
  ARM: dts: sun8i: add FriendlyArm ZeroPi support

 .../devicetree/bindings/arm/sunxi.yaml        |  5 ++
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/sun8i-h3-zeropi.dts         | 87 +++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-zeropi.dts

-- 
2.29.0

