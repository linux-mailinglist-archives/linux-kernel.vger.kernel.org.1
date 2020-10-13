Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AD028CCE9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgJMLza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgJMLzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:55:15 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96DE422AAA;
        Tue, 13 Oct 2020 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=YmKVL+6rXgGYIixlxi4+UihRuUUuG7UxvwUheXsFnBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=donI3o2TKUOh6/x/0WLG/TZU4gYa7+sYWKXkAm/sj6x40RhPqLiTFJHUr8kq0A1tN
         KjeqUZ0mv8RyT/NjHMRKm+FLtB96C0FkmY7SyW2FVLtwqGwgLlEX+4LIgF0mPgVNNV
         SPGbV5h6H3cwJxtDQzQwCLWY2tkPBZ6bsRZ04GSE=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt5-006CWE-HV; Tue, 13 Oct 2020 13:54:39 +0200
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
Subject: [PATCH v6 65/80] docs: amdgpu: fix a warning when building the documentation
Date:   Tue, 13 Oct 2020 13:54:20 +0200
Message-Id: <6e511c1938e4b5e312474ea50bdde964770c1e44.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Sphinx:

	Documentation/gpu/amdgpu.rst:200: WARNING: Inline emphasis start-string without end-string.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/gpu/amdgpu.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
index 17112352f605..4ed8ecf1cd86 100644
--- a/Documentation/gpu/amdgpu.rst
+++ b/Documentation/gpu/amdgpu.rst
@@ -197,8 +197,8 @@ pp_power_profile_mode
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
    :doc: pp_power_profile_mode
 
-*_busy_percent
-~~~~~~~~~~~~~~
+\*_busy_percent
+~~~~~~~~~~~~~~~
 
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
    :doc: gpu_busy_percent
-- 
2.26.2

