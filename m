Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23E029F6B2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 22:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgJ2VN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 17:13:28 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:41596 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbgJ2VN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 17:13:27 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09TL440N016260;
        Thu, 29 Oct 2020 16:13:22 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2053.outbound.protection.outlook.com [104.47.36.53])
        by mx0b-00010702.pphosted.com with ESMTP id 34ch80ejjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 16:13:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaP8m4Z5KCcu6DV0+mWWbNjzEp0B5vWKLb0LxMsdbKWGHk9H3JCUmOvG6ZVoMep6F42se+eY0ifNY9qBk5xWS+0yqlbxGSPUPwh9/hyEb8KrXIZ8T1AqOdWZH9Urd96jkQ0r618aL35lJSqYpjgVdUSODq3k2AFfeB3Up97TBJr0HZmUlLh2lC+VME9eEo6pa5zWNGX7+XSEDc0uMlwfPCiylkxageAOcWVjvcaUEW4DOxlkmoox2bTRwjlUHRml/f0xk3tJT4w46u4Bd+Af9pgqvBqjDT6NZt/ljihIc1Lg4nEWNkXPa/es1WbeT8iWkCZgaLyZPTI2voiaBEvJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxSKt1wOUs3hTAMzx+t7uuoqTXQMqsSyBi/FVqLzqz0=;
 b=drMSyH7x/ze93eOEXcUNJhkErtv+2nXl5cvjB3qP7GcpP1Hy/U/zgVe+xQ6BpEGM2sZNKrwUxRFSzGpBO/rpupKf2tqMNwyJ8qISF331oTXZtn6OfcffOh8JUJpkxTVeVw9viXA8spVkZu4NCNQY+1PCoiFiD6EVhixBW4Rgc7WzPyFuD76ASb8/TMzr/XVKJ92VuzBOkDmXZbmkRhA7e5mi1/aTELEeLJ0vC0ETO735ZBxKxi2odV4PQsPTJS8AfDlm1Q7Mg6nhZqD6jW0hbD5ry847OBI8YwI8CzW1+lBXq+IFs6OOKIgxHJ+wD//CpbW+mFpXROwI6JA5CK620g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxSKt1wOUs3hTAMzx+t7uuoqTXQMqsSyBi/FVqLzqz0=;
 b=F6pzzeRRHzulR5gFzaceMnwSbu+2ooaX3Z4lcQgE+PBaPsqcNuGWoLSLU3M7BOq/JhoL/DYRXyJBernOXBWUKycPMkeW9bbB6uPjw+skxAmwlN6r4ZXvBU39ispzIgC85+xBjpWE61FS63BaBOlT6xfVHKe65iTSkGppzI5+Cuk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=ni.com;
