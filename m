Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DB228BEA7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404008AbgJLRGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:06:33 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48388 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403884AbgJLRGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:06:32 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09CH4c1G151548;
        Mon, 12 Oct 2020 17:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=sywnCTUjXc0lgO6A0ChBIso9TIkehj97usAO1+Lal8Q=;
 b=uPKtTS/YINpOjTaWw9jnRSV83/rKY472HZDieah3yaran7QM/V/al7+Gds48t95MPzcO
 9bnSBJhYFsPozprJC+ok7TsurtToZbuhqmm6HNXokyN5lq3b7MJEgis+9Kg8RMDSCErr
 Mh4q0uO48c4qpRGnW1XcdnudfyLjnieZEkR3geUmP1XeBisKNxocUp+/Jv0h7B4oY4wP
 Bd3vmcFBZQohPQfD04AybaCNhPv6DHzlz5iIr1ru758jqYzgAqD/6v7RFVxhAmd54mLP
 2OrmrlPlQ/DsZXgeJZ9sLx7YAcw45vZ/EaUParlLZ7+xniBxGQy/u+FWYWESVsfzNU44 Rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 343pajmuvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 17:05:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09CGjbn0025656;
        Mon, 12 Oct 2020 17:03:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 343phm2uyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 17:03:45 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09CH3e61010418;
        Mon, 12 Oct 2020 17:03:40 GMT
Received: from [10.65.146.162] (/10.65.146.162)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Oct 2020 10:03:40 -0700
Subject: Re: [PATCH 1/2] mm/mprotect: Call arch_validate_prot under mmap_lock
 and with length
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Jann Horn <jannh@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20201007073932.865218-1-jannh@google.com>
 <d5332a7b-c300-6d28-18b9-4b7d4110ef86@oracle.com>
 <20201010110949.GA32545@gaia>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
X-Pep-Version: 2.0
Message-ID: <af207cf8-3049-85eb-349d-5fed6b9be49c@oracle.com>
Date:   Mon, 12 Oct 2020 11:03:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201010110949.GA32545@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9772 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010120130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9772 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/20 5:09 AM, Catalin Marinas wrote:
> Hi Khalid,
>=20
> On Wed, Oct 07, 2020 at 02:14:09PM -0600, Khalid Aziz wrote:
>> On 10/7/20 1:39 AM, Jann Horn wrote:
>>> arch_validate_prot() is a hook that can validate whether a given set =
of
>>> protection flags is valid in an mprotect() operation. It is given the=
 set
>>> of protection flags and the address being modified.
>>>
>>> However, the address being modified can currently not actually be use=
d in
>>> a meaningful way because:
>>>
>>> 1. Only the address is given, but not the length, and the operation c=
an
>>>    span multiple VMAs. Therefore, the callee can't actually tell whic=
h
>>>    virtual address range, or which VMAs, are being targeted.
>>> 2. The mmap_lock is not held, meaning that if the callee were to chec=
k
>>>    the VMA at @addr, that VMA would be unrelated to the one the
>>>    operation is performed on.
>>>
>>> Currently, custom arch_validate_prot() handlers are defined by
>>> arm64, powerpc and sparc.
>>> arm64 and powerpc don't care about the address range, they just check=
 the
>>> flags against CPU support masks.
>>> sparc's arch_validate_prot() attempts to look at the VMA, but doesn't=
 take
>>> the mmap_lock.
>>>
>>> Change the function signature to also take a length, and move the
>>> arch_validate_prot() call in mm/mprotect.c down into the locked regio=
n.
> [...]
>> As Chris pointed out, the call to arch_validate_prot() from do_mmap2()=

>> is made without holding mmap_lock. Lock is not acquired until
>> vm_mmap_pgoff(). This variance is uncomfortable but I am more
>> uncomfortable forcing all implementations of validate_prot to require
>> mmap_lock be held when non-sparc implementations do not have such need=

>> yet. Since do_mmap2() is in powerpc specific code, for now this patch
>> solves a current problem.
>=20
> I still think sparc should avoid walking the vmas in
> arch_validate_prot(). The core code already has the vmas, though not
> when calling arch_validate_prot(). That's one of the reasons I added
> arch_validate_flags() with the MTE patches. For sparc, this could be
> (untested, just copied the arch_validate_prot() code):

I am little uncomfortable with the idea of validating protection bits
inside the VMA walk loop in do_mprotect_pkey(). When ADI is being
enabled across multiple VMAs and arch_validate_flags() fails on a VMA
later, do_mprotect_pkey() will bail out with error leaving ADI enabled
on earlier VMAs. This will apply to protection bits other than ADI as
well of course. This becomes a partial failure of mprotect() call. I
think it should be all or nothing with mprotect() - when one calls
mprotect() from userspace, either the entire address range passed in
gets its protection bits updated or none of it does. That requires
validating protection bits upfront or undoing what earlier iterations of
VMA walk loop might have done.

--
Khalid

>=20
> static inline bool arch_validate_flags(unsigned long vm_flags)
> {
> 	if (!(vm_flags & VM_SPARC_ADI))
> 		return true;
>=20
> 	if (!adi_capable())
> 		return false;
>=20
> 	/* ADI can not be enabled on PFN mapped pages */
> 	if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
> 		return false;
>=20
> 	/*
> 	 * Mergeable pages can become unmergeable if ADI is enabled on
> 	 * them even if they have identical data on them. This can be
> 	 * because ADI enabled pages with identical data may still not
> 	 * have identical ADI tags on them. Disallow ADI on mergeable
> 	 * pages.
> 	 */
> 	if (vma->vm_flags & VM_MERGEABLE)
> 		return false;
>=20
> 	return true;
> }
>=20
>> That leaves open the question of should
>> generic mmap call arch_validate_prot and return EINVAL for invalid
>> combination of protection bits, but that is better addressed in a
>> separate patch.
>=20
> The above would cover mmap() as well.
>=20
> The current sparc_validate_prot() relies on finding the vma for the
> corresponding address. However, if you call this early in the mmap()
> path, there's no such vma. It is only created later in mmap_region()
> which no longer has the original PROT_* flags (all converted to VM_*
> flags).
>=20
> Calling arch_validate_flags() on mmap() has a small side-effect on the
> user ABI: if the CPU is not adi_capable(), PROT_ADI is currently ignore=
d
> on mmap() but rejected by sparc_validate_prot(). Powerpc already does
> this already and I think it should be fine for arm64 (it needs checking=

> though as we have another flag, PROT_BTI, hopefully dynamic loaders
> don't pass this flag unconditionally).
>=20
> However, as I said above, it doesn't solve the mmap() PROT_ADI checking=

> for sparc since there's no vma yet. I'd strongly recommend the
> arch_validate_flags() approach and reverting the "start" parameter adde=
d
> to arch_validate_prot() if you go for the flags route.
>=20
> Thanks.
>=20


