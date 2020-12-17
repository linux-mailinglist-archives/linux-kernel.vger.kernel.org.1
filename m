Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0272DD5CA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgLQRMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:12:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:33275 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728161AbgLQRMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608225073;
        bh=mrZLV+cXitWLzgg+N9fFR+hCUM3zsDp+hsTgiXTQg44=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=DpX52eK9DKIBQqWMzdFupXs5XuRPF9MbvRNF+4Ksv5+4A8uYCRfF3s4aVcLpZjT7t
         Bw0wSLpP6WwYx1uchiRMZfptiRNcHN0J7JveEU72qkl/mSyMmqqGnD/bwYU7OGE8oz
         qiEMnFga4QKZdDI3pe2KF/rR2g8l1jdpP9Fbdmdg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.140.151]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOREi-1kSMkJ2aac-00Pxse; Thu, 17
 Dec 2020 18:11:13 +0100
Date:   Thu, 17 Dec 2020 18:11:11 +0100
From:   Helge Deller <deller@gmx.de>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: add new warning when lookup_symbol_name() is used
Message-ID: <20201217171111.GA8295@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:hySuwVl6dOSZ5oGzhdzvZ+4opIUYtIg1h52+D+UF6JenP2QP2Lq
 aaKXwKHN+dctSazxTdsNwoFjuJtDnZh4iPSOtEnpAp0arTNut/P95Q1I2VHM0KTZ8bm61D3
 zvP4L1xwbvENkdgUae7p8hEIpGaoNRU5pf5QADbXqPjuPZl4k3IgafQSnk9dpc421A3zNO1
 4OOFhXkIioYei5iRw8iSg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4y5bPBBN6k0=:5MiO2rrN2164j9sa0rMynX
 Rgt00mHi8NGKABjmJmTPxLY+ZBxxigU5g3ECEyzBa05xLGPpN2qQz2O3J7mAXDBmcx/1n0Pkk
 gdcWNDVj82RZwk2msVun//sXiZnDLC0tj9PooKqDKCXRf7/+ll30tXUmRkCrIAqz3dNO74KQJ
 Am5BGqB5Hw4cD8sKVoceWNanEcoqHCbW3m+i9uG74gMyZzN7FMlbq3zrK7v4m6yyMUZZmrxta
 ok3/0JLyVpD/fzmJfHdDYbzaVIlkcgelmNL5mHXJRAdXJOQb+r91vY4UBB5xGgPueoeTPxNlO
 gLB1fvbXy+tBoh0CUtRjRq3awws/L4qxRmTXusxMor9D8HUKHIX+pPxiSGpyK0wVZgFJVelKE
 vUlw0kYG1klLj0oT1TjDSG2vMVpfrTVW8lvLJ5Hyo9XGAw0+0DbvYF23xDsM71BZZTykRXS6r
 Y/4TfGZN5VRAQQ4zU0mh7odn584IJXL88jDYs5gclbWx8hXmJgjXmG/TqI77psoVwnbrHh3ad
 TXJ6WUkAi/kVkxlzTq/tCXtFVpbibdR7CQiUdrc45SJTM6muKf4Bnbq8xIgxIRgStd+bbVQ6D
 6JCksej6H5sJzKaR6vVoePiR82jNe1Zc4A8H/uOWK/nTjllF+KQbqOq6Zi8z1Lf6z2k4372os
 jDfokUo0CfMrp0h5uhft6V8xsxmXpc2rCOIrnclaEt5IdxxFJeJhJJT/GTKUndleHYFpYVEWQ
 yVLO8xtnWj5KMEQ0be/9BzuWMZD5Nwirlbn2QwqQCoiz69pCziPpPtxOYB7QanJq8Vi6qQEb0
 wReFXTY2F1/l2gciqqDEHoQ/X9KEvgNBFVfV9fmeiYEzINzDHlf4EmfnOHDvsIZYCu2yu6mcl
 /bbCfae2Tf7DcJHIljAg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In most cases people use lookup_symbol_name() to resolve a kernel symbol
and then print it via printk().

In such cases using the %ps, %pS, %pSR or %pB printk formats are easier
to use and thus should be preferred.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..0d5515a3d875 100755
=2D-- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4317,6 +4317,12 @@ sub process {
 			     "LINUX_VERSION_CODE should be avoided, code should be for the ver=
sion to which it is merged\n" . $herecurr);
 		}

+# avoid lookup_symbol_name()
+		if ($line =3D~ /\blookup_symbol_name\b/) {
+			WARN("PREFER_PRINTK_FORMAT",
+			     "If possible prefer %ps or %pS printk format string to print symb=
ol name instead of using lookup_symbol_name()\n" . $herecurr);
+		}
+
 # check for uses of printk_ratelimit
 		if ($line =3D~ /\bprintk_ratelimit\s*\(/) {
 			WARN("PRINTK_RATELIMITED",
