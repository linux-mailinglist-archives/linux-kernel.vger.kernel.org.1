Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D7229741E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbgJWQdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:33:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S461349AbgJWQds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:48 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E99952245A;
        Fri, 23 Oct 2020 16:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470827;
        bh=0/UWmo2OH4egkc0d+jfY9c0BJNYEW+7AH+ub+Opgj/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZg1q7gFJGgfohNDBGgJzKht142NNlZJvDf+/ueBEcZbLX7nxjWOUlEQG7pLuBFJT
         EwLttIs3fnmNJXhFhUrbhaMlIiADJbSo0TGwEMxAjySl1Q8cfAiq3gjipgzgL3Xmsr
         0MkwmF6SE6sYugqsTk3nocEVTROEFIQmm5w1GXxo=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00e-002AvW-Pv; Fri, 23 Oct 2020 18:33:44 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 05/56] s390: fix kernel-doc markups
Date:   Fri, 23 Oct 2020 18:32:52 +0200
Message-Id: <c4bf95fbd9c33a92eb60ef3d696d4cbe27882079.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix one typo:
	ccw driver -> ccw_driver

and one function rename.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 arch/s390/include/asm/ccwdev.h | 2 +-
 arch/s390/include/asm/cio.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/ccwdev.h b/arch/s390/include/asm/ccwdev.h
index c0be5fe1ddba..069709b8e9e7 100644
--- a/arch/s390/include/asm/ccwdev.h
+++ b/arch/s390/include/asm/ccwdev.h
@@ -115,7 +115,7 @@ enum uc_todo {
 };
 
 /**
- * struct ccw driver - device driver for channel attached devices
+ * struct ccw_driver - device driver for channel attached devices
  * @ids: ids supported by this driver
  * @probe: function called on probe
  * @remove: function called on remove
diff --git a/arch/s390/include/asm/cio.h b/arch/s390/include/asm/cio.h
index 5c58756d6476..23dceb8d0453 100644
--- a/arch/s390/include/asm/cio.h
+++ b/arch/s390/include/asm/cio.h
@@ -329,7 +329,7 @@ struct ccw_dev_id {
 };
 
 /**
- * ccw_device_id_is_equal() - compare two ccw_dev_ids
+ * ccw_dev_id_is_equal() - compare two ccw_dev_ids
  * @dev_id1: a ccw_dev_id
  * @dev_id2: another ccw_dev_id
  * Returns:
-- 
2.26.2

