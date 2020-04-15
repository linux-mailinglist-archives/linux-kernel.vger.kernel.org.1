Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB471AB343
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 23:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442346AbgDOVRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 17:17:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:53314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438921AbgDOVRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:17:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 93013AC1D;
        Wed, 15 Apr 2020 21:17:15 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-nvdimm@lists.01.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc: nvdimm: remove reference to non-existent CONFIG_NFIT_TEST
Date:   Wed, 15 Apr 2020 23:16:50 +0200
Message-Id: <20200415211654.10827-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test driver is in tools/testing/nvdimm and cannot be selected by a
config option.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 Documentation/driver-api/nvdimm/nvdimm.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/nvdimm/nvdimm.rst b/Documentation/driver-api/nvdimm/nvdimm.rst
index 08f855cbb4e6..79c0fd39f2af 100644
--- a/Documentation/driver-api/nvdimm/nvdimm.rst
+++ b/Documentation/driver-api/nvdimm/nvdimm.rst
@@ -278,8 +278,8 @@ by a region device with a dynamically assigned id (REGION0 - REGION5).
        be contiguous in DPA-space.
 
     This bus is provided by the kernel under the device
-    /sys/devices/platform/nfit_test.0 when CONFIG_NFIT_TEST is enabled and
-    the nfit_test.ko module is loaded.  This not only test LIBNVDIMM but the
+    /sys/devices/platform/nfit_test.0 when the nfit_test.ko module from
+    tools/testing/nvdimm is loaded.  This not only test LIBNVDIMM but the
     acpi_nfit.ko driver as well.
 
 
-- 
2.26.0

