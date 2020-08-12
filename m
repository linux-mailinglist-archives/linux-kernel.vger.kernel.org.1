Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1293242CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 17:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHLP5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 11:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbgHLP5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:05 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EE122310B;
        Wed, 12 Aug 2020 15:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247821;
        bh=oTXbf1K0JfaqbK6sjMAlt2QAMJ8ewI4Je+6AHT1jcvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AeD8ndVdR1hFgC7aVpOvxPGvyYulhPUj54Iuq5KT69N5tCrInHPR+Ek0wNucoJPAC
         tfS9EpUhVVNQmxuMHxLPYx5k3tkoyRCLIEUC5s0H+BV/7LpNQYoG0c84z5SDuaiGuK
         +x/wflGxSe3Tahg14kvz6JrbXC6+slck4H9MemNA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7b-005t7X-F7; Wed, 12 Aug 2020 17:56:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 42/44] MAINTAINERS: add an entry for HiSilicon 6421v600 drivers
Date:   Wed, 12 Aug 2020 17:56:52 +0200
Message-Id: <051009e99ba3e8a1a6a2dcb5e6e9ebd7696d0747.1597247164.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the SPMI, MFD and PMIC parts of the
HiSilicon 6421v600 support.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 956ecd5ba426..e2de0b2119fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7824,6 +7824,12 @@ F:	drivers/crypto/hisilicon/sec2/sec_crypto.c
 F:	drivers/crypto/hisilicon/sec2/sec_crypto.h
 F:	drivers/crypto/hisilicon/sec2/sec_main.c
 
+HISILICON STAGING DRIVERS FOR HIKEY 960/970
+M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/staging/hikey9xx/
+
 HISILICON TRUE RANDOM NUMBER GENERATOR V2 SUPPORT
 M:	Zaibo Xu <xuzaibo@huawei.com>
 S:	Maintained
-- 
2.26.2

