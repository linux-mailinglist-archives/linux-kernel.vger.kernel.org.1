Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E953256AB6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 01:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgH2XPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 19:15:32 -0400
Received: from mail.manjaro.org ([176.9.38.148]:40540 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbgH2XPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 19:15:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 222753D60031;
        Sun, 30 Aug 2020 01:15:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dywtqmMXZZsG; Sun, 30 Aug 2020 01:15:26 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 0/1] Enable ddr modes on emmc2 of Raspberry Pi 4 B
Date:   Sun, 30 Aug 2020 01:15:08 +0200
Message-Id: <20200829231509.543901-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently both micro SD cards and eMMC storage attached to a Pi 4 are
running in single data rate mode only. However the controller used
supports dual data rate modes. This patch enables ddr modes for both
sd and mmc storage.

I've verified that there are no issues transferring data in ddr mode
using multiple micro SD cards and eMMC modules from different vendors.
Additionally I've checked signal integrity on the data lines at the micro
SD card slot and did not find any issues there either.

Tobias Schramm (1):
  ARM: dts: bcm2711: Enable ddr modes on emmc2 controller

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.28.0

