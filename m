Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C765274038
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgIVK6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:58:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbgIVK63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:58:29 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08MAWXM1093894;
        Tue, 22 Sep 2020 06:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=g0Xb4AkSfAGI8Wdj8SFHfxmZYV0aap2LiySO8+B3cbY=;
 b=KkiyaXYdMSct0gfSdSgprCN+mXzCK6ktkeVTJFUYN3oYtXUmBmlsVipNFXzL6FXCmDzH
 SjSr3QccRZEeABmRvzgzLMAQycSWF+QaRESRa4zUHEdXQpDza8BdeheHSIYrz7F+ulsk
 zLHxN5ul7ghvfVMbmeLxKJkLnGP3kRrMg8NyCo0cfBX/oR09jiH2LPgz4p0trTXWvOOm
 +MhnAWOrSNo6Rqhi3zmu8rGFveoFwcDRmIbOR7a5s7WANUS4zbfvxzSPr6cIQVYheDPx
 I9Xbrj4MVrUjFACZPVQ2pLa4mC4q6sOURj4NeYQX0FGnFGPi1IcL0u1TtNr9V4PeDQU0 iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33qcpp62ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 06:58:16 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08MAvruR024713;
        Tue, 22 Sep 2020 06:58:15 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33qcpp62bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 06:58:15 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08MAll2f020492;
        Tue, 22 Sep 2020 10:58:13 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 33n9m7shy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 10:58:13 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08MAw9ma22479294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 10:58:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B18DE52052;
        Tue, 22 Sep 2020 10:58:10 +0000 (GMT)
Received: from ibm (unknown [9.145.153.226])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 57C6652054;
        Tue, 22 Sep 2020 10:58:10 +0000 (GMT)
Date:   Tue, 22 Sep 2020 12:58:09 +0200
From:   Philipp Rudo <prudo@linux.ibm.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot
 time
Message-ID: <20200922125809.66690d54@ibm>
In-Reply-To: <20200921201811.GB3437@char.us.oracle.com>
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
        <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
        <20200921201811.GB3437@char.us.oracle.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_06:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 clxscore=1011 lowpriorityscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009220083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,


On Mon, 21 Sep 2020 16:18:12 -0400
Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:

> On Fri, Sep 18, 2020 at 05:47:43PM -0700, Andrew Morton wrote:
> > On Fri, 18 Sep 2020 11:25:46 +0800 Dave Young <dyoung@redhat.com> wrote:
> >   
> > > crash_kexec_post_notifiers enables running various panic notifier
> > > before kdump kernel booting. This increases risks of kdump failure.
> > > It is well documented in kernel-parameters.txt. We do not suggest
> > > people to enable it together with kdump unless he/she is really sure.
> > > This is also not suggested to be enabled by default when users are
> > > not aware in distributions.
> > > 
> > > But unfortunately it is enabled by default in systemd, see below
> > > discussions in a systemd report, we can not convince systemd to change
> > > it:
> > > https://github.com/systemd/systemd/issues/16661
> > > 
> > > Actually we have got reports about kdump kernel hangs in both s390x
> > > and powerpcle cases caused by the systemd change,  also some x86 cases
> > > could also be caused by the same (although that is in Hyper-V code
> > > instead of systemd, that need to be addressed separately).  
> 
> Perhaps it may be better to fix the issus on s390x and PowerPC as well?

There's little s390 can fix. We use the panic_notifier_list to start
other dumpers in case kdump isn't configured or failed. This behavior was
introduced in 2006 long before crash_kexec_post_notifiers were introduced. So I
suggest that crash_kexec_post_notifiers are fixed instead.

> > > 
> > > Thus to avoid the auto enablement here just disable the param writable
> > > permission in sysfs.
> > >   
> > 
> > Well.  I don't think this is at all a desirable way of resolving a
> > disagreement with the systemd developers
> > 
> > At the above github address I'm seeing "ryncsn added a commit to
> > ryncsn/systemd that referenced this issue 9 days ago", "pstore: don't
> > enable crash_kexec_post_notifiers by default".  So didn't that address
> > the issue?  
> 
> It does in systemd, but there is a strong interest in making this on by default.

AFAIK pstore requires UEFI to work. So what's the point to enable it on non-UEFI
systems?

Thanks
Philipp
