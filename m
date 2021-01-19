Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C748E2FBBE5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390269AbhASQDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391650AbhASQAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:00:50 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC95C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:00:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a9so16787003wrt.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h3ezeIdxQA6HUcVbMIawXV4uO3GjVDrBBcxqIn97pLo=;
        b=jOWsETPqtvTAzVk6EYslXWIDwS+h+JvNnbmzJZvezK6Wlk5xd1fYpNplpzhowgQF1V
         vCX+AcpJKRCFwa28WJgLKIvITUwPH3HpY75tlBJhgqnBhEKqvrGL8V0UNXc+dTgNqXsJ
         g7/43H1wZhd4Gr+wynZKkeLoD+VlpVULR/glo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h3ezeIdxQA6HUcVbMIawXV4uO3GjVDrBBcxqIn97pLo=;
        b=c4/DCh5xy77AJWEmCQyf/c4NT2wST2VEEFQhw+Q+tuf/BWkZKwueZBZ0BgPHnKYoLu
         qDN4dVJbAKu0m/5wknLODkGJ9XZuqlnP5+RFoaXZBgIpX/5622etLvHQJ+Hu+J12d/lI
         kRz2vpCBVTXicelCD3+kz16c2raR4LdlTvbKudZtU24ZIPJ7TK+8BVKTiRN6wDm8Ps+h
         g6541EhI+Eqp7dcfaO/T9rHqTETXVE8Vv5KFDm1t6YmTTUOO1pwwritOvDljrLgRKNMh
         cEMaJe4HlhMmJ4v2s4wRIQ4xVtEjM/wpU+UFFkF9EkNK+hiuE4DllyZQXPU2gNlnMLwG
         4XYw==
X-Gm-Message-State: AOAM5315EsFGxTdCKcQ07ABNO96THgyc9blAppWOeNj81h+KrZrTPl6Z
        LyMYCbRu+5NBfm+Xwux44+kZ2g==
X-Google-Smtp-Source: ABdhPJz+zMVRPSU1xDf7RAqAN5YPaoXl4ATKLsoGaK//5SSwMc+/JfavDapDnAlh9I5ujwLQaPg4Cg==
X-Received: by 2002:adf:f6cc:: with SMTP id y12mr5038792wrp.35.1611072006140;
        Tue, 19 Jan 2021 08:00:06 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:81f8:2ac6:58bf:7d7a])
        by smtp.gmail.com with ESMTPSA id n11sm41454944wra.9.2021.01.19.08.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:00:05 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v5 1/4] bpf: Be less specific about socket cookies guarantees
Date:   Tue, 19 Jan 2021 16:59:50 +0100
Message-Id: <20210119155953.803818-1-revest@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since "92acdc58ab11 bpf, net: Rework cookie generator as per-cpu one"
socket cookies are not guaranteed to be non-decreasing. The
bpf_get_socket_cookie helper descriptions are currently specifying that
cookies are non-decreasing but we don't want users to rely on that.

Reported-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/uapi/linux/bpf.h       | 8 ++++----
 tools/include/uapi/linux/bpf.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c001766adcbc..0b735c2729b2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1656,22 +1656,22 @@ union bpf_attr {
  * 		networking traffic statistics as it provides a global socket
  * 		identifier that can be assumed unique.
  * 	Return
- * 		A 8-byte long non-decreasing number on success, or 0 if the
- * 		socket field is missing inside *skb*.
+ * 		A 8-byte long unique number on success, or 0 if the socket
+ * 		field is missing inside *skb*.
  *
  * u64 bpf_get_socket_cookie(struct bpf_sock_addr *ctx)
  * 	Description
  * 		Equivalent to bpf_get_socket_cookie() helper that accepts
  * 		*skb*, but gets socket from **struct bpf_sock_addr** context.
  * 	Return
- * 		A 8-byte long non-decreasing number.
+ * 		A 8-byte long unique number.
  *
  * u64 bpf_get_socket_cookie(struct bpf_sock_ops *ctx)
  * 	Description
  * 		Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
  * 		*skb*, but gets socket from **struct bpf_sock_ops** context.
  * 	Return
- * 		A 8-byte long non-decreasing number.
+ * 		A 8-byte long unique number.
  *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
  * 	Return
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c001766adcbc..0b735c2729b2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1656,22 +1656,22 @@ union bpf_attr {
  * 		networking traffic statistics as it provides a global socket
  * 		identifier that can be assumed unique.
  * 	Return
- * 		A 8-byte long non-decreasing number on success, or 0 if the
- * 		socket field is missing inside *skb*.
+ * 		A 8-byte long unique number on success, or 0 if the socket
+ * 		field is missing inside *skb*.
  *
  * u64 bpf_get_socket_cookie(struct bpf_sock_addr *ctx)
  * 	Description
  * 		Equivalent to bpf_get_socket_cookie() helper that accepts
  * 		*skb*, but gets socket from **struct bpf_sock_addr** context.
  * 	Return
- * 		A 8-byte long non-decreasing number.
+ * 		A 8-byte long unique number.
  *
  * u64 bpf_get_socket_cookie(struct bpf_sock_ops *ctx)
  * 	Description
  * 		Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
  * 		*skb*, but gets socket from **struct bpf_sock_ops** context.
  * 	Return
- * 		A 8-byte long non-decreasing number.
+ * 		A 8-byte long unique number.
  *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
  * 	Return
-- 
2.30.0.284.gd98b1dd5eaa7-goog

