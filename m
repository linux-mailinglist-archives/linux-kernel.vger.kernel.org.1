Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E261A2583CE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 00:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgHaV75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 17:59:57 -0400
Received: from mail.manjaro.org ([176.9.38.148]:35778 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgHaV75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 17:59:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 3D6523741471;
        Mon, 31 Aug 2020 23:59:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZZeuDlPDZHEq; Mon, 31 Aug 2020 23:59:54 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v2 0/1] Enable ddr modes on emmc2 of Raspberry Pi 4 B
Date:   Mon, 31 Aug 2020 23:59:35 +0200
Message-Id: <20200831215936.550402-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently  eMMC storage attached to a Pi 4 is running in single data
rate mode only. However the controller used supports dual data rate
modes. This patch enables ddr modes for mmc storage.

I've verified that there are no issues transferring data in ddr mode
using multiple eMMC modules from different vendors.
Additionally I've checked signal integrity on the data lines at the
micro SD card slot and did not find any issues there either.

This is v2 of this patch. The sd-uhs-ddr50 property present in the
initial version of the patch is not required and was removed.

Changelog:
 v2: Remove sd-uhs-ddr50 property

Tobias Schramm (1):
  ARM: dts: bcm2711: Enable ddr modes on emmc2 controller

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 1 +
 1 file changed, 1 insertion(+)

-- 
2.28.0

