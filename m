Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF491C19DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 17:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbgEAPit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 11:38:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729380AbgEAPiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:38:03 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C963C2495A;
        Fri,  1 May 2020 15:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588347483;
        bh=1Q9DqDJemHqm7/huajZj2zzTTSmciVYiZ33hawipH4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UrQcrs+KRb/pwilyr6Z8dYk68ialiWEKfhEBT/Q7MHCl3Shq6O/OJCWbdOReDjwlD
         8LxwqL8nGM9GDJ4h3klNHpuPOJq6OzXexXAxmgu+BZ4mtxf5br+qw8eAzji+04xk4k
         uT3QcaHwIjImj+yF8hKoOsBD8d3+ntSuqujnTgFg=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUXjl-00FE4e-20; Fri, 01 May 2020 17:38:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Corey Minyard <minyard@acm.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Pragat Pandya <pragat.pandya@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Harald Seiler <hws@denx.de>,
        openipmi-developer@lists.sourceforge.net
Subject: [PATCH 04/14] docs: move IPMI.txt to the driver API book
Date:   Fri,  1 May 2020 17:37:48 +0200
Message-Id: <ae4edbc6753dc522cb93de36800978e3b58e0cfb.1588345503.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPMI is under drivers/char. This doc describes the kAPI
part of the IPMI (mainly).

So, move it to the driver-api directory and add it to the
corresponding index.rst file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/index.rst              | 1 +
 Documentation/{IPMI.txt => driver-api/ipmi.rst} | 0
 2 files changed, 1 insertion(+)
 rename Documentation/{IPMI.txt => driver-api/ipmi.rst} (100%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index dcc47c029f8e..6567187e7687 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -39,6 +39,7 @@ available subsections can be seen below.
    spi
    i2c
    ipmb
+   ipmi
    i3c/index
    interconnect
    devfreq
diff --git a/Documentation/IPMI.txt b/Documentation/driver-api/ipmi.rst
similarity index 100%
rename from Documentation/IPMI.txt
rename to Documentation/driver-api/ipmi.rst
-- 
2.25.4

