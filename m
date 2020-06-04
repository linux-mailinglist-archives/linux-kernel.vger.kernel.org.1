Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FEC1EDD50
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 08:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgFDGlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 02:41:10 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:9753 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgFDGlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 02:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1591252868;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=K/GYyFc9Tr1igeXlrtoAg6gyVmr7G7JxC+U8Lyl2kEc=;
        b=KSJTEb/jDA+RR6z21ugaEMSAUMf5KUrY9Nh9gKfxlYrWC20dMUECM1VplbZg9qJJs4
        tN0FHbfvenXWGFDEoaj/hIA5nqjHg3rvz6Jg02kRSkWOIyZA25knNq8gL3Jbr642wmP+
        MFAIlwiFsRnI2d8bQGx3JpJdcD0VV25NvvII2dCMiPxvvVgejzWHNBbMbBfZ7fJMU/A8
        T+s+LkCUY7ac8PBQhmr9FkjiVXoYdhOZRUppBYFURT4WhXMQ+H8ixKpiZlV4WJPl7qFI
        jKqDLsVR6itooRPcVQAqmguW87RLpbOMpO++iWIhgnfOcV4dAENlCcfswnvF508h9It1
        Ly9w==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXvdOeueZtw="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.9.1 DYNA|AUTH)
        with ESMTPSA id I05374w546f15S3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 4 Jun 2020 08:41:01 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+2e635807decef724a1fa@syzkaller.appspotmail.com>
Subject: [PATCH v2] crypto: DRBG - always try to free Jitter RNG instance
Date:   Thu, 04 Jun 2020 08:41:00 +0200
Message-ID: <2551009.mvXUDI8C0e@positron.chronox.de>
In-Reply-To: <20200603110919.GK30374@kadam>
References: <0000000000002a280b05a725cd93@google.com> <2583872.mvXUDI8C0e@positron.chronox.de> <20200603110919.GK30374@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Jitter RNG is unconditionally allocated as a seed source follwoing
the patch 97f2650e5040. Thus, the instance must always be deallocated.

Reported-by: syzbot+2e635807decef724a1fa@syzkaller.appspotmail.com
Fixes: 97f2650e5040 ("crypto: drbg - always seeded with SP800-90B ...")
Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 crypto/drbg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index 37526eb8c5d5..8a0f16950144 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1631,6 +1631,9 @@ static int drbg_uninstantiate(struct drbg_state *drbg)
 	if (drbg->random_ready.func) {
 		del_random_ready_callback(&drbg->random_ready);
 		cancel_work_sync(&drbg->seed_work);
+	}
+
+	if (!IS_ERR_OR_NULL(drbg->jent)) {
 		crypto_free_rng(drbg->jent);
 		drbg->jent = NULL;
 	}
-- 
2.26.2




