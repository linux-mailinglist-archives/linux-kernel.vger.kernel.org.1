Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38AC27069E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 22:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgIRUQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 16:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgIRUQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:16:35 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91FDC0613D0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:16:34 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id jw11so3594873pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlEobsn16/HZPi69CSqOjUi/Ev9EOUolHVFIEzKh1d0=;
        b=Cu+BpZsYq8xo9CmZFmG/NdGwNojdzVsgymJ7kwPPrUAXFQPK8a2QUlKtDn7250Ubsq
         plsZB/YYcLbkYBS8Fq/z2z1q1m9j8gl7aq62B8HS5LW43k9v16edxNqYr+9NzmYfPrwn
         cq3wH0uW3ZcHD+dQAGFM6XtXz5L8Whz3TAMDYANg0DmI7URKxbbhEg/Z+E3ypziJYKIE
         Pl3V1a0gu2zK3U7nYqNgIrHK11iAYG9Ab3M+w85rCv4omr4G3nb9vgfmycboh9msEs/J
         ZHKqAKtRD8ppiRYXdvvVXSOExckJPG6VuiDOsaqYC56jQptk8duFDsF5U/QXHIfEsi3b
         RWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlEobsn16/HZPi69CSqOjUi/Ev9EOUolHVFIEzKh1d0=;
        b=jFIA9wFhzF+X2piga5qYfV6X0LPEHCF58OeJ//rICQXZdrk4+2wIOvye9weV+PyUC2
         xj/TgdMw9vEuHTZVANwHVrUDdjopgEP+e66uU4x9Xtr4nG67lHLWTbATWjatFbT0GYxE
         DkNjgsfjXCZYWBh9vpls/I2xmbILxJdn/H/NUn7/4/vOUUR5j8iuhoe2IvCKun8eRqYI
         TXHOdeVeK41jNgpafiIvLtNH+ddwMFD73ZFNffVasXzthcxgxBIBTt4ltake/HmK4pkz
         4iDzQwdLwR5RE5syo5ObOWuOc30zoZBpPwJV1S8frXOh7JE8X5zMIf1+hL7O5SUkPebT
         9BQQ==
X-Gm-Message-State: AOAM532In5JgQO6JahEulymZkG0l4Dxc+vt+kc55JJcK7eTL0LjkCFV6
        Rw45+JZiLXumXK+lyMndmmKbHQ==
X-Google-Smtp-Source: ABdhPJz9LwXbQGxVwz/aszM2yl3QnXHYgNikKov8IUYXXvcoS7Yqu3Q6wxEn4QOq8Pb1IVtLyoyuUA==
X-Received: by 2002:a17:90b:117:: with SMTP id p23mr14981324pjz.67.1600460194319;
        Fri, 18 Sep 2020 13:16:34 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id d25sm4095709pgl.23.2020.09.18.13.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 13:16:33 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: drop myself from PM AVS drivers
Date:   Fri, 18 Sep 2020 13:16:33 -0700
Message-Id: <20200918201633.27017-1-khilman@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't had the time or the expertise to adequately review and
maintain these drivers for awhile, so make it official.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..f1bf6071c438 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5361,7 +5361,6 @@ F:	include/linux/kobj*
 F:	lib/kobj*
 
 DRIVERS FOR ADAPTIVE VOLTAGE SCALING (AVS)
-M:	Kevin Hilman <khilman@kernel.org>
 M:	Nishanth Menon <nm@ti.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
-- 
2.28.0

