Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0989A2B4BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbgKPRAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:00:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42356 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732426AbgKPRAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:00:13 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605546010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ANWzTaMQlww6MqMShYG6WZmz8RIRZQIvfTxrKe97RpI=;
        b=wjZIy7yWAxhnjYSDvbpF/DGwu2L5B0BpTgPBhXBIkABYGZNzvppbFHdcjKNMn+bXq3HveQ
        yu24Vc0+3aUBnidJUOO+HLQoCB3fPAfJtjiDMUf6qoF9DLcGKWEVD+5ma6dvECjyFYypOO
        1ohluFjmX1eXTWz9eE0bW4ZiQqLam6ZzUyciEmsG5/BezGZUazUTjalQprht1YXztqHQpG
        fvHsGl5k33KK/rXF8+HV72fPxyiJZF8vOr9G+37heNQlfxAMszPkWCN+ZyCdsbF3RP8Av4
        H8Tw7t9eV8EvkVrki31/OILMui1zMeMUDYAfjhoxe1wfvEMPeOi6XYvbPS/MCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605546010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ANWzTaMQlww6MqMShYG6WZmz8RIRZQIvfTxrKe97RpI=;
        b=8VGsz9AeygaKkeByCKxiVfjXdF98qDxGX+kwNkYk9Ip6vqTtNcLTwGXNTi6FO0C/Fr3r3k
        RXWsqzJ4QVOSmvDg==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] rapidio: Remove unused rio_get_asm() and rio_get_device()
Date:   Mon, 16 Nov 2020 18:00:04 +0100
Message-Id: <20201116170004.420143-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions rio_get_asm() and rio_get_device() are globally exported
but have almost no users in tree. The only user is rio_init_mports()
which invokes it via rio_init().
rio_init() iterates over every registered device and invokes
rio_fixup_device(). It looks like a fixup function which should perform
a "change" to the device but does nothing.
It has been like this since its introduction in commit
   394b701ce4fbf ("[PATCH] RapidIO support: core base")

which was merged into v2.6.15-rc1.

Remove rio_init() because the performed fixup function
(rio_fixup_device()) does nothing.
Remove rio_get_asm() and rio_get_device() which have no callers now.

Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Alexandre Bounine <alex.bou9@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/rapidio/rio.c   | 81 -----------------------------------------
 include/linux/rio_drv.h |  3 --
 2 files changed, 84 deletions(-)

diff --git a/drivers/rapidio/rio.c b/drivers/rapidio/rio.c
index 606986c5ba2c9..c2b79736a92b3 100644
--- a/drivers/rapidio/rio.c
+++ b/drivers/rapidio/rio.c
@@ -1412,71 +1412,6 @@ rio_mport_get_feature(struct rio_mport * port, int l=
ocal, u16 destid,
 }
 EXPORT_SYMBOL_GPL(rio_mport_get_feature);
