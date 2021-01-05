Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D454E2EB357
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbhAETIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:08:45 -0500
Received: from mail-dm6nam11on2080.outbound.protection.outlook.com ([40.107.223.80]:38048
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbhAETIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:08:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3DuFcmqGkJJE64wtm1JUL5FuxNAtiY7ySNC6BmjFguIpgZULAKbyr1B6hwLgJdttYeWdcG5omm2Ul+5KKnxzoEz5HTevDlUvvTkPTGNyuKsPcj0JuQAQJmdQ8cjGIg2HMfCVTzwdU39O1SDz5Z0Mj34PO35TSKFdxVO+PiNnVjZ7bZq3qUgC7uDZtln78ZxjWZTjTC+3ThkEpdCgcApgTHntGTkBXA9ISvlOuh/9k+IWEjA4zBmfPytv6xPZ5bajOA9Jwii1oLrYaEeWfqEi8L6ZRNCaz0vPoM+gbU0RCoJMDvJY7WWcjJaKapwWHicMW++v5dq0Zj3xnUtovYcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrBJwlafZQweejwhs/dyGVk19jF/lGOYrIZ/Tya8UbY=;
 b=Yl6PLPe4j7IR2vl6imtgDKVcAqx3NiY8C0lu8nAfipRYy+E3AKqSNSJO7MXGH6CRKmAbqqarhXK4mVp0/kr+10naqn9DJH3gatyN5N6/RvT+5HRcu7oDwrSU4Vn4qewbYkKkNJhd8UOORlzLG/lt4SNHSSZsO4dxrd+MC5i4pelUg8ql9eBc9JVHXFVL6JisRpi1N7Y7eaplTRMg1hmJE2DosQ2kEUkqmSZuHZT1JMeCqycxjgG9v704u07eDCYXQZYnDmDKdoYnS2ltbUJr3I06HHUL6po/MGfvN31Bk0PVLA1LJ4zU04o42FyND34dyO0nr5UkZ6aborNtxVEVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrBJwlafZQweejwhs/dyGVk19jF/lGOYrIZ/Tya8UbY=;
 b=xFJ+xiFOkcQhNEDuEkX4sQuIQAwa59Y2s2rK855P86rNMQPhTEqMwwr1+LuWjcBO5WSNjxopDWOd55ZrFRnsJj930KMumb//fYxvKEAFwJgE/NKCH38ZewWraMlVa/L0t2ZLPFz25akWkvrFQbjeO9Pi0MMEUlWIQNIFvqIa82I=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB4582.namprd05.prod.outlook.com (2603:10b6:a02:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.4; Tue, 5 Jan
 2021 19:07:52 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::d421:f99:8921:1ee7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::d421:f99:8921:1ee7%6]) with mapi id 15.20.3742.006; Tue, 5 Jan 2021
 19:07:51 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Xu <peterx@redhat.com>
