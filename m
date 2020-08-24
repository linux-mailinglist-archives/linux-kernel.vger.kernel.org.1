Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA10250112
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgHXP0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 11:26:48 -0400
Received: from mailoutvs5.siol.net ([185.57.226.196]:58204 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbgHXPEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:04:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id C9FE7525761;
        Mon, 24 Aug 2020 17:04:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FnGb3Jyiudtj; Mon, 24 Aug 2020 17:04:47 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 76D4552576B;
        Mon, 24 Aug 2020 17:04:47 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id B9A56525761;
        Mon, 24 Aug 2020 17:04:44 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, heiko@sntech.de,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 0/2] ARM: dts: sun8i: r40: Enable mali400 GPU
Date:   Mon, 24 Aug 2020 17:04:32 +0200
Message-Id: <20200824150434.951693-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following two patches enable Mali400 GPU on Allwinner R40 SoC. At this
point I didn't add table for frequency switching because it would
require far more testing and defaults work stable and reasonably well.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (2):
  dt-bindings: gpu: mali-utgard: Add Allwinner R40 compatible
  ARM: dts: sun8i: r40: Add Mali node

 .../bindings/gpu/arm,mali-utgard.yaml         |  2 ++
 arch/arm/boot/dts/sun8i-r40.dtsi              | 22 +++++++++++++++++++
 2 files changed, 24 insertions(+)

--=20
2.28.0

