Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193972CB5E9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgLBHuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLBHuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:50:22 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE59C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 23:49:41 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id r24so2575338lfm.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 23:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4MbluI2EBYLLjoZ+Dnq73zAtkfEntDeSUxg7LRfX/7U=;
        b=a7JFM68PAnUS7ha6TLRqHpumAW9CEDdDTHEeaIXkMrzYmm4yqaG5CSm684DW9k72Jr
         iJr9zE92aS6ZtUgk4oux/AqSvusUB8X4vXI8E29tQCetyaFFiW/hAyUdVbo6H5q+PySL
         jC2Cn3lQAXA4tzkzlO+PdzDvFDyobCX42rdX+BOtTxKHSCohN92jwGp0atsVuBtBjmvf
         BIQiR6M57/JOzLyJVM3vafsvEVa8lpPfaoC6skRtybQzIaph4yppLWvf+BDTyiYQcNef
         fAV6S07x/rNKAzBd+Y1fvwCOIyUQQ1/930dTYB5esg3M9YNRPscYlhlzmOyBytVHcIkc
         ARbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4MbluI2EBYLLjoZ+Dnq73zAtkfEntDeSUxg7LRfX/7U=;
        b=NS8NDzaool0wK2nGEohDFJfWF+oTDHxYZaVuo4Eos/akGNXZm4b8/YAuuWaUVEgL/m
         QQ11GIFpUPUKDBUNBU3mi41UqI6fUWC1M39rAYk5GnSaiGsGVEwronJmj93fc3Kqexwg
         tXchDCKhoOucBmAsy3qc/vYyQ438QGP09U92B1q+ltoEoj4anSMcwFOne2HilPOMIM1/
         HAWJ6ofybvaFDD323nv5LiqAYbtu7Hq0nPRqgKS2QQ2+8M/qkGOUfaf5aERdaIy3Y37k
         v+SlEuQ2sm6cgYq0gXUCW9CVrrKIid5wutngoM3gtf1QaY+wjsNjY54dhlQU01NAvwDs
         j9EA==
X-Gm-Message-State: AOAM530jHJS8OSPhtj60aaRE6fU6yVt0l13e2q2emJ+n9Yw1I10iADQq
        4OZliDyqAUHnCxrAfL95m5+6ABdHSMk=
X-Google-Smtp-Source: ABdhPJxIDFUvTh3Xw2bZt6/E5X4IvBEDMW4fF51eb6tedqM6nyYxmBi8zZwh9XXKRNqlDekXsiro7A==
X-Received: by 2002:a19:230d:: with SMTP id j13mr771674lfj.378.1606895379981;
        Tue, 01 Dec 2020 23:49:39 -0800 (PST)
Received: from spblnx124 ([185.204.20.3])
        by smtp.gmail.com with ESMTPSA id q191sm241352ljb.139.2020.12.01.23.49.38
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Dec 2020 23:49:39 -0800 (PST)
Date:   Wed, 2 Dec 2020 10:49:38 +0300
From:   Andrew Klychkov <andrew.a.klychkov@gmail.com>
To:     corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: fix typos in process/kernel-docs.rst
Message-ID: <20201202074938.GA35075@spblnx124.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two typos in kernel-docs.rst

Signed-off-by: Andrew Klychkov <andrew.a.klychkov@gmail.com>
---
 Documentation/process/kernel-docs.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 64786e5..22d9ace 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -90,7 +90,7 @@ On-line docs
       :Date: 2008
       :Keywords: patches, review process, types of submissions, basic rules, case studies
       :Description: This paper gives several experience values on what types of patches
-        there are and how likley they get merged.
+        there are and how likely they get merged.
       :Abstract:
         [...]. This paper examines some common problems for
         submitting larger changes and some strategies to avoid problems.
@@ -328,7 +328,7 @@ On-line docs
         block devices, hardware interrupts, scsi, DMA, access to user memory,
         memory allocation, timers.
       :Description: A guide designed to help you get up to speed on the
-        concepts that are not intuitevly obvious, and to document the internal
+        concepts that are not intuitively obvious, and to document the internal
         structures of Linux.
 
     * Title: **Dynamic Kernels: Modularized Device Drivers**
-- 
1.8.3.1

