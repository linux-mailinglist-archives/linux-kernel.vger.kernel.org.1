Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351FC28D0FC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 17:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbgJMPJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 11:09:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41816 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgJMPJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 11:09:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DF5Xkh011284;
        Tue, 13 Oct 2020 15:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=wRKRD4KkMe59+avWQEGlta8Wps+z2t1AugQ5ySSX45s=;
 b=x6Aak6vnYtmBnYavl8OJ3IJ8grXYCOrIWLTmnFKG+FnxF5iZl/MjIS1mzI3KNe+/+w+5
 6b2/DFo7bh3noA20r8q9+Apkf2wlGTIMaojsdUwagpTiVcy2RqyHicdsgiwpzn+oUeZq
 F0uhj4qTsM8ZQyyx68ikCe+YotgG98+lAb4TDrHM4AgrpRSui/Ze9QS9HCCEivH/l+5q
 ZMhSgFfhbtCAVooCiw5MBqQID2t/c4Tu+a2o5raD5E/qa4srQ7Uk0+8BjOVpy3K9psUK
 j05X/6Z5R8YgHrEku/QfsOS5ardX/mRtt4p6jgDCC1xEP2/TCz24A6tu7LHUImU0QXPk 7A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3434wkjqjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Oct 2020 15:09:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DEoWLw029640;
        Tue, 13 Oct 2020 15:09:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 343pvwgj8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Oct 2020 15:09:47 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09DF9kLG016960;
        Tue, 13 Oct 2020 15:09:46 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Oct 2020 08:09:46 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 1505C6A00D6; Tue, 13 Oct 2020 11:11:24 -0400 (EDT)
Date:   Tue, 13 Oct 2020 11:11:24 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] (swiotlb) stable/for-linus-5.10
Message-ID: <20201013151124.GA13385@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9772 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9772 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Please git pull the following branch:

 git pull git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git =
stable/for-linus-5.10=20

which has a minor enhancement of using %p to print phys_addr_r and also com=
piler
warnings.

Thank you!

 arch/x86/pci/sta2x11-fixup.c | 1 -
 include/linux/swiotlb.h      | 1 +
 kernel/dma/swiotlb.c         | 6 ++----
 3 files changed, 3 insertions(+), 5 deletions(-)

Andy Shevchenko (3):
      swiotlb: Use %pa to print phys_addr_t variables
      swiotlb: Declare swiotlb_late_init_with_default_size() in header
      swiotlb: Mark max_segment with static keyword


--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJfhcOcAAoJEFKlDoTx2wm/V08P+gPQHHZhnI1eJLIwpME54Yue
JOtDaGC37qUU2hyZnBJcs2OvqfXNV3aOlwYVn/+mRju0EVty4fuyGO2j0OZh6O+t
ufTOtbWcFutdD1c5LIx2RKdDPeYcGP0lc/JjwzMECiyBEP3LrX6vQyiwwoSt1GN+
+s9Iabue1H4k4YyO2D0YZecD/eyKB5OlZ396Gr+LSimnjikAD4Jo+KAddOJvaEWU
epaE2Q9lXwPJmob3u+H1wxkeQreD7weZSD+cXRFZGJp+CVWapmkVzIu2INf437ML
ygKE40wwA89ChAXLKgFWbUs9tk1UWsDnUZ11A5NwMMun9F0l0E0SxbGrximCIwZl
l3j1yf8+fTKw+IupJLYL0DkgdceW4O0AyaUeO81cWoVXkNiHNvVrSqVTPGy7fRHL
a1OunVeJLx0bKa+InXmvD6cVkvIwo67ilKggANUKhN7tlFbMMLJjgm0cSouoslbL
xndpHGlkHQS6rQtk1wfPDZ3kWyJ3hKxC7GYTstClR9fDxIB0N4J9dJhhmzNjYlE1
eFhEn2X269FKPe33zZWkE+S8baYbi1NUk79dGxXFNd0JXkMC7+nxU523csFTRmjm
IhjQk7eTferLVT6XC5XoNOQYFxoKAw1xHzxSkJYLhjOQK0t0CQUa00MtJybzBUpA
Ro4wLa5jpK2dw8LAF1V2
=SFUP
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
