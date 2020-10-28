Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B19529D514
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgJ1V6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:58:38 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:27436 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727786AbgJ1V6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:58:36 -0400
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09SGNAQF032663;
        Wed, 28 Oct 2020 11:25:44 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-00010702.pphosted.com with ESMTP id 34cga0uv23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 11:25:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glx/fvdYnY6YOtoMyfz6BCcn6n7nhS5SnRf1afU//Y7dM3XeEKmmW44UdCXAb+k5goHVqPBKyUppf100jlnKWgC/mnPTVEAgwhrKk/876/RGJaUOU45TpNLLag7Mc2AZe6nWT3Jnaw5PunMAAWEAW2h1AztitSHMB8TRCgMUbyvZd73sc3AdEVxbkk6zZ9JmDfS1tXHuDvhwt+ndxkvUzz4oqssV21T79SMrXjtOyAMiLIOw/XBCFTsfSnAbAKCmT0+FAB204Njw8ufprX1P8gVhHqD0XqTOMPBGYRliexHcIvxlABY+cQDknZkJ+wO3i+9wNDn2fO4wI9YQG6uPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xU67ADJwSm5aLgtkfAiyZFqDjpgo4Q9UQeo8qv5MBqM=;
 b=mQ94W4eXHbA4OlLSX4gmCE4jdb8rkt3vvTx9HmZGX3eGSU/YfIkIoZRoBCLkVRRsQCl0SIcrBGeWK6TGAA69ks+0cht7ZuKqclIAbdQ5wzEVsl6RaYZLYjQTU94Zk6gIIaN2Z22zHKJq2ER8jTXgzEB/J/P/rL7OV/IqpWkFH+TPwsB/x4e1s9XwRtpuGpzmybcuYr2k36ymyD7CVpNeUh2dIbnlvzwiNppGF9/Y0OhVLfEebmVA7GLdtTwFoYSouU/ENzXpis6iYT8lhzmes9i4CszLUQvIJZ26v96u91h9bDegVnda/XCLgmKQ0BGdxmg9IsTbu3HKuWc4+JqTXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xU67ADJwSm5aLgtkfAiyZFqDjpgo4Q9UQeo8qv5MBqM=;
 b=MvEInlcmm0ZJlgvWTbvvIZd1IoEZmBvteNDFHe7BY/gIMalFGAlYwypdTyN0xFJFSlG7h4Aa8gNoEMNm6YBJ4wDCnMkqRI94omoG7z0qev2+WE959OP1sIFrNMF7nnza27TMJTemM6WW2Xb8aJRTL1GJZXu44X3gjukeeGcOJsw=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN6PR04MB4125.namprd04.prod.outlook.com
 (2603:10b6:805:2e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 28 Oct
 2020 16:25:42 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 16:25:42 +0000
Date:   Wed, 28 Oct 2020 11:25:40 -0500
From:   Michael Auchter <michael.auchter@ni.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <20201028162540.GA2310713@xaphan>
References: <20201014193615.1045792-1-michael.auchter@ni.com>
 <d5f8a417-8db9-9385-dfea-9512b4680124@gmail.com>
 <CAGETcx_869kxKbgRO68Wp9Qq8vAp8fqpAe_Lkjx8vZdW9RNTsQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_869kxKbgRO68Wp9Qq8vAp8fqpAe_Lkjx8vZdW9RNTsQ@mail.gmail.com>
X-Originating-IP: [2605:a601:ab23:3c00:cdda:4935:f7a0:c63c]
X-ClientProxiedBy: DM5PR07CA0072.namprd07.prod.outlook.com
 (2603:10b6:4:ad::37) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2605:a601:ab23:3c00:cdda:4935:f7a0:c63c) by DM5PR07CA0072.namprd07.prod.outlook.com (2603:10b6:4:ad::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 16:25:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 445a85b8-53ce-489a-707b-08d87b5e1d1c
X-MS-TrafficTypeDiagnostic: SN6PR04MB4125:
X-Microsoft-Antispam-PRVS: <SN6PR04MB4125C6DFAC363538CF64546987170@SN6PR04MB4125.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SbLN5KApTzaH2N9Vmg0B2r57hnXzQdIJk9XemXOznv3ekAow6cvY/JSdES4f4l1p0gGuHkngsPtznxeq0lAY268ezulPZkyB6QDlLPmTT73+XuMigMAH1kKwlnVpctuSlsFqESIopGwR1w8uDiZIwbXslSbx1o15d1S1PMM46m1I/eXHfbx788qRFn2oXNbZmYuQn7gvnZOJTj46g0gUfHTV3pvdJYLRBq4W6MgVhxp7tG99/TyaxhP69qEyBHViHIkA0FVw+BMKRW2q/oABYUjc19Z4k1kHaI3aveVBlPC7EZCcsT+hBVx6AGaG2HIbBv81QDPSldwRsA8XoeOEpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(346002)(366004)(396003)(376002)(136003)(39860400002)(86362001)(316002)(6486002)(66556008)(66476007)(6496006)(66946007)(52116002)(54906003)(33656002)(44832011)(5660300002)(83380400001)(8676002)(8936002)(1076003)(2906002)(6916009)(478600001)(33716001)(186003)(16526019)(4326008)(9686003)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: +MzZDTHrMZLsHjEjepk3pWQVV8QT0E8/FR4tBSKdQTJ4vG1KPGKkvsWAbNgylhpr98UyMVUG75av6GqQbqI64m9ukGZHD+QcBnxQCkYJFVHe1ZhKN2UBrPLez4g4bFSSHZ1GrHYpIP6mefNhsLX7bUgbNSruuquZ9u1MGOvx6fIcHMDTnwG79CnbiRg4dlKjf3GV34TXa62fSuTPkUQ34IHSzsXUYTEDguQVHBzEUr5OIYT/+tZEXpQAQR/Nx16/enCq9sutDEKuLbr7culB4cExFlhT7Fh65EAZbKO+PMIPSS+kPn0un/tTYBToFmdnw9m/upezg4I3Svl3SgvkHS5jpwXa5WRQcSleW1xF1YiCAbYqmgVaAsQ91TPunqFL9QHO/NcRI5XsDManerfCqRWR4SeWTH6k3ZB/6O64s1VR2ucKJ+lLS+NhtLz/pcrOskbha26+siP5yrLt/G2+uYS7LOQK3KAGs2qXg7SYj6BrWT2ieWJHR8o8d4MQcQ2LhxRiUW5yrrnCw45AF7PqSxAQnft3Oru1S0dzCMgi3KJs4XTXvkzyXxhk/qfWdlikUjYyNmgaZOAus5CLqduxEBQCBJY3Z5HUtaoLGmZYV22u/a5XqBNbdeCXNsS+hcPbFpV75kHXyBK+r5kZYz57U8KN7PdZpDEt1kMl9MdzSdhQP/BVgT4qROQCJh8nLGykq414MsgYhaKK21eRPR49sQ==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445a85b8-53ce-489a-707b-08d87b5e1d1c
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 16:25:42.0819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHJPVRYwHCmb0sSUqstgLKhTpuybycwuXqbmpVScD1Lk7NrZskI/OKhx4Vl+ZTbfPyo0pIntl+eBGEhy0Sf0qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4125
Subject: Re: Re: [RFC PATCH 0/3] Fix errors on DT overlay removal with devlinks
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-28_08:2020-10-28,2020-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=5
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 classifier=spam
 adjust=30 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Saravana,

Thanks for taking the time to look into this!

On Mon, Oct 26, 2020 at 12:10:33PM -0700, Saravana Kannan wrote:
> On Wed, Oct 21, 2020 at 2:02 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >
> > Hi Saravana,
> >
> > Michael found an issue related to the removal of a devicetree node
> > which involves devlinks:
> >
> > On 10/14/20 2:36 PM, Michael Auchter wrote:
> > > After updating to v5.9, I've started seeing errors in the kernel log
> > > when using device tree overlays. Specifically, the problem seems to
> > > happen when removing a device tree overlay that contains two devices
> > > with some dependency between them (e.g., a device that provides a clock
> > > and a device that consumes that clock). Removing such an overlay results
> > > in:
> > >
> > >   OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy
> > >   OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy
> > >
> > > followed by hitting some REFCOUNT_WARNs in refcount.c
> > >
> > > In the first patch, I've included a unittest that can be used to
> > > reproduce this when built with CONFIG_OF_UNITTEST [1].
> > >
> > > I believe the issue is caused by the cleanup performed when releasing
> > > the devlink device that's created to represent the dependency between
> > > devices. The devlink device has references to the consumer and supplier
> > > devices, which it drops in device_link_free; the devlink device's
> > > release callback calls device_link_free via call_srcu.
> > >
> > > When the overlay is being removed, all devices are removed, and
> > > eventually the release callback for the devlink device run, and
> > > schedules cleanup using call_srcu. Before device_link_free can and call
> > > put_device on the consumer/supplier, the rest of the overlay removal
> > > process runs, resulting in the error traces above.
> >
> > When a devicetree node in an overlay is removed, the remove code expects
> > all previous users of the related device to have done the appropriate put
> > of the device and to have no later references.
> >
> > As Michael described above, the devlink release callback defers the
> > put_device().  The cleanup via srcu was implemented in commit
> > 843e600b8a2b01463c4d873a90b2c2ea8033f1f6 "driver core: Fix sleeping
> > in invalid context during device link deletion" to solve yet another
> > issue.
> >
> >
> > >
> > > Patches 2 and 3 are an attempt at fixing this: call srcu_barrier to wait
> > > for any pending device_link_free's to execute before continuing on with
> > > the removal process.
> > >
> > > These patches resolve the issue, but probably not in the best way. In
> > > particular, it seems strange to need to leak details of devlinks into
> > > the device tree overlay code. So, I'd be curious to get some feedback or
> > > hear any other ideas for how to resolve this issue.
> >
> > I agree with Michael that adding an indirect call of srcu_barrier(&device_links_srcu)
> > into the devicetree overlay code is not an appropriate solution.
> 
> I kind of see your point too. I wonder if the srcu_barrier() should
> happen inside like so:
> device_del() -> device_links_purge()->srcu_barrier()
> 
> I don't know what contention the use of SRCUs in device links was
> trying to avoid, but I think the srcu_barrier() call path I suggested
> above shouldn't be a problem. If that fixes the issue, the best way to
> know if it's an issue is to send out a patch and see if Rafael has any
> problem with it :)

