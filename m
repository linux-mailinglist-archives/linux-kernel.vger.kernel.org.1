Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A8B2FE3D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbhAUHXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:23:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbhAUHUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:20:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55809239ED;
        Thu, 21 Jan 2021 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611213508;
        bh=QCx692mEV9EmrBqf9kmDsyhi0piG9+D6dDMN9S7D8lU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PaTEgU1o8L72Yt/VuJ/9lT+vvbonDomDrsGhBOyFFg27s8mj8hw6/e8lsagQy7/un
         5igmejjw2KefDjrk1JG6Y6JtcGlHVHH4rroZ2glS0QgQsQ2I+aM5JPHIQR03f4kVNV
         CzTUbvpbvJQLYoyTwvgpPoP4peno4foRDtH9gNAgi+mOQJMJybuJOdNLOSUxxAOV0l
         /wzf7VJSJZfEaTftlkMd/1zff3sGKJ4hekhCoX7xGM77pemcwYQVpi3xIwGySm1Aqe
         8B1Uwlb3dIohf9K02QpCd32bMnEMhElUXwK9Rl6Ws24DhrwWz2bQIGn/pwq1qj9Qct
         os62T8f7XEW0w==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l2UEb-004BsM-L4; Thu, 21 Jan 2021 08:18:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 13/21] staging: hikey9xx: hisilicon,hi6421-spmi-pmic.yaml: cleanup a warning
Date:   Thu, 21 Jan 2021 08:18:15 +0100
Message-Id: <1920935fc7320f8d03ed3c89625fa865adcf4390.1611212783.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611212783.git.mchehab+huawei@kernel.org>
References: <cover.1611212783.git.mchehab+huawei@kernel.org>
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

