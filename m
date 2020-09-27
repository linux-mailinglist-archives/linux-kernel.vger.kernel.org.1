Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8789279D95
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 04:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbgI0Cvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 22:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51174 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbgI0Cvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 22:51:51 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601175109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1NJn8IpCjlFAqwDE9625qU617gkX19yU+6KV0gSW69o=;
        b=LwAKFxdolPgGLrWQwCT1K0ars4a/O8bPk/NhYImKXYSrC1lFP6GvbTMHLGxmMxxROPNaFm
        jkGDPY6Ojd1JeHpNgyM90JewB1lr771cwmTOvwi3CuQmG6NjSPNKiZ0HQyRSYBsudtxH5c
        SBi62jLrn/Zkqvo6hD2OsO/nnOpi5Fc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-TJDCAhRdOA6c63GNM6JjiA-1; Sat, 26 Sep 2020 22:51:46 -0400
X-MC-Unique: TJDCAhRdOA6c63GNM6JjiA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C6461074648;
        Sun, 27 Sep 2020 02:51:44 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-234.pek2.redhat.com [10.72.12.234])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67FF978801;
        Sun, 27 Sep 2020 02:51:38 +0000 (UTC)
Date:   Sun, 27 Sep 2020 10:51:34 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
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
Message-ID: <20200927025134.GA3445@dhcp-128-65.nay.redhat.com>
References: <20200921201811.GB3437@char.us.oracle.com>
 <87v9g6fuub.fsf@x220.int.ebiederm.org>
 <20200923024329.GB3642@dhcp-128-65.nay.redhat.com>
 <20200923154825.GC7635@char.us.oracle.com>
 <MW2PR2101MB10521373DD95F5AF014254DDD7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <874knndtvo.fsf@x220.int.ebiederm.org>
 <MW2PR2101MB1052ED1C8953135A58276F04D7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <4f964490-7464-0071-db38-4b16d665503e@oracle.com>
 <20200925030558.GA3446@dhcp-128-65.nay.redhat.com>
 <20200925145625.GH30019@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925145625.GH30019@char.us.oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/25/20 at 10:56am, Konrad Rzeszutek Wilk wrote:
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

If it is done in kernel boot phase before pid 1 comes up then things
should be good enough, specific for kvm/hyper-v guests the kdump kernel.

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

As I said we also got reports of kdump kernel hang with Hyper-V with the
crash_kexec_post_notifiers enabled.

EFI pstore also depends on efi runtime that is in firmware, also we can
not ensure it works well after a panic happened.  Ditto for other pstore
backends we do not prefer to do it before kdump.  But as I said I'm not
saying they are not useful, people can use them by their choose.

As for the virtual machine panic events maybe it is ok to add some other
hooks instead of the notifiers.  But frankly I still feel it is better to do
it in kdump kernel boot path since kdump works well for virt from our
experience.

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

Thanks
Dave