I was able to test this by adding the srcu_barrier() at the end of
device_links_purge(), and that does seem to have fixed the issue.

> > Is there some other way to fix the problem that 843e600b8a2b solves without
> > deferring the put_device() done by the devlink release callback?
> 
> Ok I finally got some time to look into this closely.
> 
> Even if you revert 843e600b8a2b, you'll see that device_link_free()
> (which drops the reference to the consumer and supplier devices) was
> scheduled to run when the SRCU clean up occurs. So I think this issue
> was present even before 843e600b8a2b, but commit 843e600b8a2b just
> made it more likely to hit this scenario because it introduces some
> delay in dropping the ref count of the supplier and consumer by going
> through the device link device's release path. So, I think this issue
> isn't related to 843e600b8a2b.
> 
> As to why 843e600b8a2b had to be written to call call_srcu() from the
> device link device's release path, it's a mess of dependencies/delays:
> 1. The device link device is part of the struct device_link. So we
> can't free device_link before the device_link.link_dev refcount goes
> to 0.
> 2. But I can't assume device_link.link_dev's refcount will go to 0 as
> soon as I call put_device() on it because of
> CONFIG_DEBUG_KOBJECT_RELEASE which frees up the kobject after a random
> delay.
> 3. The use of SRCU also means I can't free device_link until the SRCU
> is cleaned up.
> 
> Because of (1), (2) and (3), when the device_link_del() (or any of the
> other device link deletion APIs are called) I first have to do a
> put_device(device_link.link_dev) to make sure the device memory is no
> longer referenced, then trigger an SRCU clean up and then in the
> scheduled SRCU cleanup I can free struct device_link. And obviously,
> until struct device_link is ready to be freed up, I can't drop the
> reference to the supplier and consumer devices (as that old copy of
> device_link could be used by some code to refer to the supplier and
> consumer devices).
> 
> Hope that helps explain the SRCU and device link device release dependencies.
> 
> Also, even if this patch series is applied as is, I wonder if the
> current overlay code has a bug related to CONFIG_DEBUG_KOBJECT_RELEASE
> delaying the actual freeing of the device. Something to look into?

I also tried enabling CONFIG_DEBUG_KOBJECT_RELEASE... with or without
the addition of srcu_barrier() to device_links_purge(), I can't boot
successfully when CONFIG_OF_UNITTEST=y &&
CONFIG_DEBUG_KOBJECT_RELEASE=y: there are a ton of errors that result
from this combo.

Disabling the unittests and booting with CONFIG_DEBUG_KOBJECT_RELEASE=y,
I _do_ still see the errors mentioned in my original message when
removing an overlay. So yeah, it does seem like there are some latent
issues here...

Cheers,
 Michael
