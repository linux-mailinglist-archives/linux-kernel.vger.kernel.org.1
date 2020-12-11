Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644EC2D7CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 18:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395242AbgLKR1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 12:27:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:5269 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395258AbgLKR0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:26:55 -0500
IronPort-SDR: UUnfZaWDKeVNgKdugKnUXn9tks9fEa+G2r/iaggfdsnrFHBULZyE9kea5fQPMI8RXjfC1dZXx5
 8Yq3vqcnj14g==
X-IronPort-AV: E=McAfee;i="6000,8403,9832"; a="153700924"
X-IronPort-AV: E=Sophos;i="5.78,412,1599548400"; 
   d="scan'208";a="153700924"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 09:26:12 -0800
IronPort-SDR: I2D2p0AMo5G1kk6j6apY0XIGrIu5i1o3GbzifrQO+oGCv5UBkrW2HSYZmgXWtU2tAULrgZcRb9
 8coOKUuC3Yqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,412,1599548400"; 
   d="scan'208";a="349575412"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 11 Dec 2020 09:26:11 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 11 Dec 2020 09:26:11 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 11 Dec 2020 09:26:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 11 Dec 2020 09:26:10 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 11 Dec 2020 09:26:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LopMqL/XexJAxVc0lHFvkuWzhQotWdd8AtOq2awCD7cfLM138bt+OMvb8cH0TrLw9W8Qe3gwmrS0Z8YU+ysK41fiRBTtFKwn9YJUzj+b3wGMONYxXmlcC5uzIWX59CI96OD4ePbZcgH9Fw0IwrI1IoNx1Z8xuiA3MHZ46HPZRnX31I/4b61jofcw6TMBM5VSGUDQ1Mw3U4sakliaP79JfP2h7zclNb+NhqNU25df9kkaOfVSI1N3D4biz1us64Irg2n3TJruY8JMrxy5NG82I+g61fotkqyTVwWbgJ9/ki7PzATS/Y3DnRV8p2qbIbEHkvZThrAwLrV6ZFxvXbEVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuizWpEaieOXv6P/sKznbaC4zb6reBmB141i2pBRFh4=;
 b=Haig0zk7fbKBAuSaqY1IxGXb0nox9tQU0VJi0Rx1GJwRElvWefh3gMt0UeI2Naqbz/Xezjt0vivOzjH6gd/fSyOTCcO+UBhmLVtzYCBdoqPWM2F3ZBTH+pVKWJUeU65yhkvjWmj/3RQePCw9OV2TZaUb4+izG1IowmOPZVTyowZAPK0Sa72x7NFS6046WyDgHNEZQba58nzPPIx1wej4RZp8pB6tQn+DxAua5ABUusKRbIgcd1WK4nrLQo9LAG17FL3sl6oPbukIqUQvB3LgShMJ/rpfbET3uW3SqiLQ81tTFkj4ZS2Sf4vyaoCL16udjRhW0lyz7ObBGHFvdkJjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuizWpEaieOXv6P/sKznbaC4zb6reBmB141i2pBRFh4=;
 b=Nl9wtREzAJOHs1QOT1tdzL/LZuzjwS+2cQ68GonAuqVCrI0mnGBa4J1oDXJ10kFLRdph3LH2LbAxOt5jTSQ1zfNP/d5MX1MZLi/LvzObzHlaymok3lz49iI1JwNoDLg9GUdA4G69CzisqaFNoeWYAP62lx7rZI2Rr7jpXUpI4Zw=
