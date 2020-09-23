Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C03F275C54
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgIWPrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:47:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36532 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWPrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:47:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08NFiivc144589;
        Wed, 23 Sep 2020 15:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=cXSRu0zSyXARJHkTDieXFRLEmdfO3Td85pYV2exm7dU=;
 b=F2wr94gpirAOKnkYgWIudLca6NBRqv9zMzm01Uv95ANxZGIGyGHRGBva6VnEXRaXt4g+
 MWEIngIUPMIkyWN+2hqBQ7y0a9VKTw+YuOiGKG+X80NTE2+QJ5LDcjsyC4QTmeAu9Eiy
 DPqdeqrTtCFyVE+cLos9TBBTurOQJlWlU7835KOH8TfZ7ZqZVH5JT4Nx5nBAEobGwIC1
 pnnfHMQ2HxnZe9W+2tZKNgV59GgGsjUiKUrX84oJnaeixZD5gwL47M/uWejsfhbU7NyO
 vwjjzmXy31ijo7+UtpVhhkKG5vjc9M7ZPV/8OcQ4f4zaVaB2dfob7SlKi8xnZfPwhpun rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33ndnukc7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 15:47:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08NFk4GF007475;
        Wed, 23 Sep 2020 15:47:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33r28vqwcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Sep 2020 15:47:03 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08NFl0Ln012222;
        Wed, 23 Sep 2020 15:47:01 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Sep 2020 08:47:00 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id AB71F6A0109; Wed, 23 Sep 2020 11:48:25 -0400 (EDT)
Date:   Wed, 23 Sep 2020 11:48:25 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Eric DeVolder <eric.devolder@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Tianyu Lani <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
Message-ID: <20200923154825.GC7635@char.us.oracle.com>
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
 <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
 <20200921201811.GB3437@char.us.oracle.com>
 <87v9g6fuub.fsf@x220.int.ebiederm.org>
 <20200923024329.GB3642@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923024329.GB3642@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009230125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 10:43:29AM +0800, Dave Young wrote:
> + more people who may care about this param 

Paarty time!!

(See below, didn't snip any comments)
> On 09/21/20 at 08:45pm, Eric W. Biederman wrote:
> > Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> writes:
> > 
> > > On Fri, Sep 18, 2020 at 05:47:43PM -0700, Andrew Morton wrote:
> > >> On Fri, 18 Sep 2020 11:25:46 +0800 Dave Young <dyoung@redhat.com> wrote:
> > >> 
> > >> > crash_kexec_post_notifiers enables running various panic notifier
> > >> > before kdump kernel booting. This increases risks of kdump failure.
> > >> > It is well documented in kernel-parameters.txt. We do not suggest
> > >> > people to enable it together with kdump unless he/she is really sure.
> > >> > This is also not suggested to be enabled by default when users are
> > >> > not aware in distributions.
> > >> > 
> > >> > But unfortunately it is enabled by default in systemd, see below
> > >> > discussions in a systemd report, we can not convince systemd to change
> > >> > it:
> > >> > https://github.com/systemd/systemd/issues/16661
> > >> > 
> > >> > Actually we have got reports about kdump kernel hangs in both s390x
> > >> > and powerpcle cases caused by the systemd change,  also some x86 cases
> > >> > could also be caused by the same (although that is in Hyper-V code
> > >> > instead of systemd, that need to be addressed separately).
> > >
> > > Perhaps it may be better to fix the issus on s390x and PowerPC as well?
> > >
> > >> > 
> > >> > Thus to avoid the auto enablement here just disable the param writable
> > >> > permission in sysfs.
> > >> > 
> > >> 
> > >> Well.  I don't think this is at all a desirable way of resolving a
> > >> disagreement with the systemd developers
> > >> 
> > >> At the above github address I'm seeing "ryncsn added a commit to
> > >> ryncsn/systemd that referenced this issue 9 days ago", "pstore: don't
> > >> enable crash_kexec_post_notifiers by default".  So didn't that address
> > >> the issue?
> > >
> > > It does in systemd, but there is a strong interest in making this on
> > > by default.
> > 
> > There is also a strong interest in removing this code entirely from the
> > kernel.
> 
> Added Hyper-V people and people who created the param, it is below
> commit, I also want to remove it if possible, let's see how people
> think, but the least way should be to disable the auto setting in both systemd
> and kernel:
> 
>     commit f06e5153f4ae2e2f3b0300f0e260e40cb7fefd45
>     Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
>     Date:   Fri Jun 6 14:37:07 2014 -0700
>     
>         kernel/panic.c: add "crash_kexec_post_notifiers" option for kdump after panic_notifers
>     
>         Add a "crash_kexec_post_notifiers" boot option to run kdump after
>         running panic_notifiers and dump kmsg.  This can help rare situations
>         where kdump fails because of unstable crashed kernel or hardware failure
>         (memory corruption on critical data/code), or the 2nd kernel is already
>         broken by the 1st kernel (it's a broken behavior, but who can guarantee
>         that the "crashed" kernel works correctly?).
>     
>         Usage: add "crash_kexec_post_notifiers" to kernel boot option.
>     
>         Note that this actually increases risks of the failure of kdump.  This
>         option should be set only if you worry about the rare case of kdump
>         failure rather than increasing the chance of success.


If this is such risky knob that leads to bugs where folks are backing away
from with disgust in their faces - then perhaps the only way to go about
this is - limit the exposure to known working situations on firmware
that we can control?

That is enable only a subset of post notifiers which determine if they
are OK running if the conditions are blessed?

I think that would satisfy the conditions where you have to to deal with unsavory
bugs that end up on your plate - and aren't fun because there is no
way to fixing it -  but at the same time allowing multiple ways to save the crash?

Please don't take away something that is quite useful in the field. Can we
hammer out something that will remove your pain points?
> 
> > 
> > This failure is a case in point.
> > 
> > I think I am at my I told you so point.  This is what all of the testing
> > over all the years has said.  Leaving functionality to the peculiarities
> > of firmware when you don't have to, and can actually control what is
> > going on doesn't work.
> > 
> > Eric
> > 
> > 
> 
> Thanks
> Dave
> 
