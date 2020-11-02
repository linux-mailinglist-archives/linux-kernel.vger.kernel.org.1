Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD622A2857
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgKBKc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:32:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728450AbgKBKcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:32:25 -0500
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A812E222E8;
        Mon,  2 Nov 2020 10:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604313144;
        bh=1VWzzJjHUb1R30k+duKrw4K9kSc2mgbk8JLzxQJmXks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eBqut+b6H2EGd7UpzkhoST1LRrnoIUPQHV1fnxW5RVB6v3BKQnOtGrYkZwtHO1IuS
         z5L6JAXM+D451ynpd+eSuY/YqUt/YIv7lACBd70s0WppQwosrk/FC/VtRB+Qfx5vhk
         drncfpCt51DMjWtqyKCSrXZQAX6cP29k3NtLSp/0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kZX8P-005tud-TW; Mon, 02 Nov 2020 11:32:21 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: [PATCH 3/5] docs: leds: index.rst: add a missing file
Date:   Mon,  2 Nov 2020 11:32:14 +0100
Message-Id: <36a6e3aef6e57ea349f1b47c7731d4cd1e03ca77.1604312590.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604312590.git.mchehab+huawei@kernel.org>
References: <cover.1604312590.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 26a07553041e ("docs: ABI: sysfs-class-led-trigger-pattern: remove hw_pattern duplication")
didn't include the needed changes at index.rst.

Fixes: 26a07553041e ("docs: ABI: sysfs-class-led-trigger-pattern: remove hw_pattern duplication")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/leds/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index 53e6090454af..e5d63b940045 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -25,3 +25,4 @@ LEDs
    leds-lp5562
    leds-lp55xx
    leds-mlxcpld
+   leds-sc27xx
-- 
2.26.2

