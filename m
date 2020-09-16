Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609FA26C804
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgIPSiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbgIPS27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:28:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BD8C035437
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:06:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so6673178wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rp7Xhs/bBt9D8tUMlvjIoqHMOsBqD8IYyxiK/2FKKG8=;
        b=NzuEqJEaQL8fg8E+ugG0EvQ+ISnYy96VOTeyqJ2H4egEbK1//gM37ymiqQDoNLVucw
         ZHKgF8zoZS4sE+eFUY5nU3d0PGYihU3kowLoGaEPHhj2oy4IPrVBPyh1462yd5rznFvZ
         2PtEI+LhLapu6mgrPLWGZVRDWX7X4PLtZb42I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rp7Xhs/bBt9D8tUMlvjIoqHMOsBqD8IYyxiK/2FKKG8=;
        b=dyFNWWL9kPJ5h4oOIs5e/pBu78q4lTpRVn1ftUK3/z7/DrCYnm4b2C5g35eUsxL68H
         V5mIeg0c3SS0psmybokm0MpmyPTLqhrKzlukozugGNVp5Tn/1Cw2/rj+rTCgH3BL8yKr
         H6GJKLjj43H/DOIBLKDFHM4YiBAaAAyVnkqXuOCegiFlPGTOd8Fs3G+RZ4PMEp27Ergx
         UYAJWZ0IcJ9eod4N1ahIPTIdK1hnBqcOJGIfKpPjA6aJ5uNfp1RP7eTvwmaugRGSza13
         gOEMqq1eRDteqVFYE9lLYNdNy2cDLX/3RE4QciN7tn5ylsfjnZxGeN9NEMsniwc5+BA5
         HlLg==
X-Gm-Message-State: AOAM530h6MBU/citmgdjiVsurPHZB2FpDIo+nIHNfYhN5SPHd1cPk2Lb
        FMhM8wCUHnt/yttOckv7oX/mLxKqCiGS/1Jd/xE=
X-Google-Smtp-Source: ABdhPJwhEX5BY4LjbmOas8IFcM0+VybB2aJZphWqZuuk3BYpd+O+YeVNh7I4lfx7jWld+B+H8VyF6w==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr25833458wrm.422.1600258018090;
        Wed, 16 Sep 2020 05:06:58 -0700 (PDT)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id h8sm32042888wrw.68.2020.09.16.05.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 05:06:57 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH] ima: Fix NULL pointer dereference in ima_file_hash
Date:   Wed, 16 Sep 2020 12:05:48 +0000
Message-Id: <20200916120548.364892-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

ima_file_hash can be called when there is no iint->ima_hash available
even though the inode exists in the integrity cache.

An example where this can happen (suggested by Jann Horn):

Process A does:

	while(1) {
		unlink("/tmp/imafoo");
		fd = open("/tmp/imafoo", O_RDWR|O_CREAT|O_TRUNC, 0700);
		if (fd == -1) {
			perror("open");
			continue;
		}
		write(fd, "A", 1);
		close(fd);
	}

and Process B does:

	while (1) {
		int fd = open("/tmp/imafoo", O_RDONLY);
		if (fd == -1)
			continue;
    		char *mapping = mmap(NULL, 0x1000, PROT_READ|PROT_EXEC,
			 	     MAP_PRIVATE, fd, 0);
		if (mapping != MAP_FAILED)
			munmap(mapping, 0x1000);
		close(fd);
  	}

Due to the race to get the iint->mutex between ima_file_hash and
process_measurement iint->ima_hash could still be NULL.

Fixes: 6beea7afcc72 ("ima: add the ability to query the cached hash of a given file")
Signed-off-by: KP Singh <kpsingh@google.com>
---
 security/integrity/ima/ima_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8a91711ca79b..4c86cd4eece0 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -531,6 +531,16 @@ int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&iint->mutex);
+
+	/*
+	 * ima_file_hash can be called when ima_collect_measurement has still
+	 * not been called, we might not always have a hash.
+	 */
+	if (!iint->ima_hash) {
+		mutex_unlock(&iint->mutex);
+		return -EOPNOTSUPP;
+	}
+
 	if (buf) {
 		size_t copied_size;
 
-- 
2.28.0.618.gf4bc123cb7-goog

