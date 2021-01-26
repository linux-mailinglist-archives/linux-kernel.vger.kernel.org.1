Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C516F304F02
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405207AbhA0Bdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389104AbhAZSiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:38:22 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51518C0617A9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:36:08 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h9so7317678wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NmVEUkooFz5Tfz1+fj+rLfrC74ZA/wXoG61R5qDLmbU=;
        b=DVbwGC8thxi+LMqdMJaD5FDz+72wUPoAX9YrH2g8z65x+Y/7wxfxy+7jVJZ0LnlQfl
         6TGvJhHAZtPCuzaw9l1U4g2fTEkckLxTLtMIG5qLTq8pL3p66gRZwfPzdrsrYTP6o4bp
         9C2ZIZVOzaoNja8akpTcC9Rt20vjoG1A512BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NmVEUkooFz5Tfz1+fj+rLfrC74ZA/wXoG61R5qDLmbU=;
        b=kdEObnrOmPvY1Y25Y4CZ/F1owMFC5yi4NzYb8YQC3u7me987uvzAAF0GgsILVUdiJU
         ZrUk/ij7qEFANR8q2z5O2FI9dMzyOGl311fuTeNeNsRY1i3hB0L6PHDHbTv6fLJacYQp
         WKNX9Wv67MLHn9IFf5BRCrXxWei0+sblhpsL/kRVklBZ2C5uGIxMkHhAUP+C58VRQlIj
         hHHl1LbKPYCc1iX0zkqdq9rIPwQyI4oDgK+6TMFA8Xy3/wwTZs9QTKRlc/xxydKCUWD+
         JP3zu6hzyKcLOH5zDZDAjF82VA0r6MBYCzD9xNh/xVj8rORb7ChH6a+cJYwJuB3VR8gg
         7pEA==
X-Gm-Message-State: AOAM5329bt0W3/OU4R7BCvn5FQzQaB2MRlV/HjeOi4bAIzserClDgYh8
        A08eKwQ6aITNyw3KvPLm0TMcvA==
X-Google-Smtp-Source: ABdhPJzXdwv/c9GLOmKOtZ+ecBeub/zi4Knq2tTYbBTvcCvgxl0qC5VJ3WgT2IULsq08r4A6ADxHQg==
X-Received: by 2002:a5d:47a2:: with SMTP id 2mr7499442wrb.393.1611686167020;
        Tue, 26 Jan 2021 10:36:07 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:deb:d0ec:3143:2380])
        by smtp.gmail.com with ESMTPSA id d13sm28339354wrx.93.2021.01.26.10.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:36:06 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next v6 1/5] bpf: Be less specific about socket cookies guarantees
Date:   Tue, 26 Jan 2021 19:35:55 +0100
Message-Id: <20210126183559.1302406-1-revest@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
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
Acked-by: KP Singh <kpsingh@kernel.org>
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
2.30.0.280.ga3ce27912f-goog

