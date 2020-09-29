Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CFF27CF4A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgI2Ngi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:36:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725306AbgI2Ngh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:36:37 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TDVsec091045;
        Tue, 29 Sep 2020 09:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=xdJZZtgkzxEGgNzOlCoAlbWk6B8I7GmQ36NKZok3idc=;
 b=rd8995YWjhY6CgIv19DPqYCI6iSSLMfNOmpvaBCvp8Q64fkp3hp3tokK6BZnO2T1U8dk
 tUqH7MWhij4RxHMkwY28gwzOZvYASSCBkiaLr4Svx6YnkW6gGJt2xuzEmTtFoCPMdoY9
 Ehbk+HiCzpTL0P0Am+C5cxRw4ZsNmirqX9CvZ/PKjL6xZnXm6H2MHTeS6NED87eFzIE1
 0l/75Eh930uHeCwG0KhVdnfKJuXiRhQ8FSE3AdpeCv8IeurXuIufPsVp0O9b4ihkt7gM
 RpwHO37ieARYSvDrDohRQ0hcg6EMOaKIjx0liRI6oszgfk7+4nHbThnaI7jdzxtx9ZUV zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33v5ks0wg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 09:36:24 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08TDXGU4099406;
        Tue, 29 Sep 2020 09:36:24 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33v5ks0wex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 09:36:23 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08TDWmGO014359;
        Tue, 29 Sep 2020 13:36:21 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 33t16k1p9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 13:36:21 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08TDaIrq22085994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 13:36:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE108AE055;
        Tue, 29 Sep 2020 13:36:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B5AAAE04D;
        Tue, 29 Sep 2020 13:36:18 +0000 (GMT)
Received: from ibm (unknown [9.145.154.80])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Sep 2020 13:36:18 +0000 (GMT)
Date:   Tue, 29 Sep 2020 15:36:16 +0200
From:   Philipp Rudo <prudo@linux.ibm.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Dave Young <dyoung@redhat.com>, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        boris.ostrovsky@oracle.com,
        Eric DeVolder <eric.devolder@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot
 time
Message-ID: <20200929153616.3cf68f16@ibm>
In-Reply-To: <20200925145625.GH30019@char.us.oracle.com>
References: <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
        <20200921201811.GB3437@char.us.oracle.com>
        <87v9g6fuub.fsf@x220.int.ebiederm.org>
        <20200923024329.GB3642@dhcp-128-65.nay.redhat.com>
        <20200923154825.GC7635@char.us.oracle.com>
        <MW2PR2101MB10521373DD95F5AF014254DDD7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
        <874knndtvo.fsf@x220.int.ebiederm.org>
        <MW2PR2101MB1052ED1C8953135A58276F04D7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
        <4f964490-7464-0071-db38-4b16d665503e@oracle.com>
        <20200925030558.GA3446@dhcp-128-65.nay.redhat.com>
        <20200925145625.GH30019@char.us.oracle.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_04:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 clxscore=1011 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 25 Sep 2020 10:56:25 -0400
Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:

