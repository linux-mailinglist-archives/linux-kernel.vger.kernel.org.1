Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F8E2F4515
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 08:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbhAMHTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 02:19:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbhAMHTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 02:19:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19D082313E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 07:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610522306;
        bh=kvx7bxJFYN/uGWgQv3lwYWeG/BBG0xs6FjhUUVwkk8Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OaArDMulrgsrVSv6N/xjGIk/pAd2SHUhc8wG51Ka5nNinPE1MAqeuFMwenR7Mbchc
         gllL7VkyKkLwD7nsl+k1ftqv+QsFcHRBs37iifFr+M8YEK6JuBW4Qtih2rFuZWJIVT
         iU/C/j5X+1c25++qaSZhFvd7Vo9gMzvMTUqpGSMtWRMmkbF6FKDow1Cr5fI1zd6/SJ
         kycrbLJ332D0PE+8GFkkerLJV6K0V/BOt6vgX7mTK3289dQPXPStY6rFx3QaRRgGqE
         IIyg1wF3HN8uzOFo0nYEGgEqlksJnfUIKkBgtTCsK2jIP5ArHbHohX8TzerUpuMwse
         1du9M7EdIzmzw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] CREDITS: update email address and home address
Date:   Wed, 13 Jan 2021 09:18:22 +0200
Message-Id: <20210113071822.25421-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113071822.25421-1-ogabbay@kernel.org>
References: <20210113071822.25421-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update my email address to kernel.org account and my home address
to my new house.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 CREDITS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/CREDITS b/CREDITS
index 090ed4b004a5..ebd00ca9515b 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1240,10 +1240,10 @@ S: 80050-430 - Curitiba - Paraná
 S: Brazil
 
 N: Oded Gabbay
-E: oded.gabbay@gmail.com
-D: HabanaLabs and AMD KFD maintainer
-S: 12 Shraga Raphaeli
-S: Petah-Tikva, 4906418
+E: ogabbay@kernel.org
+D: HabanaLabs maintainer
+S: 29 Duchifat St.
+S: Ra'anana 4372029
 S: Israel
 
 N: Kumar Gala
-- 
2.25.1

