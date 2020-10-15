Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCE428F55C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389495AbgJOOzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:55:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53864 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389416AbgJOOzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:55:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FEhrZB052451;
        Thu, 15 Oct 2020 14:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ueK+5z08xx09zYAdi9VimFxxn1I5v3nWGR96uKYJNFM=;
 b=kaDhG2k74OiAbUFy7+baU2RnCsv0qY5hkd+J6ISe3wwppx0JwAw5X/xQm6L+Bf+FmzEQ
 0V/Wh5IUgVavHCqYBDjypsA4GV4lO2kDUP9JOlC3cigQOoQM8SsN8W39IjyUxOoFNEdn
 TMutc8TBvAQgJjl5oprrpzoFRTMhLOlZxMHMaOMHMPwxWVL3w5VLv2fMq/3UGDp7JjWV
 uwjaxMhA4+QNnXnZzieerA6sSVdIjQRWhf86YlX4fbeQIBEpAWtG0rDd2eXuGSmWFfJG
 jMObM+6fcAlF4uosfUpdmizujuHqPAmLAuQx+vtDASBWcZiIVLDgWrMaOOkkM5p8KJCm vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 343vaekf7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Oct 2020 14:54:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FEjd1J027747;
        Thu, 15 Oct 2020 14:54:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 344by5a1nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Oct 2020 14:54:57 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09FEsrOX006866;
        Thu, 15 Oct 2020 14:54:53 GMT
Received: from [10.154.134.81] (/10.154.134.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Oct 2020 07:54:52 -0700
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
 <af207cf8-3049-85eb-349d-5fed6b9be49c@oracle.com>
 <20201012172218.GE6493@gaia>
 <20c85633-b559-c299-3e57-ae136b201526@oracle.com>
 <20201013091638.GA10778@gaia>
 <e4c2c56b-3dbe-73dd-ea72-a5378de7de6a@oracle.com>
 <20201015084936.GC20197@gaia>
From:   Khalid Aziz <khalid.aziz@oracle.com>
X-Pep-Version: 2.0
Organization: Oracle Corp
Message-ID: <09d9cb95-3414-ef29-de08-f4f2b22b7f77@oracle.com>
Date:   Thu, 15 Oct 2020 08:53:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201015084936.GC20197@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010150102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/20 3:05 AM, Catalin Marinas wrote:
> On Wed, Oct 14, 2020 at 03:21:16PM -0600, Khalid Aziz wrote:
>> What FreeBSD does seems like a reasonable thing to do. Any way first
>> thing to do is to update sparc to use arch_validate_flags() and update=

>> sparc_validate_prot() to not peek into vma without lock.
>=20
> If you go for arch_validate_flags(), I think sparc_validate_prot()
> doesn't need the vma at all.

Yes, the plan is to move vma flag check from sparc_validate_prot() to
arch_validate_flags()..

>=20
> BTW, on the ADI topic, I think you have a race in do_swap_page() since
> set_pte_at() is called before arch_do_swap_page(). So a thread in the
> same process would see the new mapping but the tags have not been
> updated yet. Unless sparc relies on the new user pte to be set, I think=

> you can just swap the two calls.
>=20

Thanks for pointing that out. I will take a look at it.

--
Khalid


