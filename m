Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53D32B989E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgKSQue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbgKSQud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:50:33 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745BFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:50:33 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id i19so8845714ejx.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7EUH8Q0hBE0cJa1m9igvLFmlRoYOR4Mc6yV41qq2m5A=;
        b=pkm8rl5wy17M49CsHLopmkGDqmEtPPZjHQqE2f17cqCXeUx+Ltkzhbg873gvUefCqm
         tgOinhxHcJIagN0Sm+rMgYTQMs1EPAWKAoWt5fi/P1OMxsPnR51jxpeh2mNf3eJb0fHC
         hCeIQgUDl58gFZubN9gMSPw60KGB7mzU1Q48GSeWmY/Q4ImuRKzyJYVVcCv9t2fjeZsx
         YEF40ZTqGJolgYsM4DbvKpt6O1I9DMnKUqXhJMC1gE0nWPiXtE7UV0rMqTTSFAHbWgxn
         UXJ0UHfeOQKEwLJU6S9kzNbZI6vCnqMAcgK2Q9aN715c6kkxaJ4YeZvkoM+PfFeMeKJZ
         vWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7EUH8Q0hBE0cJa1m9igvLFmlRoYOR4Mc6yV41qq2m5A=;
        b=Tga14TM4npveAKjmy+aA9jAy2/1Hyg83eHU4yH1CNCyNeDunmno+NJ3mAQKya1EQMH
         EXI+M4f0ret+YbDBQaQ48Ex9pXdqXbpqbdc96ZK+pTzwm5nTADXaI7nXHYrikSJZ3Aca
         Yr+F2DMJpO2UeslEJzvb8DcDM6+f1WtTalQqy/Plbu18uec4VvMyMt2+TG6pjx1mq84M
         LHxhqjkl+lzivjKPfEYjgi+YnmwMsatHWkaoMaTmrqTNM13Dshy6K4Lg18UldtkKQh+/
         VFIZHsXO0PeVLrazl3iwqMFpzQkEaZicZT4I+gCFEjqGwClX6QiEOxOJOiivwhmpRXa1
         zv+w==
X-Gm-Message-State: AOAM530LPGX2pZuBpYiliM+aPyezz22vrkp7ik6IkyksDAjqzZhNUKs9
        KqwMT1sZ2/Tuxad+UlalinI=
X-Google-Smtp-Source: ABdhPJw1mfwku1elBpRFI1KyU0bYl+SATIhZ0tnpWfdunHPqvQxW/Uf5zjN3RRPuM/q0R5cmTxnfHA==
X-Received: by 2002:a17:906:fc4:: with SMTP id c4mr21043702ejk.490.1605804632082;
        Thu, 19 Nov 2020 08:50:32 -0800 (PST)
Received: from yoga-910.localhost ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id s15sm2176edj.75.2020.11.19.08.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 08:50:31 -0800 (PST)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 3/3] staging: dpaa2-switch: pack the firmware command structures
Date:   Thu, 19 Nov 2020 18:50:17 +0200
Message-Id: <20201119165017.806696-4-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201119165017.806696-1-ciorneiioana@gmail.com>
References: <20201119165017.806696-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

The structures defined in the dpsw-cmd.h header file describe exactly
the layout of commands accepted by the MC firmware. Make sure that all
these structures are packed.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
index c9fb688f387c..450841cc6ca8 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
@@ -86,6 +86,7 @@
 #define dpsw_get_bit(var, bit) \
 	(((var)  >> (bit)) & GENMASK(0, 0))
 
+#pragma pack(push, 1)
 struct dpsw_cmd_open {
 	__le32 dpsw_id;
 };
@@ -385,4 +386,5 @@ struct dpsw_cmd_if_set_mac_addr {
 	u8 mac_addr[6];
 };
 
+#pragma pack(pop)
 #endif /* __FSL_DPSW_CMD_H */
-- 
2.28.0

