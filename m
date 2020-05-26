Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC7F1E2EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 21:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389704AbgEZS6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 14:58:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390392AbgEZS6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:58:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C641020849;
        Tue, 26 May 2020 18:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519525;
        bh=iDeY2skZ4/3Sbynoo4JMtZ+fdIMyYtcW3coIfHV83mc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZRB236cGUcAp+LMzBGZQ/GqHOvmAb0Y18wKZyTx6YGufV1HqDA2P7Z6ZnqgdW2zln
         oYCvIV+H0YFp4eFPuSd44gZjVPU3z6dAwI3P6LtSBW72OkDjD8waAKrUikxqfTWETg
         aqQi4ABAwzselq8tXTDfFsemA+mwsaqtBwohf5u4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 06/64] evm: Check also if *tfm is an error pointer in init_desc()
Date:   Tue, 26 May 2020 20:52:35 +0200
Message-Id: <20200526183915.284720219@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183913.064413230@linuxfoundation.org>
References: <20200526183913.064413230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

[ Upstream commit 53de3b080d5eae31d0de219617155dcc34e7d698 ]

This patch avoids a kernel panic due to accessing an error pointer set by
crypto_alloc_shash(). It occurs especially when there are many files that
require an unsupported algorithm, as it would increase the likelihood of
the following race condition:

Task A: *tfm = crypto_alloc_shash() <= error pointer
Task B: if (*tfm == NULL) <= *tfm is not NULL, use it
Task B: rc = crypto_shash_init(desc) <= panic
Task A: *tfm = NULL

This patch uses the IS_ERR_OR_NULL macro to determine whether or not a new
crypto context must be created.

Cc: stable@vger.kernel.org
Fixes: d46eb3699502b ("evm: crypto hash replaced by shash")
Co-developed-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/evm/evm_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index c783fefa558a..e034dc21421e 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -90,7 +90,7 @@ static struct shash_desc *init_desc(char type)
 		algo = evm_hash;
 	}
 
-	if (*tfm == NULL) {
+	if (IS_ERR_OR_NULL(*tfm)) {
 		mutex_lock(&mutex);
 		if (*tfm)
 			goto out;
-- 
2.25.1



