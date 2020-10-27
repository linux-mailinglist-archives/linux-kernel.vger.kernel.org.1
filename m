Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F82B29A8E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896937AbgJ0KCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:02:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896028AbgJ0Jvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:51:42 -0400
Received: from mail.kernel.org (ip5f5ad5af.dynamic.kabel-deutschland.de [95.90.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A1AB222C8;
        Tue, 27 Oct 2020 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603792301;
        bh=rdpIjUCn8I2jWacOW9CCQKWVEkvFnGocny38ubnytOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fB49CDxy6mDdMY3SYyaxLTqXsoGx6b1zmyKbCnA0/NvLX5eP01XYHxYjO81zhNP0V
         OErBV3RRLQtecfmpDT8cey5lMFOqvR4vSUSs8hfVa1gYRKY+ITjReSCuc6NLddr30J
         GoRXJlVdsKGtJZg59tq0nR3UrHdxaO2z9puaCcIM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXLdj-003FEn-6R; Tue, 27 Oct 2020 10:51:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.pan.linux@gmail.com>,
        Joerg Roedel <jroedel@suse.de>, Liu Yi L <yi.l.liu@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/32] docs: userspace-api: add iommu.rst to the index file
Date:   Tue, 27 Oct 2020 10:51:12 +0100
Message-Id: <cc55219a551e29848e2282cd8939a4115067234c.1603791716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603791716.git.mchehab+huawei@kernel.org>
References: <cover.1603791716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a new uAPI doc for IOMMU. Add it to the index file.
Should address this warning:

	.../Documentation/userspace-api/iommu.rst: WARNING: document isn't included in any toctree

Fixes: d0023e3ee28d ("docs: IOMMU user API")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/userspace-api/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 69fc5167e648..acd2cc2a538d 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -22,6 +22,7 @@ place where this information is gathered.
    spec_ctrl
    accelerators/ocxl
    ioctl/index
+   iommu
    media/index
 
 .. only::  subproject and html
-- 
2.26.2

