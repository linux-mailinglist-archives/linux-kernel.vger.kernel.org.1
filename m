Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF7F2E104B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 23:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgLVW3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 17:29:46 -0500
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:50825 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728410AbgLVW3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 17:29:39 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D0rRH6tLszPk1h;
        Tue, 22 Dec 2020 23:21:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1608675708; bh=n0czzUvvt3SkCFICCpWB9oK3QXru4vyuSDr/GChrA1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=jw1kfaHL9cFHzcxYt2XwipQjNGRTfglevTdBJrTRNVgygU4U94TfZ20B8lbLL4OtH
         Hv25JmyBMe5pVweLjVufE0kZ9c9bNK0ewaJ0NPi0vJ1+KyH5gA1YlYq48G54tkeyj1
         F9lRr7GSeZHOXnneO7+7jYYraX6d+CjWQeMyK5gvFa1ABxJky75Ki3W3baYUSKsN6Y
         Qem+qlxoc7QSsvvF7TOv5Cy/rvEtcSxmlJFJfKaI08u0OV5ilOlcogfUiPshLdQY/h
         jD8V28lVRZOyyysQkt/iZv8IG3VRO1f21lvGTX1YIK07LQXiTdsgGN0uB3L5+brNu+
         s18t/hB4r2cKA==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:a62:19fa:6f01:10d5:3d50:1797:6266
Received: from shaun-PC.fritz.box (unknown [IPv6:2001:a62:19fa:6f01:10d5:3d50:1797:6266])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+7RJcTTjdbiW4GOFIM08BJzvzFK8lL52Q=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D0rRF2FzpzPjnl;
        Tue, 22 Dec 2020 23:21:45 +0100 (CET)
From:   Johannes Czekay <johannes.czekay@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     johannes.czekay@fau.de, nicolai.fischer@fau.de,
        gustavo@embeddedor.com, hannes@cmpxchg.org, longman@redhat.com,
        mhocko@suse.com, adawesomeguy222@gmail.com,
        igormtorrente@gmail.com, sylphrenadin@gmail.com,
        izabela.bakollari@gmail.com, colin.king@canonical.com,
        steff.richards.the.third@gmail.com
Subject: [PATCH 2/6] wlan-ng: clean up spinlock_t definition
Date:   Tue, 22 Dec 2020 23:20:13 +0100
Message-Id: <20201222222015.20558-3-johannes.czekay@fau.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201222222015.20558-1-johannes.czekay@fau.de>
References: <20201222222015.20558-1-johannes.czekay@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up a "spinlock_t definition without comment" warning in
hfa384x.h.

Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
Co-developed-by: Nicolai Fischer <nicolai.fischer@fau.de>
Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
---
 drivers/staging/wlan-ng/hfa384x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
index 88e894dd3568..13ab9545a066 100644
--- a/drivers/staging/wlan-ng/hfa384x.h
+++ b/drivers/staging/wlan-ng/hfa384x.h
@@ -1184,7 +1184,7 @@ struct hfa384x_usbctlx {
 };
 
 struct hfa384x_usbctlxq {
-	spinlock_t lock;
+	spinlock_t lock;	/* Lock for CTLX que */
 	struct list_head pending;
 	struct list_head active;
 	struct list_head completing;
-- 
2.25.1

