Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3401A11DC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 18:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgDGQj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 12:39:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:57661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728667AbgDGQjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586277585;
        bh=mGcNn/hciDAa1MtlzL+yKAo9BVtXHK66bYlr9Vx0ozY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cn6DZ2WjYtKs62CRZOZRNdXp5CDg2YFifosNGXDjunNRe/aXDW/ktp7jR2sdLC5z9
         r4t2W2nVixSJNC/4ERTtvFbhcD3qfm3VYeS3/+i1u+Zk0Xglbv7Tx0jv/YV6umIC+W
         d0WYqCPZL6lqiGRewiUsD6exyP55On0xPpIb9NVU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MZCfD-1jqz2W1KwT-00V5jc; Tue, 07 Apr 2020 18:39:45 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] staging: vt6656: Remove unnecessary local variable initialization
Date:   Tue,  7 Apr 2020 18:39:15 +0200
Message-Id: <20200407163915.7491-3-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407163915.7491-1-oscar.carter@gmx.com>
References: <20200407163915.7491-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JrTaUvLuKsciovcEVi75pTrLYdNbPfCu5hJeSr2pBmookCPFny6
 neiE3yExWHRogwpjE3iAY3L7iG8M75o3peug+ZHIF+JDfu6HEumkc7xe1cyIo5UGIk2IHMd
 DyU4hsDiOCSbZncae30RHZWClOb/duMhJytWUfOTdA85jkUozZuRrrfU4K4QEpRD8FVKy3o
 dPjSxZFHf1O8ewXr0qh+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nng2L4oE85I=:zehfCa5Fv7gVuVuM/+8MD5
 tKo+2MJhT7R8zpgpYizHQEaGVj3f79mNY687TBmJGsKWfen8ENPDVXxxzYrej0r9tteSDeJDi
 J0f9MwwUbUE+o/3KKFXBZmnQkJO10U0Jk50HnsSQletDZt5yO8s6OcSNhSBguWYxo4dtsj/BM
 431ZQwmc/prQHSL91rSPv9frVBpynlEbhTCALH7eOBom9/39nYNHn3dqxwEHzHe9T+KXInn3F
 +TmacHYiniiLhGgW/4eArAmUoP1R5eoX/Ifl06bRc4kNLZzR+7gYW7WbiqnJlpweObxIE8m1T
 RZ01yttXL9YFtNOwKWXaLMfx/YYJoSzWR+Rdij2xhRxzDIWnT4R3pxK01pESpGTl2djJ3PwrQ
 XgbtQxJDvTAKTBBF492KaIzcIowYAZ3EtdjVCRPru49bXLbbt30Flk0olvm9K/daq4CoPX5CR
 qYsGqlCZwQYXhVgxAyNVFdkcPahF3hNnnzUiaLtZkXCOHb9bimv0NJa2bHqVWx1Ie6C0K+GAH
 WhbkErZKwLVWzT4UP0t8XzqKSKHN7KjDf768hszM34Nh+PjyPOpnjHw/rDkth/h29bL0AsS9O
 8fi4aHxybI72PtaFcovvEd+R+UhcBMqSAgzuf7FbHkUQ2Tud2DepyFhTbzeorSwsmF51eJsRB
 VyGCctny7NxXgA570MmP89pHncJ3xVNxMyy+oalRmVnGLjCmDNzw20n5Vs/vhAHCOtZLOARUN
 As1pOATkJrksZuN9pQvk2Z3ejQLF8/U0ElfzNOr0iikHDyMFQJsAfrF4ewpGYLiBZ8Z5QWjy6
 Z8ZWKUEbhBgAEcQj8KCldzUz/Nnda/IC0IINZGvzGrrgutDNiS29eREtAyWRaMxLXkYxC+5jN
 R30zIwRQzIOASCe5lQcIIjvImSPsJelFNBeD0cNMmu6fooFGkh6NPzMVGxcAdwSP03ct72rUc
 ZxLnTBH1FgVRM3+Wf4BhM3Hv60G3F1HYqRKD/ad1Z6hs1Mkhqe2AgEekCepI+0K9cbS3L+pWd
 ei4iB1hvFoRffcZWYCyVdXoBMPOFwGJmBSDjYo1oNy9Ks6goNwMKtagOHEgD1gTuJCjiotXVK
 0qx97J6JBnyBpiLlsAyBmn4H2xDwzhy0epFEFFPVCns9AXur0tT1GyLyYSGoY/hVHPKv7m4Qw
 sgGYyRyM6mvrRE7YGISOaa8bjNjSR5Obza/MCnxQC6NYnt8CnNNRJ2HeNb1lUOyrLSu8uCmZk
 goUCWlTs2aSOKQkEs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't initialize the rate variable as it is set a few lines later.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index 092e56668a09..5d9bc97916a5 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -135,7 +135,7 @@ unsigned int vnt_get_frame_time(u8 preamble_type, u8 p=
kt_type,
 {
 	unsigned int frame_time;
 	unsigned int preamble;
-	unsigned int rate =3D 0;
+	unsigned int rate;

 	if (tx_rate > RATE_54M)
 		return 0;
=2D-
2.20.1