Received: from DM5PR0401MB3639.namprd04.prod.outlook.com (2603:10b6:4:77::34)
 by DM6PR04MB6762.namprd04.prod.outlook.com (2603:10b6:5:24f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 29 Oct
 2020 21:13:20 +0000
Received: from DM5PR0401MB3639.namprd04.prod.outlook.com
 ([fe80::d98c:c98a:dd45:36c3]) by DM5PR0401MB3639.namprd04.prod.outlook.com
 ([fe80::d98c:c98a:dd45:36c3%6]) with mapi id 15.20.3477.029; Thu, 29 Oct 2020
 21:13:20 +0000
Date:   Thu, 29 Oct 2020 16:13:19 -0500
From:   Michael Auchter <michael.auchter@ni.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <20201029211319.GB2361266@xaphan>
References: <20201014193615.1045792-1-michael.auchter@ni.com>
 <d5f8a417-8db9-9385-dfea-9512b4680124@gmail.com>
 <CAGETcx_869kxKbgRO68Wp9Qq8vAp8fqpAe_Lkjx8vZdW9RNTsQ@mail.gmail.com>
 <20201028162540.GA2310713@xaphan>
 <9e8e7f6e-cebc-a99e-b883-b7555dc01ef6@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e8e7f6e-cebc-a99e-b883-b7555dc01ef6@gmail.com>
X-Originating-IP: [2605:a601:ab23:3c00:cdda:4935:f7a0:c63c]
X-ClientProxiedBy: DM5PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:3:93::17) To DM5PR0401MB3639.namprd04.prod.outlook.com
 (2603:10b6:4:77::34)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2605:a601:ab23:3c00:cdda:4935:f7a0:c63c) by DM5PR20CA0007.namprd20.prod.outlook.com (2603:10b6:3:93::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 29 Oct 2020 21:13:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c49bf19e-7af8-4343-9ad1-08d87c4f768c
X-MS-TrafficTypeDiagnostic: DM6PR04MB6762:
X-Microsoft-Antispam-PRVS: <DM6PR04MB67624D338F1F639723475E7087140@DM6PR04MB6762.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o36eLkol2Y29Oxr3zr99uEETwgAv8xZ+G10epOXPfAjeglnFnlKzPxnNlyc2S27Oaxdih8YmS6HcP3RAA0BEqBR99MqpKDOYxTiN9wkpHhmDYxHyt4iKbhrcN7yMKmLL8DAcGxu6iBzcuij+VvocH+4hGUWChQyQedu28rXUt0wOlCybCToX3t5Jj0NJxrg1CHwMdTtXD99PyklMDYBU3PXSOX2jEPByV4JifY+MNGm7FG/vhmF32cq+8GVA9q7palpNBsxYhWQbSJH0BinkOlIZLvo2QrXQeaSjc3VnnaiQOCh99oGqsyVsz3LHD2MQGRpRnZo+S7PqZZ+VFkbQfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3639.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(39860400002)(366004)(136003)(396003)(346002)(6496006)(33716001)(66946007)(316002)(86362001)(6916009)(2906002)(54906003)(8676002)(478600001)(52116002)(53546011)(44832011)(186003)(9686003)(83380400001)(16526019)(4326008)(5660300002)(66556008)(8936002)(66476007)(6486002)(33656002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: WFJW2V1jTGRPirQmyKFdCqdJFUoLLIPAVZXKczhGxmIGxPUes/vb2LQ26f0raX7oVjHUCGClxPT/vVOvgavIXPi+G6YfUPHj2iLPnknTwfK/alUJ/MA2v9vZqSZrAHHOq59xkVkP/Vletm6F3L2zOtLR+PbKxD3RnSCapNeyOt+D1aZcBfzlzWmWzYeNqFo7B4rF3eJXRezwxPzBfglzU0Rc+hYywpxiz+u4kGWLs0j4s4wB1RbBAladZZKFDr4APN5WesuXIJtC87oFgm3oDbYZcJbAKyXnpwo8+yaVqnU0ohe+H6z4ftKLEgzyDHyJPJn3TWbJQx67x8IYwov/tdlYVCHs73QbTwqeHgopT1eCjcurcfXrXWs6QoD3uijKig4Q/6X5RB+Oiv7rTpu153sZCInvEUy2dEtyQFv62Ywtnr+5Z98yvSyl/1r4noMkTTQjhbfX55Fdbl8j4YSWNLy+G44Tytmpo22sqeR8XQhfsKmC+h4sv3zmrsGsmCzCCf5ccT9OIwcHSpm2jjmohQAfiMz7RQdTIuc8UjyOlxK83dVxadFlMQqUV5FC/iMCq1EBo8XW8vwWO7f2W+fdqCo5K4BScsA8F7OwSYDJq3gC1fZCrkpJU7RL+lLAiBStg/29vJC84U/FB+JPg+4z4wsI7vOF/JjePDlqNg3emCx1HVRvZoO4N8URbTj5e/B4+SoPK0Veeqdo1hTc26nfbQ==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49bf19e-7af8-4343-9ad1-08d87c4f768c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3639.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 21:13:20.7990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKu6B5TC/qJtCXDUAq/XRdVvI+NM9u1a1JM8mPPP/wZFHfh+EdMWbf5dWNPzeFRFZCHJ4k2WWNDScIIPYQRgrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6762
Subject: Re: Re: [RFC PATCH 0/3] Fix errors on DT overlay removal with devlinks
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_12:2020-10-29,2020-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 clxscore=1015
 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=5 phishscore=0
 malwarescore=0 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290147
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 03:54:21PM -0500, Frank Rowand wrote:
> On 10/28/20 11:25 AM, Michael Auchter wrote:
> > Hey Saravana,
> > 
> > Thanks for taking the time to look into this!
> > 
> > On Mon, Oct 26, 2020 at 12:10:33PM -0700, Saravana Kannan wrote:
> >> On Wed, Oct 21, 2020 at 2:02 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>>
> >>> Hi Saravana,
> >>>
> >>> Michael found an issue related to the removal of a devicetree node
> >>> which involves devlinks:
> >>>
> >>> On 10/14/20 2:36 PM, Michael Auchter wrote:
> >>>> After updating to v5.9, I've started seeing errors in the kernel log
> >>>> when using device tree overlays. Specifically, the problem seems to
> >>>> happen when removing a device tree overlay that contains two devices
> >>>> with some dependency between them (e.g., a device that provides a clock
> >>>> and a device that consumes that clock). Removing such an overlay results
> >>>> in:
> >>>>
> >>>>   OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy
> >>>>   OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy
> >>>>
> >>>> followed by hitting some REFCOUNT_WARNs in refcount.c
> >>>>
> >>>> In the first patch, I've included a unittest that can be used to
> >>>> reproduce this when built with CONFIG_OF_UNITTEST [1].
> >>>>
> >>>> I believe the issue is caused by the cleanup performed when releasing
> >>>> the devlink device that's created to represent the dependency between
> >>>> devices. The devlink device has references to the consumer and supplier
> >>>> devices, which it drops in device_link_free; the devlink device's
> >>>> release callback calls device_link_free via call_srcu.
> >>>>
> >>>> When the overlay is being removed, all devices are removed, and
> >>>> eventually the release callback for the devlink device run, and
> >>>> schedules cleanup using call_srcu. Before device_link_free can and call
> >>>> put_device on the consumer/supplier, the rest of the overlay removal
> >>>> process runs, resulting in the error traces above.
> >>>
> >>> When a devicetree node in an overlay is removed, the remove code expects
> >>> all previous users of the related device to have done the appropriate put
> >>> of the device and to have no later references.
> >>>
> >>> As Michael described above, the devlink release callback defers the
> >>> put_device().  The cleanup via srcu was implemented in commit
> >>> 843e600b8a2b01463c4d873a90b2c2ea8033f1f6 "driver core: Fix sleeping
> >>> in invalid context during device link deletion" to solve yet another
> >>> issue.
> >>>
> >>>
> >>>>
> >>>> Patches 2 and 3 are an attempt at fixing this: call srcu_barrier to wait
> >>>> for any pending device_link_free's to execute before continuing on with
> >>>> the removal process.
> >>>>
> >>>> These patches resolve the issue, but probably not in the best way. In
> >>>> particular, it seems strange to need to leak details of devlinks into
> >>>> the device tree overlay code. So, I'd be curious to get some feedback or
> >>>> hear any other ideas for how to resolve this issue.
> >>>
> >>> I agree with Michael that adding an indirect call of srcu_barrier(&device_links_srcu)
> >>> into the devicetree overlay code is not an appropriate solution.
> >>
> >> I kind of see your point too. I wonder if the srcu_barrier() should
> >> happen inside like so:
> >> device_del() -> device_links_purge()->srcu_barrier()
> >>
> >> I don't know what contention the use of SRCUs in device links was
> >> trying to avoid, but I think the srcu_barrier() call path I suggested
> >> above shouldn't be a problem. If that fixes the issue, the best way to
> >> know if it's an issue is to send out a patch and see if Rafael has any
> >> problem with it :)
> > 
> > I was able to test this by adding the srcu_barrier() at the end of
> > device_links_purge(), and that does seem to have fixed the issue.
> > 
> >>> Is there some other way to fix the problem that 843e600b8a2b solves without
> >>> deferring the put_device() done by the devlink release callback?
> >>
> >> Ok I finally got some time to look into this closely.
> >>
> >> Even if you revert 843e600b8a2b, you'll see that device_link_free()
> >> (which drops the reference to the consumer and supplier devices) was
> >> scheduled to run when the SRCU clean up occurs. So I think this issue
> >> was present even before 843e600b8a2b, but commit 843e600b8a2b just
> >> made it more likely to hit this scenario because it introduces some
> >> delay in dropping the ref count of the supplier and consumer by going
> >> through the device link device's release path. So, I think this issue
> >> isn't related to 843e600b8a2b.
> >>
> >> As to why 843e600b8a2b had to be written to call call_srcu() from the
> >> device link device's release path, it's a mess of dependencies/delays:
> >> 1. The device link device is part of the struct device_link. So we
> >> can't free device_link before the device_link.link_dev refcount goes
> >> to 0.
> >> 2. But I can't assume device_link.link_dev's refcount will go to 0 as
> >> soon as I call put_device() on it because of
> >> CONFIG_DEBUG_KOBJECT_RELEASE which frees up the kobject after a random
> >> delay.
> >> 3. The use of SRCU also means I can't free device_link until the SRCU
> >> is cleaned up.
> >>
> >> Because of (1), (2) and (3), when the device_link_del() (or any of the
> >> other device link deletion APIs are called) I first have to do a
> >> put_device(device_link.link_dev) to make sure the device memory is no
> >> longer referenced, then trigger an SRCU clean up and then in the
> >> scheduled SRCU cleanup I can free struct device_link. And obviously,
> >> until struct device_link is ready to be freed up, I can't drop the
> >> reference to the supplier and consumer devices (as that old copy of
> >> device_link could be used by some code to refer to the supplier and
> >> consumer devices).
> >>
> >> Hope that helps explain the SRCU and device link device release dependencies.
> >>
> >> Also, even if this patch series is applied as is, I wonder if the
> >> current overlay code has a bug related to CONFIG_DEBUG_KOBJECT_RELEASE
> >> delaying the actual freeing of the device. Something to look into?
> > 
> > I also tried enabling CONFIG_DEBUG_KOBJECT_RELEASE... with or without
> > the addition of srcu_barrier() to device_links_purge(), I can't boot
> > successfully when CONFIG_OF_UNITTEST=y &&
> > CONFIG_DEBUG_KOBJECT_RELEASE=y: there are a ton of errors that result
> > from this combo.
> 
> I'll add looking checking out booting with CONFIG_DEBUG_KOBJECT_RELEASE
> enabled with CONFIG_OF_UNITTEST enabled to my todo list.
> 
> > 
> > Disabling the unittests and booting with CONFIG_DEBUG_KOBJECT_RELEASE=y,
> > I _do_ still see the errors mentioned in my original message when
> > removing an overlay. So yeah, it does seem like there are some latent
> 
> Just to make sure I understand clearly, you are still seeing the
> messages:
> 
>    OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy
>    OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy
> 
> when the overlay is removed?  And if I apply patch 1/3 (the new unittest)
> and also add srcu_barrier() at the end of device_links_purge()
> then I will see these messages?

Yes, that's correct: with CONFIG_DEBUG_KOBJECT_RELEASE=y + the new
unittest, I see those errors when booting, regardless of whether the
srcu_barrier is present in device_links_purge().

> Can you add a reply to this email with the patch to add srcu_barrier() at
> the end of device_links_purge() so that I am testing the same thing that
> you are testing?  (If it makes life easier for you, you can just cut
> and paste the patch into the reply, even if it results in a white
> space damaged patch -- I'm assuming a one-line patch.)

Sure thing:

From 87d9e27d1c10ec35a82db0c6d2b4d87ba22bbda5 Mon Sep 17 00:00:00 2001
From: Michael Auchter <michael.auchter@ni.com>
Date: Wed, 28 Oct 2020 15:43:04 -0500
Subject: [PATCH] driver core: wait for srcu callbacks in device_links_purge

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
 drivers/base/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f90e9f77bf8c..e131cc2e7083 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1399,6 +1399,8 @@ static void device_links_purge(struct device *dev)
 	}
 
 	device_links_write_unlock();
+
+	srcu_barrier(&device_links_srcu);
 }
 
 static u32 fw_devlink_flags = DL_FLAG_SYNC_STATE_ONLY;
-- 
2.25.4

