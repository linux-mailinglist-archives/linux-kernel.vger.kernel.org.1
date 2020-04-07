Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E03251A0572
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 06:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgDGEA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 00:00:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgDGEA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 00:00:58 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0373Wnpn135350
        for <linux-kernel@vger.kernel.org>; Tue, 7 Apr 2020 00:00:57 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3082nw9tmc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 00:00:57 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bharata@linux.ibm.com>;
        Tue, 7 Apr 2020 05:00:37 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 Apr 2020 05:00:35 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03740qoE46465516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Apr 2020 04:00:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAC184203F;
        Tue,  7 Apr 2020 04:00:51 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7039D4205E;
        Tue,  7 Apr 2020 04:00:49 +0000 (GMT)
Received: from in.ibm.com (unknown [9.79.188.166])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  7 Apr 2020 04:00:49 +0000 (GMT)
Date:   Tue, 7 Apr 2020 09:30:46 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Leonardo Bras <leonardo@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH v3 1/1] powerpc/kernel: Enables memory hot-remove after
 reboot on pseries guests
Reply-To: bharata@linux.ibm.com
References: <20200402195156.626430-1-leonardo@linux.ibm.com>
 <20200403143831.GA12662@in.ibm.com>
 <6c09a6e1a1f790ad87a2591ff8f8a6e1c7d6b079.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c09a6e1a1f790ad87a2591ff8f8a6e1c7d6b079.camel@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-TM-AS-GCONF: 00
x-cbid: 20040704-0008-0000-0000-0000036BE47E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040704-0009-0000-0000-00004A8D7CB3
Message-Id: <20200407040046.GA12609@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_01:2020-04-07,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=652 malwarescore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004070026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 12:41:01PM -0300, Leonardo Bras wrote:
> Hello Bharata,
> 
> On Fri, 2020-04-03 at 20:08 +0530, Bharata B Rao wrote:
> > The patch would be more complete with the following change that ensures
> > that DRCONF_MEM_HOTREMOVABLE flag is set for non-boot-time hotplugged
> > memory too. This will ensure that ibm,dynamic-memory-vN property
> > reflects the right flags value for memory that gets hotplugged
> > post boot.
> > 
> 
> You just sent that on a separated patchset, so I think it's dealt with.
> Do you have any other comments on the present patch?

None, thanks.

Regards,
Bharata.

