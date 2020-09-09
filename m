Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0F62633CA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 19:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbgIIRKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 13:10:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730330AbgIIPgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:00 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ADFC20672;
        Wed,  9 Sep 2020 13:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599659730;
        bh=A4xze2O/XEmpibAWCPJ5C9vaARnb4IKBSgOmzWAWWQA=;
        h=From:To:Cc:Subject:Date:From;
        b=a0riKZWL4WjQfSwJ1o4IBW5ekIbaZ8lrIujK6CtVAOFmPSKC1M/Gda3CbpFR+vQxL
         Y7kTi2TB4t6C3zSn7QIfrlmfBniVbYjGql9tKxRaFcT1pH1KCI5ZjPytS75bX2y4GY
         cxdiDFfZjeOOWzTl0fIRUemF4w0TDCYjYNZDg5UU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0ZK-00DT04-Dm; Wed, 09 Sep 2020 15:55:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2] media: camera-sensor.rst: fix a doc build warning
Date:   Wed,  9 Sep 2020 15:55:25 +0200
Message-Id: <7f002687c5c310dff305057a9f94bcb32a28269a.1599659722.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Documentation/driver-api/media/camera-sensor.rst:123: WARNING: Inline literal start-string without end-string.

There's a missing blank line over there.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/media/camera-sensor.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/media/camera-sensor.rst b/Documentation/driver-api/media/camera-sensor.rst
index bd81c2cc37f8..4d1ae12b9b4d 100644
--- a/Documentation/driver-api/media/camera-sensor.rst
+++ b/Documentation/driver-api/media/camera-sensor.rst
@@ -123,7 +123,7 @@ Control framework
 ``v4l2_ctrl_handler_setup()`` function may not be used in the device's runtime
 PM ``runtime_resume`` callback, as it has no way to figure out the power state
 of the device. This is because the power state of the device is only changed
-after the power state transition has taken place. The ``s_ctrl``callback can be
+after the power state transition has taken place. The ``s_ctrl`` callback can be
 used to obtain device's power state after the power state transition:
 
 .. c:function::
-- 
2.26.2

