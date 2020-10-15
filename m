Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262DE28FB67
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 01:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbgJOXF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 19:05:27 -0400
Received: from mail-eopbgr1410042.outbound.protection.outlook.com ([40.107.141.42]:22880
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731114AbgJOXFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 19:05:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLcM0b93MSrIu0gdR/qCkFWMrQ+IVfSxSVHhZsv55B+tZuQywnDmj2LtmOoGW2W4zz87P8qa/3IXfWqtHOtrdE9B6OaEihltYw0JqZAc/5N70bIpiWjoohRreQQa+iSsLRxsz6tiAhpRIOIg0kCLW3Vd19pvsSLq5x8HCL2SYCXTJ1NbJjzRTNvh/7PPCtSygmDvviShaZ78bzwxvQ8RL9K43DXfF/KOB1sgxZ7MO+aksEEyNJwDIPPeSQcgWC+VmwIPRkF/s+HjbhgGMyjg9hvCZdlhs8WO5aU3gezvl0YmgRV/wPfFe+iDzx0SrUAHXdN9sHG/GgpzFJkPQYWaJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVt1oD+lU+EcpN76db2GoG1MHFhhh279a78yjfYLJJs=;
 b=NUHI1Em3RzWy4WL/lCCwew7XD0dTxn1GDS6iIHg+iMOezlkPDty6Rxn+d0ZSkY/z0k5unhAcOYdr4+Uq5O4yyfFD3WdU8VC+D0YxcrgvwHdStfLFsLz9aD98YMFNGUhh1whrZq8XFeuI9e1wAMpczL3ccdJXe6sDDdKvYJxPco7QAu0FvFujXC2Y4PvsLbRGI5S4obsBUNoACgZjFaqj/14SxTtnxq/YN3B4FMW7m/i/xKixEyp5AHbhkVYPMtjIDCaDOyLmpqNshn9VvXGbeMBMBbx9b22+O3Ul5w49ObqKn00E4xqDNUs/xx6f7i2AOZbPWRqk4pEIueRz3o0VFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVt1oD+lU+EcpN76db2GoG1MHFhhh279a78yjfYLJJs=;
 b=HcPhnwQmm046uY5M265mC3M103P1D9AckLgyNpfzdH8hUKfrkBvefzGnFFjJJJi38LhceuwpcKYQsu/vj4eqgbAEH7nFC9Qltlo9hWhiYfjhQrKfDD9NPw0L8PVA95TTBx+KkAwRo4m0NuWNTVHeM+KTyW1tyQf535F+YwD3Fk0=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TYAPR01MB2718.jpnprd01.prod.outlook.com (2603:1096:404:88::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Thu, 15 Oct
 2020 23:05:12 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206%7]) with mapi id 15.20.3455.030; Thu, 15 Oct 2020
 23:05:12 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/3] hugetlbfs: introduce hinode_rwsem for pmd sharing
 synchronization
Thread-Topic: [RFC PATCH 2/3] hugetlbfs: introduce hinode_rwsem for pmd
 sharing synchronization
Thread-Index: AQHWobZ0Ua+xFbd32UuAZQkoTCduxKmZS9eA
Date:   Thu, 15 Oct 2020 23:05:12 +0000
Message-ID: <20201015230511.GA4325@hori.linux.bs1.fc.nec.co.jp>
References: <20201013231100.71013-1-mike.kravetz@oracle.com>
 <20201013231100.71013-3-mike.kravetz@oracle.com>
