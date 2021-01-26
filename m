Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61357304296
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406052AbhAZP3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:29:43 -0500
Received: from mail-m974.mail.163.com ([123.126.97.4]:42492 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388820AbhAZJdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=K5K9NFGYOsZZL/fGgQ
        V3jvN8qQG+N2RPICK9SX7rPvk=; b=e2adE11js3m55YblhCHJHjPXI3KoBzSdUl
        2XC1gmrRyGAjiuiRsqHihH8qcp3F6mkH0WFfv2Mbbsdscjk2Nu4tr17dD6q9w4n1
        N8WjS6QntNaqNuACp8FJWZr8Gwr+uAadG/2hHicUL2fVJf1Ao896ua3gKFhmGGcK
        s6OB3EgBg=
Received: from COOL-20200923LL.ccdomain.com (unknown [218.94.48.178])
        by smtp4 (Coremail) with SMTP id HNxpCgBXDyVohA9gnJGHhg--.6151S2;
        Tue, 26 Jan 2021 10:54:35 +0800 (CST)
From:   Guoqing Chi <chi962464zy@163.com>
To:     hverkuil@xs4all.nl
Cc:     mchehab@kernel.org, linux-kernel@vger.kernel.org,
        zhangwen@yulong.com, chiguoqing@yulong.com,
        chiguoqing <chi962464zy@163.com>
Subject: [PATCH resend] media: vidtv: remove redundant quote
Date:   Tue, 26 Jan 2021 10:54:18 +0800
Message-Id: <20210126025418.4069-1-chi962464zy@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: HNxpCgBXDyVohA9gnJGHhg--.6151S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF1fWFWktw4ftryxZr15CFg_yoW3XFb_uw
        n7Zr4xW342yry0yr15JF9rAryFkayDZFn5XFnIqw1YvFy7Z345GasFvw1UGw42ga1ava97
        ZF15JF18ur1xGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRuiih7UUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pfklmlasuwk6r16rljoofrz/1tbiJwsmRF5u9TbneQAAsj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangwen <zhangwen@yulong.com>

Repeated references string.h

Signed-off-by: zhangwen <zhangwen@yulong.com>
Signed-off-by: chiguoqing <chi962464zy@163.com>
---
 drivers/media/test-drivers/vidtv/vidtv_psi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_psi.c b/drivers/media/test-drivers/vidtv/vidtv_psi.c
index 4511a2a98405..8ff27d26c343 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_psi.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_psi.c
@@ -19,7 +19,6 @@
 #include <linux/ratelimit.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/string.h>
 #include <linux/time.h>
 #include <linux/types.h>
 
-- 
2.17.1

