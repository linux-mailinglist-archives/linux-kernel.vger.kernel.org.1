Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6132FBDBD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391349AbhASRc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:32:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391404AbhASQMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:12:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 696392313B;
        Tue, 19 Jan 2021 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611072651;
        bh=QCx692mEV9EmrBqf9kmDsyhi0piG9+D6dDMN9S7D8lU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dOnBvQuk6RgwW9YZ1o0IVHyi5XLFg4snkaWq6aP6KM3N1jIqMtWnNx3uyp5ECN3qd
         G1o7acQM7DbbJNrr9b5FDXU/l6r8WzcSA7SvYHVN0kn+r9x7PcfJDVSrgFKCE+9P2G
         IONEStEHYHHzv9nT5Nl6EdynO9An7xKpVjeR/pNY1HQ/GIwkgVBHkrFrSXgqtZYdNj
         uMd0rlhT50+mmBZ4G6VsVB/O0N2EguX2+XEgCEnBjRxB3WCowXhFxodMMiIEqRg2+M
         iiSCrVMBlbIQKg8brs8KEQupvGSbHTR8iCMRgLPb76wFIoHDIQ+Bi1TnhXfq1hHKKC
         eVcbVEx9clwNw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1taj-0012by-6l; Tue, 19 Jan 2021 17:10:49 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/21] staging: hikey9xx: hisilicon,hi6421-spmi-pmic.yaml: cleanup a warning
Date:   Tue, 19 Jan 2021 17:10:39 +0100
Message-Id: <0663e419bdebd2a5603d151f4212a2751e9fc8fd.1611072387.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611072387.git.mchehab+huawei@kernel.org>
References: <cover.1611072387.git.mchehab+huawei@kernel.org>
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

