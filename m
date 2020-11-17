Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789702B7010
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgKQUa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:30:26 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56850 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgKQUa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:30:26 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHKORws128609;
        Tue, 17 Nov 2020 20:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to : content-transfer-encoding; s=corp-2020-01-29;
 bh=/9ouyw75sZcj64B7J3W0GYiJN8Cf86XbWdloBIz8was=;
 b=zj0QOE2bh0JBJey8IOaUA6r/ystzgD5gpvEzU19rRmVQqand2cCeG49nXMJ4WqNraXpV
 IDK1j28YlJPajIltbcu3+To0hmN14gYMNmDPo+uV1m0aj1RDAZBRE8rYPdWM/yibPidP
 R8e0BFr9pSFkdjy12jpO0nKmC1ScTtYnCmgqGrVXNcbqh0qHV7EEZzyFT3NFb/TaUbu9
 yDYTJbKtGSBmYZ69ECqCPNRBIlhcOH8CxK7rzSTqkWn9WMMBaQFPzRpmfAYkKzKvEvka
 gLIXCgL/GYbsXKfELoGg1q2tC5KTsj657Imuui6PN0ecrcZfydubwYhELrqU1VwMHKv9 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34t4ravu78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 20:29:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHKLGtT159075;
        Tue, 17 Nov 2020 20:29:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34umcypfdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 20:29:46 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AHKTXiv026531;
        Tue, 17 Nov 2020 20:29:33 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Nov 2020 12:29:32 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 9CE916A00FA; Tue, 17 Nov 2020 15:31:24 -0500 (EST)
Date:   Tue, 17 Nov 2020 15:31:24 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     "Kalra, Ashish" <Ashish.Kalra@amd.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux-intel.com" <dave.hansen@linux-intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ssg.sos.patches" <ssg.sos.patches@amd.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>,
        "rientjes@google.com" <rientjes@google.com>
Subject: Re: [PATCH v3] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201117203123.GB16539@char.us.oracle.com>
References: <20201105184115.GA25261@ashkalra_ubuntu_server>
 <20201105190649.GB5366@char.us.oracle.com>
 <20201105193828.GA25303@ashkalra_ubuntu_server>
 <20201105202007.GA6370@char.us.oracle.com>
 <20201105212045.GB25303@ashkalra_ubuntu_server>
 <20201113211925.GA6096@char.us.oracle.com>
 <20201117153302.GA29293@ashkalra_ubuntu_server>
 <20201117170003.GF10360@char.us.oracle.com>
 <20201117173829.GA29387@ashkalra_ubuntu_server>
 <7EAA7A38-50B7-4291-9A4E-34668455B59D@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7EAA7A38-50B7-4291-9A4E-34668455B59D@amd.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170149
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 07:04:59PM +0000, Kalra, Ashish wrote:
> Hello Konrad,
>=20
> Actually I didn=E2=80=99t get that, do you mean you are taking 1G and <=
=3D4G cases out of the patch and only going to apply the >4G case as part=
 of the patch ?

That was the thought, but now I am wondering how TDX is going to work
with this. That is the __weak won't work on distro kernel that has to
run on both AMD and Intel. Hmm.

Let me brush off the late-SWIOTLB patches that internally we developed so=
me time ago.

>=20
> Thanks,
> Ashish=20
>=20
> > On Nov 17, 2020, at 11:38 AM, Kalra, Ashish <Ashish.Kalra@amd.com> wr=
ote:
> >=20
> > =EF=BB=BFHello Konrad,=20
> >=20
> >> On Tue, Nov 17, 2020 at 12:00:03PM -0500, Konrad Rzeszutek Wilk wrot=
e:
> >> .snip..
> >>>>>> Lets break this down:
> >>>>>>=20
> >>>>>> How does the performance improve for one single device if you in=
crease the SWIOTLB?
> >>>>>> Is there a specific device/driver that you can talk about that i=
mprove with this patch?
> >>>>>>=20
> >>>>>>=20
> >>>>>=20
> >>>>> Yes, these are mainly for multi-queue devices such as NICs or eve=
n
> >>>>> multi-queue virtio.=20
> >>>>>=20
> >>>>> This basically improves performance with concurrent DMA, hence,
> >>>>> basically multi-queue devices.
> >>>>=20
> >>>> OK, and for _1GB_ guest - what are the "internal teams/external cu=
stomers" amount=20
> >>>> of CPUs they use? Please lets use real use-cases.
> >>>=20
> >>>>> I am sure you will understand we cannot share any external custom=
er
> >>>>> data as all that customer information is proprietary.
> >>>>>=20
> >>>>> In similar situation if you have to share Oracle data, you will
> >>>>> surely have the same concerns and i don't think you will be able
> >>>>> to share any such information externally, i.e., outside Oracle.
> >>>>>=20
> >>>> I am asking for a simple query - what amount of CPUs does a 1GB
> >>>> guest have? The reason for this should be fairly obvious - if
> >>>> it is a 1vCPU, then there is no multi-queue and the existing
> >>>> SWIOTLB pool size as it is OK.
> >>>>=20
> >>>> If however there are say 2 and multiqueue is enabled, that
> >>>> gives me an idea of how many you use and I can find out what
> >>>> the maximum pool size usage of virtio there is with that configura=
tion.
> >>>=20
> >>> Again we cannot share any customer data.
> >>>=20
> >>> Also i don't think there can be a definitive answer to how many vCP=
Us a
> >>> 1GB guest will have, it will depend on what kind of configuration w=
e are
> >>> testing.
> >>>=20
> >>> For example, i usually setup 4-16 vCPUs for as low as 512M configur=
ed
> >>> gueest memory.
> >>=20
> >> Sure, but you are not the normal user.
> >>=20
> >> That is I don't like that for 1GB guests your patch ends up doubling=
 the
> >> SWIOTLB memory pool. That seems to me we are trying to solve a probl=
em
> >> that normal users will not hit. That is why I want 'here is the cust=
omer
> >> bug'.
> >>=20
> >> Here is what I am going to do - I will take out the 1GB and 4GB case=
 out of
> >> your patch and call it a day. If there are customers who start repor=
ting issues
> >> we can revist that. Nothing wrong with 'Reported-by' XZY (we often a=
sk the
> >> customer if he or she would like to be recognized on upstream bugs).
> >>=20
> >=20
> > Ok.
> >=20
> >> And in the meantime I am going to look about adding ..
> >>>=20
> >>> I have been also testing with 16 vCPUs configuration for 512M-1G gu=
est
> >>> memory with Mellanox SRIOV NICs, and this will be a multi-queue NIC
> >>> device environment.
> >>=20
> >> .. late SWIOTLB expansion to stich the DMA pools together as both
> >> Mellanox and VirtIO are not 32-bit DMA bound.
> >>=20
> >>>=20
> >>> So we might be having less configured guest memory, but we still mi=
ght
> >>> be using that configuration with I/O intensive workloads.
> >>>=20
> >=20
> > I am going to submit v4 of my current patch-set which uses max() inst=
ead
> > of clamp() and also replaces constants defined in this patch with the
> > pre-defined ones in sizes.h
> >=20
> > Thanks,
> > Ashish