> On Fri, Sep 25, 2020 at 11:05:58AM +0800, Dave Young wrote:
> > Hi,
> > 
> > On 09/24/20 at 01:16pm, boris.ostrovsky@oracle.com wrote:  
> > > 
> > > On 9/24/20 12:43 PM, Michael Kelley wrote:  
> > > > From: Eric W. Biederman <ebiederm@xmission.com> Sent: Thursday, September 24, 2020 9:26 AM  
> > > >> Michael Kelley <mikelley@microsoft.com> writes:
> > > >>  
> > > >>>>> Added Hyper-V people and people who created the param, it is below
> > > >>>>> commit, I also want to remove it if possible, let's see how people
> > > >>>>> think, but the least way should be to disable the auto setting in both systemd
> > > >>>>> and kernel:  
> > > >>> Hyper-V uses a notifier to inform the host system that a Linux VM has
> > > >>> panic'ed.  Informing the host is particularly important in a public cloud
> > > >>> such as Azure so that the cloud software can alert the customer, and can
> > > >>> track cloud-wide reliability statistics.   Whether a kdump is taken is controlled
> > > >>> entirely by the customer and how he configures the VM, and we want
> > > >>> the host to be informed either way.  
> > > >> Why?
> > > >>
> > > >> Why does the host care?
> > > >> Especially if the VM continues executing into a kdump kernel?  
> > > > The host itself doesn't care.  But the host is a convenient out-of-band
> > > > channel for recording that a panic has occurred and to collect basic data
> > > > about the panic.  This out-of-band channel is then used to notify the end
> > > > customer that his VM has panic'ed.  Sure, the customer should be running
> > > > his own monitoring software, but customers don't always do what they
> > > > should.  Equally important, the out-of-band channel allows the cloud
> > > > infrastructure software to notice trends, such as that the rate of Linux
> > > > panics has increased, and that perhaps there is a cloud problem that
> > > > should be investigated.  
> > > 
> > > 
> > > In many cases (especially in cloud environment) your dump device is remote (e.g. iscsi) and kdump sometimes (often?) gets stuck because of connectivity issues (which could be cause of the panic in the first place). So it is quite desirable to inform the infrastructure that the VM is on its way out without waiting for kdump to complete.  
> > 
> > That can probably be done in kdump kernel if it is really needed.  Say
> > informing host that panic happened and a kdump kernel is runnning.  
> 
> If kdump kernel gets to that point. Sometimes (sadly) it ends up being
> misconfigured and it chokes up - and hence having multiple ways to emit
> the crash information before running kdump kernel is a life-saver.
> 
> > 
> > But I think to set crash_kexec_post_notifiers by default is still bad.   
> 
> Because of the way it is run today I presume? If there was some
> safe/unsafe policy that should work right? I would think that the
> safe ones that work properly all the time are:
> 
>  - HyperV CRASH_MSRs,
>  - KVM PVPANIC_[PANIC,CRASHLOAD] push button knob,
>  - pstore EFI variables
>  - Dumping in memory,
> 
> And then some that depend on firmware version (aka BIOS, and vendor) are:
>  - ACPI ERST,
> 
> And then the unsafe:
>  - s390, PowerPC (I don't actually know what they are but that
>     was Dave's primary motivator).

that won't work on s390. Let me emphasize that the problems on s390 are not the
notifiers themselves but the fact that they are called before crash_kexec.

On s390 we have multiple dump methods besides kdump. We use a panic notifier to
trigger these dump methods from the panicking kernel. The problem is that these
dump methods are less powerful than kdump so we only want to use them as
fallback, i.e. only use them when either kdump wasn't configured or loading of
the crash kernel failed for whatever reason. That's why (plus historic reasons)
our notifier stops the machine when it is called and none of the methods is
configured. Which means that the second crash_kexec is never reached.

Long story short, the problem on s390 is caused by the two hunks in
kernel/panic.c:panic from f06e5153f4ae ("kernel/panic.c: add
"crash_kexec_post_notifiers" option for kdump after panic_notifers").

Besides the problems on s390 I support Dave and think that setting
crash_kexec_post_notifiers by default is wrong. We should keep in mind that
we are in a panic situation. This means that the kernel is in a state where it
doesn't trust itself anymore. So we should keep the code that is run to the
bare minimum as we cannot rely on it to work properly.

Thanks
Philipp

> 
> >   
> > > 
> > >   
> > > >  
> > > >> Further like I have mentioned everytime something like this has come up
> > > >> a call on the kexec on panic code path should be a direct call (That can
> > > >> be audited) not something hidden in a notifier call chain (which can not).
> > > >>  
> > > 
> > > We btw already have a direct call from panic() to kmsg_dump() which is indirectly controlled by crash_kexec_post_notifiers, and it would also be preferable to be able to call it before kdump as well.  
> > 
> > Right, that is the same thing we are talking about.
> > 
> > Thanks
> > Dave
> >   
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
