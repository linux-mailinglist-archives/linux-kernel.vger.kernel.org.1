Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBC719F909
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 17:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgDFPla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 11:41:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26824 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726723AbgDFPla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:41:30 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036FYack057517;
        Mon, 6 Apr 2020 11:41:11 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 306n24eudc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 11:41:10 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 036FZV37015214;
        Mon, 6 Apr 2020 15:41:10 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 306hv5s2v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 15:41:10 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 036Ff9O254460904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Apr 2020 15:41:09 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 978E0AE062;
        Mon,  6 Apr 2020 15:41:09 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13345AE05F;
        Mon,  6 Apr 2020 15:41:07 +0000 (GMT)
Received: from LeoBras (unknown [9.85.165.246])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Apr 2020 15:41:06 +0000 (GMT)
Message-ID: <6c09a6e1a1f790ad87a2591ff8f8a6e1c7d6b079.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] powerpc/kernel: Enables memory hot-remove after
 reboot on pseries guests
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     bharata@linux.ibm.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, Allison Randal <allison@lohutok.net>
Date:   Mon, 06 Apr 2020 12:41:01 -0300
In-Reply-To: <20200403143831.GA12662@in.ibm.com>
References: <20200402195156.626430-1-leonardo@linux.ibm.com>
         <20200403143831.GA12662@in.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-9qOAwFiqOabJT4Un+oxn"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_08:2020-04-06,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=537
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 suspectscore=1 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9qOAwFiqOabJT4Un+oxn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Bharata,

On Fri, 2020-04-03 at 20:08 +0530, Bharata B Rao wrote:
> The patch would be more complete with the following change that ensures
> that DRCONF_MEM_HOTREMOVABLE flag is set for non-boot-time hotplugged
> memory too. This will ensure that ibm,dynamic-memory-vN property
> reflects the right flags value for memory that gets hotplugged
> post boot.
>=20

You just sent that on a separated patchset, so I think it's dealt with.
Do you have any other comments on the present patch?

Best regards,

--=-9qOAwFiqOabJT4Un+oxn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl6LTY0ACgkQlQYWtz9S
ttTE0xAAwC4OgrLJoU37JGHUVnbtvnDoM/soV+/MjQz128yoydIeASSL9FZJBa9I
py00+2vLjFXtLyOqv/JQPLaZmhwmNLJFgykmdVFM2zsM6pWIpASNZ86eSYhbzASn
iw4T38IYMp8BHgb7ajO8R5nUAmPZhDAZCjlXMGgsxOkxfP0Cn2nymoznQAoEy2zf
/Vlzs/8eDHNj6msFXEnTjXt4liG9jp6itoQaLQjGWiXDlAFPvXVcn5pxvu/culPU
sdWmwbo+PHJxEtAarZ95iJH8rbWgtJVUheGsyEILFojhk4yzKp2r5rq/JLMUy96+
3tfxUom7V3tqfEPvfrC5LzFx/Dxr/SPod9mEu6whjcJVK1QJW8s5CBgmA1XBLnWP
fSyUQNCMZCl2S7l1ucqqcNyDXDX3DSHYbbJVOcKkafIhczitLriRJR/fp43s6ysd
4RejaK1Eh+KRc2nkHGvah/p5X7io00fU6WQeXyQGz+EEvTZ7NeUSPV22VDnhfZXN
3v1chC7v8066KkU86fj8N0D//srfnkxEaA1jRgRQ6Sc4YkQPhuprrqqilsVo3dNP
onlowpsjXcMoKFckXYu4d2DC+n++Rb0q4fnX+sEHLAB3r+9LGLwL1yH13MVEI96Q
b/HOVSm2+hTWo/R294Z1YaCDHZjz2ez0gO8KDVitodS1ez3YV7Q=
=VJEq
-----END PGP SIGNATURE-----

--=-9qOAwFiqOabJT4Un+oxn--

