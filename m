Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2452FFEAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhAVIuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbhAVIo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:44:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3E7C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 00:43:48 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1l2s2c-0005xf-A2; Fri, 22 Jan 2021 09:43:38 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1l2s2b-0006GM-Kx; Fri, 22 Jan 2021 09:43:37 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Cc:     kernel@pengutronix.de, Arnd Bergmann <arnd@arndb.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Dmitry Baryshkov <dbaryshkov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dm crypt: replaced #if defined with IS_ENABLED
Date:   Fri, 22 Jan 2021 09:43:20 +0100
Message-Id: <20210122084321.24012-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IS_ENABLED(CONFIG_ENCRYPTED_KEYS) is true whether the option is built-in
or a module, so use it instead of #if defined checking for each
separately.

The other #if was to avoid a static function defined, but unused
warning. As we now always build the callsite when the function
is defined, we can remove that first #if guard.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 drivers/md/dm-crypt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 8c874710f0bc..7eeb9248eda5 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2436,7 +2436,6 @@ static int set_key_user(struct crypt_config *cc, struct key *key)
 	return 0;
 }
 
-#if defined(CONFIG_ENCRYPTED_KEYS) || defined(CONFIG_ENCRYPTED_KEYS_MODULE)
 static int set_key_encrypted(struct crypt_config *cc, struct key *key)
 {
 	const struct encrypted_key_payload *ekp;
@@ -2452,7 +2451,6 @@ static int set_key_encrypted(struct crypt_config *cc, struct key *key)
 
 	return 0;
 }
-#endif /* CONFIG_ENCRYPTED_KEYS */
 
 static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string)
 {
@@ -2482,11 +2480,10 @@ static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string
 	} else if (!strncmp(key_string, "user:", key_desc - key_string + 1)) {
 		type = &key_type_user;
 		set_key = set_key_user;
-#if defined(CONFIG_ENCRYPTED_KEYS) || defined(CONFIG_ENCRYPTED_KEYS_MODULE)
-	} else if (!strncmp(key_string, "encrypted:", key_desc - key_string + 1)) {
+	} else if (IS_ENABLED(CONFIG_ENCRYPTED_KEYS) &&
+		   !strncmp(key_string, "encrypted:", key_desc - key_string + 1)) {
 		type = &key_type_encrypted;
 		set_key = set_key_encrypted;
-#endif
 	} else {
 		return -EINVAL;
 	}
-- 
2.30.0

