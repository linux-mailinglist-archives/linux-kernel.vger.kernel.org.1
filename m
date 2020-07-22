Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8610122980D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 14:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbgGVMPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 08:15:20 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51502 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732252AbgGVMPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:15:14 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 501F2200906;
        Wed, 22 Jul 2020 14:15:13 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 43C05200905;
        Wed, 22 Jul 2020 14:15:13 +0200 (CEST)
Received: from fsr-ub1864-014.ea.freescale.net (fsr-ub1864-014.ea.freescale.net [10.171.95.219])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D7A28202AC;
        Wed, 22 Jul 2020 14:15:12 +0200 (CEST)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 6/7] crypto: caam - add more RNG hw error codes
Date:   Wed, 22 Jul 2020 15:14:57 +0300
Message-Id: <20200722121458.8478-7-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722121458.8478-1-horia.geanta@nxp.com>
References: <20200722121458.8478-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, e.g. when TRNG is not properly configured,
the RNG module could issue a "Hardware error" at runtime.

"Continuos check" error is emitted when some of the BISTs fail.

Signed-off-by: Horia Geantă <horia.geanta@freescale.com>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 drivers/crypto/caam/error.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/caam/error.c b/drivers/crypto/caam/error.c
index 17c6108b6d41..72db90176b1a 100644
--- a/drivers/crypto/caam/error.c
+++ b/drivers/crypto/caam/error.c
@@ -212,6 +212,9 @@ static const char * const rng_err_id_list[] = {
 	"Prediction resistance and test request",
 	"Uninstantiate",
 	"Secure key generation",
+	"",
+	"Hardware error",
+	"Continuous check"
 };
 
 static int report_ccb_status(struct device *jrdev, const u32 status,
-- 
2.17.1

