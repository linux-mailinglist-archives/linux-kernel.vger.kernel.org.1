Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65943245E72
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 09:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgHQHuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 03:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgHQHu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:50:26 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A26920866;
        Mon, 17 Aug 2020 07:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597650620;
        bh=N+BPELjCZ1KevloDTScYAnAb55+e4DGgdCthwItNvYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rk04h9QxU9gQK5aeirH28zj9zmAf80BbzdKi0n0y8VG8ph678mpp0l0/LulSibci4
         gLOlFOQF0Gyn5EX/KImjVAqSDoGv4iOlxjelXhQhzDNmMYVI/eKKL13vveFWLSPrSS
         2fj9EQQGq6xoJ5W2Z5zGo+1//Z3fTd/RHxwqzVjc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZuM-00Bfcb-JP; Mon, 17 Aug 2020 09:50:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 16/16] staging: hikey9xx: add an item about the iommu driver
Date:   Mon, 17 Aug 2020 09:50:15 +0200
Message-Id: <5a666747a71c73ab9f7c007846dc075c10932ae2.1597650455.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597650455.git.mchehab+huawei@kernel.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver doesn't use a too standard DT. Need to
adjust it and the upcoming DRM driver who uses it, in
order to do things on a more standard way.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/TODO | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/hikey9xx/TODO b/drivers/staging/hikey9xx/TODO
index 65e7996a3066..79f2cc990415 100644
--- a/drivers/staging/hikey9xx/TODO
+++ b/drivers/staging/hikey9xx/TODO
@@ -2,4 +2,5 @@ ToDo list:
 
 - Port other drivers needed by Hikey 960/970;
 - Test drivers on Hikey 960;
+- Adjust the iommu driver's code for it to use more standard DT settings;
 - Validate device tree bindings.
-- 
2.26.2

