Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AC0261946
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 20:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbgIHSL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 14:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgIHSLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:11:39 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9A5C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:11:38 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id j11so23982593ejk.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sior-be.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2jeAKbPcMYL3zKYHWUAD80qBl6LQnPeUqzL2ybjhdJg=;
        b=GRWuV3D+NPs+O8PhfljngvbH+/zdl1IG8s+i5wlKJNll0vYKQc3oEZmRBq2GPksBfB
         KZqDXGLyapYUntSwXu7zK1WBhKrrjsmYheZ21l9UPvc2kysM5F4IbTnkh/il6rSNqwoL
         EdCab1UyiUXvyGG2hYYrI867vxh2q3cIXvimK6XSZJgxiaFUvNOV4Mln6uGZ2yinOj01
         OpRJg968cPDL9fxOL2uFJCforjAmLjmTrsy4/frYWGR4IaBF8bCZ7fGBT6ABNkJ4qWa/
         8rXZp3U0TvvLv7/t94dXEBoHvAfxre9JV3R14nppWYwCg8WRqahVi/+t1FDgtIafF0Al
         PATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2jeAKbPcMYL3zKYHWUAD80qBl6LQnPeUqzL2ybjhdJg=;
        b=gCoFK2IkkpV/JReSOulyxJFre0xRSleCvZmyI0tMvPba7vy2x4GnSS4S8NZRswlAbi
         TOLSdrKlHZ3VeJdkPSqKI5nZFMq4E7K5KFuEvx1Cign3BwZeKdNbiBG50T9MRHz5xbdT
         0XyxXjK03v3hZHtmbf7WABECzzLcDI2xRRNg0Ol94o/TJqvb17BdMhXMcesxX1j2l8fy
         dDEK3FbtO8/h+Ws0SRtcIBq3gwkM9Yl52al674bKr5WZmX1oCqKy7ZLK26DAc3NgMlfB
         Wjo4bRciPN6JyYfgUMgflPeFwwfNs9VJq9eccr0j0gnZwk7ORk+VDsKJ3xtVgwuBA/3J
         joGQ==
X-Gm-Message-State: AOAM531sF5OQwJKgmXKLcGUVk4yFkfjwx4YfBQ8OSDv5062VO0d6X+W7
        wy+1O4lEjAiSBzKWP4xgUljC3g==
X-Google-Smtp-Source: ABdhPJzXcxEi0aj0yBJLuuB4LmRVp2OUfbxb1m0J1V/0WroShEQJp8UGXqXJyJVSx6nGyPsh9AglWA==
X-Received: by 2002:a17:906:3552:: with SMTP id s18mr26864500eja.23.1599588697308;
        Tue, 08 Sep 2020 11:11:37 -0700 (PDT)
Received: from aws.localdomain ([94.107.139.190])
        by smtp.gmail.com with ESMTPSA id g20sm16127ejx.12.2020.09.08.11.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:11:36 -0700 (PDT)
From:   Alejandro Sior <aho@sior.be>
Cc:     Alejandro Sior <aho@sior.be>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [Intel-gfx][PATCH v2] drm/i915/gvt: Prevent NULL pointer dereference in intel_vgpu_reg_rw_edid()
Date:   Tue,  8 Sep 2020 20:11:21 +0200
Message-Id: <20200908181122.9100-1-aho@sior.be>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <743818af-fa38-e31a-1780-84a6a7e72e25@web.de>
References: <743818af-fa38-e31a-1780-84a6a7e72e25@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function intel_vgpu_reg_rw_edid of kvmgt.c, pos can be equal
to NULL for GPUs that do not properly support EDID. In those cases, when
pos gets passed to the handle_edid functions, it gets added a short offset
then it's dereferenced in memcpy's, leading to NULL pointer
dereference kernel oops.

More concretely, that kernel oops renders some Broadwell GPUs users
unable to set up virtual machines with virtual GPU passthrough (virtual
machines hang indefinitely when trying to make use of the virtual GPU),
and make them unable to remove the virtual GPUs once the kernel oops has
happened (it hangs indefinitely, and notably too when the kernel tries to
shutdown). The issues that this causes and steps to reproduce are
discussed in more details in this github issue post:
https://github.com/intel/gvt-linux/issues/170#issuecomment-685806160

Check if pos is equal to NULL, and if it is, set ret to a negative
value, making the module simply indicate that the access to EDID region
has failed, without any fatal repercussion.

Signed-off-by: Alejandro Sior <aho@sior.be>

---
Changes in v2:
- removed middle name of author to comply with git name
- rephrased the patch description with imperative phrasing
- removed useless paragraph
- made a paragraph more concise
- fixed typos
- made individual lines shorter than 75 chars

 drivers/gpu/drm/i915/gvt/kvmgt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index ad8a9df49f29..49163363ba4a 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -557,7 +557,9 @@ static size_t intel_vgpu_reg_rw_edid(struct intel_vgpu *vgpu, char *buf,
 		(struct vfio_edid_region *)kvmgt_vdev(vgpu)->region[i].data;
 	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
 
-	if (pos < region->vfio_edid_regs.edid_offset) {
+	if (pos == NULL) {
+		ret = -EINVAL;
+	} else if (pos < region->vfio_edid_regs.edid_offset) {
 		ret = handle_edid_regs(vgpu, region, buf, count, pos, iswrite);
 	} else {
 		pos -= EDID_BLOB_OFFSET;
-- 
2.28.0

