Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B382D8F44
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 19:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgLMSdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 13:33:35 -0500
Received: from smtp-outgoing.laposte.net ([160.92.124.105]:42967 "EHLO
        smtp-outgoing.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbgLMSdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 13:33:35 -0500
X-mail-filterd: {"version":"1.2.0","queueID":"4CvCg925zrz10MQY","contextId":"65b9d905-9a9e-4f5c-9967-0d45e91ce3a2"}
Received: from outgoing-mail.laposte.net (localhost.localdomain [127.0.0.1])
        by mlpnf0103.laposte.net (SMTP Server) with ESMTP id 4CvCg925zrz10MQY;
        Sun, 13 Dec 2020 19:27:33 +0100 (CET)
X-mail-filterd: {"version":"1.2.0","queueID":"4CvCf7035Dz10MQV","contextId":"b7eefe2d-5cd9-468a-9753-f7e7ca878663"}
X-lpn-mailing: LEGIT
X-lpn-spamrating: 36
X-lpn-spamlevel: not-spam
X-lpn-spamcause: OK, (-100)(0000)gggruggvucftvghtrhhoucdtuddrgedujedrudekiedguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfntefrqffuvffgpdfqfgfvpdggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeggihhntggvnhhtucfuthgvhhhlrocuoehvihhntggvnhhtrdhsthgvhhhlvgeslhgrphhoshhtvgdrnhgvtheqnecuggftrfgrthhtvghrnhepteeivdehieejtdfgledvgffhvedtveejhefftdeukeeuieduudetjeektdeuffetnecukfhppeekkedruddvuddrudegledrgeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheprhhomhhurghlugdrsggvrhhgvghrihgvpdhinhgvthepkeekrdduvddurddugeelrdegledpmhgrihhlfhhrohhmpehvihhntggvnhhtrdhsthgvhhhlvgeslhgrphhoshhtvgdrnhgvthdprhgtphhtthhopehgvghofhhfsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhinhgtvghnthdrshhtvghhlhgvsehlrghpohhsthgvrdhnvghtpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Received: from romuald.bergerie (unknown [88.121.149.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mlpnf0103.laposte.net (SMTP Server) with ESMTPSA id 4CvCf7035Dz10MQV;
        Sun, 13 Dec 2020 19:26:36 +0100 (CET)
Received: from radicelle.bergerie (radicelle.bergerie [192.168.124.12])
        by romuald.bergerie (Postfix) with ESMTPS id 1BD413DF32AF;
        Sun, 13 Dec 2020 19:26:36 +0100 (CET)
Received: from vincent by radicelle.bergerie with local (Exim 4.94)
        (envelope-from <vincent@radicelle.bergerie>)
        id 1koW4p-00060T-P4; Sun, 13 Dec 2020 19:26:35 +0100
From:   =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>,
        Geoff Levand <geoff@infradead.org>,
        Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH] powerpc/ps3: use dma_mapping_error()
Date:   Sun, 13 Dec 2020 19:26:22 +0100
Message-Id: <20201213182622.23047-1-vincent.stehle@laposte.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=lpn-wlmd; t=1607884056; bh=YIAg0xdLhTfsQSKbEzRITi543Hxi26DWrI5pNv7EPQE=; h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding; b=WJOsG7SG5zZNX67Z4deYt5Rmbp3b9eZYAjCg05EL1kfAvwu8aQDB2Nn/ztdbmuFm4YvktmSdYSWMGLLqHNXQq9C+1DF6viKxvEm9BIHD+JYx3cQniyZrKoRN7exjE35fOVlMxa5EllYBF+eipx4L1ctyqpk3Lx896/3vveZoJizAnCHF3IEws6PCrISBSalBOQicKANmOMXiWTBkodBqszB4VVC7BD5bDMfd/NlAyWVJBIzTM452dno4qzaBz4AcMHNErDkCyliV7iMkkGC3GSdjFKWQUDYZ1r8SEKSSggXd9rtMqzRNtOZNbk/nPR1zM80jYjBWP5/6UNpvFnkyvg==;
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA address returned by dma_map_single() should be checked with
dma_mapping_error(). Fix the ps3stor_setup() function accordingly.

Fixes: 80071802cb9c ("[POWERPC] PS3: Storage Driver Core")
Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@laposte.net>
Cc: Geoff Levand <geoff@infradead.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/ps3/ps3stor_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ps3/ps3stor_lib.c b/drivers/ps3/ps3stor_lib.c
index 333ba83006e48..a12a1ad9b5fe3 100644
--- a/drivers/ps3/ps3stor_lib.c
+++ b/drivers/ps3/ps3stor_lib.c
@@ -189,7 +189,7 @@ int ps3stor_setup(struct ps3_storage_device *dev, irq=
_handler_t handler)
 	dev->bounce_lpar =3D ps3_mm_phys_to_lpar(__pa(dev->bounce_buf));
 	dev->bounce_dma =3D dma_map_single(&dev->sbd.core, dev->bounce_buf,
 					 dev->bounce_size, DMA_BIDIRECTIONAL);
-	if (!dev->bounce_dma) {
+	if (dma_mapping_error(&dev->sbd.core, dev->bounce_dma)) {
 		dev_err(&dev->sbd.core, "%s:%u: map DMA region failed\n",
 			__func__, __LINE__);
 		error =3D -ENODEV;
--=20
2.29.2

