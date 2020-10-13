Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5253128CD57
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgJML6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727599AbgJMLyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:45 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 281F122472;
        Tue, 13 Oct 2020 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=bcpQJSQo4RKMfem1gJIWG3R0CHNjrpPoGlDyF+b98TQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FjduE5D3FPfx/1MjdT7V/5aywyY4FiBjixNvhVVYiNa9G4N9Xk8otUoYhx316kLes
         jlMAGJQOupHaw8Zey6FE4qjcve8fU1QU+Fxx1lZVdAoSbKM/yV3NOPlOzTfEFJ6QZy
         il7J/t+2lCoNe21WOodkxuJsAmHoFYsO0UciRfXA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt6-006CWs-13; Tue, 13 Oct 2020 13:54:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: [PATCH v6 76/80] docs: virt: user_mode_linux_howto_v2.rst: fix a literal block markup
Date:   Tue, 13 Oct 2020 13:54:31 +0200
Message-Id: <393933f6b2ffb20c3fed514508c13d78229562ff.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a missing new line for a literal block:

	.../Documentation/virt/uml/user_mode_linux_howto_v2.rst:682: WARNING: Unexpected indentation.

Fixes: 04301bf5b072 ("docs: replace the old User Mode Linux HowTo with a new one")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/virt/uml/user_mode_linux_howto_v2.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
index f70e6f5873c6..312e431695d9 100644
--- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
+++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
@@ -679,6 +679,7 @@ Starting UML
 
 We can now run UML.
 ::
+
    # linux mem=2048M umid=TEST \
     ubd0=Filesystem.img \
     vec0:transport=tap,ifname=tap0,depth=128,gro=1 \
-- 
2.26.2

