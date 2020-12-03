Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B1D2CD46A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 12:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388925AbgLCLPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 06:15:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8621 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbgLCLPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 06:15:54 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CmtXJ2smHz15WDR;
        Thu,  3 Dec 2020 19:14:40 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Dec 2020 19:15:00 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <support.opensource@diasemi.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] regulator: da9121: Mark some symbols with static keyword
Date:   Thu, 3 Dec 2020 19:26:35 +0800
Message-ID: <1606994795-36182-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warnings:

drivers/regulator/da9121-regulator.c:55:21: warning: symbol 'da9121_10A_2phase_current' was not declared. Should it be static?
drivers/regulator/da9121-regulator.c:63:21: warning: symbol 'da9121_6A_2phase_current' was not declared. Should it be static?
drivers/regulator/da9121-regulator.c:71:21: warning: symbol 'da9121_5A_1phase_current' was not declared. Should it be static?
drivers/regulator/da9121-regulator.c:79:21: warning: symbol 'da9121_3A_1phase_current' was not declared. Should it be static?
drivers/regulator/da9121-regulator.c:151:32: warning: symbol 'status_event_handling' was not declared. Should it be static?

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/regulator/da9121-regulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 3ead6a1..893512c 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -52,7 +52,7 @@ struct da9121_range {
 	int reg_max;
 };
 
-struct da9121_range da9121_10A_2phase_current = {
+static struct da9121_range da9121_10A_2phase_current = {
 	.val_min =  7000000,
 	.val_max = 20000000,
 	.val_stp =  1000000,
@@ -60,7 +60,7 @@ struct da9121_range da9121_10A_2phase_current = {
 	.reg_max = 14,
 };
 
-struct da9121_range da9121_6A_2phase_current = {
+static struct da9121_range da9121_6A_2phase_current = {
 	.val_min =  7000000,
 	.val_max = 12000000,
 	.val_stp =  1000000,
@@ -68,7 +68,7 @@ struct da9121_range da9121_6A_2phase_current = {
 	.reg_max = 6,
 };
 
-struct da9121_range da9121_5A_1phase_current = {
+static struct da9121_range da9121_5A_1phase_current = {
 	.val_min =  3500000,
 	.val_max = 10000000,
 	.val_stp =   500000,
@@ -76,7 +76,7 @@ struct da9121_range da9121_5A_1phase_current = {
 	.reg_max = 14,
 };
 
-struct da9121_range da9121_3A_1phase_current = {
+static struct da9121_range da9121_3A_1phase_current = {
 	.val_min = 3500000,
 	.val_max = 6000000,
 	.val_stp =  500000,
@@ -148,7 +148,7 @@ struct status_event_data {
  *
  * GPIO0/1/2 are not configured for use by default, so should not be seen.
  */
-const struct status_event_data status_event_handling[] = {
+static const struct status_event_data status_event_handling[] = {
 	DA9xxx_STATUS(0, 0, SG, 0, "Handled E_SG\n"),
 	DA9121_STATUS(0, 0, TEMP_CRIT, (REGULATOR_EVENT_OVER_TEMP|REGULATOR_EVENT_DISABLE), NULL),
 	DA9121_STATUS(0, 0, TEMP_WARN, REGULATOR_EVENT_OVER_TEMP, NULL),
-- 
2.6.2

