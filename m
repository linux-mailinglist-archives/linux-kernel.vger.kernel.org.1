Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615F02E7EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 09:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgLaIxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 03:53:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgLaIxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 03:53:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81B83208B8;
        Thu, 31 Dec 2020 08:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609404789;
        bh=3XT/6I6rd1Yk/9gVWV9Z+YqtCtiIi+MPjlaUt/WQmo0=;
        h=From:To:Cc:Subject:Date:From;
        b=jt79nNaXxEXhqixdY6zD9cXSGcz+GCu+TbRr2RlI0ft1qDbfgDDDCLpvFkpPuGLtr
         JylY5qPYnRIL6GWYIvyP6vpghEXduHLsi3GloN96EV+IBItfd0T1WUGYzlnyIY5Bip
         SNuax/LnMQnwoLBu6JN+HPqr2jEIeIU3Jt1lsmzXOyHwi32IkeLxO7stPlvWYyfvw4
         fXJ/ISCSqqQajhdVQn9i0ele9tMSv93Bv3MeaVERizqbub9YgJGGkAmeGhPaQmZHQb
         LPQZMQmRWpqEKiJskIFz//C59kJ8wvp/Amqs03L9uUk0PNgc7l3qXjd2+Ys9U0qDlU
         WGy0PuoldQgvw==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Timon Baetz <timon.baetz@protonmail.com>, kbuild-all@lists.01.org,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] extcon: Add stubs for extcon_register_notifier_all() functions
Date:   Thu, 31 Dec 2020 09:52:52 +0100
Message-Id: <20201231085252.69831-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add stubs for extcon_register_notifier_all() function for !CONFIG_EXTCON
case.  This is useful for compile testing and for drivers which use
EXTCON but do not require it (therefore do not depend on CONFIG_EXTCON).

Fixes: 815429b39d94 ("extcon: Add new extcon_register_notifier_all() to monitor all external connectors")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 include/linux/extcon.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index fd183fb9c20f..0c19010da77f 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -271,6 +271,29 @@ static inline  void devm_extcon_unregister_notifier(struct device *dev,
 				struct extcon_dev *edev, unsigned int id,
 				struct notifier_block *nb) { }
 
+static inline int extcon_register_notifier_all(struct extcon_dev *edev,
+					       struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int extcon_unregister_notifier_all(struct extcon_dev *edev,
+						 struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int devm_extcon_register_notifier_all(struct device *dev,
+						    struct extcon_dev *edev,
+						    struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline void devm_extcon_unregister_notifier_all(struct device *dev,
+						       struct extcon_dev *edev,
+						       struct notifier_block *nb) { }
+
 static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
 {
 	return ERR_PTR(-ENODEV);
-- 
2.25.1

