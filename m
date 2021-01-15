Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D46C2F83CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbhAOSP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388036AbhAOSPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:15:09 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEF7C061384
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:14 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k10so8214019wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQaT8O9XxcsJgVKni1h0yZPLQZvOBcm7ZwMWNBkJiNk=;
        b=qGaHgBNTx/fmF+7Ais7Ufdt9dmQbs5EWdBbcb57RTL+tsSdSG4dLYqS9cxfLbabOBM
         G7I9mfukkMai6ee/f1y806pY54Bn5Spyy/lJ+0gebGjME7nRSZhwig9Ab/PU/kMiYg76
         mzI5bP3uYAC1BJWW096JxqScQIA4ZkiEe9M5zfTyTJBhTf6QXjhDL+HacORBsYZv3rW3
         FeJ+dEqcpLZUwtxPPWorSiauOcrk5TU9ew+/7T0tr/u7+w/wvoZK5pd85sOSdZdHs3Sf
         1oorr/AZEqW+GB/mtVJMRy6oiv2AWntCCnTYB8gOg/kWttSVJvcSMHlBtdvydQBhyfR1
         eoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQaT8O9XxcsJgVKni1h0yZPLQZvOBcm7ZwMWNBkJiNk=;
        b=XUK/Qp8vXxI1SSty/x2PKhVYOCVyEQa0k6rlvdUmW1CdcS+xqOArt0q6aLu49xis8U
         sWkk/vu0bDvee4s7c6OecewArLTjh/Ctp4E54Jl7Mr7gnxWyrcMLKuAaBojEvHh8XAEW
         LnnLyyXf1on7MXfh9mEULLbkIXnDCxEZhRL+5WlzpTJAlfFetzDEUjHU7fVrKnSkH/+E
         G5g1oFrBXKn20i4wVSgAPRLTRZ063kXw510ueL7rDNFpMTnp86YizkD2DlEBn4lEmn1m
         X8TcpiI0tv+srZbM1Qur6qp9y0fU5iodMF10cOsb6Np0zTYdYPL/5KZghq+aX2iOMzeW
         VPxQ==
X-Gm-Message-State: AOAM532662bv8N9GmYCih1F8mF32zDJRr9pM4Rw7UIeCInFmRcxtT4Sr
        WZ9MbLEKlQPo05t7e9Vk7H8wvQ==
X-Google-Smtp-Source: ABdhPJxIi81NmcZ3eJUbgrKPBLwd7qw1Vv7O/IAtMiKJeBKW0LklxrjADuKqEt0hUyewqgWE0ZqQ8g==
X-Received: by 2002:a1c:cc14:: with SMTP id h20mr9966183wmb.180.1610734453384;
        Fri, 15 Jan 2021 10:14:13 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:14:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 39/40] drm/vmwgfx/vmwgfx_cmdbuf_res: Remove unused variable 'ret'
Date:   Fri, 15 Jan 2021 18:13:12 +0000
Message-Id: <20210115181313.3431493-40-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c: In function ‘vmw_cmdbuf_res_revert’:
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c:162:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
index 92509fbf2fd1d..b262d61d839d5 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
@@ -159,7 +159,6 @@ void vmw_cmdbuf_res_commit(struct list_head *list)
 void vmw_cmdbuf_res_revert(struct list_head *list)
 {
 	struct vmw_cmdbuf_res *entry, *next;
-	int ret;
 
 	list_for_each_entry_safe(entry, next, list, head) {
 		switch (entry->state) {
@@ -167,8 +166,7 @@ void vmw_cmdbuf_res_revert(struct list_head *list)
 			vmw_cmdbuf_res_free(entry->man, entry);
 			break;
 		case VMW_CMDBUF_RES_DEL:
-			ret = drm_ht_insert_item(&entry->man->resources,
-						 &entry->hash);
+			drm_ht_insert_item(&entry->man->resources, &entry->hash);
 			list_del(&entry->head);
 			list_add_tail(&entry->head, &entry->man->list);
 			entry->state = VMW_CMDBUF_RES_COMMITTED;
-- 
2.25.1

