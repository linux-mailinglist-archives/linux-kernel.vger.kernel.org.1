Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A39F1EA0D6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 11:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgFAJTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 05:19:13 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:51587 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727951AbgFAJTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:19:11 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 Jun 2020 12:19:06 +0300
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0519IsSu003135;
        Mon, 1 Jun 2020 12:19:06 +0300
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v1 6/8] Documentation/ABI: Add new attribute for mlxreg-io sysfs interfaces
Date:   Mon,  1 Jun 2020 12:18:49 +0300
Message-Id: <20200601091851.5491-7-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200601091851.5491-1-vadimp@mellanox.com>
References: <20200601091851.5491-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the new attributes for exposing CPLDs part
numbers and CPLD minor versions.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 Documentation/ABI/stable/sysfs-driver-mlxreg-io | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
index b0d90cc696a8..1397f207523c 100644
--- a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
+++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
@@ -206,3 +206,20 @@ Description:	This file exposes the firmware version of burnable voltage
 		regulator devices.
 
 		The file is read only.
+
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld1_pn
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld2_pn
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld3_pn
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld4_pn
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld1_version_min
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld2_version_min
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld3_version_min
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld4_version_min
+Date:		June 2020
+KernelVersion:	5.8
+Contact:	Vadim Pasternak <vadimpmellanox.com>
+Description:	These files show with which CPLD part numbers and minor
+		versions have been burned CPLD devices equipped on a
+		system.
+
+		The files are read only.
-- 
2.11.0

