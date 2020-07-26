Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB7022E16B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 18:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgGZQor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 12:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgGZQoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:44:46 -0400
Received: from localhost.localdomain (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28595204EA;
        Sun, 26 Jul 2020 16:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595781886;
        bh=dOJbAPnEvGYxQk1u0akkqHdNIhxLho/LRvY3km7+pls=;
        h=From:To:Cc:Subject:Date:From;
        b=kYsHiZradkbeFozTELM5fn/2NRx+mO6tq58wGGET80iCDTX9ZH5JfAbp+Gxr9kOPS
         N8fSwyLhGiVyXnZgzLglk0QcySswAOztovRizE98Cweu8cEMs1Vw4cQ0/dV8ZPAhpZ
         4lh3lwMaacMAwEa3kPgSswb1zJRNLMGa0Y/2byxk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] MAINTAINERS: Add Git repository for memory controller drivers
Date:   Sun, 26 Jul 2020 18:44:31 +0200
Message-Id: <20200726164431.9234-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dedicated Krzysztof Kozlowski's Git repository on @kernel.org for
memory controller drivers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1cc0afe0762..652abe9a5bc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11159,6 +11159,7 @@ MEMORY CONTROLLER DRIVERS
 M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git
 F:	Documentation/devicetree/bindings/memory-controllers/
 F:	drivers/memory/
 
-- 
2.17.1

