Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C908029742B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbgJWQe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751862AbgJWQdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:51 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5B71246DD;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=eksPX5hWIQ0X68hOaZK/G3AyPOBnQomK+GXPdk2P8yA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=krYfzdRXT/KYjRJ/lU2pn0SLwaHCiiGta8OybwKiqba2bEKqsHApW738htG+miaKq
         Z7D/Qy/vsx4QvxPkmQQRfZ0fWwNIkDwyB7pnxCq8JdNkQVvMyFUa/hE1vPkY3zwqdV
         PRahBBXNC/SokOI6v/DVKsaSvLySrHXUZXRRaZlg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002Axj-ML; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 51/56] audit: fix a kernel-doc markup
Date:   Fri, 23 Oct 2020 18:33:38 +0200
Message-Id: <8c04d5c5d0144019c2c38d7c3f31061d6b35d360.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

typo:
	kauditd_print_skb -> kauditd_printk_skb

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 kernel/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 68cee3bc8cfe..0be42cac086b 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -523,7 +523,7 @@ static int auditd_set(struct pid *pid, u32 portid, struct net *net)
 }
 
 /**
- * kauditd_print_skb - Print the audit record to the ring buffer
+ * kauditd_printk_skb - Print the audit record to the ring buffer
  * @skb: audit record
  *
  * Whatever the reason, this packet may not make it to the auditd connection
-- 
2.26.2

