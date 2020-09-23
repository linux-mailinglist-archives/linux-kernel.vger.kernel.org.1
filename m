Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75B7275C38
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgIWPmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:42:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:33095 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWPmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:42:31 -0400
IronPort-SDR: ags3XNwcYzueu9iWmttt7HYtB7B+iGTuDi7T8Tusm6cxqO58Twh+zigQhNNkabzdPnMAEv5utC
 FXX8b7yetmIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="161853433"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="gz'50?scan'50,208,50";a="161853433"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 08:42:28 -0700
IronPort-SDR: UUENYrNs9/v81KUtfpl4YM/1EyM2mkLhBWoyyLi4jWVY0O+FeQEdybPMujsQCG0f/RJ/XnO/aU
 92/7vSdMqFZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="gz'50?scan'50,208,50";a="454963478"
Received: from lkp-server01.sh.intel.com (HELO 9f27196b5390) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Sep 2020 08:42:26 -0700
Received: from kbuild by 9f27196b5390 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kL6uX-0000Ch-OI; Wed, 23 Sep 2020 15:42:25 +0000
Date:   Wed, 23 Sep 2020 23:42:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: fs/nfsd/nfs4xdr.c:4683:24: sparse: sparse: incorrect type in return
 expression (different base types)
Message-ID: <202009232306.LM4tz9RH%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   805c6d3c19210c90c109107d189744e960eae025
commit: 23e50fe3a5e6045a573c69d4b0e3d78aa6183323 nfsd: implement the xattr functions and en/decode logic
date:   2 months ago
config: m68k-randconfig-s032-20200923 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-201-g24bdaac6-dirty
        git checkout 23e50fe3a5e6045a573c69d4b0e3d78aa6183323
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   fs/nfsd/nfs4xdr.c:1860:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected int status @@     got restricted __be32 @@
   fs/nfsd/nfs4xdr.c:1860:16: sparse:     expected int status
   fs/nfsd/nfs4xdr.c:1860:16: sparse:     got restricted __be32
   fs/nfsd/nfs4xdr.c:1862:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __be32 @@     got int status @@
   fs/nfsd/nfs4xdr.c:1862:24: sparse:     expected restricted __be32
   fs/nfsd/nfs4xdr.c:1862:24: sparse:     got int status
>> fs/nfsd/nfs4xdr.c:4683:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __be32 [usertype] @@
>> fs/nfsd/nfs4xdr.c:4683:24: sparse:     expected int
>> fs/nfsd/nfs4xdr.c:4683:24: sparse:     got restricted __be32 [usertype]
   fs/nfsd/nfs4xdr.c:4693:32: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __be32 [usertype] @@
   fs/nfsd/nfs4xdr.c:4693:32: sparse:     expected int
   fs/nfsd/nfs4xdr.c:4693:32: sparse:     got restricted __be32 [usertype]