Received: from MWHPR11MB1679.namprd11.prod.outlook.com (2603:10b6:301:f::12)
 by MWHPR11MB1742.namprd11.prod.outlook.com (2603:10b6:300:113::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 11 Dec
 2020 17:26:09 +0000
Received: from MWHPR11MB1679.namprd11.prod.outlook.com
 ([fe80::c84:799f:437b:19d0]) by MWHPR11MB1679.namprd11.prod.outlook.com
 ([fe80::c84:799f:437b:19d0%4]) with mapi id 15.20.3654.013; Fri, 11 Dec 2020
 17:26:09 +0000
From:   "Gross, Mark" <mark.gross@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
CC:     "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>
Subject: RE: [PATCH 03/22] keembay-ipc: Add Keem Bay IPC module
Thread-Topic: [PATCH 03/22] keembay-ipc: Add Keem Bay IPC module
Thread-Index: AQHWyDJR6ibfO+n2Z0iYweamtROKuKnjVd+AgApCJ4CAAA2ngIADETYAgADmXICAAJXDQA==
Date:   Fri, 11 Dec 2020 17:26:09 +0000
Message-ID: <MWHPR11MB1679089EDC581294CE9EB0E38ECA0@MWHPR11MB1679.namprd11.prod.outlook.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-4-mgross@linux.intel.com> <X8cyA1qKCwrayEOp@kroah.com>
 <bcf8bad08a5f586093a151126aba2127eee44c02.camel@linux.intel.com>
 <X8/YceIsM/Akt/E/@kroah.com>
 <a5a13b6b399745f1f8b369334b0e626ee16d532a.camel@linux.intel.com>
 <X9MsXRDcdoftq8ZC@kroah.com>
In-Reply-To: <X9MsXRDcdoftq8ZC@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [50.53.49.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 085736f1-2268-40ad-30d6-08d89df9d993
x-ms-traffictypediagnostic: MWHPR11MB1742:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB174215D9E89B70C9A72966168ECA0@MWHPR11MB1742.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n0hNrnA/loAq1XYS11fwAWZrwyz1j/4Y9OZMkrMqJu638JJFEab+31T2Hlyda33XEcuSi0891xP3ljNTyxcBpAUt+/4FNsbp+ueIUH/0Uy83panVel7ToQ/mBKzQHp+YdlsY0lDH54Qdhsdmyg51+LRaOvOBIfEfYiEs5bvDJxoIuyP2vKqL/BUp+ALH0z7XtH0YNLzDFY4qyJ8DcjYy9Z4SfSkU/FW9PeyXy0W/KG2VG7v4Q94eMucRDycCxFvHkTzvX69k27iYmTwVxSuLIT8Oh9aEWZtzY5beM5rKtVtj4K/51E89rJibQCt/XnsKKxNNmIDhVcAQ6ZJgIoSz/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1679.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(52536014)(7696005)(8936002)(33656002)(9686003)(55016002)(8676002)(110136005)(86362001)(71200400001)(2906002)(6506007)(53546011)(508600001)(64756008)(54906003)(26005)(66946007)(186003)(76116006)(66476007)(83380400001)(4326008)(66446008)(66556008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JApEzPaXhX0Degvf+cH8kuHxn8+1eLpKpnnkZTiJ/tir2DCMGm2KTFD2qxuV?=
 =?us-ascii?Q?7+DTZMDTFoY5EXUk6tXu+k1zE6g9h2rqQO1pANHch03xjri7R3yNL7P6Pw89?=
 =?us-ascii?Q?2V98O706ojD+KCaku27uvX5k9RGwbFsuptERNQsqw9qz6CTa5S7vAQIt5lbe?=
 =?us-ascii?Q?u3cPILGWzUJUxmzfdIBiHy2AFoqyxmrEPWToSKPje1q/finsXXtvH7sJLjcE?=
 =?us-ascii?Q?5yUggXGbdn2F/MJE6LrfpKdRD1Syk9aLswnnu3uUBPinzsKrS7sRXEA/J9Qh?=
 =?us-ascii?Q?Y+q6JEfiP/SsCqqJCmzZG5iM8aJZdZWrmCdxzO/dsFEMjjGAGmhlhsPbs9uA?=
 =?us-ascii?Q?RZIys4poJz5ldqjBavudkbcmKHX6vb/E4wtynnDbpbF8ZBBzEr4XQcCP9j3Z?=
 =?us-ascii?Q?q7EqSX1GeaXplkHxk204UTmx1DVF22002qcbYBtuwdBvnOwId+7X/vqnr0Jj?=
 =?us-ascii?Q?4dAOijQsNqtwlkcsU9R6qSs107iP6qQsq0R4lHlM+dxbNLG6215zDzm7oP7O?=
 =?us-ascii?Q?MOIm/qHA2XFASI1hTMV6faFG3KKlK5oJ9C+74vKXEbD96RXhQzrVi/2WEyal?=
 =?us-ascii?Q?8YL1qbjC2eaxTGzTz1Z34cHR+JDAkdnXf/74NAou44rFS9n0mXrUWhykcCNb?=
 =?us-ascii?Q?o/HG3hYG6aJF1W50uYxcLcakVRmFVJDaPKLniwq2X89M2hiSCdVB9m7sHoB3?=
 =?us-ascii?Q?GdAvTh1S/PbxqZExr5XOM5CpHzTpzzRdLz93E5PEkJi2Yp1Q+GMuwtsuvK+B?=
 =?us-ascii?Q?9ZhAwd1gUzn6cxcwlstxq4mTReEcEnjqyxT7WeF0ioGQhbA2lieXEQ8VFUvz?=
 =?us-ascii?Q?SahmYedupXy4vUzaAhCsp7E/NlQYWawvG/7WHlJ6dDfvNpjhu+ds/rd6tMMN?=
 =?us-ascii?Q?6cm7LxTwtQP3b2euZvKPkDn3O7isbr0g1NDACvOaOb9kLUpyFoHA+fjmxUyF?=
 =?us-ascii?Q?Rpb+Wvfl8D4jivnceBQcr69AJXf0BWtBOmz5qGcvulE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1679.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 085736f1-2268-40ad-30d6-08d89df9d993
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 17:26:09.4105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XobFMIi2tnJCJH0rXL3VlwILzGK91lce9MNjc6Yj+PfURulfal6OBGy39BPts1ScVJhMajIxbW2q1neBNx7rjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1742
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, December 11, 2020 12:23 AM
> To: Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
> Cc: Alessandrelli, Daniele <daniele.alessandrelli@intel.com>;
> mgross@linux.intel.com; markgross@kernel.org; arnd@arndb.de;
> robh+dt@kernel.org; linux-kernel@vger.kernel.org; sumit.semwal@linaro.org=
;
> christian.koenig@amd.com
> Subject: Re: [PATCH 03/22] keembay-ipc: Add Keem Bay IPC module
>=20
> On Thu, Dec 10, 2020 at 06:38:24PM +0000, Daniele Alessandrelli wrote:
> > On Tue, 2020-12-08 at 20:48 +0100, Greg KH wrote:
> > > On Tue, Dec 08, 2020 at 06:59:09PM +0000, Daniele Alessandrelli wrote=
:
> > > > Hi Greg,
> > > >
> > > > Thanks for your feedback.
> > > >
> > > > On Wed, 2020-12-02 at 07:19 +0100, Greg KH wrote:
> > > > > On Tue, Dec 01, 2020 at 02:34:52PM -0800, mgross@linux.intel.com
> wrote:
> > > > > > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > > > > >
> > > > > > On the Intel Movidius SoC code named Keem Bay, communication
> > > > > > between the Computing Sub-System (CSS), i.e., the CPU, and the
> > > > > > Multimedia Sub-System (MSS), i.e., the VPU is enabled by the
> > > > > > Keem Bay Inter-Processor Communication (IPC) mechanism.
> > > > > >
> > > > > > Add the driver for using Keem Bay IPC from within the Linux Ker=
nel.
> > > > > >
> > > > > > Keem Bay IPC uses the following terminology:
> > > > > >
> > > > > > - Node:    A processing entity that can use the IPC to communic=
ate;
> > > > > > 	   currently, we just have two nodes, CPU (CSS) and VPU (MSS).
> > > > > >
> > > > > > - Link:    Two nodes that can communicate over IPC form an IPC =
link
> > > > > > 	   (currently, we just have one link, the one between the CPU
> > > > > > 	   and VPU).
> > > > > >
> > > > > > - Channel: An IPC link can provide multiple IPC channels. IPC c=
hannels
> > > > > > 	   allow communication multiplexing, i.e., the same IPC link c=
an
> > > > > > 	   be used by different applications for different
> > > > > > 	   communications. Each channel is identified by a channel ID,
> > > > > > 	   which must be unique within a single IPC link. Channels are
> > > > > > 	   divided in two categories, High-Speed (HS) channels and
> > > > > > 	   General-Purpose (GP) channels. HS channels have higher
> > > > > > 	   priority over GP channels.
> > > > > >
> > > > > > Keem Bay IPC mechanism is based on shared memory and hardware
> FIFOs.
> > > > > > Both the CPU and the VPU have their own hardware FIFO. When
> > > > > > the CPU wants to send an IPC message to the VPU, it writes to
> > > > > > the VPU FIFO (MSS FIFO); similarly, when MSS wants to send an
> > > > > > IPC message to the CPU, it writes to the CPU FIFO (CSS FIFO).
> > > > > >
> > > > > > A FIFO entry is simply a pointer to an IPC buffer (aka IPC
> > > > > > header) stored in a portion of memory shared between the CPU an=
d
> the VPU.
> > > > > > Specifically, the FIFO entry contains the (VPU) physical
> > > > > > address of the IPC buffer being transferred.
> > > > > >
> > > > > > In turn, the IPC buffer contains the (VPU) physical address of
> > > > > > the payload (which must be located in shared memory too) as
> > > > > > well as other information (payload size, IPC channel ID, etc.).
> > > > > >
> > > > > > Each IPC node instantiates a pool of IPC buffers from its own
> > > > > > IPC buffer memory region. When instantiated, IPC buffers are
> > > > > > marked as free. When the node needs to send an IPC message, it
> > > > > > gets the first free buffer it finds (from its own pool), marks
> > > > > > it as allocated (used), and puts its physical address into the
> > > > > > IPC FIFO of the destination node. The destination node (which
> > > > > > is notified by an interrupt when there are entries pending in
> > > > > > its FIFO) extract the physical address from the FIFO and
> > > > > > process the IPC buffer, marking it as free once done (so that t=
he sender
> can reuse the buffer).
> > > > >
> > > > > Any reason you can't use the dmabuf interface for these memory
> > > > > buffers you are creating and having to manage "by hand"?  I
> > > > > thought that was what the kernel was wanting to unify on such
> > > > > that individual drivers/subsystems didn't have to do this on thei=
r own.
> > > >
> > > > My understanding is that the dmabuf interface is used to share DMA
> > > > buffers across different drivers, while these buffers are used
> > > > only internally to the IPC driver (and exchanged only with the VPU
> > > > firmware). They basically are packet headers that are sent to the V=
PU.
> > >
> > > There's no reason you couldn't use these to share your buffers
> > > "internally" as well, because you have the same lifetime rules and
> > > accounting and all other sorts of things you have to handle, right?
> > > Why rewrite something like this when you should take advantage of
> > > common code instead?
> >
> > I looked at dma-buf again, but I'm still failing to see how we can use
> > it in this driver :/
> >
> > The problem I'm not able to solve is exactly how to match the lifetime
> > of this IPC packets (IPC buffers is probably a misleading name, my bad
> > for using it in the code) with the dma-buf lifetime rules.
> >
> > Basically, these IPC packets are cache-aligned (64 bytes) and have the
> > following fixed structure:
> >
> >    struct kmb_ipc_buf {
> >           u32 data_addr;
> >           u32 data_size;
> >           u16 channel;
> >           u8  src_node;
> >           u8  dst_node;
> >           u8  status;
> >    } __packed __aligned(KMB_IPC_ALIGNMENT);
>=20
> If that is shared out of the kernel, please use the proper data types for=
 it.
>=20
> And it isn't properly padded out?  That feels like a hardware design mist=
ake
> somewhere, anyway...
>=20
> > Now, let's ignore the first 5 fields and focus on the last one that
> > controls the lifetime of the packet. The status field can be either
> > FREE or ALLOCATED (perhaps should be renamed to IN_USE).
> >
> > Basically, during probe, the driver allocates an array (pool) of these
> > packets from its 'local' reserved memory region. This is done using
> > dma_alloc_coherent(). This array remains allocated until remove() is
> > called.
> >
> > At run-time, every time the driver sends a message to the VPU, the
> > following happens:
> >
> >    1. The IPC driver loops through the array of 'local' packets to find
> >       the first one marked as FREE
> >    2. The IPC driver marks the packet as IN_USE and shares it with the =
VPU
> >       by putting its physical address into the VPU HW FIFO.
> >    3. The VPU Firmware processes the packet and, when done with it, it
> >       marks it as FREE again so that the IPC driver can use it again.
>=20
> How does the firmware "mark it as free"?
>=20
> > Please note that the IPC driver is not notified by the VPU when the
> > packet is marked as free (there is no IRQ or other async mechanism to
> > do that). The driver will simply find the message free the next time
> > it loops over the message pool again (i.e., when it is trying to send
> > a new message).
> >
> > Given that the free operation is silently done by the VPU, I'm failing
> > to see how I can use dmabuf (or gen_pool or dma_pool). Is there
> > anything that I'm missing?
>=20
> So maybe this isn't set up to use the dma buffers, but it still feels rea=
lly odd.  I
> recommend getting a review by the dmabuf authors before declaring that yo=
u
> really should be rolling your own buffer management logic here, as you ca=
n see
> that it feels like you are doing much the same thing, sharing memory outs=
ide of
> the kernel to something else.
Great idea!  I will do this on the V2 posting.

Say, we've gotten some really good feedback so far and I'm thinking about p=
osting an update with most of the issues raised addressed next week.  There=
 is one feedback that looks like will take a bit longer to address (splitti=
ng out and use of the common mailbox framework in the keembay-ipc driver). =
 Would it be acceptable to post a V2 that has some ToDo's in it to allow fo=
r more feedback to get to the rest of the stack or should we hold until we =
get all the issues address before posting the V2?

Thanks again for your advice and review feedback!

--mark


>=20
> thanks,
>=20
> greg k-h
