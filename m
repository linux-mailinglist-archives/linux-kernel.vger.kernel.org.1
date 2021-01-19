Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F7E2FB776
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404784AbhASKzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:55:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404496AbhASKp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:45:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A17EC23137;
        Tue, 19 Jan 2021 10:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611053086;
        bh=4vwoBa/srEYigK5iPFIq9fzkW1MkqM6bmsc3KeSzeBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RapumV7xXwiL5aRMuvaegh9/A2P1Cq+QG9mCzdJwEsUJ10/lf8JxTeRJSwhS3Jx/D
         Tvoo5WKpMZHo7sOf8cGpi13/NpE2UcCq7+5oO8NtuZkMhntvJGXMkeIfLKon6Brbpd
         RsoBcK76tQwfGBFqpaQE1F1geFwNtag0Rnx8B5LnRFaDMQZGxjGqrVoCBKKhub0hep
         TJwvP2dn4PhT6AoT4l1jzPjH3OGwBEDdNjcwKovYEPcorv157T2+SOsRofUJqehqgM
         rUSeQbJvyZnNA8dqsKHfV5a1zEye+BXoPJD2bOOmJwF+1moqip9ca1BRyIT3CRPWDy
         T1blVlIAOnEBA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1oVA-000u2L-7a; Tue, 19 Jan 2021 11:44:44 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] staging: hikey9xx: phy-hi3670-usb3.yaml: add a blank line
Date:   Tue, 19 Jan 2021 11:44:42 +0100
Message-Id: <2bd13d3e141fd8826a8e791e5c65e877c6233966.1611052729.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611052729.git.mchehab+huawei@kernel.org>
References: <cover.1611052729.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a blank line after maintainers field.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/phy-hi3670-usb3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/hikey9xx/phy-hi3670-usb3.yaml b/drivers/staging/hikey9xx/phy-hi3670-usb3.yaml
index 125a5d6546ae..ebd78acfe2de 100644
--- a/drivers/staging/hikey9xx/phy-hi3670-usb3.yaml
+++ b/drivers/staging/hikey9xx/phy-hi3670-usb3.yaml
@@ -8,6 +8,7 @@ title: Hisilicon Kirin970 USB PHY
 
 maintainers:
   - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
 description: |+
   Bindings for USB3 PHY on HiSilicon Kirin 970.
 
-- 
2.29.2

