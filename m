Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E212E743B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgL2VTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgL2VTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:19:00 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACEEC0617A2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 13:17:51 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id h16so13723037edt.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 13:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LSTn+zdHs3EQCdNMeZ23ByyNgq/oc3X8v+D4QtL94I0=;
        b=Wo15sHYbADhGTF51yjJzBNLQa2Qex+CQjCz1S13GoALcn7YLerWOu+cRTYg7w7jHBZ
         Dlv7XAt0eKADiFdOULkae48JWhLiwLjjmgAiwjQ4Wdr9pbiF0Tf0yVCIYp8UQKmEyy06
         iopmp66oniata0voGzOJ/jUYUZwOl8KaPx5yNbS1bhNtQRF5ylHBSLHjyURYuYQ0iFiW
         dQbNyxMttUeWHDBShNO3A72Xl4pSkMoIU7dqmk5a6bwaQ24DbW7KIaWaHoON3yxBgQ25
         TAqKvJoqzYWf/bXYiTQ0OELYi4H2jXj2bS1oGGvMn/U53pYgxkNzpwUmvSvWkz6VYo2v
         FGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LSTn+zdHs3EQCdNMeZ23ByyNgq/oc3X8v+D4QtL94I0=;
        b=lIy3OIqfrwaDhnaf7FLq3crJgRUmZEgDg5MoDYWO0TvhTZ5rg/hPEH8P5Pw9R1zeJZ
         LakwXaqBAqbcOGaDItvTtj/Wf/WIXXsIcVq9yDRYRzwFjq15+KLSyWp8m/IHAXcP0qG0
         67RpSkEC10NREiqOtLilvX1wei2DVxc6K6f2BGpgFkXa+++dTpe5AdT7pC+SFwOuU6Z2
         efczkeBUNyZjDT9UfMYo2mLPD1jLpE3WL/OXTS5G+Erj5H96s0vVSKrecJi7WHj+AKuY
         wZdSWx1kbkMicemsgZT7PHfe25A4JcYCId0SORRjR12A9IkCV+ORzyW4kO7V0vthAFh5
         fTaw==
X-Gm-Message-State: AOAM530JV8ZW3Rz0wovYeJshHVF4xxv44vijb8/wlZ41fRxO47FBLgOs
        9QhOzGLrHZcaA0i33as18lk=
X-Google-Smtp-Source: ABdhPJwu3ilA9K7gIV05jLluH/zJoD03uGCPMVfPA+g2B5NFXQGVQ8fJtCdQFHE1XkgQox0vkzxDvA==
X-Received: by 2002:aa7:dd05:: with SMTP id i5mr47823089edv.223.1609276670087;
        Tue, 29 Dec 2020 13:17:50 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id u9sm37354553edd.54.2020.12.29.13.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 13:17:49 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/13] MAINTAINERS: Add linux-actions ML for Actions Semi Arch
Date:   Tue, 29 Dec 2020 23:17:28 +0200
Message-Id: <942e2dcc9f184999f53e739dda794fc2607a288b.1609263738.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
References: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the linux-actions mailing list for the Actions Semi architecture.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
 - Added Reviewed-by from Mani

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 546aa66428c9..74a6eaae7b31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1512,6 +1512,7 @@ ARM/ACTIONS SEMI ARCHITECTURE
 M:	Andreas Färber <afaerber@suse.de>
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/actions.yaml
 F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
-- 
2.30.0

