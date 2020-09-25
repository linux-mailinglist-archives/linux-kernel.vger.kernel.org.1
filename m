Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDE7277E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 05:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgIYDGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 23:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726704AbgIYDGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 23:06:15 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601003174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pPyth/CR2dpYigKRz2XXFwV37AHeH6IZ34wEhpd6C0I=;
        b=UcD7ReOrhUshmqSIGC716n6ndzBHB+t9fYNqbYZD+E8Vf+HDKr7XgiVPnT8rV3hfXYvexE
        AB8M3xiFgEJfq0sr0a36aD6TjuOojsAw18s15/QIdBChR4gNRf7qJrsfECAXm9DlVVp61a
        AkVdMg/fTEkzc3w7Tu2Vs/FUEplCyaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-lzcnFl1kPHmEFve_DDKvEA-1; Thu, 24 Sep 2020 23:06:09 -0400
X-MC-Unique: lzcnFl1kPHmEFve_DDKvEA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1D131091062;
        Fri, 25 Sep 2020 03:06:07 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-229.pek2.redhat.com [10.72.12.229])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F1B319C78;
        Fri, 25 Sep 2020 03:06:01 +0000 (UTC)
Date:   Fri, 25 Sep 2020 11:05:58 +0800
From:   Dave Young <dyoung@redhat.com>
To:     boris.ostrovsky@oracle.com
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
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
Message-ID: <20200925030558.GA3446@dhcp-128-65.nay.redhat.com>
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
 <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
 <20200921201811.GB3437@char.us.oracle.com>
 <87v9g6fuub.fsf@x220.int.ebiederm.org>
 <20200923024329.GB3642@dhcp-128-65.nay.redhat.com>
 <20200923154825.GC7635@char.us.oracle.com>
 <MW2PR2101MB10521373DD95F5AF014254DDD7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <874knndtvo.fsf@x220.int.ebiederm.org>
 <MW2PR2101MB1052ED1C8953135A58276F04D7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <4f964490-7464-0071-db38-4b16d665503e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f964490-7464-0071-db38-4b16d665503e@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/24/20 at 01:16pm, boris.ostrovsky@oracle.com wrote:
> 
> On 9/24/20 12:43 PM, Michael Kelley wrote:
> > From: Eric W. Biederman <ebiederm@xmission.com> Sent: Thursday, September 24, 2020 9:26 AM
> >> Michael Kelley <mikelley@microsoft.com> writes:
> >>
> >>>>> Added Hyper-V people and people who created the param, it is below
> >>>>> commit, I also want to remove it if possible, let's see how people
> >>>>> think, but the least way should be to disable the auto setting in both systemd
> >>>>> and kernel:
> >>> Hyper-V uses a notifier to inform the host system that a Linux VM has
> >>> panic'ed.  Informing the host is particularly important in a public cloud
> >>> such as Azure so that the cloud software can alert the customer, and can
> >>> track cloud-wide reliability statistics.   Whether a kdump is taken is controlled
> >>> entirely by the customer and how he configures the VM, and we want
> >>> the host to be informed either way.
> >> Why?
> >>
> >> Why does the host care?
> >> Especially if the VM continues executing into a kdump kernel?
> > The host itself doesn't care.  But the host is a convenient out-of-band
> > channel for recording that a panic has occurred and to collect basic data
> > about the panic.  This out-of-band channel is then used to notify the end
> > customer that his VM has panic'ed.  Sure, the customer should be running
> > his own monitoring software, but customers don't always do what they
> > should.  Equally important, the out-of-band channel allows the cloud
> > infrastructure software to notice trends, such as that the rate of Linux
> > panics has increased, and that perhaps there is a cloud problem that
> > should be investigated.
> 
> 
> In many cases (especially in cloud environment) your dump device is remote (e.g. iscsi) and kdump sometimes (often?) gets stuck because of connectivity issues (which could be cause of the panic in the first place). So it is quite desirable to inform the infrastructure that the VM is on its way out without waiting for kdump to complete.

That can probably be done in kdump kernel if it is really needed.  Say
informing host that panic happened and a kdump kernel is runnning.

But I think to set crash_kexec_post_notifiers by default is still bad. 

> 
> 
> >
> >> Further like I have mentioned everytime something like this has come up
> >> a call on the kexec on panic code path should be a direct call (That can
> >> be audited) not something hidden in a notifier call chain (which can not).
> >>
> 
> We btw already have a direct call from panic() to kmsg_dump() which is indirectly controlled by crash_kexec_post_notifiers, and it would also be preferable to be able to call it before kdump as well.

Right, that is the same thing we are talking about.

Thanks
Dave

