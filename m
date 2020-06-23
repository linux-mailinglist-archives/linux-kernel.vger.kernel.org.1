Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B6F204A97
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 09:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731543AbgFWHJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 03:09:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731272AbgFWHJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:09:16 -0400
Received: from mail.kernel.org (unknown [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 642A6207D0;
        Tue, 23 Jun 2020 07:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592896155;
        bh=khBvS0uP1wWlDBUJ8A67iqIDEyy0uCUR0NtvDKkd8bQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S1RDWcSW0TuIUyJ3cKP7k3A82jGGU7999ulpaIMRnodWWhWWr5cGhSw//Yi8RgWgH
         uCysoKvw9zzPuery19dtzFkip+Xgx5bhoJ9i483cV5jvthoeR3pP7KwE/lj//FokEs
         dtxFnANLOw+kJkfVt+qszK9lpw9BLr6Law5AK/Ho=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnd3R-003qjZ-DE; Tue, 23 Jun 2020 09:09:13 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Akira Shimahara <akira215corp@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 13/15] docs: ABI: fix a typo when pointing to w1-generic.rst
Date:   Tue, 23 Jun 2020 09:09:09 +0200
Message-Id: <66b47dd879e8ae38b6db6d2f38780e00a29fc086.1592895969.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592895969.git.mchehab+huawei@kernel.org>
References: <cover.1592895969.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a typo there:

	w1_generic.rst -> w1-generic.rst

Causing the document reference to point to the wrong place.

Fixes: e2c94d6f5720 ("w1_therm: adding alarm sysfs entry")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-driver-w1_therm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index 076659d506f2..9b488c0afdfa 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -8,7 +8,7 @@ Description:
 		to device min/max capabilities. Values are integer as they are
 		stored in a 8bit register in the device. Lowest value is
 		automatically put to TL. Once set, alarms could be search at
-		master level, refer to Documentation/w1/w1_generic.rst for
+		master level, refer to Documentation/w1/w1-generic.rst for
 		detailed information
 Users:		any user space application which wants to communicate with
 		w1_term device
-- 
2.26.2

