Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571B42B2665
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgKMVS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:18:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46412 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgKMVSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:18:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ADLFhR4078786;
        Fri, 13 Nov 2020 21:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=gNk0JG1FFC5UH5WXHYXt8d8wnGBHRDwIpGjGIanQY78=;
 b=gNjZhXz1rW9aynBB1xEwY1gsTP1zD8IzhRIQRBlope4ZPzX73ubCr83yyLcK5oAvUTuk
 MTczsvCSGH+PCWEHg/6hThouOwBC+isBG5VHgc5L/pu/rTV7r1OleScIrYULGBXny6L/
 d7aaptnmA8kEzVLgWlfNDgsGIdrbEFZMgGBVPgBvC27fKu9VPPe98lon0Z75HJNtROoU
 gTDZOxlaxXQQZFJVY5Cvy1I8zyiYyN2hEtD29vQ2U/fxz3/M+bweaWf3BMT7nnFQaDE5
 9D2mDTmNvc1rnO1Z2e707xS2zfPtuDk5ZuKXGxOSuLSa4d28xXbumD2eOEKsAi6Iu5eb Zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34p72f2gyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 21:17:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ADLGJlb089847;
        Fri, 13 Nov 2020 21:17:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34rtkua0gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Nov 2020 21:17:40 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0ADLHaQp022362;
        Fri, 13 Nov 2020 21:17:36 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Nov 2020 13:17:36 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 6FBB66A0109; Fri, 13 Nov 2020 16:19:25 -0500 (EST)
Date:   Fri, 13 Nov 2020 16:19:25 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     hch@lst.de, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux-intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com, Thomas.Lendacky@amd.com,
        ssg.sos.patches@amd.com
Subject: Re: [PATCH v3] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201113211925.GA6096@char.us.oracle.com>
References: <20201104220804.21026-1-Ashish.Kalra@amd.com>
 <20201104221452.GA26079@char.us.oracle.com>
 <20201104223913.GA25311@ashkalra_ubuntu_server>
 <20201105174317.GA4294@char.us.oracle.com>
 <20201105184115.GA25261@ashkalra_ubuntu_server>
 <20201105190649.GB5366@char.us.oracle.com>
 <20201105193828.GA25303@ashkalra_ubuntu_server>
 <20201105202007.GA6370@char.us.oracle.com>
 <20201105212045.GB25303@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105212045.GB25303@ashkalra_ubuntu_server>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9804 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9804 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 09:20:45PM +0000, Ashish Kalra wrote:
> On Thu, Nov 05, 2020 at 03:20:07PM -0500, Konrad Rzeszutek Wilk wrote:
> > On Thu, Nov 05, 2020 at 07:38:28PM +0000, Ashish Kalra wrote:
> > > On Thu, Nov 05, 2020 at 02:06:49PM -0500, Konrad Rzeszutek Wilk wrote:
> > > > .
> > > > > > Right, so I am wondering if we can do this better.
> > > > > > 
> > > > > > That is you are never going to get any 32-bit devices with SEV right? That
> > > > > > is there is nothing that bounds you to always use the memory below 4GB?
> > > > > > 
> > > > > 
> > > > > We do support 32-bit PCIe passthrough devices with SEV.
> > > > 
> > > > Ewww..  Which devices would this be?
> > > 
> > > That will be difficult to predict as customers could be doing
> > > passthrough of all kinds of devices.
> > 
> > But SEV is not on some 1990 hardware. It has PCIe, there is no PCI slots in there.
> > 
> > Is it really possible to have a PCIe device that can't do more than 32-bit DMA?
> > 
> > > 
> > > > > 
> > > > > Therefore, we can't just depend on >4G memory for SWIOTLB bounce buffering
> > > > > when there is I/O pressure, because we do need to support device
> > > > > passthrough of 32-bit devices.
> > > > 
> > > > Presumarily there is just a handful of them?
> > > >
> > > Again, it will be incorrect to assume this.
> > > 
> > > > > 
> > > > > Considering this, we believe that this patch needs to adjust/extend
> > > > > boot-allocation of SWIOTLB and we want to keep it simple to do this
> > > > > within a range detemined by amount of allocated guest memory.
> > > > 
> > > > I would prefer to not have to revert this in a year as customers
> > > > complain about "I paid $$$ and I am wasting half a gig on something 
> > > > I am not using" and giving customers knobs to tweak this instead of
> > > > doing the right thing from the start.
> > > 
> > > Currently, we face a lot of situations where we have to tell our
> > > internal teams/external customers to explicitly increase SWIOTLB buffer
> > > via the swiotlb parameter on the kernel command line, especially to
> > > get better I/O performance numbers with SEV. 
> > 
> > Presumarily these are 64-bit?
> > 
> > And what devices do you speak off that are actually affected by 
> > this performance? Increasing the SWIOTLB just means we have more
> > memory, which in mind means you can have _more_ devices in the guest
> > that won't handle the fact that DMA mapping returns an error.
> > 
> > Not neccessarily that one device suddenly can go faster.
> > 
> > > 
> > > So by having this SWIOTLB size adjustment done implicitly (even using a
> > > static logic) is a great win-win situation. In other words, having even
> > > a simple and static default increase of SWIOTLB buffer size for SEV is
> > > really useful for us.
> > > 
> > > We can always think of adding all kinds of heuristics to this, but that
> > > just adds too much complexity without any predictable performance gain.
> > > 
> > > And to add, the patch extends the SWIOTLB size as an architecture
> > > specific callback, currently it is a simple and static logic for SEV/x86
> > > specific, but there is always an option to tweak/extend it with
> > > additional logic in the future.
> > 
> > Right, and that is what I would like to talk about as I think you
> > are going to disappear (aka, busy with other stuff) after this patch goes in.
> > 
> > I need to understand this more than "performance" and "internal teams"
> > requirements to come up with a better way going forward as surely other
> > platforms will hit the same issue anyhow.
> > 
> > Lets break this down:
> > 
> > How does the performance improve for one single device if you increase the SWIOTLB?
> > Is there a specific device/driver that you can talk about that improve with this patch?
> > 
> > 
> 
> Yes, these are mainly for multi-queue devices such as NICs or even
> multi-queue virtio. 
> 
> This basically improves performance with concurrent DMA, hence,
> basically multi-queue devices.

OK, and for _1GB_ guest - what are the "internal teams/external customers" amount 
of CPUs they use? Please lets use real use-cases.