CC:     linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Thread-Topic: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Thread-Index: AQHW43ScO4K8xuaKgUCXplD05vzEqqoZZTeA
Date:   Tue, 5 Jan 2021 19:07:51 +0000
Message-ID: <070CFD88-57A0-40FF-9614-6ED47B214301@vmware.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com> <20210105150813.GB149908@xz-x1>
In-Reply-To: <20210105150813.GB149908@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ce7f3fc-39bd-4772-73f5-08d8b1ad3338
x-ms-traffictypediagnostic: BYAPR05MB4582:
x-microsoft-antispam-prvs: <BYAPR05MB4582AD6ADF0E1BA2ED1FC646D0D10@BYAPR05MB4582.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qaQiF8v2Y3Aglgd+Lm9l8844iVaWmttQbjvHxwILTaneNo7sK1V35Ctd4o8MFjtU2wTDMVyjo+fgmjUwwnx4oYCkvqNZT/Ns8FFnfhwYwfAxyeJQbQgwyMk0NNkFN4aXc6IXqaH7rGB67vzuJXozYAwTJT3U5aECGEMRu5VDpdB/YW/EfOFfmsFxHAyTNZldceyBz2pAVRrHsiPrgBZlh0q9fvJ6RyRQRazGZZ77YcZlHsJZgN6kvWFHUq/xDtsGv9fq9PlQr/7sv9/1Eb86LCAGd8mY/heNX97bBwXM5buXzFHdwGIUoWM+PRF5awifydY/awgN13RYXGjpADPmcY1c+EQZg+0mZQE9mjKBp/LpWXx1W3mz3bO53vtj+WWdyI2sdwD8ar6V4ypF2p0OGTiG3cbMe8KB/PfWowNXmBjx0bFObbZ5wJr18PA8macC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(8936002)(186003)(6512007)(86362001)(83380400001)(71200400001)(53546011)(36756003)(6486002)(26005)(6506007)(8676002)(54906003)(66946007)(64756008)(66446008)(76116006)(66476007)(66556008)(316002)(6916009)(4326008)(5660300002)(2906002)(2616005)(478600001)(7416002)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CN3qBXoQM0+KcFSr62tjqtYhskmixPYFWCSLKnaR4vks7l3H9mod3d0vqr9K?=
 =?us-ascii?Q?8nAXKCVFmQeuTW2rUBmrf9fmCgF6LFICKfw6qyQ8TeA4k6xVoQHaxK8nLDex?=
 =?us-ascii?Q?XCjVLxI+HTTZ8/EC9H/Lpnr0ezqAE975JUWZd5dk1hJiX6GkiCTr4FCyR0iz?=
 =?us-ascii?Q?Apt9yiuSloMSUx0FPm/0hZZbiEv31qyWhuKAW7Nf+5XCAaDCYDo3SKJQ9XEk?=
 =?us-ascii?Q?W383nxc4lXDg9j7V3wWzBdppYZjXF1I621iqi8MgEcbNhpospyZLBg/RPOkg?=
 =?us-ascii?Q?RwvjzVAgMOJa/U+KZjatpP7tJBygfCyQ5IyVE4f0Es/dcEif5S65NUz61CFM?=
 =?us-ascii?Q?cMTLA3MXGuYdzIHLsmu833l1rl8GIODE+zODeyRQVRYjvIrAOUWXMBktGF4X?=
 =?us-ascii?Q?igr46mp9PRcJFE05o+26y2QykheuZZozS7Gaz+yCWqN6+lyOowCmpO35NZwo?=
 =?us-ascii?Q?v1TXp0YRuW599Yu1N7BBoocQYIqKfO0cgLQU4gx9rGcF4X/FjSPSfAkdMyJW?=
 =?us-ascii?Q?PfCleUchXlQ50ykQ4e6zcRCxvEdd4Fp6mconhJv8zZbkRWpurpqcYsalT6pY?=
 =?us-ascii?Q?f3+QufZs+35rNXyw9ZS5l7p0qKrUT1DKfUPlvH2PuFKo6TmjeK4P2sjAa6ci?=
 =?us-ascii?Q?/fWOm9BKV3x19DJFimk5YpHrTk9KW1RhRXhEsmMiFpQ5bsr3dcGMN65rIfrX?=
 =?us-ascii?Q?NL+ntty59ToJ03y9G55g7yfILP9HpjN5+qDhPSUmcnnTIDg7E/WKhVSJ66Xm?=
 =?us-ascii?Q?eqNu4kFAWo1wm8Hv2V9bE51O/bpCJ3BiptE/egCTIbGDym2uQuczUYC47Ti4?=
 =?us-ascii?Q?v3d/8KZ+mMlnd53WLLYeNlz5Elj5y/VrcBISxqNS+t+vJ59zpWHn9eZiG7QE?=
 =?us-ascii?Q?7UmpCdmWVIUS90t5V5SHwWfLgRzQuG7jxOkMjaPIq9RzL6H9BaIwNJz+P0bo?=
 =?us-ascii?Q?UcZvq9ju30+IIt3GErC+uynEKncLgYY222/w8zwsE3jJ9SutKwoNtocLH4f2?=
 =?us-ascii?Q?pWIF?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <46673C3D88D87E43A30C13736D58D9B6@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce7f3fc-39bd-4772-73f5-08d8b1ad3338
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 19:07:51.8991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +lomDiUwpK2kihH+3SKBRYDs4YkYjcJU6e5rXIuQwCWFuCRW8jlo8aMUK08fRLLFgD31JYihRHrUrHd+Z2B2IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4582
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 5, 2021, at 7:08 AM, Peter Xu <peterx@redhat.com> wrote:
>=20
> On Fri, Dec 25, 2020 at 01:25:28AM -0800, Nadav Amit wrote:
>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>> index ab709023e9aa..c08c4055b051 100644
>> --- a/mm/mprotect.c
>> +++ b/mm/mprotect.c
>> @@ -75,7 +75,8 @@ static unsigned long change_pte_range(struct vm_area_s=
truct *vma, pmd_t *pmd,
>> 		oldpte =3D *pte;
>> 		if (pte_present(oldpte)) {
>> 			pte_t ptent;
>> -			bool preserve_write =3D prot_numa && pte_write(oldpte);
>> +			bool preserve_write =3D (prot_numa || uffd_wp_resolve) &&
>> +					      pte_write(oldpte);
>=20
> Irrelevant of the other tlb issue, this is a standalone one and I comment=
ed in
> v1 about simply ignore the change if necessary; unluckily that seems to b=
e
> ignored..  so I'll try again - would below be slightly better?
>=20
>    if (uffd_wp_resolve && !pte_uffd_wp(oldpte))
>        continue;
>=20
> Firstly, current patch is confusing at least to me, because "uffd_wp_reso=
lve"
> means "unprotect the pte", whose write bit should mostly be cleared alrea=
dy
> when uffd_wp_resolve is applicable.  Then "preserve_write" for that pte l=
ooks
> odd already.
>=20
> Meanwhile, if that really happens (when pte write bit set, but during a
> uffd_wp_resolve request) imho there is really nothing we can do, so we sh=
ould
> simply avoid touching that at all, and also avoid ptep_modify_prot_start,
> pte_modify, ptep_modify_prot_commit, calls etc., which takes extra cost.

Sorry for missing your feedback before. What you suggest makes perfect
sense.=
