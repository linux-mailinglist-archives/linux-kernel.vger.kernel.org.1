Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36292FD9FA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392714AbhATTqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392680AbhATTl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:41:26 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEED6C0613C1;
        Wed, 20 Jan 2021 11:40:45 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 68A3822727;
        Wed, 20 Jan 2021 20:40:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1611171644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tlKQp8qtg7ZoARKjR0krCyCtHtuqS8eLJSkS8h5Iy+Q=;
        b=Hkmt4GpEE9/lMp95snLoV+wwqAyxIEbTWRW0zi6nwA+ZcjVqGKufBoel3qAQJd/qWrNZRQ
        csZv1jkZB1/uttJKjXEPLGk6VJK8Yf6AYMNl6TJ+OnTZqpysmQ/imYQdfjWwjtxbzzKjVX
        H223mRARsbIL8lqGNkZeAvN9nc0yCJ8=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH 0/3] add Ebang EBAZ4205 support
Date:   Wed, 20 Jan 2021 20:40:30 +0100
Message-Id: <20210120194033.26970-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Ebang EBAZ4205 board. This board was once used as a
control board for a bitcoin mining device. Nowawdays it is sold as a cheap
Zynq-7000 eval board.

Michael Walle (3):
  dt-bindings: add ebang vendor prefix
  dt-bindings: arm: add Ebang EBAZ4205 board
  ARM: dts: add Ebang EBAZ4205 device tree

 .../devicetree/bindings/arm/xilinx.yaml       |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/zynq-ebaz4205.dts           | 109 ++++++++++++++++++
 4 files changed, 113 insertions(+)
 create mode 100644 arch/arm/boot/dts/zynq-ebaz4205.dts

-- 
2.20.1

