Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A282920A5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 01:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgJRXwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 19:52:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:40808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbgJRXwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 19:52:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "Cc"
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A430B264;
        Sun, 18 Oct 2020 23:52:18 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Mon, 19 Oct 2020 10:52:09 +1100
Subject: [PATCH] workqueue: export apply_workqueue_attrs()
cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     LKML <linux-kernel@vger.kernel.org>
Message-ID: <87blgzf5xy.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Lustre is a widely used cluster filesystem which is currently
out-of-tree, but work is underway to make it ready for upstream
submission.

Lustre needs apply_workqueue_attrs(), and for this reason that function
was exported in Commit 6106c0f82481 ("staging: lustre: lnet: convert
selftest to use workqueues").

Unfortuantely it was later (through an excess of caution) unexported by
Commit 2c9858ecbeb1 ("workqueue: Make alloc/apply/free_workqueue_attrs()
static"), which also marked the function static.

Subsequently in Commit 513c98d08682 ("workqueue: unconfine
alloc/apply/free_workqueue_attrs()") the "static" marking was removed
when it was realized that it is actually useful to some clients of
"workqueue", but it was not exported at this time.

Lustre has been making do with use of kallsyms_lookup_name() to get
access to this function when it isn't exported, but that loop-hole has
now been removed.

So: time to export the function again.

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 kernel/workqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 437935e7a199..ab593b20fb94 100644
=2D-- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4068,6 +4068,7 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
=20
 	return ret;
 }
+EXPORT_SYMBOL_GPL(apply_workqueue_attrs);
=20
 /**
  * wq_update_unbound_numa - update NUMA affinity of a wq for CPU hot[un]pl=
ug
=2D-=20
2.28.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl+M1SkOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbnQKQ/9HgoIiOI2vo95Er4XPeBn0ngvga0sS1K4Vzht
it68xtcFV6zJRp1foYDBikc/0NYHNDzGctcbVef4wypRYujI2e70ReARstPB8YVD
p8d8PCJ5T5ZSJcL0DDSYY15XeFOqgiALgUErPYWmNvanXrQNVpBEAforLyn4hJvf
lmRpbXTDHWJarKEYY56clsNivzq1NFa4aVUv30yX59vNzJ5qn8oaDiAoAwOlzjqJ
/Vangn2C0Z2ymaWyLGNkI/v5u6y9nZx2EaNL6wCRJ09PQsfI5RAwSUqZDEmA7MxS
vB58fLZNJ6o8snOqzt/J9jpRwHu6TfUzcbgPVVwMJOG8qJS88AXJSZWR03BZwEqo
TN2vryIN/mR0Q3QjlvWE9yFrOZOGCQ3lwUgXhkcTTwwHT6qBmcbw4tTYM1oaZ4o0
Qd3q/NxLUBHqwyVnsnALZX7daeV499aZF+Agf0iJDCWukmjvHjmeUexxXxcSqoAJ
y9d6fqkHVMUQxNw8l7rMi07T6hPajJhrCPZTNT9vYqtnNMYqi05/pWORk6VvmCBu
MqitPAkZAo8HEf5K9QbSvIXw4Ax2V7iiVe8QXHUSwlpnV7G6bcbXFWwX9iAc/4Fd
G4ndWYayRnlGtUBdQP9jVfMCufmJMv6iX8bRFSKL1URfzvtWhaOSsXcxTFH1CeoA
R/2MnK4=
=taI5
-----END PGP SIGNATURE-----
--=-=-=--
