Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD8A1AD395
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 02:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgDQAU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 20:20:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55552 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgDQAU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 20:20:56 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03H0KeSx002968;
        Thu, 16 Apr 2020 19:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587082840;
        bh=MmrL7c1P4QoUychSaHzqzrqt5M60o7cJWVq4Yc0OSjI=;
        h=From:To:CC:Subject:Date;
        b=N0O0iCnVsymFZGgsPIsioGMsvMDztXJ0PYo1zGRubWTAyRTUTF9Qdt8wg5lnbiNJr
         gOpT9CJ7GQtmNdW7eA2DZA03Grxzx2Pzu5JdhmiHzzsXdDixXctZgoz0LOxm7LclqG
         RExaPwRMLtClUMzQj4G2NsHWrsG7R6CzK0CrTmok=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03H0KeOf060155
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Apr 2020 19:20:40 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 16
 Apr 2020 19:20:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 16 Apr 2020 19:20:39 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03H0Kd4W020891;
        Thu, 16 Apr 2020 19:20:39 -0500
Received: from localhost ([10.250.70.56])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 03H0Kdj3060516;
        Thu, 16 Apr 2020 19:20:39 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/2] rproc core patches needed for TI K3 drivers
Date:   Thu, 16 Apr 2020 19:20:34 -0500
Message-ID: <20200417002036.24359-1-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn, Mathieu,

The following 2 patches were a revised version and split out from the
TI K3 R5F remoteproc support patch series [1]. The patches do use the
cleanup logic from  Mathieu's "remoteproc: Refactor function rproc_alloc()"
series. The patches address both of your comments.

Delta changes in individual patches.

regards
Suman

[1] https://patchwork.kernel.org/cover/11456367/
[2] https://patchwork.kernel.org/cover/11492005/

Loic Pallardy (1):
  remoteproc: Add prepare and unprepare ops

Suman Anna (1):
  remoteproc: Use a local copy for the name field

 drivers/remoteproc/remoteproc_core.c     | 21 +++++++++++++++++++--
 drivers/remoteproc/remoteproc_internal.h | 16 ++++++++++++++++
 include/linux/remoteproc.h               |  4 ++++
 3 files changed, 39 insertions(+), 2 deletions(-)

-- 
2.26.0