In-Reply-To: <20201013231100.71013-3-mike.kravetz@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71115873-a348-4f34-2dd0-08d8715ec557
x-ms-traffictypediagnostic: TYAPR01MB2718:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB2718155105018B5CDA030A02E7020@TYAPR01MB2718.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1hjbCvzozI+i/5N5C/BbjtNPZrwNiU7iKNAc1aw4z3nAh1rEmd5PldI0DtSAie+6uznVMXI2e/8iNa7e+zqQiVn79MzYjh147MD85pxpYrDgvPO5Qvay8Kpde1jsHvpGelK5Qcc20fTLB0fvdjrPeaSQSJB+3d88cclcLiH42hb8frRB160eVqvwUs9vcpM/wjTtW5Q8iwTq5JxakUYOe9fg6N2UaATf4QxIR7CcHKs2uA+no+yR3z8JG9MKpB+C41G8I4Yj/L1qKgOcSKeExWi7uqKyCWIldB05gESyW9HNirNa9Z7uTtVE3Hnik4cY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(83380400001)(1076003)(33656002)(8936002)(86362001)(71200400001)(6916009)(2906002)(186003)(316002)(54906003)(5660300002)(6486002)(7416002)(64756008)(76116006)(66476007)(8676002)(66946007)(66556008)(55236004)(9686003)(26005)(6512007)(4326008)(6506007)(66446008)(478600001)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: HFJVDwSB/UaEDNukSs5LQZkL+9kVfPg8gQrNcPkNN4dpI90T4PTVLzmgs7HNH2rXHnaQqJM8+rOVYZwGzKXR9xtm7PaKSlW1VXkfT5oVHQG1oW+8XEKAv0vKHgduMBEMy9VzbOste5c5Yzz9uAjRvyfTL3XvMvZRcM14Cp+YkPcWPgCVHlAt41jVHz/4alT9iRCXl3ZYIfrsXepvzhx+loSKwwoe9Ubc8TYRiGNAhsssAbMkTK6Mcwm0BgmuET+vpqT7gUz80VWv/hCifvt2TXsBQ/rUrUROaTzIWzUdNubMlf7lMN+o8IJ572JMQN3DBlOgnJu5jQS01HsqWOVbFsCueza2CqguxvF01+dUL04gp2ffoXNh5+MdMnCIgmmGMdaerlNVi71iEfrAk55DJ1EOJyKehiJAALxMnYuN50WJUwREDticPjVGdFXfssn7nOnhslzChaudlH9QjF3xeJSbfnDcuaBRNXOEoWrUDD32tN/fk6IqXQ1KC+DieDmQsTnOdTxpJuc/OB7enuuvZtqB+beJgmvyA6KSthjFtTsgyhlLxKqYnX+QTyN/WCGRMxbkiDnIxHBNZlVPcirB/vGdZPW5Mowzyeac56WLJakVSGzkuSwG1UX89EvOXQXtXwAVsuFU10AWcQqh8gbwKg==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <62974E552E5AFF419936CA86F227CC97@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71115873-a348-4f34-2dd0-08d8715ec557
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 23:05:12.3645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7g/ZXvy1TB8ruXCcfOb1Su9tUGC6OfF6dBmyZbxy/qs6hE0/HZt1hQNfkjrupJubmClNhOU94SDOFUUJEr9t2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2718
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 04:10:59PM -0700, Mike Kravetz wrote:
> Due to pmd sharing, the huge PTE pointer returned by huge_pte_alloc
> may not be valid.  This can happen if a call to huge_pmd_unshare for
> the same pmd is made in another thread.
>=20
> To address this issue, add a rw_semaphore (hinode_rwsem) to the hugetlbfs
> inode.
> - hinode_rwsem is taken in read mode before calling huge_pte_alloc, and
>   held until finished with the returned pte pointer.
> - hinode_rwsem is held in write mode whenever huge_pmd_unshare is called.
>=20
> In the locking hierarchy, hinode_rwsem must be taken before a page lock.
>=20
> In an effort to minimize performance impacts, hinode_rwsem is not taken
> if the caller knows the target can not possibly be part of a shared pmd.
> lockdep_assert calls are added to huge_pmd_share and huge_pmd_unshare to
> help catch callers not using the proper locking.
>=20
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Hi Mike,

I didn't find a problem on main idea of introducing hinode_rwsem, so
I'm fine if the known problems are fixed.

I have one question. This patch seems to make sure that huge_pmd_unshare()
are called under holding hinode_rwsem in write mode for some case. Some
callers of try_to_unmap() seem not to hold it like shrink_page_list(),
unmap_page(), which is OK because they never call try_to_unmap() for hugetl=
b
pages.  And unmap_ref_private() doesn't takes hinode_rwsem either, and
that's also OK because this function never handles pmd sharing case.  So
what about unmap_single_vma()?  It seems that this generic function could
reach huge_pmd_unshare() without hinode_rwsem, so what prevents the race he=
re?
(Maybe I might miss some assumption or condition over this race...)

I left a few other minor comments below ...

> @@ -4424,6 +4442,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, str=
uct vm_area_struct *vma,
> =20
>  	ptep =3D huge_pte_offset(mm, haddr, huge_page_size(h));
>  	if (ptep) {
> +		/*
> +		 * Since we hold no locks, ptep could be stale.  That is
> +		 * OK as we are only making decisions based on content and
> +		 * not actually modifying content here.
> +		 */

nice comment, thank you.

>  		entry =3D huge_ptep_get(ptep);
>  		if (unlikely(is_hugetlb_entry_migration(entry))) {
>  			migration_entry_wait_huge(vma, mm, ptep);
> @@ -4431,20 +4454,32 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, st=
ruct vm_area_struct *vma,
>  		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
>  			return VM_FAULT_HWPOISON_LARGE |
>  				VM_FAULT_SET_HINDEX(hstate_index(h));
> -	} else {
> -		ptep =3D huge_pte_alloc(mm, haddr, huge_page_size(h));
> -		if (!ptep)
> -			return VM_FAULT_OOM;
>  	}
> =20
> +	/*
> +	 * Acquire hinode_sem before calling huge_pte_alloc and hold

                   hinode_rwsem?

> +	 * until finished with ptep.  This prevents huge_pmd_unshare from
> +	 * being called elsewhere and making the ptep no longer valid.
> +	 *
> +	 * ptep could have already be assigned via huge_pte_offset.  That
> +	 * is OK, as huge_pte_alloc will return the same value unless
> +	 * something has changed.
> +	 */

...=20

> @@ -278,10 +278,14 @@ static __always_inline ssize_t __mcopy_atomic_huget=
lb(struct mm_struct *dst_mm,
>  		BUG_ON(dst_addr >=3D dst_start + len);
> =20
>  		/*
> -		 * Serialize via hugetlb_fault_mutex
> +		 * Serialize via hinode_rwsem hugetlb_fault_mutex.
                                             ^ "and" here?

> +		 * hinode_rwsem ensures the dst_pte remains valid even
> +		 * in the case of shared pmds.  fault mutex prevents
> +		 * races with other faulting threads.
>  		 */
>  		idx =3D linear_page_index(dst_vma, dst_addr);
>  		mapping =3D dst_vma->vm_file->f_mapping;
> +		hinode_lock_read(mapping, dst_vma, dst_addr);
>  		hash =3D hugetlb_fault_mutex_hash(mapping, idx);
>  		mutex_lock(&hugetlb_fault_mutex_table[hash]);


Thanks,
Naoya Horiguchi=
