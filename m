Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242D7284D15
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgJFOFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgJFOD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:56 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B06220782;
        Tue,  6 Oct 2020 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993034;
        bh=gircHDTmaOYdmAjX4GqQkC9md45Fenmq59SXCI2xF+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P43rC0oxS07LbUeeQmaLgln41Qmgp89dgMe/2hM2ZjJfDoyj9F92TVJXAmGcdPzi4
         9f+HsAFWPmgxXo7547lVVP/7Zd4Ky9+QS83yHN+TQcBgs8GTrG5Zv/rlSsxmjBVo8i
         HjjRef17FP76W3CqOeTgYffO6jz7nkOsaRik+kOU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZI-0019G5-I3; Tue, 06 Oct 2020 16:03:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alex Deucher <alexander.deucher@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 36/52] docs: devices.rst: get rid of :c:type macros
Date:   Tue,  6 Oct 2020 16:03:33 +0200
Message-Id: <3e4b8d8c35dd2c0f3104d1ccd76b9b9698b31084.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to use macros to use :c:type on this file,
as automarkup.py should do this automatically.

Also, this breaks compatibility with Sphinx 3.x, as there,
structs should be declared using .. c:struct.

So, get rid of them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/pm/devices.rst | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/Documentation/driver-api/pm/devices.rst b/Documentation/driver-api/pm/devices.rst
index 946ad0b94e31..4bda8a21f5d1 100644
--- a/Documentation/driver-api/pm/devices.rst
+++ b/Documentation/driver-api/pm/devices.rst
@@ -1,14 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. include:: <isonum.txt>
 
-.. |struct dev_pm_ops| replace:: :c:type:`struct dev_pm_ops <dev_pm_ops>`
-.. |struct dev_pm_domain| replace:: :c:type:`struct dev_pm_domain <dev_pm_domain>`
-.. |struct bus_type| replace:: :c:type:`struct bus_type <bus_type>`
-.. |struct device_type| replace:: :c:type:`struct device_type <device_type>`
-.. |struct class| replace:: :c:type:`struct class <class>`
-.. |struct wakeup_source| replace:: :c:type:`struct wakeup_source <wakeup_source>`
-.. |struct device| replace:: :c:type:`struct device <device>`
-
 .. _driverapi_pm_devices:
 
 ==============================
@@ -107,7 +99,7 @@ Device Power Management Operations
 
 Device power management operations, at the subsystem level as well as at the
 device driver level, are implemented by defining and populating objects of type
-|struct dev_pm_ops| defined in :file:`include/linux/pm.h`.  The roles of the
+struct dev_pm_ops defined in :file:`include/linux/pm.h`.  The roles of the
 methods included in it will be explained in what follows.  For now, it should be
 sufficient to remember that the last three methods are specific to runtime power
 management while the remaining ones are used during system-wide power
@@ -115,7 +107,7 @@ transitions.
 
 There also is a deprecated "old" or "legacy" interface for power management
 operations available at least for some subsystems.  This approach does not use
-|struct dev_pm_ops| objects and it is suitable only for implementing system
+struct dev_pm_ops objects and it is suitable only for implementing system
 sleep power management methods in a limited way.  Therefore it is not described
 in this document, so please refer directly to the source code for more
 information about it.
@@ -125,9 +117,9 @@ Subsystem-Level Methods
 -----------------------
 
 The core methods to suspend and resume devices reside in
-|struct dev_pm_ops| pointed to by the :c:member:`ops` member of
-|struct dev_pm_domain|, or by the :c:member:`pm` member of |struct bus_type|,
-|struct device_type| and |struct class|.  They are mostly of interest to the
+struct dev_pm_ops pointed to by the :c:member:`ops` member of
+struct dev_pm_domain, or by the :c:member:`pm` member of struct bus_type,
+struct device_type and struct class.  They are mostly of interest to the
 people writing infrastructure for platforms and buses, like PCI or USB, or
 device type and device class drivers.  They also are relevant to the writers of
 device drivers whose subsystems (PM domains, device types, device classes and
@@ -156,7 +148,7 @@ The :c:member:`power.can_wakeup` flag just records whether the device (and its
 driver) can physically support wakeup events.  The
 :c:func:`device_set_wakeup_capable()` routine affects this flag.  The
 :c:member:`power.wakeup` field is a pointer to an object of type
-|struct wakeup_source| used for controlling whether or not the device should use
+struct wakeup_source used for controlling whether or not the device should use
 its system wakeup mechanism and for notifying the PM core of system wakeup
 events signaled by the device.  This object is only present for wakeup-capable
 devices (i.e. devices whose :c:member:`can_wakeup` flags are set) and is created
@@ -713,8 +705,8 @@ nested inside another power domain. The nested domain is referred to as the
 sub-domain of the parent domain.
 
 Support for power domains is provided through the :c:member:`pm_domain` field of
-|struct device|.  This field is a pointer to an object of type
-|struct dev_pm_domain|, defined in :file:`include/linux/pm.h`, providing a set
+struct device.  This field is a pointer to an object of type
+struct dev_pm_domain, defined in :file:`include/linux/pm.h`, providing a set
 of power management callbacks analogous to the subsystem-level and device driver
 callbacks that are executed for the given device during all power transitions,
 instead of the respective subsystem-level callbacks.  Specifically, if a
-- 
2.26.2

