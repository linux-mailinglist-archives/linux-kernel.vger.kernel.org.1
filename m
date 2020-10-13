Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA1428CD62
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgJML7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:59:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbgJMLyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:44 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E34B72240B;
        Tue, 13 Oct 2020 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=4ynPZZg1aOSrSTWF5WFCnN/3Tph4/bJsI6wm8tGW9EA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/UY4oclCDEu27jf00PvAQ2E2vR4cyBwq2en+KAunETqjjDO9c9SrZ1p/D3pSjqzH
         CO2BUCawQHgFCeXobbaiw+xz+R5DTgFrqVjQ43Zgb8s/zs9wUvwDeQQEMLn0IsR/UP
         reWottKxWk2RhCqYvdmTyp7ZwjeF6YBvUOb7kpi4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt6-006CX1-4Z; Tue, 13 Oct 2020 13:54:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 79/80] drm: drm_edid: remove a duplicated kernel-doc declaration
Date:   Tue, 13 Oct 2020 13:54:34 +0200
Message-Id: <6db8684b1f6a58c1caecb85bfc6a45c990e24ea9.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not possible to create cross-references for duplicated
symbols. While Sphinx always detected it, on Sphinx 3 it
generates warnings like this:

	.../Documentation/gpu/drm-kms-helpers:326: ../drivers/gpu/drm/drm_edid.c:1626: WARNING: Duplicate C declaration, also defined in 'gpu/drm-kms-helpers'.
	Declaration is 'bool drm_edid_are_equal (const struct edid *edid1, const struct edid *edid2)'.

So, get rid of the duplicated kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/drm/drm_edid.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index cfa4f5af49af..6586c9104ec1 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -359,13 +359,6 @@ drm_load_edid_firmware(struct drm_connector *connector)
 }
 #endif
 
-/**
- * drm_edid_are_equal - compare two edid blobs.
- * @edid1: pointer to first blob
- * @edid2: pointer to second blob
- * This helper can be used during probing to determine if
- * edid had changed.
- */
 bool drm_edid_are_equal(const struct edid *edid1, const struct edid *edid2);
 
 int
-- 
2.26.2

