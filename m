Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0140A2D13E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgLGOlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:41:40 -0500
Received: from mail-co1nam11on2071.outbound.protection.outlook.com ([40.107.220.71]:41833
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725802AbgLGOlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:41:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0M3IWTrm34G1HPIKtVZOY2gxlrRENBOigz423xABuJUB7zgDUaf3yGpebs3+mHVW2PiD6dM+T569+UITs3MdDUoVWI0rXM08MXavR0S3xPJT5NupYBOUoR6IImoaXtUw5035KI/JosrkkWbgEIuUm4WcWOviFiOrUHPxgp1OTaeg6uEXv6+G/tqWqzUlz+nBV2P025slYnW1di85aK0CAnYOt8GCviav1p2yE7iIxOtQ7ETzyDp11OmmrjSB82B5WaX22TzQ0PMBFmcU3g7GwQNY5OmxCLlMXxFQgN5Iuvv4qmjJfciW0sSUFXAVGcm3lEwGSKtObuJ28DOqAEjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6gztsyGCsZQFU1CAdVvD3vPBWPQo1jlOxrToi2VP24=;
 b=RoneHIYPHXAY6uyNr+KVTk0HhDrZ7mLpWAlxUWNN8O6HD0o7gjvZs2HnwN5wZtXGGlh1rkkvOOFENC+7/aVv6bSVW3KqQCjjoYP8l0teNWkBsATSncbIbUBJ2zckXnbXY8dxjERvotNYXnfsQJvxKYD3tmnHDqrDUqVdbcJhU7S5jhhqygjmSlsFqmVUiv1LA7QbRpIRM+Y/UfQseBs0udNgTpUQBj6DsOYYsm/F3p12y4s9WsfPCDM9bJAWkT4JOOSD0CA3lKMszLhmh/z0ujl1Q8KyGVI6/IMrHK162aQowm3favjB3a95hNPrTPvCWKfebtexABK72xEtWMeXmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6gztsyGCsZQFU1CAdVvD3vPBWPQo1jlOxrToi2VP24=;
 b=Vv5Vykcs9j95Wbdyk8DOfxLAElEY0nyL6xKKZPOaJs0Ti2+Bbc3sXWgrgsvrpHW9Z5VAmy2ZJ3Gbl6lwe+ELleEo/SGsMY87Iu9xQPySmqbKjDwL3sEVbGh62dYzzGm4BiJB37FY6aWht5J/5pyNQeRPwQmPAXWCxjYKG1GkVls=
Received: from DM5PR05MB3452.namprd05.prod.outlook.com (2603:10b6:4:41::11) by
 DS7PR05MB7207.namprd05.prod.outlook.com (2603:10b6:5:2cb::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.10; Mon, 7 Dec 2020 14:40:47 +0000
Received: from DM5PR05MB3452.namprd05.prod.outlook.com
 ([fe80::7ddf:8a5d:4b6b:7491]) by DM5PR05MB3452.namprd05.prod.outlook.com
 ([fe80::7ddf:8a5d:4b6b:7491%7]) with mapi id 15.20.3654.011; Mon, 7 Dec 2020
 14:40:46 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     Stefano Garzarella <sgarzare@redhat.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Arnd Bergmann <arnd@kernel.org>
CC:     gregkh <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND] misc/vmw_vmci: bail out earlier on too big queue
 allocation
Thread-Topic: [PATCH RESEND] misc/vmw_vmci: bail out earlier on too big queue
 allocation
Thread-Index: AQHWwdvBx3YmmaRjgU6QHAKkQ+OYDKniutsAgADm2QCACBbh0A==
Date:   Mon, 7 Dec 2020 14:40:46 +0000
Message-ID: <DM5PR05MB3452D9FA3B2B1FB066B55BE1DACE0@DM5PR05MB3452.namprd05.prod.outlook.com>
References: <trinity-56749cfc-536b-45e2-8e6f-621754c07824-1606165260518@3c-app-gmx-bs09>
 <CAK8P3a2dq8VtYARPS9r9aeJipA3hD9M01wmEJ8LuZT1_Taav3w@mail.gmail.com>
 <CAGxU2F7-suw3PT0GKw68AHTaOzUOgbBRCZmNOZd+MH+Y+q8EyA@mail.gmail.com>
In-Reply-To: <CAGxU2F7-suw3PT0GKw68AHTaOzUOgbBRCZmNOZd+MH+Y+q8EyA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [83.92.5.149]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d6519ca-4c99-4e58-fd99-08d89abe159a
x-ms-traffictypediagnostic: DS7PR05MB7207:
x-microsoft-antispam-prvs: <DS7PR05MB7207F4C75E2466FCDEAAC307DACE0@DS7PR05MB7207.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: anhCGogqYed42pwXiQIad7sP36GtvoH7tIuc7rPs+qDf1gjT0YGTaUYINRVxPYvXHMwl6c0AXk4tsBULJ1lHHwAh9AFMsOn3efO4RSSsTVKWK6tE6ex4eRpT8vTphWsdJ3/DfvJF8KG+YbiCxAk0DXOiUSyJ67lE7a0JT1QXsw8Szamn1Q8yMHO5J2maxr2LWBtfyuduid6AuskYUSIyggjD+YkYLdP/pUMDE1yWR7dHjM4Hs2HqWrYxiA1g+rwjjMRfnZ2te900QAZa7vBBVPGUIzhKJeSnPQemvEAhxBIjGoiddkBsfmFzFJL6GEUUYxeDl9TOHCY+FgWTe0AwCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR05MB3452.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(64756008)(91956017)(83380400001)(52536014)(66556008)(66476007)(66446008)(71200400001)(76116006)(9686003)(5660300002)(7696005)(55016002)(26005)(33656002)(186003)(2906002)(8676002)(53546011)(8936002)(6506007)(110136005)(478600001)(66946007)(66574015)(4326008)(316002)(86362001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?PMm/C9AOkfS1Y/hym+CIz299XElBIv0I6bTK3tHSHxS6WOMmlR302TchLn?=
 =?iso-8859-1?Q?0dfxhb1nckax4N7XJoMSKvD9p0E88o/pwU5SH9FLKWva761mAgkvNPJ6yB?=
 =?iso-8859-1?Q?IDT2A2sBbz86GMvV6HAsrOj1TycF6x+MuW2UAHN0HrR2NwhsTtxG7Vw3nE?=
 =?iso-8859-1?Q?+gTr8I4mlrJ9WRb6/HZRx+wTpOCkuRCjoy3HsFVqv38/wrm4o76MDBgMNq?=
 =?iso-8859-1?Q?0tPyggbTsTeIHmpnHo4t648NLSbgIoF7VACSJEzwyhjcwT4UZP6GabqX/r?=
 =?iso-8859-1?Q?YHmsv5X/rMkTzFMZ8nUIaXO+aCBqhyANFSjgA1UoSH8xdy3DXb9UlokRPp?=
 =?iso-8859-1?Q?fxpPZlEuQ1NaLmv3nT3CohoG2nCZjibKYqmzwJI+v06CbFlfYTsxWIvdT5?=
 =?iso-8859-1?Q?CzXZl0AX8OKJgUColGR0bYKhyAAwgGXSEbOYfHm/rA2XVMLo1Xhy0Rt68e?=
 =?iso-8859-1?Q?h4PZqfkQ8j+xQxOk8uH+woUTIExv9tlGiGpELJt9iWRn/ZoS0eECgzf4hl?=
 =?iso-8859-1?Q?Kgn+eJ8jQfsa9rum5Yvk8XDez4go4xO3nl+cPnAYbE35wKu1VFdosB/3QG?=
 =?iso-8859-1?Q?cgzHiv/vj5kChm20Yr092ET5Uw84lTATK0onTb6/qQbD1xbofJrgjk00TU?=
 =?iso-8859-1?Q?DFZIbE90EH6rnc1QAXMpTGZbg/vJUtuEHNathmG3uWN/jC4xzDJo1LrJUg?=
 =?iso-8859-1?Q?uz580IA0nFaHGC4JUm9+l6RTdpYc8GDReIZ30ohqh5gnRXoe3UBeh+63JF?=
 =?iso-8859-1?Q?+VhmjpJap/WN1N5JX/aCjHnCLWh2hA1sxB3TCWJG3xb43/5qCWpmaJCuPO?=
 =?iso-8859-1?Q?Y93HhvMoEc0na2cfkCF6xVyiC7TNrQFG/aK1utpGRbV5uQfj8WRl07NigT?=
 =?iso-8859-1?Q?qzAwwDVfjfbZQgjQhuly+76vq1LHBIhxRt7PdMPH1MKPWcMcFVhNVnEqCs?=
 =?iso-8859-1?Q?Pn2m2FcNJcFgTadP2mvf09ZAPGSh/fWbTE2FNNKDXfbHb0jmBPKAvKrZxI?=
 =?iso-8859-1?Q?8yUF3CWVQKvVoI6dM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR05MB3452.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6519ca-4c99-4e58-fd99-08d89abe159a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 14:40:46.8508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8zgz2TtOYLnOUZuZyQKBEeN53NtlStEpmdEE11Y6SqMFmXj2+ttZ7t4vq5oU9iwfD9kkfwfzlrbH9wKb+M6Tpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR05MB7207
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>=0A=
Sent: Wednesday, December 2, 2020 2:06 AM=0A=
> =0A=
> On Tue, Dec 1, 2020 at 9:21 PM Arnd Bergmann <arnd@kernel.org> wrote:=0A=
> >=0A=
> > On Mon, Nov 23, 2020 at 10:01 PM Norbert Slusarek <nslusarek@gmx.net>=
=0A=
> wrote:=0A=
> > >=0A=
> > > From: Norbert Slusarek <nslusarek@gmx.net>=0A=
> > > Date: Mon, 23 Nov 2020 21:53:41 +0100=0A=
> > > Subject: [PATCH RESEND] misc/vmw_vmci: bail out earlier on too big=0A=
> > > queue allocation=0A=
> > >=0A=
> > > For the allocation of a queue pair in qp_host_alloc_queue() an=0A=
> > > arbitrary value can be passed for produce_size, which can lead to=0A=
> > > miscalculation of memory we'd like to allocate in one take. A=0A=
> > > warning is triggered at __alloc_pages_nodemask() in=0A=
> > > mm/page_alloc.c:4737 which aborts the false allocation, but it result=
s in a=0A=
> VMware machine freezing for an infinite time.=0A=
> > >=0A=
> > > Signed-off-by: Norbert Slusarek <nslusarek@gmx.net>=0A=
> >=0A=
> > Thank you for sending a patch with such a detailed analysis and even=0A=
> > including a test case!=0A=
> =0A=
> Yeah agree, very good details!=0A=
=0A=
Yes, thanks a lot for pointing this out.=0A=
=0A=
> >=0A=
> > > diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c=0A=
> > > b/drivers/misc/vmw_vmci/vmci_queue_pair.c=0A=
> > > index c49065887e8f..997ff32475b2 100644=0A=
> > > --- a/drivers/misc/vmw_vmci/vmci_queue_pair.c=0A=
> > > +++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c=0A=
> > > @@ -526,6 +526,7 @@ static struct vmci_queue=0A=
> *qp_host_alloc_queue(u64 size)=0A=
> > >         struct vmci_queue *queue;=0A=
> > >         size_t queue_page_size;=0A=
> > >         u64 num_pages;=0A=
> > > +       unsigned int order;=0A=
> > >         const size_t queue_size =3D sizeof(*queue) +=0A=
> > > sizeof(*(queue->kernel_if));=0A=
> > >=0A=
> > >         if (size > SIZE_MAX - PAGE_SIZE) @@ -537,6 +538,10 @@ static=
=0A=
> > > struct vmci_queue *qp_host_alloc_queue(u64 size)=0A=
> > >=0A=
> > >         queue_page_size =3D num_pages *=0A=
> > > sizeof(*queue->kernel_if->u.h.page);=0A=
> > >=0A=
> > > +       order =3D get_order(queue_size + queue_page_size);=0A=
> > > +       if (order >=3D MAX_ORDER)=0A=
> > > +               return NULL;=0A=
> > > +=0A=
> > >         queue =3D kzalloc(queue_size + queue_page_size, GFP_KERNEL);=
=0A=
> >=0A=
> > Calling kzalloc() with that user-provided size may still not be a=0A=
> > great idea, and MAX_ORDER is probably more than anyone ever needs=0A=
> here=0A=
> > (I don't know what the interface is needed for, but usually it is).=0A=
> >=0A=
> > If there is a reasonable upper bound smaller than MAX_ORDER, I would=0A=
> > suggest using that. It might also be helpful to use=0A=
> > kvzalloc()/kvfree() in this case, which can return an arbitrary number=
=0A=
> > of pages and suffers less from fragmentation.=0A=
> =0A=
> I don't know well vmw_vmci, but I took a brief look, and I saw that there=
 is a=0A=
> macro (VMCI_MAX_GUEST_QP_MEMORY) used in vmci_qpair_alloc(), I'm=0A=
> not sure if we can use the same macro, but maybe something similar.=0A=
> =0A=
> Honestly I don't know where that limit comes from, maybe it was chosen as=
=0A=
> an arbitrary and reasonable value but I suggest to check if we can reuse =
the=0A=
> same macro here with some adjustments.=0A=
> I think in some way that limit is related to the max memory that the host=
=0A=
> should allocate.=0A=
> =0A=
> @Jorgen any thought?=0A=
=0A=
The VMCI_MAX_GUEST_QP_MEMORY limit is the limit for the total amount of gue=
st memory that can be used for VMCI queue pairs with the current revision o=
f the VMCI virtual device, so it is the upper limit on the size of a single=
 queue pair as well. In this function, the size parameter indicates the des=
ired queue size of one of the queues in the queue pair, so they should be b=
ounded by this as well. The appropriate check in the beginning of the funct=
ion would be=0A=
=0A=
 if (size > min(VMCI_MAX_GUEST_QP_MEMORY, SIZE_MAX - PAGE_SIZE))=0A=
    return NULL;=0A=
=0A=
Since VMCI_MAX_GUEST_QP_MEMORY is 128MB, the actual kzalloc argument should=
 be well below the limit imposed by MAX_ORDER, with the modification of the=
 above check.=0A=
=0A=
That this unchecked value can occur here at all is due to another bug, wher=
e the queue sizes aren't validated against the VMCI_MAX_GUEST_QP_MEMORY lim=
it on the vmci_qp_broker_alloc callpath. We'll fix that and we can update t=
he above check as well in the same change.=0A=
=0A=
Thanks,=0A=
J=F8rgen=0A=
=0A=
=0A=
