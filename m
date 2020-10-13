Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE6328D216
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 18:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389572AbgJMQV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 12:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731703AbgJMQV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:21:26 -0400
X-Greylist: delayed 460 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Oct 2020 09:21:26 PDT
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E45FC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 09:21:26 -0700 (PDT)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 710F1A53273; Tue, 13 Oct 2020 18:13:42 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Heiko Stuebner <heiko@sntech.de>, Aditya Prayoga <aditya@kobol.io>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 0/2] arm64: Add basic support for Kobol's Helios64
Date:   Tue, 13 Oct 2020 18:13:38 +0200
Message-Id: <20201013161340.720403-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

compared to v2 of this series (starting with Message-Id:
20201012204317.1581752-1-uwe@kleine-koenig.org) I sorted various things
as pointed out by Johan Jonker, dropped and improved a few things. I
hope I got the sorting right now.

This time I also Cc:d lkml (even though I don't think to attract someone
interested in this patch series there).

Uwe Kleine-König (2):
  dt-bindings: vendor-prefixes: Add kobol prefix
  arm64: dts: rockchip: Add basic support for Kobol's Helios64

 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3399-kobol-helios64.dts    | 378 ++++++++++++++++++
 3 files changed, 381 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts

-- 
2.28.0