>> fs/nfsd/nfs4xdr.c:4730:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] err @@     got int @@
>> fs/nfsd/nfs4xdr.c:4730:13: sparse:     expected restricted __be32 [usertype] err
>> fs/nfsd/nfs4xdr.c:4730:13: sparse:     got int
>> fs/nfsd/nfs4xdr.c:4882:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [assigned] [usertype] count @@     got restricted __be32 [usertype] @@
>> fs/nfsd/nfs4xdr.c:4882:15: sparse:     expected unsigned int [assigned] [usertype] count
   fs/nfsd/nfs4xdr.c:4882:15: sparse:     got restricted __be32 [usertype]

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=23e50fe3a5e6045a573c69d4b0e3d78aa6183323
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 23e50fe3a5e6045a573c69d4b0e3d78aa6183323
vim +4683 fs/nfsd/nfs4xdr.c

  4669	
  4670	/*
  4671	 * Encode kmalloc-ed buffer in to XDR stream.
  4672	 */
  4673	static int
  4674	nfsd4_vbuf_to_stream(struct xdr_stream *xdr, char *buf, u32 buflen)
  4675	{
  4676		u32 cplen;
  4677		__be32 *p;
  4678	
  4679		cplen = min_t(unsigned long, buflen,
  4680			      ((void *)xdr->end - (void *)xdr->p));
  4681		p = xdr_reserve_space(xdr, cplen);
  4682		if (!p)
> 4683			return nfserr_resource;
  4684	
  4685		memcpy(p, buf, cplen);
  4686		buf += cplen;
  4687		buflen -= cplen;
  4688	
  4689		while (buflen) {
  4690			cplen = min_t(u32, buflen, PAGE_SIZE);
  4691			p = xdr_reserve_space(xdr, cplen);
  4692			if (!p)
  4693				return nfserr_resource;
  4694	
  4695			memcpy(p, buf, cplen);
  4696	
  4697			if (cplen < PAGE_SIZE) {
  4698				/*
  4699				 * We're done, with a length that wasn't page
  4700				 * aligned, so possibly not word aligned. Pad
  4701				 * any trailing bytes with 0.
  4702				 */
  4703				xdr_encode_opaque_fixed(p, NULL, cplen);
  4704				break;
  4705			}
  4706	
  4707			buflen -= PAGE_SIZE;
  4708			buf += PAGE_SIZE;
  4709		}
  4710	
  4711		return 0;
  4712	}
  4713	
  4714	static __be32
  4715	nfsd4_encode_getxattr(struct nfsd4_compoundres *resp, __be32 nfserr,
  4716			      struct nfsd4_getxattr *getxattr)
  4717	{
  4718		struct xdr_stream *xdr = &resp->xdr;
  4719		__be32 *p, err;
  4720	
  4721		p = xdr_reserve_space(xdr, 4);
  4722		if (!p)
  4723			return nfserr_resource;
  4724	
  4725		*p = cpu_to_be32(getxattr->getxa_len);
  4726	
  4727		if (getxattr->getxa_len == 0)
  4728			return 0;
  4729	
> 4730		err = nfsd4_vbuf_to_stream(xdr, getxattr->getxa_buf,
  4731					    getxattr->getxa_len);
  4732	
  4733		kvfree(getxattr->getxa_buf);
  4734	
  4735		return err;
  4736	}
  4737	
  4738	static __be32
  4739	nfsd4_encode_setxattr(struct nfsd4_compoundres *resp, __be32 nfserr,
  4740			      struct nfsd4_setxattr *setxattr)
  4741	{
  4742		struct xdr_stream *xdr = &resp->xdr;
  4743		__be32 *p;
  4744	
  4745		p = xdr_reserve_space(xdr, 20);
  4746		if (!p)
  4747			return nfserr_resource;
  4748	
  4749		encode_cinfo(p, &setxattr->setxa_cinfo);
  4750	
  4751		return 0;
  4752	}
  4753	
  4754	/*
  4755	 * See if there are cookie values that can be rejected outright.
  4756	 */
  4757	static __be32
  4758	nfsd4_listxattr_validate_cookie(struct nfsd4_listxattrs *listxattrs,
  4759					u32 *offsetp)
  4760	{
  4761		u64 cookie = listxattrs->lsxa_cookie;
  4762	
  4763		/*
  4764		 * If the cookie is larger than the maximum number we can fit
  4765		 * in either the buffer we just got back from vfs_listxattr, or,
  4766		 * XDR-encoded, in the return buffer, it's invalid.
  4767		 */
  4768		if (cookie > (listxattrs->lsxa_len) / (XATTR_USER_PREFIX_LEN + 2))
  4769			return nfserr_badcookie;
  4770	
  4771		if (cookie > (listxattrs->lsxa_maxcount /
  4772			      (XDR_QUADLEN(XATTR_USER_PREFIX_LEN + 2) + 4)))
  4773			return nfserr_badcookie;
  4774	
  4775		*offsetp = (u32)cookie;
  4776		return 0;
  4777	}
  4778	
  4779	static __be32
  4780	nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
  4781				struct nfsd4_listxattrs *listxattrs)
  4782	{
  4783		struct xdr_stream *xdr = &resp->xdr;
  4784		u32 cookie_offset, count_offset, eof;
  4785		u32 left, xdrleft, slen, count;
  4786		u32 xdrlen, offset;
  4787		u64 cookie;
  4788		char *sp;
  4789		__be32 status;
  4790		__be32 *p;
  4791		u32 nuser;
  4792	
  4793		eof = 1;
  4794	
  4795		status = nfsd4_listxattr_validate_cookie(listxattrs, &offset);
  4796		if (status)
  4797			goto out;
  4798	
  4799		/*
  4800		 * Reserve space for the cookie and the name array count. Record
  4801		 * the offsets to save them later.
  4802		 */
  4803		cookie_offset = xdr->buf->len;
  4804		count_offset = cookie_offset + 8;
  4805		p = xdr_reserve_space(xdr, 12);
  4806		if (!p) {
  4807			status = nfserr_resource;
  4808			goto out;
  4809		}
  4810	
  4811		count = 0;
  4812		left = listxattrs->lsxa_len;
  4813		sp = listxattrs->lsxa_buf;
  4814		nuser = 0;
  4815	
  4816		xdrleft = listxattrs->lsxa_maxcount;
  4817	
  4818		while (left > 0 && xdrleft > 0) {
  4819			slen = strlen(sp);
  4820	
  4821			/*
  4822			 * Check if this a user. attribute, skip it if not.
  4823			 */
  4824			if (strncmp(sp, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
  4825				goto contloop;
  4826	
  4827			slen -= XATTR_USER_PREFIX_LEN;
  4828			xdrlen = 4 + ((slen + 3) & ~3);
  4829			if (xdrlen > xdrleft) {
  4830				if (count == 0) {
  4831					/*
  4832					 * Can't even fit the first attribute name.
  4833					 */
  4834					status = nfserr_toosmall;
  4835					goto out;
  4836				}
  4837				eof = 0;
  4838				goto wreof;
  4839			}
  4840	
  4841			left -= XATTR_USER_PREFIX_LEN;
  4842			sp += XATTR_USER_PREFIX_LEN;
  4843			if (nuser++ < offset)
  4844				goto contloop;
  4845	
  4846	
  4847			p = xdr_reserve_space(xdr, xdrlen);
  4848			if (!p) {
  4849				status = nfserr_resource;
  4850				goto out;
  4851			}
  4852	
  4853			p = xdr_encode_opaque(p, sp, slen);
  4854	
  4855			xdrleft -= xdrlen;
  4856			count++;
  4857	contloop:
  4858			sp += slen + 1;
  4859			left -= slen + 1;
  4860		}
  4861	
  4862		/*
  4863		 * If there were user attributes to copy, but we didn't copy
  4864		 * any, the offset was too large (e.g. the cookie was invalid).
  4865		 */
  4866		if (nuser > 0 && count == 0) {
  4867			status = nfserr_badcookie;
  4868			goto out;
  4869		}
  4870	
  4871	wreof:
  4872		p = xdr_reserve_space(xdr, 4);
  4873		if (!p) {
  4874			status = nfserr_resource;
  4875			goto out;
  4876		}
  4877		*p = cpu_to_be32(eof);
  4878	
  4879		cookie = offset + count;
  4880	
  4881		write_bytes_to_xdr_buf(xdr->buf, cookie_offset, &cookie, 8);
> 4882		count = htonl(count);
  4883		write_bytes_to_xdr_buf(xdr->buf, count_offset, &count, 4);
  4884	out:
  4885		if (listxattrs->lsxa_len)
  4886			kvfree(listxattrs->lsxa_buf);
  4887		return status;
  4888	}
  4889	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--sdtB3X0nJg68CQEu
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
z2FtMvL+EfolkBSYyEblsdFaQqFVlY6/7F6W6y8fu8V2tXldfFL5qY+JlhawpFJPBKSeCKY7
HSijIymzJHuiwzR0NCzPGVTVkxmipXpiiedYpasOG+PRGRkkqtfRUd/OHlL0YCBGX0fXnInY
UG7lUYZEN7bLOBMBvhNMaXPIQ48HORPP0YTnE4mFmQGyMTbmcsdLr2cHxBiZKQOJRK3tngrf
XRriLkqoswt+r3UZ/KhRQQfNs6qi0EKEoVLftRXWPnPtVy7Tn5DCcByjM9nr5u/1ye/Zanby
azN7fV+uT3az7wuoxfL1ZLneL95Qup3sN6vN783Jy/v3YyX3bhfb9eKXzM+0kLcLvfzTIhcc
LddL9E9Z/nfWeLJ1fRGVuHKg83E09f6N8GWuWq3mU12LYgybjUmgZSAjC2/R/rp3fpm2VO8s
DRS1WXtMGmx/v+83R/PNdnG02Tbp5/tGKmJoysRInWKAhy6cs5AEuqTFbRDlU10YWQj3kynT
t0oN6JKKdELBSMLO0nEq7q0J81X+Ns9dagC6HMBsJ0hBY2ATgm8Ddz8wX+ab1N1RiHx/7FBN
xoPhlZHHp0GkVUwDjaP9Bi7/UGK0bWhVTmGbJ77EWvm/UzlK2tmaf7z8Ws4//Vz8PprLifuG
qZl+O/NVFMypeehOGh4EBIwkFGHBqGZX4p4PLy4GRoBydQHxsf+BV9Pz2X7xesTXssJ4p//3
ElO47nab+VKiwtl+5rQg0BM5tSNFwIIpqGFseJpn8ZPp39Qtu0lUDPSYzO0C43fRPdHSKQPx
dN/2+Eh66+LWv3PrOKLGMxiP/MMZlIL6pCTPmtoajZxaxuKBYJMdKjlXtTWBj8R6AGXyQbCc
4M8wKlJZUXpcW9ei6LtuOtv98PVcwtzKTCngI93J90DrzLhw+bbY7d3CRHA2dDlLsFveIyle
RzG75UN3IBTc7URgXg5OjfjX7SQm+XunbxKeEzCCLoKJy2XCHKK7RBIOSO9FDa+7dPbg4cVX
Cnw2dKmLKRtQQIoFgC8GxG44ZWdE9YuEcudrkSVoEaNsQnxXTsTg2nO2qSgecqiGe/ezfP9h
vLboZIk70gCry4haLWk1ijznpQ2FCKhjn25qZQ/jiJyLCtEfeTvyhCUcDH9KIe0o0IK1jsw1
3AXJtSjJAADN/kJ0zlj+dUXMlD0TGlLB4oIRE6uV8dTMsKLu2ViRG7ncuvnkLqqSU/sbGK/Y
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
/T+KEtGmhUsBAA==

--sdtB3X0nJg68CQEu--
