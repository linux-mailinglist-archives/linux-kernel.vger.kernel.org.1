Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860082515EB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 12:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgHYKAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 06:00:42 -0400
Received: from mailoutvs20.siol.net ([185.57.226.211]:36394 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729635AbgHYKAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:00:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 2F49452321A;
        Tue, 25 Aug 2020 12:00:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id m6MdO9UJgfFR; Tue, 25 Aug 2020 12:00:35 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id DC18A522FC8;
        Tue, 25 Aug 2020 12:00:35 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 46557522F22;
        Tue, 25 Aug 2020 12:00:35 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 0/2] ARM: dts: sun8i: r40: Enable DMA
Date:   Tue, 25 Aug 2020 12:00:28 +0200
Message-Id: <20200825100030.1145356-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner R40 contains DMA engine similar to that in A64.

Following two patches enable it so DMA users can be added later.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (2):
  dt-bindings: dma: allwinner,sun50i-a64-dma: Add R40 compatible
  ARM: dts: sun8i: r40: Add DMA node

 .../bindings/dma/allwinner,sun50i-a64-dma.yaml       |  9 ++++++---
 arch/arm/boot/dts/sun8i-r40.dtsi                     | 12 ++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

--=20
2.28.0

