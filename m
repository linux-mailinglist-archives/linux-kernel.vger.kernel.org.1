Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EAF29743C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465896AbgJWQfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751874AbgJWQdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:51 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B08D24728;
        Fri, 23 Oct 2020 16:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470829;
        bh=oO8rHblWrltD5o/CNaVST9iwCP59MCxNxH8BZzAUDy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jQ0+RECx3STbdEd2V/INhAoxUb2EKibO4gc7MTIrJBeW7dwMrk0XLiI8CWtsyu4/D
         /Efzq7tPYI/GM2isaLu7+VF+NE2ZUctD8ZAyNTAXHGBUm6jECsv5g5lUQguykgSn0c
         0HqrhVGgP2toUPzK91vEriwg8y9wFMPG5yzdsxQU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002Ax4-AX; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 38/56] clk: fix a kernel-doc markup
Date:   Fri, 23 Oct 2020 18:33:25 +0200
Message-Id: <b2336f3f3cdfe6e1a2d3a7a056ab7ccc7a81b945.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_get_duty_cycle -> clk_get_scaled_duty_cycle

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/clk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 7fd6a1febcf4..5f8d5f4931c0 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -150,7 +150,7 @@ int clk_get_phase(struct clk *clk);
 int clk_set_duty_cycle(struct clk *clk, unsigned int num, unsigned int den);
 
 /**
- * clk_get_duty_cycle - return the duty cycle ratio of a clock signal
+ * clk_get_scaled_duty_cycle - return the duty cycle ratio of a clock signal
  * @clk: clock signal source
  * @scale: scaling factor to be applied to represent the ratio as an integer
  *
-- 
2.26.2

