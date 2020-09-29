Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD9727D47E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgI2RaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:30:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58486 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgI2RaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:30:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08THO5Tc000826;
        Tue, 29 Sep 2020 17:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=x10vdcZygFwBhAQKwQ8d/UINuRe4BBcPPbo1w9Cq3eU=;
 b=PveahHWiqwegGPiJW675ylIuI/iLJfewyMLwqXzBr/mDiAJDZc4KEcjnCGsDcvZzF52a
 vfUaXxYJNBrV/c+iEVVvoEO/B5Or+uWmbpLgcemqMfSoY5WjY2Iiyo7PyuN0QtTrpBgR
 ebCUhOBVBqo3jcoz1w3HZ1s4tTNdj1tv20+YZArZW0L0ZpxCROddjUiviVsvMsHh4RsP
 phW73phmZSoI8iK2bF9+bmox9EbCHc+Fnq73dYzRVMemSnw2wq44CurSX7DmOhykHRZz
 /Dz7VMkRp7t5n5HBkLN/P63BXjJQ53FwYoUYjtPpkQYRmqPM/WRVIergto8H+pqpkXKr 0Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 33swkkv8af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 17:30:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08THOsTQ073592;
        Tue, 29 Sep 2020 17:30:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33uv2e7cd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 17:30:15 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08THUAqZ031610;
        Tue, 29 Sep 2020 17:30:10 GMT
Received: from [10.154.161.108] (/10.154.161.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Sep 2020 10:30:09 -0700
Subject: Re: SPARC version of arch_validate_prot() looks broken (UAF read)
To:     Jann Horn <jannh@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Khalid Aziz <khalid@gonehiking.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <CAG48ez3YsfTfOFKa-Po58e4PNp7FK54MFbkK3aUPSRt3LWtxQA@mail.gmail.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
X-Pep-Version: 2.0
Message-ID: <0fb905cc-77a2-4beb-dc9c-0c2849a6f0ae@oracle.com>
Date:   Tue, 29 Sep 2020 11:30:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez3YsfTfOFKa-Po58e4PNp7FK54MFbkK3aUPSRt3LWtxQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=2 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=2 mlxlogscore=999 clxscore=1011 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/20 6:14 AM, Jann Horn wrote:
> From what I can tell from looking at the code:
>=20
> SPARC's arch_validate_prot() looks up the VMA and peeks at it; that's
> not permitted though. do_mprotect_pkey() calls arch_validate_prot()
> before taking the mmap lock, so we can hit use-after-free reads if
> someone concurrently deletes a VMA we're looking at.

That makes sense. It will be a good idea to encapsulate vma access
inside sparc_validate_prot() between mmap_read_lock() and
mmap_read_unlock().

>=20
> Additionally, arch_validate_prot() currently only accepts the start
> address as a parameter, but the SPARC code probably should be checking
> the entire given range, which might consist of multiple VMAs?
>=20
> I'm not sure what the best fix is here; it kinda seems like what SPARC
> really wants is a separate hook that is called from inside the loop in
> do_mprotect_pkey() that iterates over the VMAs? So maybe commit
> 9035cf9a97e4 ("mm: Add address parameter to arch_validate_prot()")
> should be reverted, and a separate hook should be created?
>=20
> (Luckily the ordering of the vmacache operations works out suIch that
> AFAICS, despite calling find_vma() without holding the mmap_sem, we
> can never end up establishing a vmacache entry with a dangling pointer
> that might be considered valid on a subsequent call. So this should be
> limited to a rather boring UAF data read, and not be exploitable for a
> UAF write or UAF function pointer read.)
>=20

I think arch_validate_prot() is still the right hook to validate the
protection bits. sparc_validate_prot() can iterate over VMAs with read
lock. This will, of course, require range as well to be passed to
arch_validate_prot().

Thanks,
Khalid

