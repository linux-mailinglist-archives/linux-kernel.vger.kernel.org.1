Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC8D2314A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 23:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgG1VdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 17:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgG1VdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 17:33:07 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB94C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 14:33:06 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y206so1455932pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=students-iitmandi-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CT1RfNS2wB94CWta2isV6Olvkifh5I0o1QRBEScvpF8=;
        b=kDVj7S2Jk3itKTp3Hp+e0PRGpwlzbWQsFRUUVwuq2RNjxrK0+7XeR2p6hxd7AFCWkC
         FpQZWCZZWbYSJwqQnSEhiHYDIrYX8YrFDFyEHuvUOUU91DTpaf6Rm0dGqfmZtakHDCrb
         UbvsQcS8CtG97v205FQUwrnRoGa72EBhVGP7kfh4HFAWPOteRcajuAI4boFsQTk0x341
         nX96LdH8NX/Nbag/1kI6ASSBGmjJB++gtl0j3xBNbVYpFIygaGDfhWg8C7pL03TIjza8
         YV+HaDxB4Z5AlZ/px/r6ikXCL33NSh/WRNG+rofv5uQo/mqEv2xP4cgmKwwvABzq+nHC
         c1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CT1RfNS2wB94CWta2isV6Olvkifh5I0o1QRBEScvpF8=;
        b=kGTQDrztICVXe+KyNoVHqsPGesBO1/QpEhyyPMNzCVJ/yO/7jfrv5PdTxhTr6CKbrR
         RNE7/wKvXcjiKAnKVk7c+YJ+qhd4ZFVTSUbgT85AIe89rUHjN+ZMMx1I73cWA4O7XLnx
         97nXIshThpqVVpeMBnAD6qSZuyvOlEqlJy8p51viFvJe2Rr8yeVm6+ATl9ApwBpz1nwO
         NsJmGNWxSJ4ifSazDeIR/tJmkpmxqnSxvkqFXCkl4rwgqZPcJQIq9v3uBpZIz9Lc31u8
         H80GnttdrFOrBuNeX5qD4K+M0k8uh+doGT9wj7Fs+DagGA12eaKuIREj1VNgze5WE0Dk
         P1Ng==
X-Gm-Message-State: AOAM533m37/1HUvLa2AQ7KEADAov3mKM/49q33N1Ki4sXG9e70Sc1pXK
        sfz1rNrACAS1cLKIm0eqCX4+xA==
X-Google-Smtp-Source: ABdhPJwLyHPfdyN7tFGpQLZ2/NJtjQ/xp87HFZ9wuujwjzEXtTn+a1CAnqJg/v5T7ofEdlh9wI8wiA==
X-Received: by 2002:aa7:8d95:: with SMTP id i21mr24881049pfr.240.1595971986373;
        Tue, 28 Jul 2020 14:33:06 -0700 (PDT)
Received: from devil-VirtualBox.www.tendawifi.com ([103.198.174.215])
        by smtp.gmail.com with ESMTPSA id z11sm12152pfg.169.2020.07.28.14.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 14:33:05 -0700 (PDT)
From:   Ankit Baluni <b18007@students.iitmandi.ac.in>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, rohitsarkar5398@gmail.com,
        straube.linux@gmail.com, mukadr@gmail.com, pterjan@google.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ankit Baluni <b18007@students.iitmandi.ac.in>
Subject: [PATCH] Staging : rtl8712 : Fixed a coding sytle issue
Date:   Wed, 29 Jul 2020 03:02:31 +0530
Message-Id: <20200728213231.26626-1-b18007@students.iitmandi.ac.in>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed braces for a 'if' condition as it contain only single line &
there is no need for braces for such case according to coding style
rules.

Signed-off-by: Ankit Baluni <b18007@students.iitmandi.ac.in>
---
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index c6f6ccd060bb..df6ae855f3c1 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -238,9 +238,8 @@ static char *translate_scan(struct _adapter *padapter,
 	/* parsing HT_CAP_IE */
 	p = r8712_get_ie(&pnetwork->network.IEs[12], _HT_CAPABILITY_IE_,
 			 &ht_ielen, pnetwork->network.IELength - 12);
-	if (p && ht_ielen > 0) {
+	if (p && ht_ielen > 0)
 		ht_cap = true;
-	}
 	/* Add the protocol name */
 	iwe.cmd = SIOCGIWNAME;
 	if (r8712_is_cckratesonly_included(pnetwork->network.rates)) {
-- 
2.25.1

