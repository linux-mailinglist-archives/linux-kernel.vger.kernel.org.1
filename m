Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9906E2FC554
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 01:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbhATAFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 19:05:52 -0500
Received: from foss.arm.com ([217.140.110.172]:58248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730777AbhATAEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 19:04:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70CB3D6E;
        Tue, 19 Jan 2021 16:04:07 -0800 (PST)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DDC13F68F;
        Tue, 19 Jan 2021 16:04:07 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com, stefan.wahren@i2se.com,
        nsaenzjulienne@suse.de, ardb@kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 0/1] rpi: enable SD/Wifi on ACPI firmware
Date:   Tue, 19 Jan 2021 18:04:05 -0600
Message-Id: <20210120000406.1843400-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rpi4 can be booted on Linux using ACPI, this set
adds the ACPI bindings to allow it to utilize the Arasan
and eMMC2 controllers.

v1->v2: Fix a build warning when !ACPI
        Some comment/change log tweaks

Jeremy Linton (1):
  mmc: sdhci-iproc: Add ACPI bindings for the rpi

 drivers/mmc/host/sdhci-iproc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

-- 
2.26.2

