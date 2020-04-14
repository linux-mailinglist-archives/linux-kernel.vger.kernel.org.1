Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577461A8542
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404761AbgDNQkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:40:09 -0400
Received: from mail.manjaro.org ([176.9.38.148]:47480 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404433AbgDNQkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:40:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 6926A3742B3D;
        Tue, 14 Apr 2020 18:40:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LtX2ZRwLkphG; Tue, 14 Apr 2020 18:40:00 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 0/2] Fix some GPIO setup on Pinebook Pro
Date:   Tue, 14 Apr 2020 18:39:50 +0200
Message-Id: <20200414163952.1093784-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains two small fixes for the dts of the Pinebook Pro.
The first fixes inverted logic on the headphone detect GPIO.
The second patch fixes unreliable DC charger detection.

Tobias Schramm (2):
  arm64: dts: rockchip: fix inverted headphone detection
  arm64: dts: rockchip: enable DC charger detection pullup

 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.26.0

