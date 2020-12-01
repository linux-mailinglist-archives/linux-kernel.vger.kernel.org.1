Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732412C9428
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389130AbgLAAmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389120AbgLAAme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:42:34 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A909C0613D4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:41:48 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id t8so13804552iov.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HnzEbVx2smAAOoGAKmXe1MxzApt3PoExhyWVjcN51Tc=;
        b=Z/9eOuHn68lFWpsnehSX4d4rv62zcE5cHMVXkAPLCRmhv6xQta7Je7+Ntz3L7+mxcb
         2xzFWxgWPzHV1Xg+0IKUsZOjxL42D6x/BFvyIQM4rMriee7MvBAC2QjaMaMmjqA6R7U8
         31yb3jGAFfRcnjaR00m0wcy65SVAIg1uI0iIMgPebz4H6H6svOoiQHBxwgxGiBBbJf6v
         3q3MNHNBcwCo3uCNA/wlAurZjw/Fc65Tyq0dZeTsHUp3SPGL8Y8AqWqOq9nMew0EC9+3
         zcewf6QrnN+mj43enRjUY6zON1NPCrXqKv6n7BM7XB77LrIglhKHAxKNaCn5+EzfDF8g
         0vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HnzEbVx2smAAOoGAKmXe1MxzApt3PoExhyWVjcN51Tc=;
        b=aBNmLRfLsfjy7iHD+fLxVOaFFIOsDQRQll9ofvj3zDRJNduqG0TJS5uA2gH8/oOH7w
         t/Zk2YmZleOdXtdKFA5n3MKwzduSkV8ErsrD18HSJ6a3iGnyWhS83vz72gYcvBoGHUg3
         g5UQxXMZVVE8lXh/JPiQhFkVS0UmnOYYAW2A7Zn0NrWpT6BC0hmZfTOCRVTll4KB3Xrr
         YwUBsRPGhw+4dDLScfBfemgea066COSh5/6sbJxWHgvbSxn1dv0AJxv8Dk9NA8EJwFmT
         EFqdzxBwlfs+w/zAbbnYx+RcJ1K/pmkF3NZfpbCijBwWhLV4tX1XjuHb4d2tyFfoxCBc
         ZQPQ==
X-Gm-Message-State: AOAM530LwmBfn7HwWFLDi83d3hRlVZnhB5Vd/g0Qyr23heYAUfM2Qtzl
        Y18L0+3nhhNlH/2yrlzvvniwVg==
X-Google-Smtp-Source: ABdhPJz0zGU1M1hhTa+Y6+Wp19wicKcJXjiGEdnbdQ1GQtNjcQqHWD/1bE43MzFkyhZ/niZVUbKd5g==
X-Received: by 2002:a02:b68e:: with SMTP id i14mr423070jam.36.1606783307827;
        Mon, 30 Nov 2020 16:41:47 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id p7sm138561iln.11.2020.11.30.16.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 16:41:47 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org, subashab@codeaurora.org
Cc:     evgreen@chromium.org, cpratapa@codeaurora.org,
        bjorn.andersson@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] if_rmnet.h: define struct rmnet_map_v5_csum_header
Date:   Mon, 30 Nov 2020 18:41:42 -0600
Message-Id: <20201201004143.27569-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201201004143.27569-1-elder@linaro.org>
References: <20201201004143.27569-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a new rmnet_map_v5_csum_header structure type.  It will be
used for inline checksum offload, supported with version 5 of the
QMAP protocol.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 include/linux/if_rmnet.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/if_rmnet.h b/include/linux/if_rmnet.h
index 9661416a9bb47..0fdda0e6e9963 100644
--- a/include/linux/if_rmnet.h
+++ b/include/linux/if_rmnet.h
@@ -52,4 +52,34 @@ struct rmnet_map_ul_csum_header {
 #endif
 } __aligned(1);
 
+
+/* Values for the header_type field of struct rmnet_map_v5_csum_header */
+enum rmnet_map_v5_header_type {
+	RMNET_MAP_HEADER_TYPE_UNKNOWN		= 0x0,
+	RMNET_MAP_HEADER_TYPE_COALESCING	= 0x1,
+	RMNET_MAP_HEADER_TYPE_CSUM_OFFLOAD	= 0x2,
+};
+
+/* QMAP v5 checksum offload header */
+struct rmnet_map_v5_csum_header {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u8 next_hdr:1;
+	u8 header_type:7;
+
+	u8 hw_reserved:5;
+	u8 priority:1;
+	u8 hw_reserved_bit:1;
+	u8 csum_valid_required:1;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	u8 header_type:7;
+	u8 next_hdr:1;
+
+	u8 csum_valid_required:1;
+	u8 hw_reserved_bit:1;
+	u8 priority:1;
+	u8 hw_reserved:5;
+#endif
+	__be16 reserved;
+};
+
 #endif /* !(_LINUX_IF_RMNET_H_) */
-- 
2.20.1

