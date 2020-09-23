Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EF0275C41
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgIWPn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:43:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32840 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIWPn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:43:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08NFOu2I091440;
        Wed, 23 Sep 2020 15:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=F5lEKgJ45wkWUYmva0Jj2qx+WGncz/TKvT2D/F19+Ow=;
 b=Wz01mJvhHYHiiTASaUSKJ3swf4/EAuUHb1I4tG4FdeYrbVnCjlHqYvRlkp0QyOjpV0Co
 G/dmlfCBrXt66jXS3fanuKWZpKmFrjRQLSOkOYRiZ+m8W9iPD2o8JY1QkwHBzMjK4Iiw
 Xn6tU50C+HmgAb/8g0R1YU3C+1pk+6vLD5BI/mLsuN5m+Re1BwzE53C5H/9GGU4mvg9D
 /mvRKnOer0hEjomZZuX2ljGiyePze9IV0mbO0/DxiEtifVmBrubsfj9EEv3hyt6J5DRH
 kg86gG9ISdGs1SgPm4TOd7AXSEg7A9LbepDdedvzYn4Dj7D8Edm3JkYiAClPTnGAvdq0 vQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33ndnukbas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 15:43:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08NFQ3dp124475;
        Wed, 23 Sep 2020 15:43:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33r28vqpts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Sep 2020 15:43:47 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08NFhldm031465;
        Wed, 23 Sep 2020 15:43:47 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Sep 2020 08:43:47 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: fs/nfsd/nfs4xdr.c:4683:24: sparse: sparse: incorrect type in
 return expression (different base types)
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <202009232306.LM4tz9RH%lkp@intel.com>
Date:   Wed, 23 Sep 2020 11:43:45 -0400
Cc:     Frank van der Linden <fllinden@amazon.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ADDB187A-B65D-400D-9FFE-6808863D7903@oracle.com>
References: <202009232306.LM4tz9RH%lkp@intel.com>
To:     kernel test robot <lkp@intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009230124
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 23, 2020, at 11:42 AM, kernel test robot <lkp@intel.com> wrote:
>=20
> tree:   =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
> head:   805c6d3c19210c90c109107d189744e960eae025
> commit: 23e50fe3a5e6045a573c69d4b0e3d78aa6183323 nfsd: implement the =
xattr functions and en/decode logic
> date:   2 months ago
> config: m68k-randconfig-s032-20200923 (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce:
>        wget =
https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross =
-O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        # apt-get install sparse
>        # sparse version: v0.6.2-201-g24bdaac6-dirty
>        git checkout 23e50fe3a5e6045a573c69d4b0e3d78aa6183323
>        # save the attached .config to linux build tree
>        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 =
make.cross C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=3Dm68k=
=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

I believe both of these robot reports are addressed by
patches I have sent to Bruce for v5.10.


> sparse warnings: (new ones prefixed by >>)
>=20
>   fs/nfsd/nfs4xdr.c:1860:16: sparse: sparse: incorrect type in =
assignment (different base types) @@     expected int status @@     got =
restricted __be32 @@
>   fs/nfsd/nfs4xdr.c:1860:16: sparse:     expected int status
>   fs/nfsd/nfs4xdr.c:1860:16: sparse:     got restricted __be32
>   fs/nfsd/nfs4xdr.c:1862:24: sparse: sparse: incorrect type in return =
expression (different base types) @@     expected restricted __be32 @@   =
  got int status @@
>   fs/nfsd/nfs4xdr.c:1862:24: sparse:     expected restricted __be32
>   fs/nfsd/nfs4xdr.c:1862:24: sparse:     got int status
>>> fs/nfsd/nfs4xdr.c:4683:24: sparse: sparse: incorrect type in return =
expression (different base types) @@     expected int @@     got =
restricted __be32 [usertype] @@
>>> fs/nfsd/nfs4xdr.c:4683:24: sparse:     expected int
>>> fs/nfsd/nfs4xdr.c:4683:24: sparse:     got restricted __be32 =
[usertype]
>   fs/nfsd/nfs4xdr.c:4693:32: sparse: sparse: incorrect type in return =
expression (different base types) @@     expected int @@     got =
restricted __be32 [usertype] @@
>   fs/nfsd/nfs4xdr.c:4693:32: sparse:     expected int
>   fs/nfsd/nfs4xdr.c:4693:32: sparse:     got restricted __be32 =
[usertype]
>>> fs/nfsd/nfs4xdr.c:4730:13: sparse: sparse: incorrect type in =
assignment (different base types) @@     expected restricted __be32 =
[usertype] err @@     got int @@
>>> fs/nfsd/nfs4xdr.c:4730:13: sparse:     expected restricted __be32 =
[usertype] err
>>> fs/nfsd/nfs4xdr.c:4730:13: sparse:     got int
>>> fs/nfsd/nfs4xdr.c:4882:15: sparse: sparse: incorrect type in =
assignment (different base types) @@     expected unsigned int =
[assigned] [usertype] count @@     got restricted __be32 [usertype] @@
>>> fs/nfsd/nfs4xdr.c:4882:15: sparse:     expected unsigned int =
[assigned] [usertype] count
>   fs/nfsd/nfs4xdr.c:4882:15: sparse:     got restricted __be32 =
[usertype]
>=20
> # =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D23e50fe3a5e6045a573c69d4b0e3d78aa6183323
> git remote add linus =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git fetch --no-tags linus master
> git checkout 23e50fe3a5e6045a573c69d4b0e3d78aa6183323
> vim +4683 fs/nfsd/nfs4xdr.c
>=20
>  4669=09
>  4670	/*
>  4671	 * Encode kmalloc-ed buffer in to XDR stream.
>  4672	 */
>  4673	static int
>  4674	nfsd4_vbuf_to_stream(struct xdr_stream *xdr, char *buf, u32 =
buflen)
>  4675	{
>  4676		u32 cplen;
>  4677		__be32 *p;
>  4678=09
>  4679		cplen =3D min_t(unsigned long, buflen,
>  4680			      ((void *)xdr->end - (void *)xdr->p));
>  4681		p =3D xdr_reserve_space(xdr, cplen);
>  4682		if (!p)
>> 4683			return nfserr_resource;
>  4684=09
>  4685		memcpy(p, buf, cplen);
>  4686		buf +=3D cplen;
>  4687		buflen -=3D cplen;
>  4688=09
>  4689		while (buflen) {
>  4690			cplen =3D min_t(u32, buflen, PAGE_SIZE);
>  4691			p =3D xdr_reserve_space(xdr, cplen);
>  4692			if (!p)
>  4693				return nfserr_resource;
>  4694=09
>  4695			memcpy(p, buf, cplen);
>  4696=09
>  4697			if (cplen < PAGE_SIZE) {
>  4698				/*
>  4699				 * We're done, with a length that wasn't =
page
>  4700				 * aligned, so possibly not word =
aligned. Pad
>  4701				 * any trailing bytes with 0.
>  4702				 */
>  4703				xdr_encode_opaque_fixed(p, NULL, cplen);
>  4704				break;
>  4705			}
>  4706=09
>  4707			buflen -=3D PAGE_SIZE;
>  4708			buf +=3D PAGE_SIZE;
>  4709		}
>  4710=09
>  4711		return 0;
>  4712	}
>  4713=09
>  4714	static __be32
>  4715	nfsd4_encode_getxattr(struct nfsd4_compoundres *resp, __be32 =
nfserr,
>  4716			      struct nfsd4_getxattr *getxattr)
>  4717	{
>  4718		struct xdr_stream *xdr =3D &resp->xdr;
>  4719		__be32 *p, err;
>  4720=09
>  4721		p =3D xdr_reserve_space(xdr, 4);
>  4722		if (!p)
>  4723			return nfserr_resource;
>  4724=09
>  4725		*p =3D cpu_to_be32(getxattr->getxa_len);
>  4726=09
>  4727		if (getxattr->getxa_len =3D=3D 0)
>  4728			return 0;
>  4729=09
>> 4730		err =3D nfsd4_vbuf_to_stream(xdr, getxattr->getxa_buf,
>  4731					    getxattr->getxa_len);
>  4732=09
>  4733		kvfree(getxattr->getxa_buf);
>  4734=09
>  4735		return err;
>  4736	}
>  4737=09
>  4738	static __be32
>  4739	nfsd4_encode_setxattr(struct nfsd4_compoundres *resp, __be32 =
nfserr,
>  4740			      struct nfsd4_setxattr *setxattr)
>  4741	{
>  4742		struct xdr_stream *xdr =3D &resp->xdr;
>  4743		__be32 *p;
>  4744=09
>  4745		p =3D xdr_reserve_space(xdr, 20);
>  4746		if (!p)
>  4747			return nfserr_resource;
>  4748=09
>  4749		encode_cinfo(p, &setxattr->setxa_cinfo);
>  4750=09
>  4751		return 0;
>  4752	}
>  4753=09
>  4754	/*
>  4755	 * See if there are cookie values that can be rejected outright.
>  4756	 */
>  4757	static __be32
>  4758	nfsd4_listxattr_validate_cookie(struct nfsd4_listxattrs =
*listxattrs,
>  4759					u32 *offsetp)
>  4760	{
>  4761		u64 cookie =3D listxattrs->lsxa_cookie;
>  4762=09
>  4763		/*
>  4764		 * If the cookie is larger than the maximum number we =
can fit
>  4765		 * in either the buffer we just got back from =
vfs_listxattr, or,
>  4766		 * XDR-encoded, in the return buffer, it's invalid.
>  4767		 */
>  4768		if (cookie > (listxattrs->lsxa_len) / =
(XATTR_USER_PREFIX_LEN + 2))
>  4769			return nfserr_badcookie;
>  4770=09
>  4771		if (cookie > (listxattrs->lsxa_maxcount /
>  4772			      (XDR_QUADLEN(XATTR_USER_PREFIX_LEN + 2) + =
4)))
>  4773			return nfserr_badcookie;
>  4774=09
>  4775		*offsetp =3D (u32)cookie;
>  4776		return 0;
>  4777	}
>  4778=09
>  4779	static __be32
>  4780	nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 =
nfserr,
>  4781				struct nfsd4_listxattrs *listxattrs)
>  4782	{
>  4783		struct xdr_stream *xdr =3D &resp->xdr;
>  4784		u32 cookie_offset, count_offset, eof;
>  4785		u32 left, xdrleft, slen, count;
>  4786		u32 xdrlen, offset;
>  4787		u64 cookie;
>  4788		char *sp;
>  4789		__be32 status;
>  4790		__be32 *p;
>  4791		u32 nuser;
>  4792=09
>  4793		eof =3D 1;
>  4794=09
>  4795		status =3D nfsd4_listxattr_validate_cookie(listxattrs, =
&offset);
>  4796		if (status)
>  4797			goto out;
>  4798=09
>  4799		/*
>  4800		 * Reserve space for the cookie and the name array =
count. Record
>  4801		 * the offsets to save them later.
>  4802		 */
>  4803		cookie_offset =3D xdr->buf->len;
>  4804		count_offset =3D cookie_offset + 8;
>  4805		p =3D xdr_reserve_space(xdr, 12);
>  4806		if (!p) {
>  4807			status =3D nfserr_resource;
>  4808			goto out;
>  4809		}
>  4810=09
>  4811		count =3D 0;
>  4812		left =3D listxattrs->lsxa_len;
>  4813		sp =3D listxattrs->lsxa_buf;
>  4814		nuser =3D 0;
>  4815=09
>  4816		xdrleft =3D listxattrs->lsxa_maxcount;
>  4817=09
>  4818		while (left > 0 && xdrleft > 0) {
>  4819			slen =3D strlen(sp);
>  4820=09
>  4821			/*
>  4822			 * Check if this a user. attribute, skip it if =
not.
>  4823			 */
>  4824			if (strncmp(sp, XATTR_USER_PREFIX, =
XATTR_USER_PREFIX_LEN))
>  4825				goto contloop;
>  4826=09
>  4827			slen -=3D XATTR_USER_PREFIX_LEN;
>  4828			xdrlen =3D 4 + ((slen + 3) & ~3);
>  4829			if (xdrlen > xdrleft) {
>  4830				if (count =3D=3D 0) {
>  4831					/*
>  4832					 * Can't even fit the first =
attribute name.
>  4833					 */
>  4834					status =3D nfserr_toosmall;
>  4835					goto out;
>  4836				}
>  4837				eof =3D 0;
>  4838				goto wreof;
>  4839			}
>  4840=09
>  4841			left -=3D XATTR_USER_PREFIX_LEN;
>  4842			sp +=3D XATTR_USER_PREFIX_LEN;
>  4843			if (nuser++ < offset)
>  4844				goto contloop;
>  4845=09
>  4846=09
>  4847			p =3D xdr_reserve_space(xdr, xdrlen);
>  4848			if (!p) {
>  4849				status =3D nfserr_resource;
>  4850				goto out;
>  4851			}
>  4852=09
>  4853			p =3D xdr_encode_opaque(p, sp, slen);
>  4854=09
>  4855			xdrleft -=3D xdrlen;
>  4856			count++;
>  4857	contloop:
>  4858			sp +=3D slen + 1;
>  4859			left -=3D slen + 1;
>  4860		}
>  4861=09
>  4862		/*
>  4863		 * If there were user attributes to copy, but we didn't =
copy
>  4864		 * any, the offset was too large (e.g. the cookie was =
invalid).
>  4865		 */
>  4866		if (nuser > 0 && count =3D=3D 0) {
>  4867			status =3D nfserr_badcookie;
>  4868			goto out;
>  4869		}
>  4870=09
>  4871	wreof:
>  4872		p =3D xdr_reserve_space(xdr, 4);
>  4873		if (!p) {
>  4874			status =3D nfserr_resource;
>  4875			goto out;
>  4876		}
>  4877		*p =3D cpu_to_be32(eof);
>  4878=09
>  4879		cookie =3D offset + count;
>  4880=09
>  4881		write_bytes_to_xdr_buf(xdr->buf, cookie_offset, &cookie, =
8);
>> 4882		count =3D htonl(count);
>  4883		write_bytes_to_xdr_buf(xdr->buf, count_offset, &count, =
4);
>  4884	out:
>  4885		if (listxattrs->lsxa_len)
>  4886			kvfree(listxattrs->lsxa_buf);
>  4887		return status;
>  4888	}
>  4889=09
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> <.config.gz>

--
Chuck Lever



