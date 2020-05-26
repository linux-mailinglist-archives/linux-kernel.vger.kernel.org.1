Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE6819FD7A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 20:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgDFSsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 14:48:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbgDFSsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:48:54 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036IYQGw137647;
        Mon, 6 Apr 2020 14:47:36 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3082k26cce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 14:47:36 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 036IiZlZ015752;
        Mon, 6 Apr 2020 18:47:35 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 306hv6er63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 18:47:35 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 036IlY0h45744596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Apr 2020 18:47:35 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0A56AC062;
        Mon,  6 Apr 2020 18:47:34 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE465AC05B;
        Mon,  6 Apr 2020 18:47:31 +0000 (GMT)
Received: from LeoBras (unknown [9.85.165.246])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Apr 2020 18:47:31 +0000 (GMT)
Message-ID: <bd01a908addbb9050bbbe1cff81401f3bb7ed841.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] ppc/crash: Reset spinlocks during crash
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Enrico Weigelt <info@metux.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        peterz@infradead.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <871rp6t9di.fsf@mpe.ellerman.id.au>
References: <20200401000020.590447-1-leonardo@linux.ibm.com>
         <871rp6t9di.fsf@mpe.ellerman.id.au>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-H9cEVCgKCXK7x0ewIdQK"
MIME-Version: 1.0
Date:   Mon, 06 Apr 2020 15:46:58 -0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_08:2020-04-06,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-H9cEVCgKCXK7x0ewIdQK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-04-02 at 22:28 +1100, Michael Ellerman wrote:
> Leonardo Bras <leonardo@linux.ibm.com>=20
> TBH I think we could just drop that printk() entirely.
>=20
> Or we could tell printk() that we're in NMI context so that it uses the
> percpu buffers.
>=20
> We should probably do the latter anyway, in case there's any other code
> we call that inadvertently calls printk().

Done:
http://patchwork.ozlabs.org/patch/1266956/

About the rtas-call, I think it will take more time, because I have to
study it properly.

Thank you,

--=-H9cEVCgKCXK7x0ewIdQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl6LeRIACgkQlQYWtz9S
ttTtkxAAgcj1HnOp231sVwNiekotD/Q6j7wrz05YDPEiOksAZZ8y3mR0aS+WKrtK
k4ZYbe/wPU9+6vDOYDzN/ydcFIs8oWoKAbZh+2g/VXb0gEbC6HT4ZNP7+093cLCw
tW0Ab2HxjYKfOLqWa8RxUb9Yg6NgDXsZPhJpjwT2jWzo4Er3GEzatF4l2w87Yz77
4YagpTt7+xzYnPuymmw6cNFXYrCuXeLEVVEjevxFpg+nLlrbyuq/rWjttGNlRCxZ
NEb6P84r0KqNvT0kQKWVJkkyLSZLtB2QPJOQsQUxa57rRFCfneEFIa//jyRyJwyp
p2kKOHXy+0evRAVa0UDqpR0WOBDg9nfk8MGsusb4GcCMXb0lArhzPS7MVmFpVof+
IbO9NOXxFzXKMgtw48/8LIKy/dV5Jg1Z1Amfr+uOGXMRdQ7+jdXjErozqmLwwaV7
v6td5S8b/UcmC08jwDFiXVq3svxie7yzYACWwQ396Ndl3+gGwo2cAqX4agtW7F4B
NQWKsIJGHzPXt8daEZn592hIsnt4SDHUF3WQWoAhh4qLh4bDlzKsAJ1fV3oRZvFX
Q1sNGcKOw0bOyTmL0UOICYcBsmGDLazSv4JuizgS4y1IZ7eaI41AJGYpJx9sXnOG
NN1OpQaEnhocgxPVWm5sSKHjGk6eGnOSECbizCRLfTcq801bOoA=
=6kFn
-----END PGP SIGNATURE-----

--=-H9cEVCgKCXK7x0ewIdQK--

