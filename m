Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5024119EFFD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 06:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgDFE5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 00:57:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726473AbgDFE5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 00:57:19 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0364Yl86097301;
        Mon, 6 Apr 2020 00:57:10 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 306k5uj65u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 00:57:10 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0364tDZf016378;
        Mon, 6 Apr 2020 04:57:09 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 306hv6h0ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 04:57:09 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0364v8eX54133176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Apr 2020 04:57:08 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD6C628059;
        Mon,  6 Apr 2020 04:57:08 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 230B628058;
        Mon,  6 Apr 2020 04:57:08 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.79.181.69])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Apr 2020 04:57:08 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id AD3982E3231; Fri,  3 Apr 2020 16:54:28 +0530 (IST)
Date:   Fri, 3 Apr 2020 16:54:28 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     ego@linux.vnet.ibm.com,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [PATCH v4 2/6] powerpc/idle: Add accessor function to always
 read latest idle PURR
Message-ID: <20200403112428.GB20293@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1585308760-28792-1-git-send-email-ego@linux.vnet.ibm.com>
 <1585308760-28792-3-git-send-email-ego@linux.vnet.ibm.com>
 <1585734073.0qmf6bbdoa.naveen@linux.ibm.com>
 <20200403061536.GA9066@in.ibm.com>
 <1585909343.fw0f8jg7ug.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585909343.fw0f8jg7ug.naveen@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_01:2020-04-03,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 04:04:56PM +0530, Naveen N. Rao wrote:
> Gautham R Shenoy wrote:
> >On Wed, Apr 01, 2020 at 03:12:53PM +0530, Naveen N. Rao wrote:
> >>Hi Gautham,
> >>
> >>Gautham R. Shenoy wrote:
> >>>From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >>>
> >>>+
> >>>+static inline u64 read_this_idle_purr(void)
> >>>+{
> >>>+	/*
> >>>+	 * If we are reading from an idle context, update the
> >>>+	 * idle-purr cycles corresponding to the last idle period.
> >>>+	 * Since the idle context is not yet over, take a fresh
> >>>+	 * snapshot of the idle-purr.
> >>>+	 */
> >>>+	if (unlikely(get_lppaca()->idle == 1)) {
> >>>+		update_idle_purr_accounting();
> >>>+		snapshot_purr_idle_entry();
> >>>+	}
> >>>+
> >>>+	return be64_to_cpu(get_lppaca()->wait_state_cycles);
> >>>+}
> >>>+
> >>
> >>I think this and read_this_idle_spurr() from the next patch should be moved
> >>to Patch 4/6, where they are actually used.
> >
> >The reason I included this function in this patch was to justify why
> >we were introducing snapshotting the purr values in a global per-cpu
> >variable instead of on a stack variable. The reason being that someone
> >might want to read the PURR value from an interrupt context which had
> >woken up the CPU from idle. At this point, since epilog() function
> >wasn't called, the idle PURR count corresponding to this latest idle
> >period would have been accumulated in lppaca->wait_cycles. Thus, this
> >helper function safely reads the value by
> >   1) First updating the lppaca->wait_cycles with the latest idle_purr
> >   count.
> >   2) Take a fresh snapshot, since the time from now to the epilog()
> >   call is also counted under idle CPU. So the PURR cycle increment
> >   during this short period should also be accumulated in lppaca->wait_cycles.
> >
> >
> >prolog()
> >|	snapshot PURR
> >|
> >|
> >|
> >Idle
> >|
> >| <----- Interrupt . Read idle PURR ---- update idle PURR;
> >|                              	         snapshot PURR;
> >|                                   	 Read idle PURR.       |
> >epilog()
> >	update idle PURR
> >
> 
> Yes, I understand. It makes sense.
> 
> >
> >However, if you feel that moving this function to Patch 4 where it is
> >actually used makes it more readable, I can do that.
> 
> My suggestion was from a bisectability standpoint though. This is a fairly
> simple function, but it is generally recommended to ensure that newly added
> code gets exercized in the patch that it is introduced in:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/5.Posting.rst#n119
>

Fair point. Will move those functions to Patch 4.


> 
> Regards,
> Naveen
> 
