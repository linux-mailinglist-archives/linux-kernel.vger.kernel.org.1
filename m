Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456BE23C27E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 02:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgHEALK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 20:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbgHEAK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:10:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9EB822D03;
        Wed,  5 Aug 2020 00:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596586256;
        bh=meQTT1s1Rrlo1gj4g9dJYjkI+GuEn89kJWoTpmyaJRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TGPfQHY1V4U4rXtTqTL9KFlQmcGAsnCKSGeTMiT3r0ybdyDTBavaegLzSd1lvYgSE
         iVT6ENmrFD3rOaZzXbIm1VuhtD8ssIzWsuSy4IGqsdOVYTgGNpMKBQc+esigwanpAE
         WolcQONyCSvr8Y8o5gGvWxw0IWA1LnBmsJ9vefK0=
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 12/14] tools/kernel.h: hide noinstr
Date:   Tue,  4 Aug 2020 20:10:41 -0400
Message-Id: <20200805001043.3331907-13-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200805001043.3331907-1-sashal@kernel.org>
References: <20200805001043.3331907-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 655389666643 ("vmlinux.lds.h: Create section for protection against
instrumentation") we need to ignore "noinstr" in userspace.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/kernel.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 5ac493eef4237..39fcbb144a34a 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -126,4 +126,6 @@ static __maybe_unused int system_state;
 
 #define in_nmi() 0
 
+#define noinstr
+
 #endif
-- 
2.25.1

