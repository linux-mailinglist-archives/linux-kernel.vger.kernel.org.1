Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174A6242525
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 08:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgHLGBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 02:01:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbgHLGBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 02:01:21 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07C5mCij059518;
        Wed, 12 Aug 2020 02:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=Flytr8k2939r01rScwjBxWieA0ZKAN00UvMze6baDuU=;
 b=L3I3u9z7Oj5Aj0x3Gjc8mkcJSMyILV1bwMDd6mSk/RPN8brB/+DRw6fZz5iyPaVbwcRq
 GypubXC0xCVf07SJwWpKxEscBe2baGJJovxo0XZMD+LdBBmYKGwQPxtLhrmbUEpKSbzS
 xkVeXWs/uIoYAUj4IVLaDlLkCnSiLCtLsaNOyil6yKpciwViD3GpR9FxO6kFWfbncG4x
 eJW8PIKgggfN+UfUWDdGl9DrEtRiAsDW1DTeCig3OTvMXmmZHOx1UnIc+0MGJivMYCvL
 61+9AmjlBdcZutyN/v1pj8mo7AJLQbvOf+Fm4aKVg2iZNOLD668k64pGIsa4GzEKNg0C cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32vakp07yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Aug 2020 02:01:10 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07C5t6EV075791;
        Wed, 12 Aug 2020 02:01:09 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32vakp07x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Aug 2020 02:01:09 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07C5pVWk011342;
        Wed, 12 Aug 2020 06:01:07 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 32skahc22b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Aug 2020 06:01:06 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07C614ei26607962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Aug 2020 06:01:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 866B6AE05F;
        Wed, 12 Aug 2020 06:01:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEEC3AE05A;
        Wed, 12 Aug 2020 06:01:01 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 12 Aug 2020 06:01:01 +0000 (GMT)
Date:   Wed, 12 Aug 2020 11:31:01 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Michal Such?nek <msuchanek@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linuxppc-dev@lists.ozlabs.org, Christopher Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
Message-ID: <20200812060101.GB10992@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <184102af-ecf2-c834-db46-173ab2e66f51@redhat.com>
 <20200701110145.GC17918@linux.vnet.ibm.com>
 <0468f965-8762-76a3-93de-3987cf859927@redhat.com>
 <12945273-d788-710d-e8d7-974966529c7d@redhat.com>
 <20200701122110.GT2369@dhcp22.suse.cz>
 <20200703091001.GJ21462@kitsune.suse.cz>
 <20200703092414.GR18446@dhcp22.suse.cz>
 <20200703105944.GS18446@dhcp22.suse.cz>
 <20200703125823.GA26243@linux.vnet.ibm.com>
 <20200806213211.6a6a56037fe771836e5abbe9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200806213211.6a6a56037fe771836e5abbe9@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-11_19:2020-08-11,2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008120039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Michal, David

* Andrew Morton <akpm@linux-foundation.org> [2020-08-06 21:32:11]:

> On Fri, 3 Jul 2020 18:28:23 +0530 Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:
> 
> > > The memory hotplug changes that somehow because you can hotremove numa
> > > nodes and therefore make the nodemask sparse but that is not a common
> > > case. I am not sure what would happen if a completely new node was added
> > > and its corresponding node was already used by the renumbered one
> > > though. It would likely conflate the two I am afraid. But I am not sure
> > > this is really possible with x86 and a lack of a bug report would
> > > suggest that nobody is doing that at least.
> > > 
> > 
> > JFYI,
> > Satheesh copied in this mailchain had opened a bug a year on crash with vcpu
> > hotplug on memoryless node. 
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=202187
> 
> So...  do we merge this patch or not?  Seems that the overall view is
> "risky but nobody is likely to do anything better any time soon"?

Can we decide on this one way or the other?

-- 
Thanks and Regards
Srikar Dronamraju
