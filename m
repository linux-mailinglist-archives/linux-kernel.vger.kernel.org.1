Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149191D3BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 21:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgENTFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 15:05:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729644AbgENTF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:05:27 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EJ4SMe069982;
        Thu, 14 May 2020 15:04:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3111w8w6aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 15:04:58 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04EJ4WT0070393;
        Thu, 14 May 2020 15:04:58 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3111w8w69w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 15:04:58 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04EJ3PVR027513;
        Thu, 14 May 2020 19:04:57 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04wdc.us.ibm.com with ESMTP id 3100ubrxqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 19:04:57 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04EJ4uQh20709730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 May 2020 19:04:56 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31AFAC6057;
        Thu, 14 May 2020 19:04:56 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4DD1C605A;
        Thu, 14 May 2020 19:04:55 +0000 (GMT)
Received: from localhost (unknown [9.85.205.196])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 14 May 2020 19:04:55 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Leonardo Bras <leonardo@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH 1/1] powerpc/rtas: Implement reentrant rtas call
In-Reply-To: <ba97d52df60ac9c4a4afc2c03121a8c263aa5a15.camel@linux.ibm.com>
References: <20200408223901.760733-1-leonardo@linux.ibm.com> <87ftdb87jf.fsf@linux.ibm.com> <ba97d52df60ac9c4a4afc2c03121a8c263aa5a15.camel@linux.ibm.com>
Date:   Thu, 14 May 2020 14:04:55 -0500
Message-ID: <875zcy2v8o.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_07:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 cotscore=-2147483648 clxscore=1015 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=1 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonardo,

Leonardo Bras <leonardo@linux.ibm.com> writes:
> Hello Nathan, thanks for the feedback!
>
> On Fri, 2020-04-10 at 14:28 -0500, Nathan Lynch wrote:
>> Leonardo Bras <leonardo@linux.ibm.com> writes:
>> > Implement rtas_call_reentrant() for reentrant rtas-calls:
>> > "ibm,int-on", "ibm,int-off",ibm,get-xive" and  "ibm,set-xive".
>> > 
>> > On LoPAPR Version 1.1 (March 24, 2016), from 7.3.10.1 to 7.3.10.4,
>> > items 2 and 3 say:
>> > 
>> > 2 - For the PowerPC External Interrupt option: The * call must be
>> > reentrant to the number of processors on the platform.
>> > 3 - For the PowerPC External Interrupt option: The * argument call
>> > buffer for each simultaneous call must be physically unique.
>> > 
>> > So, these rtas-calls can be called in a lockless way, if using
>> > a different buffer for each call.
>> > 
>
>> From the language in the spec it's clear that these calls are intended
>> to be reentrant with respect to themselves, but it's less clear to me
>> that they are safe to call simultaneously with respect to each other or
>> arbitrary other RTAS methods.
>
> In my viewpoint, being reentrant to themselves, without being reentrant
> to others would be very difficult to do, considering the way the
> rtas_call is crafted to work.
>
> I mean, I have no experience in rtas code, it's my viewpoint. In my
> thoughts there is something like this:
>
> common_path -> selects function by token -> reentrant function
> 					|-> non-reentrant function
>
> If there is one function that is reentrant, it means the common_path
> and function selection by token would need to be reentrant too.

I checked with partition firmware development and these calls can be
used concurrently with arbitrary other RTAS calls, which confirms your
interpretation. Thanks for bearing with me.

