Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D402A4472
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 12:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgKCLob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 06:44:31 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15823 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgKCLob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 06:44:31 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa142a10000>; Tue, 03 Nov 2020 03:44:33 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Nov
 2020 11:44:30 +0000
Received: from localhost.localdomain (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 3 Nov 2020 11:44:28 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] drm/tegra: sor: Don't warn on probe deferral
Date:   Tue, 3 Nov 2020 11:44:26 +0000
Message-ID: <20201103114426.546626-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604403873; bh=rntxA0RjiInWM7/UTBNFjUV2RmVmdlOjNbvWUA83d2k=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=GzuMlUZRznf3zmicrEnhFp66Z3L2nqtM0k2iO74oWhwGqAIK4e9MP8OCn9S97FDBY
         xjosivdSGxtLe2svkx3zLl8NoEmxIu8pmWFug7k0JST6aEIyHPRASGayVM1O8oFENj
         Ea6RqZkpJTvfwzGZ9zXPioLWjIsMy/azDvZX8LvBLPuwbw4tSXZ6tW5Ozgc/VZWTN4
         EHMF2dhMVlwif71tCTsnqxJRZzG268oTyM4eYBwc4vQCUkx2IV4CshYublAk36Gr0Q
         F9wxTQobiFqs4GB7ctFG3v7zwx2TaqKR7JRITffDNW60+bXwfo2ZlkFBjV+i3YDOnw
         DhfO07VVuRYpw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deferred probe is an expected return value for tegra_output_probe().
Given that the driver deals with it properly, there's no need to output
a warning that may potentially confuse users.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/gpu/drm/tegra/sor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index e88a17c2937f..5a232055b8cc 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -3765,7 +3765,7 @@ static int tegra_sor_probe(struct platform_device *pd=
ev)
=20
 	err =3D tegra_output_probe(&sor->output);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to probe output: %d\n", err);
+		dev_err_probe(&pdev->dev, "failed to probe output: %d\n", err);
 		return err;
 	}
=20
--=20
2.25.1