=20
-/**
- * rio_get_asm - Begin or continue searching for a RIO device by vid/did/a=
sm_vid/asm_did
- * @vid: RIO vid to match or %RIO_ANY_ID to match all vids
- * @did: RIO did to match or %RIO_ANY_ID to match all dids
- * @asm_vid: RIO asm_vid to match or %RIO_ANY_ID to match all asm_vids
- * @asm_did: RIO asm_did to match or %RIO_ANY_ID to match all asm_dids
- * @from: Previous RIO device found in search, or %NULL for new search
- *
- * Iterates through the list of known RIO devices. If a RIO device is
- * found with a matching @vid, @did, @asm_vid, @asm_did, the reference
- * count to the device is incrememted and a pointer to its device
- * structure is returned. Otherwise, %NULL is returned. A new search
- * is initiated by passing %NULL to the @from argument. Otherwise, if
- * @from is not %NULL, searches continue from next device on the global
- * list. The reference count for @from is always decremented if it is
- * not %NULL.
- */
-struct rio_dev *rio_get_asm(u16 vid, u16 did,
-			    u16 asm_vid, u16 asm_did, struct rio_dev *from)
-{
-	struct list_head *n;
-	struct rio_dev *rdev;
-
-	WARN_ON(in_interrupt());
-	spin_lock(&rio_global_list_lock);
-	n =3D from ? from->global_list.next : rio_devices.next;
-
-	while (n && (n !=3D &rio_devices)) {
-		rdev =3D rio_dev_g(n);
-		if ((vid =3D=3D RIO_ANY_ID || rdev->vid =3D=3D vid) &&
-		    (did =3D=3D RIO_ANY_ID || rdev->did =3D=3D did) &&
-		    (asm_vid =3D=3D RIO_ANY_ID || rdev->asm_vid =3D=3D asm_vid) &&
-		    (asm_did =3D=3D RIO_ANY_ID || rdev->asm_did =3D=3D asm_did))
-			goto exit;
-		n =3D n->next;
-	}
-	rdev =3D NULL;
-      exit:
-	rio_dev_put(from);
-	rdev =3D rio_dev_get(rdev);
-	spin_unlock(&rio_global_list_lock);
-	return rdev;
-}
-EXPORT_SYMBOL_GPL(rio_get_asm);
-
-/**
- * rio_get_device - Begin or continue searching for a RIO device by vid/did
- * @vid: RIO vid to match or %RIO_ANY_ID to match all vids
- * @did: RIO did to match or %RIO_ANY_ID to match all dids
- * @from: Previous RIO device found in search, or %NULL for new search
- *
- * Iterates through the list of known RIO devices. If a RIO device is
- * found with a matching @vid and @did, the reference count to the
- * device is incrememted and a pointer to its device structure is returned.
- * Otherwise, %NULL is returned. A new search is initiated by passing %NULL
- * to the @from argument. Otherwise, if @from is not %NULL, searches
- * continue from next device on the global list. The reference count for
- * @from is always decremented if it is not %NULL.
- */
-struct rio_dev *rio_get_device(u16 vid, u16 did, struct rio_dev *from)
-{
-	return rio_get_asm(vid, did, RIO_ANY_ID, RIO_ANY_ID, from);
-}
-EXPORT_SYMBOL_GPL(rio_get_device);
-
 /**
  * rio_std_route_add_entry - Add switch route table entry using standard
  *   registers defined in RIO specification rev.1.3
@@ -2106,20 +2041,6 @@ int rio_mport_scan(int mport_id)
 	return rc;
 }
=20
-static void rio_fixup_device(struct rio_dev *dev)
-{
-}
-
-static int rio_init(void)
-{
-	struct rio_dev *dev =3D NULL;
-
-	while ((dev =3D rio_get_device(RIO_ANY_ID, RIO_ANY_ID, dev)) !=3D NULL) {
-		rio_fixup_device(dev);
-	}
-	return 0;
-}
-
 static struct workqueue_struct *rio_wq;
=20
 struct rio_disc_work {
@@ -2206,8 +2127,6 @@ int rio_init_mports(void)
 	kfree(work);
=20
 no_disc:
-	rio_init();
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rio_init_mports);
diff --git a/include/linux/rio_drv.h b/include/linux/rio_drv.h
index d637742e50399..e49c32b0f3946 100644
--- a/include/linux/rio_drv.h
+++ b/include/linux/rio_drv.h
@@ -444,9 +444,6 @@ static inline void rio_set_drvdata(struct rio_dev *rdev=
, void *data)
 /* Misc driver helpers */
 extern u16 rio_local_get_device_id(struct rio_mport *port);
 extern void rio_local_set_device_id(struct rio_mport *port, u16 did);
-extern struct rio_dev *rio_get_device(u16 vid, u16 did, struct rio_dev *fr=
om);
-extern struct rio_dev *rio_get_asm(u16 vid, u16 did, u16 asm_vid, u16 asm_=
did,
-				   struct rio_dev *from);
 extern int rio_init_mports(void);
=20
 #endif				/* LINUX_RIO_DRV_H */
--=20
2.29.2

