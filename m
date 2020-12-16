Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27DD2DC18A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgLPNru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgLPNru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:47:50 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF27AC061282
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 05:47:03 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g25so1976463wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 05:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KftYZd62fX32zg2WC2QvD8OPXOuyZBfnJgkDnV1mwqY=;
        b=CLReobLT9VHfHG7+xWWubJvml+kt3Ff0xG0whO3LjSNalaBT0su6kwH1HIJ0/nm04q
         /oysGEQ59Wcwjf2CvgpBDiw9Y1wt4OcLmiEci3E0mYg4JYG5EpkUWNO41kbbWKIBfkoN
         DsTIGQKGU/PuV5PHdrWtpfNeYg3zstfWWmciyDfOyq/IBk4Z+Xexr/CtOL+QUFTN6fn3
         u7NmyrTe+yw+sidAff3IcVib84ATh29fUHkZcET79alVEXL+4qE2dRncVx1J8GqMnTUT
         8wvHIL2HPvI28ARNAO/IJabxNIJD2/bsUoheyq6B7D6CysEVDGoP+zSleQzU+R6C8YBd
         /fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KftYZd62fX32zg2WC2QvD8OPXOuyZBfnJgkDnV1mwqY=;
        b=KDrRK3yuwR6eCeAbXu6qtzVbLox0HZp2UWN0jgAwW+VOfzNn2ZLSkDil7GG0121yEd
         lIGy0nSOmuXX+JQf+QE+TU5zXDjZ00A3Yf+NbGjtLXt877jb0bqQQwaEIN2HrHteWA9/
         YzK4SXmp52Dg3dilBiY6qPSgRpjWJdkrTpA6rVlD/3YIxxHyym+JnM4M1Lo9aYeMOns0
         Knt1cupztGNJQJOX0bPlAfuAkKhpktqpQ4HNJWCPvNyXr8Bp7HDRm/aVC05nOYOLj138
         b4sL1qdiXACpIwV3JzJQfmZQmuPAIy3xEFezgdtqBRoSRv2c/KizQ20a2qabd38NeHSP
         i94w==
X-Gm-Message-State: AOAM533Y5RfTOP+VGqLAFmJMgBmPxG6ykZT+7+bwS9PPMYUSC0pwPn1Z
        Q6bdC/z1k/OJPCTgAzeyNiIIWhRX6TUT11Iu
X-Google-Smtp-Source: ABdhPJyvfywoV7EzC+xHckvRU9HoKLb+eOnqtQGM5kwKZTGE9ehSPbhZGrmTO+TT8K5ZT0sGs309cQ==
X-Received: by 2002:a1c:a785:: with SMTP id q127mr3397684wme.25.1608126422468;
        Wed, 16 Dec 2020 05:47:02 -0800 (PST)
Received: from dell.default ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id n12sm3323474wrg.76.2020.12.16.05.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 05:47:01 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 1/1] docs: submitting-patches: Trivial - fix grammatical error
Date:   Wed, 16 Dec 2020 13:46:54 +0000
Message-Id: <20201216134654.271508-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"it is a used" does not make sense.  Should be "it is used".

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/process/submitting-patches.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index fb8261a4be308..2c48a00a436e7 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -446,7 +446,7 @@ patch.  This tag documents that potentially interested parties
 have been included in the discussion.
 
 Co-developed-by: states that the patch was co-created by multiple developers;
-it is a used to give attribution to co-authors (in addition to the author
+it is used to give attribution to co-authors (in addition to the author
 attributed by the From: tag) when several people work on a single patch.  Since
 Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
 followed by a Signed-off-by: of the associated co-author.  Standard sign-off
-- 
2.25.1

