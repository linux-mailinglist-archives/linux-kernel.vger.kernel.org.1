Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1DB278B55
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgIYOzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:55:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60178 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbgIYOzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:55:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PEnKGr087730;
        Fri, 25 Sep 2020 14:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=bM/KGhN7X/B0rWlIXrAEsLv5vK48LHNh9qXkAYDH3qY=;
 b=UzI0P7JRpw99/O6tZtRdIrQjY/M/TJPXT6rEk4tEJKeW9KV1DkPkBTbe9sa7wzdFtRx/
 NxgAuPWbA1xrr0G9EpcE/Q7RrTh2qk6jAudZz5Rv1Re0OKhf4DhHAjX5Qvq8pXhd0TiR
 JJwMHoJjFSXnxJJvmadzvMkH/uJ2kbOne6uHxkTLbNuuRJeig2hBqe/Wt5XFlFEpgL7R
 dykvgQrYCxbVdpExaTfrZoo7euwyh4xumS3Hc2Ow20998pA+9i40bsxABrpka4fJJ3M8
 85AAMACl6e14WEBkoC34f6CuuzTYLqY4HS+ICsekhsCvjURMACtURKVItOA48PXucjwL ZQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33q5rgvfux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 14:54:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PEkYZq085193;
        Fri, 25 Sep 2020 14:54:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33nurxwes7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Sep 2020 14:54:57 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08PEst1S028973;
        Fri, 25 Sep 2020 14:54:55 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Sep 2020 07:54:55 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 5C5C16A00F9; Fri, 25 Sep 2020 10:56:25 -0400 (EDT)
Date:   Fri, 25 Sep 2020 10:56:25 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     boris.ostrovsky@oracle.com,
        Michael Kelley <mikelley@microsoft.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
Message-ID: <20200925145625.GH30019@char.us.oracle.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925030558.GA3446@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 11:05:58AM +0800, Dave Young wrote:
> Hi,
> 
> On 09/24/20 at 01:16pm, boris.ostrovsky@oracle.com wrote:
> > 
> > On 9/24/20 12:43 PM, Michael Kelley wrote:
> > > From: Eric W. Biederman <ebiederm@xmission.com> Sent: Thursday, September 24, 2020 9:26 AM
> > >> Michael Kelley <mikelley@microsoft.com> writes:
> > >>
> > >>>>> Added Hyper-V people and people who created the param, it is below
> > >>>>> commit, I also want to remove it if possible, let's see how people
> > >>>>> think, but the least way should be to disable the auto setting in both systemd
> > >>>>> and kernel:
> > >>> Hyper-V uses a notifier to inform the host system that a Linux VM has
> > >>> panic'ed.  Informing the host is particularly important in a public cloud
> > >>> such as Azure so that the cloud software can alert the customer, and can
> > >>> track cloud-wide reliability statistics.   Whether a kdump is taken is controlled
> > >>> entirely by the customer and how he configures the VM, and we want
> > >>> the host to be informed either way.
> > >> Why?
> > >>
> > >> Why does the host care?
> > >> Especially if the VM continues executing into a kdump kernel?
> > > The host itself doesn't care.  But the host is a convenient out-of-band
> > > channel for recording that a panic has occurred and to collect basic data
> > > about the panic.  This out-of-band channel is then used to notify the end
> > > customer that his VM has panic'ed.  Sure, the customer should be running
> > > his own monitoring software, but customers don't always do what they
> > > should.  Equally important, the out-of-band channel allows the cloud
> > > infrastructure software to notice trends, such as that the rate of Linux
> > > panics has increased, and that perhaps there is a cloud problem that
> > > should be investigated.
> > 
> > 
> > In many cases (especially in cloud environment) your dump device is remote (e.g. iscsi) and kdump sometimes (often?) gets stuck because of connectivity issues (which could be cause of the panic in the first place). So it is quite desirable to inform the infrastructure that the VM is on its way out without waiting for kdump to complete.
> 
> That can probably be done in kdump kernel if it is really needed.  Say
> informing host that panic happened and a kdump kernel is runnning.

If kdump kernel gets to that point. Sometimes (sadly) it ends up being
misconfigured and it chokes up - and hence having multiple ways to emit
the crash information before running kdump kernel is a life-saver.

> 
> But I think to set crash_kexec_post_notifiers by default is still bad. 

Because of the way it is run today I presume? If there was some
safe/unsafe policy that should work right? I would think that the
safe ones that work properly all the time are:

 - HyperV CRASH_MSRs,
 - KVM PVPANIC_[PANIC,CRASHLOAD] push button knob,
 - pstore EFI variables
 - Dumping in memory,

And then some that depend on firmware version (aka BIOS, and vendor) are:
 - ACPI ERST,

And then the unsafe:
 - s390, PowerPC (I don't actually know what they are but that
    was Dave's primary motivator).

> 
> > 
> > 
> > >
> > >> Further like I have mentioned everytime something like this has come up
> > >> a call on the kexec on panic code path should be a direct call (That can
> > >> be audited) not something hidden in a notifier call chain (which can not).
> > >>
> > 
> > We btw already have a direct call from panic() to kmsg_dump() which is indirectly controlled by crash_kexec_post_notifiers, and it would also be preferable to be able to call it before kdump as well.
> 
> Right, that is the same thing we are talking about.
> 
> Thanks
> Dave
> 
