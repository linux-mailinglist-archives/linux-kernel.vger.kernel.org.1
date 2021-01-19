Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355292FB743
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403978AbhASKd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:33:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389822AbhASKRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:17:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16B5C23137;
        Tue, 19 Jan 2021 10:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611051267;
        bh=QCx692mEV9EmrBqf9kmDsyhi0piG9+D6dDMN9S7D8lU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VP0dcE5O+4PWIgAVupUy2WV9F9ZCnEGoCnX5oDT3d37RxPaXLDlICfJ9vWGoquW7i
         soilPwpcHlgtKUAmR7rbXzfVx+K+o3f0A3be08pfqeg73ZeNvwN3JbXucN7DExHCEE
         LaGT4UAsUUwGw8cYtnPM8fgA3fcN9mWLKJB+QjL3MVpGC1wosgM1jeodZSQcR+/VW4
         WT1BVZ7L0a2YFU4MMYOexzxRKgDk7hHwi61pOX6VTxrymx4dzJohrpNm4J3/EH8kdQ
         OhjSGky+IaLm2Ec7a2KH6iPu8WWeSXgQUU+bloyECvihjSelUFcC8SitRUH5uKJ5Cw
         f2IUr8WGrxpaQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1o1o-000tP6-UA; Tue, 19 Jan 2021 11:14:24 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/18] staging: hikey9xx: hisilicon,hi6421-spmi-pmic.yaml: cleanup a warning
Date:   Tue, 19 Jan 2021 11:14:18 +0100
Message-Id: <e491a7421ecffda5348e0191020ab1d661808c0c.1611048785.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611048785.git.mchehab+huawei@kernel.org>
References: <cover.1611048785.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no additionalProperties field at the yaml file, causing
a warning when checking it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
index f385146d2bd1..3b23ad56b31a 100644
--- a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
+++ b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
@@ -60,6 +60,8 @@ required:
   - reg
   - regulators
 
+additionalProperties: false
+
 examples:
   - |
     /* pmic properties */
-- 
2.29.2

