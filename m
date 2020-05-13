Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA57A1D1348
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 14:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbgEMMyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 08:54:18 -0400
Received: from mailomta9-re.btinternet.com ([213.120.69.102]:11884 "EHLO
        re-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728591AbgEMMyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:54:17 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20200513125415.BCRW8887.re-prd-fep-048.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 13 May 2020 13:54:15 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=j.oldman998@btinternet.com
X-Originating-IP: [31.53.141.224]
X-OWM-Source-IP: 31.53.141.224 (GB)
X-OWM-Env-Sender: j.oldman998@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrleeggdehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofestddtredtredttdenucfhrhhomheplfhohhhnucfqlhgumhgrnhcuoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqnecuggftrfgrthhtvghrnhepgeeftdfhfeeuiefhgfekfeethedutddtfeduteevleevfedvfefhjeeijefhgffgnecukfhppeefuddrheefrddugedurddvvdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohephhgvnhhrhidrhhhomhgvpdhinhgvthepfedurdehfedrudeguddrvddvgedpmhgrihhlfhhrohhmpeeojhhohhhnrdholhgumhgrnhesphholhgvhhhilhhlrdgtohdruhhkqedprhgtphhtthhopeeosggtmhdqkhgvrhhnvghlqdhfvggvuggsrggtkhdqlhhishhtsegsrhhorggutghomhdrtghomheqpdhrtghpthhtohepoeguvghvvghlsegurhhivhgvrhguvghvrdhoshhuohhslhdrohhrgheqpdhrtghpthhtohepoehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgheqpdhrtghpthhtohepoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqpdhrtghpthhtohepoehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdr
        ihhnfhhrrgguvggrugdrohhrgheqpdhrtghpthhtohepoehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehlihhnuhigqdhrphhiqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgheqpdhrtghpthhtohepoehnshgrvghniihjuhhlihgvnhhnvgesshhushgvrdguvgeq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from henry.home (31.53.141.224) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as j.oldman998@btinternet.com)
        id 5E3A16DE1046F7AE; Wed, 13 May 2020 13:54:15 +0100
From:   John Oldman <john.oldman@polehill.co.uk>
To:     nsaenzjulienne@suse.de
Cc:     gregkh@linuxfoundation.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        John Oldman <john.oldman@polehill.co.uk>
Subject: [PATCH V4] staging: vc04_services: Block comment alignment
Date:   Wed, 13 May 2020 13:54:05 +0100
Message-Id: <20200513125405.28242-1-john.oldman@polehill.co.uk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style issue reported by checkpatch.pl
This patch clears the checkpatch.pl "Block comments should align
the * on each line" warning.
Also cleared /****** and blank line.

Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
---
v1: Initial attempt.
v2: Resubmitted with shorter comment line, as suggested by Greg KH.
v3: Resubmitted with descriptiuon text moved into the comment area.
v4: Resubmitted with /****** and blank lines removed.

 .../interface/vchiq_arm/vchiq_connected.c     | 33 +++++++------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
index 1640906e3929..79b75efa6868 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
@@ -14,12 +14,7 @@ static   VCHIQ_CONNECTED_CALLBACK_T g_deferred_callback[MAX_CALLBACKS];
 static   int                        g_once_init;
 static   struct mutex               g_connected_mutex;
 
-/****************************************************************************
-*
-* Function to initialize our lock.
-*
-***************************************************************************/
-
+/* Function to initialize our lock */
 static void connected_init(void)
 {
 	if (!g_once_init) {
@@ -28,15 +23,12 @@ static void connected_init(void)
 	}
 }
 
-/****************************************************************************
-*
-* This function is used to defer initialization until the vchiq stack is
-* initialized. If the stack is already initialized, then the callback will
-* be made immediately, otherwise it will be deferred until
-* vchiq_call_connected_callbacks is called.
-*
-***************************************************************************/
-
+/*
+ * This function is used to defer initialization until the vchiq stack is
+ * initialized. If the stack is already initialized, then the callback will
+ * be made immediately, otherwise it will be deferred until
+ * vchiq_call_connected_callbacks is called.
+ */
 void vchiq_add_connected_callback(VCHIQ_CONNECTED_CALLBACK_T callback)
 {
 	connected_init();
@@ -63,13 +55,10 @@ void vchiq_add_connected_callback(VCHIQ_CONNECTED_CALLBACK_T callback)
 	mutex_unlock(&g_connected_mutex);
 }
 
-/****************************************************************************
-*
-* This function is called by the vchiq stack once it has been connected to
-* the videocore and clients can start to use the stack.
-*
-***************************************************************************/
-
+/*
+ * This function is called by the vchiq stack once it has been connected to
+ * the videocore and clients can start to use the stack.
+ */
 void vchiq_call_connected_callbacks(void)
 {
 	int i;
-- 
2.17.1

