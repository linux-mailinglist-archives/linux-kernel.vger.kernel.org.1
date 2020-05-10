Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6720E1CC715
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 08:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgEJGHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 02:07:07 -0400
Received: from mailomta32-re.btinternet.com ([213.120.69.125]:41956 "EHLO
        re-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725764AbgEJGHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 02:07:07 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20200510060705.EELH21962.re-prd-fep-044.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Sun, 10 May 2020 07:07:05 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=j.oldman998@btinternet.com
X-Originating-IP: [31.53.141.224]
X-OWM-Source-IP: 31.53.141.224 (GB)
X-OWM-Env-Sender: j.oldman998@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrkeejgddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofestddtredtredttdenucfhrhhomheplfhohhhnucfqlhgumhgrnhcuoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqnecuggftrfgrthhtvghrnhepgeeftdfhfeeuiefhgfekfeethedutddtfeduteevleevfedvfefhjeeijefhgffgnecukfhppeefuddrheefrddugedurddvvdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohephhgvnhhrhidrhhhomhgvpdhinhgvthepfedurdehfedrudeguddrvddvgedpmhgrihhlfhhrohhmpeeojhhohhhnrdholhgumhgrnhesphholhgvhhhilhhlrdgtohdruhhkqedprhgtphhtthhopeeosggtmhdqkhgvrhhnvghlqdhfvggvuggsrggtkhdqlhhishhtsegsrhhorggutghomhdrtghomheqpdhrtghpthhtohepoeguvghvvghlsegurhhivhgvrhguvghvrdhoshhuohhslhdrohhrgheqpdhrtghpthhtohepoehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgheqpdhrtghpthhtohepoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqpdhrtghpthhtohepoehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdr
        ihhnfhhrrgguvggrugdrohhrgheqpdhrtghpthhtohepoehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehlihhnuhigqdhrphhiqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgheqpdhrtghpthhtohepoehnshgrvghniihjuhhlihgvnhhnvgesshhushgvrdguvgeq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from henry.home (31.53.141.224) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as j.oldman998@btinternet.com)
        id 5E3A16DE0FB0AA7B; Sun, 10 May 2020 07:07:05 +0100
From:   John Oldman <john.oldman@polehill.co.uk>
To:     nsaenzjulienne@suse.de
Cc:     gregkh@linuxfoundation.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        John Oldman <john.oldman@polehill.co.uk>
Subject: [PATCH V2] staging: vc04_services: vchiq_connected.c: Block comment alignment
Date:   Sun, 10 May 2020 07:06:45 +0100
Message-Id: <20200510060645.10159-1-john.oldman@polehill.co.uk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style issue

Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
---
v1: Initial attempt.
V2: Resubmitted with shorter comment line, as suggested by Greg KH.

This patch clears the checkpatch.pl "Block comments should align the * on each line" warning.

 .../interface/vchiq_arm/vchiq_connected.c     | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
index 1640906e3929..993535bbc479 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
@@ -15,10 +15,10 @@ static   int                        g_once_init;
 static   struct mutex               g_connected_mutex;
 
 /****************************************************************************
-*
-* Function to initialize our lock.
-*
-***************************************************************************/
+ *
+ * Function to initialize our lock.
+ *
+ ***************************************************************************/
 
 static void connected_init(void)
 {
@@ -29,13 +29,13 @@ static void connected_init(void)
 }
 
 /****************************************************************************
-*
-* This function is used to defer initialization until the vchiq stack is
-* initialized. If the stack is already initialized, then the callback will
-* be made immediately, otherwise it will be deferred until
-* vchiq_call_connected_callbacks is called.
-*
-***************************************************************************/
+ *
+ * This function is used to defer initialization until the vchiq stack is
+ * initialized. If the stack is already initialized, then the callback will
+ * be made immediately, otherwise it will be deferred until
+ * vchiq_call_connected_callbacks is called.
+ *
+ ***************************************************************************/
 
 void vchiq_add_connected_callback(VCHIQ_CONNECTED_CALLBACK_T callback)
 {
@@ -64,11 +64,11 @@ void vchiq_add_connected_callback(VCHIQ_CONNECTED_CALLBACK_T callback)
 }
 
 /****************************************************************************
-*
-* This function is called by the vchiq stack once it has been connected to
-* the videocore and clients can start to use the stack.
-*
-***************************************************************************/
+ *
+ * This function is called by the vchiq stack once it has been connected to
+ * the videocore and clients can start to use the stack.
+ *
+ ***************************************************************************/
 
 void vchiq_call_connected_callbacks(void)
 {
-- 
2.17.1

