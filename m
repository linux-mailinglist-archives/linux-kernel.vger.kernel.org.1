Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB76273963
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 05:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgIVDsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 23:48:15 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:15498 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726818AbgIVDsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 23:48:15 -0400
X-Greylist: delayed 4950 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 23:48:14 EDT
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08M2NwcI024796;
        Tue, 22 Sep 2020 02:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pps0720; bh=YhlXw8QcjdddmawFlgsEQRqTwEMEyQzgIm4huUErdIc=;
 b=bnOaR2j9kDgMQs06jkwuTkSCw1fc+B1zMs1RKDrC8ByV+4+QA4UaoXR/G5Lb8ASRQNlc
 t1fnUw5ZT0ZXorWmUz4EYEMmSsv6tl78Zi3ie2JCaM30/vqDxRA0hTPbzpAulzF3CUR0
 4cl8DuA3DzyBOI6o2BY3+s6RX37ITkyktd9QZJ3DD3H+oLgU8WG/vxLc0ynzkncmjuOp
 opCSUfSRACYGYOkdkkowWgAcgJF3dsPmHVUqoO5S4C9frKa6nIVXP8S3pB83I4OTfYUQ
 LlGKo/N1/EnTL43I30XEtJC59qf5W+CrU/YwRsf2qQJ+5LHkyQ5PEpejzZUxPUgkdEel fA== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 33q53yh0va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 02:25:08 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id BC36759;
        Tue, 22 Sep 2020 02:25:06 +0000 (UTC)
Received: from hpe.com (ben.americas.hpqcorp.net [10.33.153.7])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id E3C8548;
        Tue, 22 Sep 2020 02:25:04 +0000 (UTC)
Date:   Mon, 21 Sep 2020 21:25:04 -0500
From:   Russ Anderson <rja@hpe.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mike Travis <mike.travis@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 13/13] x86/platform/uv: Update Copyrights to conform
 to HPE standards
Message-ID: <20200922022504.unsi33w4njahh6pv@hpe.com>
Reply-To: Russ Anderson <rja@hpe.com>
References: <20200916192039.162934-1-mike.travis@hpe.com>
 <20200916192039.162934-14-mike.travis@hpe.com>
 <20200917075429.GB3333802@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917075429.GB3333802@kroah.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_03:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=778
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 clxscore=1011 suspectscore=2 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009220018
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 09:54:29AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 16, 2020 at 02:20:39PM -0500, Mike Travis wrote:
> > Add Copyrights to those files that have been updated for UV5 changes.
> > 
> > Signed-off-by: Mike Travis <mike.travis@hpe.com>
> > ---
> >  arch/x86/include/asm/uv/bios.h      | 1 +
> >  arch/x86/include/asm/uv/uv_hub.h    | 1 +
> >  arch/x86/include/asm/uv/uv_mmrs.h   | 1 +
> >  arch/x86/kernel/apic/x2apic_uv_x.c  | 1 +
> >  arch/x86/platform/uv/bios_uv.c      | 1 +
> >  arch/x86/platform/uv/uv_nmi.c       | 1 +
> >  arch/x86/platform/uv/uv_time.c      | 1 +
> >  drivers/misc/sgi-gru/grufile.c      | 1 +
> >  drivers/misc/sgi-xp/xp.h            | 1 +
> >  drivers/misc/sgi-xp/xp_main.c       | 1 +
> >  drivers/misc/sgi-xp/xp_uv.c         | 1 +
> >  drivers/misc/sgi-xp/xpc_main.c      | 1 +
> >  drivers/misc/sgi-xp/xpc_partition.c | 1 +
> >  drivers/misc/sgi-xp/xpnet.c         | 1 +
> >  14 files changed, 14 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
> > index 97ac595ebc6a..08b3d810dfba 100644
> > --- a/arch/x86/include/asm/uv/bios.h
> > +++ b/arch/x86/include/asm/uv/bios.h
> > @@ -5,6 +5,7 @@
> >  /*
> >   * UV BIOS layer definitions.
> >   *
> > + * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
> >   * Copyright (C) 2007-2017 Silicon Graphics, Inc. All rights reserved.
> >   * Copyright (c) Russ Anderson <rja@sgi.com>
> 
> Gotta love the different ways of text here :(
> 
> Anyway, much better than before, thanks.

The HPE copyright text is different than the old SGI copyright text.
We could update the SGI copyright line to be consistent, change
"Copyright (C)" to "(C) Copyright", if that is desired.

The HPE lawyers said the old SGI copyrights do not need to be
updated as far as they are concerned, because HPE owns the SGI
copyrights, but they can.  So the two lines could be combined to 

  * (C) Copyright 2007-2017, 2020 Hewlett Packard Enterprise Development LP

I will do whatever the lawyers and community want as far as format.

For what it's worth, the rja@sgi.com email still works, as does rja@hpe.com.

Thanks.
-- 
Russ Anderson,  SuperDome Flex Linux Kernel Group Manager
HPE - Hewlett Packard Enterprise (formerly SGI)  rja@hpe.com
