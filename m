Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D072B6AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgKQQ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:59:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43752 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgKQQ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:59:02 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHGsBok165104;
        Tue, 17 Nov 2020 16:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=rVPuEROOQXBR4hTuD3HtWREB5RhUzbVjlGZJwxuk08o=;
 b=xLXdEh0uyhHE/j/Ur6Zjjfc1PmRtzXMJLU0dkNBKQRSutBYpOzIXPxsp31AKgp+u1mYX
 drT/tYWJPQDj/sbEY8mJLiV4plvGDP5MPBddPHXrXCFgIxpTodrh/Day8M4org4leEgd
 6L9mM5nZ8NDjAtBq9ijS4fvRy8lofgW4lKGKoDWRKxrmE7g97A+cZbE3HOV04DxbHcT6
 /MhHclCvSU8ucdmjkTAA4gkWCrURFz4LTRN/vZ+89Tp78FwijEUBGDTXa0AvXyBQEZle
 fp4Iyi+ebEKEDqwQqdKejirWnRVdvXe2kvXgkeThA/5qp9mVSeJ/g027ahdDizc7QxJH hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34t76kumrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 16:58:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHGtbV9193546;
        Tue, 17 Nov 2020 16:58:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 34usptmx1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 16:58:26 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AHGwLL0010091;
        Tue, 17 Nov 2020 16:58:21 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Nov 2020 08:58:20 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 581B16A00FA; Tue, 17 Nov 2020 12:00:03 -0500 (EST)
Date:   Tue, 17 Nov 2020 12:00:03 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     hch@lst.de, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux-intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com, Thomas.Lendacky@amd.com,
        ssg.sos.patches@amd.com, jon.grimm@amd.com, rientjes@google.com
Subject: Re: [PATCH v3] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201117170003.GF10360@char.us.oracle.com>
References: <20201104221452.GA26079@char.us.oracle.com>
 <20201104223913.GA25311@ashkalra_ubuntu_server>
 <20201105174317.GA4294@char.us.oracle.com>
 <20201105184115.GA25261@ashkalra_ubuntu_server>
 <20201105190649.GB5366@char.us.oracle.com>
 <20201105193828.GA25303@ashkalra_ubuntu_server>
 <20201105202007.GA6370@char.us.oracle.com>
 <20201105212045.GB25303@ashkalra_ubuntu_server>
 <20201113211925.GA6096@char.us.oracle.com>
 <20201117153302.GA29293@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117153302.GA29293@ashkalra_ubuntu_server>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170121
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.snip..
> > > > Lets break this down:
> > > > 
> > > > How does the performance improve for one single device if you increase the SWIOTLB?
> > > > Is there a specific device/driver that you can talk about that improve with this patch?
> > > > 
> > > > 
> > > 
> > > Yes, these are mainly for multi-queue devices such as NICs or even
> > > multi-queue virtio. 
> > > 
> > > This basically improves performance with concurrent DMA, hence,
> > > basically multi-queue devices.
> > 
> > OK, and for _1GB_ guest - what are the "internal teams/external customers" amount 
> > of CPUs they use? Please lets use real use-cases.
> 
> >> I am sure you will understand we cannot share any external customer
> >> data as all that customer information is proprietary.
> >>
> >> In similar situation if you have to share Oracle data, you will
> >> surely have the same concerns and i don't think you will be able
> >> to share any such information externally, i.e., outside Oracle.
> >>
> >I am asking for a simple query - what amount of CPUs does a 1GB
> >guest have? The reason for this should be fairly obvious - if
> >it is a 1vCPU, then there is no multi-queue and the existing
> >SWIOTLB pool size as it is OK.
> >
> >If however there are say 2 and multiqueue is enabled, that
> >gives me an idea of how many you use and I can find out what
> >the maximum pool size usage of virtio there is with that configuration.
> 
> Again we cannot share any customer data.
> 
> Also i don't think there can be a definitive answer to how many vCPUs a
> 1GB guest will have, it will depend on what kind of configuration we are
> testing.
> 
> For example, i usually setup 4-16 vCPUs for as low as 512M configured
> gueest memory.

Sure, but you are not the normal user.

That is I don't like that for 1GB guests your patch ends up doubling the
SWIOTLB memory pool. That seems to me we are trying to solve a problem
that normal users will not hit. That is why I want 'here is the customer
bug'.

Here is what I am going to do - I will take out the 1GB and 4GB case out of
your patch and call it a day. If there are customers who start reporting issues
we can revist that. Nothing wrong with 'Reported-by' XZY (we often ask the
customer if he or she would like to be recognized on upstream bugs).

And in the meantime I am going to look about adding ..
> 
> I have been also testing with 16 vCPUs configuration for 512M-1G guest
> memory with Mellanox SRIOV NICs, and this will be a multi-queue NIC
> device environment.

.. late SWIOTLB expansion to stich the DMA pools together as both
Mellanox and VirtIO are not 32-bit DMA bound.

> 
> So we might be having less configured guest memory, but we still might
> be using that configuration with I/O intensive workloads.
> 
> Thanks,
> Ashish
