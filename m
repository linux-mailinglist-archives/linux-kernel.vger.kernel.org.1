Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8494228173E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbgJBP5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBP5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:57:20 -0400
Received: from localhost.localdomain (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 190BA206FA;
        Fri,  2 Oct 2020 15:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601654239;
        bh=1XmlhFEoYkmMXoYkScUn44VfFc7GCYdOUljXjYt6/Eo=;
        h=From:To:Cc:Subject:Date:From;
        b=Ub9UuoF4ZwClAO8KPVh+H+WPkPYNjpGMM1vlEwcUsOyJgF4zq4ZlgH97EnsXEla6o
         nrPkM/ZUqVehH4ItQvEfaoUTGg0mspLKxGBfx6yuo5FKgi0d8JS03i8Z80cRWoRGCT
         5cyCtlqXM7gI6WQDQEvABtuW1nUKTnuhG44fwIyM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Subject: [PATCH] MAINTAINERS: add dt binding headers to memory controller drivers entry
Date:   Fri,  2 Oct 2020 17:57:13 +0200
Message-Id: <20201002155713.3569-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cover also the include/dt-bindings/memory/ headers in the memory
controller drivers entry.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 00214bbaa72c..6db9b677559b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11328,6 +11328,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git
 F:	Documentation/devicetree/bindings/memory-controllers/
 F:	drivers/memory/
+F:	include/dt-bindings/memory/
 
 MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA
 M:	Dmitry Osipenko <digetx@gmail.com>
-- 
2.17.1

