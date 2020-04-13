Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11DB21A6302
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 08:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgDMGYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 02:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbgDMGYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 02:24:49 -0400
Received: from mail.siol.net (mailoutvs39.siol.net [185.57.226.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76358C0A3BE0;
        Sun, 12 Apr 2020 23:24:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 88F8C522DEC;
        Mon, 13 Apr 2020 08:24:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id I2uoRwcVt52q; Mon, 13 Apr 2020 08:24:48 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 450CE522E37;
        Mon, 13 Apr 2020 08:24:48 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id C9DE0522DEC;
        Mon, 13 Apr 2020 08:24:43 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 0/3] arm64: dts: allwinner: h6: OrangePi Lite2 and One Plus DTs
Date:   Mon, 13 Apr 2020 08:24:30 +0200
Message-Id: <20200413062433.1145043-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds missing nodes for OrangePi Lite2 and One Plus and
fixes USB OTG mode to host because there is no way to toggle VBUS
power supply on/off.

The only remaining board specific functionality not enabled is USB3
on OrangePi Lite2, but for that USB connector power supply support
has to be added to driver first.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (2):
  arm64: dts: allwinner: h6: orangepi: Add gpio power supply
  arm64: dts: allwinner: h6: orangepi: Disable OTG mode

Sebastian Meyer (1):
  arm64: allwinner: h6: orangepi-lite2: Support BT+WIFI combo module

 .../allwinner/sun50i-h6-orangepi-lite2.dts    | 65 +++++++++++++++++++
 .../dts/allwinner/sun50i-h6-orangepi.dtsi     | 17 ++++-
 2 files changed, 81 insertions(+), 1 deletion(-)

--=20
2.26.0

