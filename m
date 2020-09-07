Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C99E25FAAC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 14:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgIGMtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 08:49:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54574 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgIGMmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:42:40 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 087B3x3n025594;
        Mon, 7 Sep 2020 06:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599476639;
        bh=bpMQ9siMVCgyNlXexA6tKfgUJX3SmIx6i7F6npFEAMA=;
        h=From:To:CC:Subject:Date;
        b=IjkTFUdcplA41NeqNBe4jg+qyZ5rtQXThBYEEY82TLqSN5GaLfAlgzFg3H131XE3I
         GpdiBxdFdJhA4p+Ru9uzZOpyln2y0sJA4jPzu1ccyszlIRLvopSdJ0qQqbwx2BezhS
         MQzhAGLp85gMCpUAf3QPT79bujiLXlBnY2/xhp7U=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 087B3xep019448
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Sep 2020 06:03:59 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 06:03:59 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 06:03:59 -0500
Received: from sokoban.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 087B3v3F103242;
        Mon, 7 Sep 2020 06:03:58 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <nm@ti.com>, <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] firmware: ti_sci: allow frequency change for disabled clocks by default
Date:   Mon, 7 Sep 2020 14:03:57 +0300
Message-ID: <20200907110357.2972-1-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a clock is disabled, its frequency should be allowed to change as
it is no longer in use. Add a flag towards this to the firmware clock
API handler routines.

Tested-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/firmware/ti_sci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 53cee17d0115..39890665a975 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1124,7 +1124,8 @@ static int ti_sci_cmd_get_clock(const struct ti_sci_handle *handle, u32 dev_id,
 static int ti_sci_cmd_idle_clock(const struct ti_sci_handle *handle,
 				 u32 dev_id, u32 clk_id)
 {
-	return ti_sci_set_clock_state(handle, dev_id, clk_id, 0,
+	return ti_sci_set_clock_state(handle, dev_id, clk_id,
+				      MSG_FLAG_CLOCK_ALLOW_FREQ_CHANGE,
 				      MSG_CLOCK_SW_STATE_UNREQ);
 }
 
@@ -1143,7 +1144,8 @@ static int ti_sci_cmd_idle_clock(const struct ti_sci_handle *handle,
 static int ti_sci_cmd_put_clock(const struct ti_sci_handle *handle,
 				u32 dev_id, u32 clk_id)
 {
-	return ti_sci_set_clock_state(handle, dev_id, clk_id, 0,
+	return ti_sci_set_clock_state(handle, dev_id, clk_id,
+				      MSG_FLAG_CLOCK_ALLOW_FREQ_CHANGE,
 				      MSG_CLOCK_SW_STATE_AUTO);
 }
 
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
