Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5975C29A8C4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896753AbgJ0KBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896056AbgJ0Jvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:51:44 -0400
Received: from mail.kernel.org (ip5f5ad5af.dynamic.kabel-deutschland.de [95.90.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E51882466D;
        Tue, 27 Oct 2020 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603792302;
        bh=2vGt09zv9T52aqBWuiYyElX+A1oCUvIR/X33luu4RwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qd1Qbhi9SNYhd3MS6c2zdUNw6SCJi0pqLtuydjzJMEnhZ4RfuPbiFN8cjGVv/RgSG
         IHFGzPNsZ1tYGQnQQx6ZbllYKaPokR2hBOigFXgYJAE75TrGWAZxnt43kfNtu8MqDP
         cU2MmYr8rNREngpZ2J74l5k62yiygujH2Fm5HhXU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXLdj-003FFc-Rl; Tue, 27 Oct 2020 10:51:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 26/32] gpu: docs: amdgpu.rst: get rid of wrong kernel-doc markups
Date:   Tue, 27 Oct 2020 10:51:30 +0100
Message-Id: <bd070923591ae54f9587e7407b6291ac116952b2.1603791716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603791716.git.mchehab+huawei@kernel.org>
References: <cover.1603791716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by kernel-doc:
    ./drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:1: warning: no structured comments found
    ./drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1: warning: no structured comments found

Those files only contain

	/**
	 * DOC:
	 */

markups, but they're included twice there: one to parse
such markup, and another one to parse internal functions.

In the case of amdgpu_xgmi.c, as it has just one such
markup, we can simply include the file once, and let it
parse the entire file without passing arguments to kernel-doc.

This should place everything altogether.

For amdgpu_ras.c, however, we need to remove the kernel-doc
with just internal. This should be re-introduced if this
file ever gets new non-DOC markups.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/gpu/amdgpu.rst | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
index 1f9ea8221f80..2062a6023678 100644
--- a/Documentation/gpu/amdgpu.rst
+++ b/Documentation/gpu/amdgpu.rst
@@ -83,10 +83,6 @@ AMDGPU XGMI Support
 ===================
 
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
-   :doc: AMDGPU XGMI Support
-
-.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
-   :internal:
 
 AMDGPU RAS Support
 ==================
@@ -124,9 +120,6 @@ RAS VRAM Bad Pages sysfs Interface
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
    :doc: AMDGPU RAS sysfs gpu_vram_bad_pages Interface
 
-.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
-   :internal:
-
 Sample Code
 -----------
 Sample code for testing error injection can be found here:
-- 
2.26.2

