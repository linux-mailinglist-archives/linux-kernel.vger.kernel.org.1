Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C6B274F20
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgIWCnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 22:43:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726862AbgIWCnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600829023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/3hHB/CEPSXmG4ARGQaB71EdY5egWAxtcNh/vDG4KOs=;
        b=eB0wsEuv9AcI0CV43n1tKtLdzF2f5hUo9hICLv1daUZmiTBTQDYnkdSAQ5Oa3oCwW0PS1D
        ij+FeRp2U+GDRYoiCgNVYL6P5axb6aDPQx6oMr/1Z4zuSufTT9GrzBX84FoICLQpSXILd2
        AbT8R7ahIaiMEOoPcKjRDi8LsABpIjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-M98clFEDMdmyaQmWlc20vQ-1; Tue, 22 Sep 2020 22:43:39 -0400
X-MC-Unique: M98clFEDMdmyaQmWlc20vQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86BD1186DD28;
        Wed, 23 Sep 2020 02:43:37 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-77.pek2.redhat.com [10.72.13.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C348B5C1D0;
        Wed, 23 Sep 2020 02:43:32 +0000 (UTC)
Date:   Wed, 23 Sep 2020 10:43:29 +0800
From:   Dave Young <dyoung@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
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
Message-ID: <20200923024329.GB3642@dhcp-128-65.nay.redhat.com>
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
 <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
 <20200921201811.GB3437@char.us.oracle.com>
 <87v9g6fuub.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9g6fuub.fsf@x220.int.ebiederm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ more people who may care about this param 
On 09/21/20 at 08:45pm, Eric W. Biederman wrote:
> Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> writes:
> 
> > On Fri, Sep 18, 2020 at 05:47:43PM -0700, Andrew Morton wrote:
> >> On Fri, 18 Sep 2020 11:25:46 +0800 Dave Young <dyoung@redhat.com> wrote:
> >> 
> >> > crash_kexec_post_notifiers enables running various panic notifier
> >> > before kdump kernel booting. This increases risks of kdump failure.
> >> > It is well documented in kernel-parameters.txt. We do not suggest
> >> > people to enable it together with kdump unless he/she is really sure.
> >> > This is also not suggested to be enabled by default when users are
> >> > not aware in distributions.
> >> > 
> >> > But unfortunately it is enabled by default in systemd, see below
> >> > discussions in a systemd report, we can not convince systemd to change
> >> > it:
> >> > https://github.com/systemd/systemd/issues/16661
> >> > 
> >> > Actually we have got reports about kdump kernel hangs in both s390x
> >> > and powerpcle cases caused by the systemd change,  also some x86 cases
> >> > could also be caused by the same (although that is in Hyper-V code
> >> > instead of systemd, that need to be addressed separately).
> >
> > Perhaps it may be better to fix the issus on s390x and PowerPC as well?
> >
> >> > 
> >> > Thus to avoid the auto enablement here just disable the param writable
> >> > permission in sysfs.
> >> > 
> >> 
> >> Well.  I don't think this is at all a desirable way of resolving a
> >> disagreement with the systemd developers
> >> 
> >> At the above github address I'm seeing "ryncsn added a commit to
> >> ryncsn/systemd that referenced this issue 9 days ago", "pstore: don't
> >> enable crash_kexec_post_notifiers by default".  So didn't that address
> >> the issue?
> >
> > It does in systemd, but there is a strong interest in making this on
> > by default.
> 
> There is also a strong interest in removing this code entirely from the
> kernel.

Added Hyper-V people and people who created the param, it is below
commit, I also want to remove it if possible, let's see how people
think, but the least way should be to disable the auto setting in both systemd
and kernel:

    commit f06e5153f4ae2e2f3b0300f0e260e40cb7fefd45
    Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
    Date:   Fri Jun 6 14:37:07 2014 -0700
    
        kernel/panic.c: add "crash_kexec_post_notifiers" option for kdump after panic_notifers
    
        Add a "crash_kexec_post_notifiers" boot option to run kdump after
        running panic_notifiers and dump kmsg.  This can help rare situations
        where kdump fails because of unstable crashed kernel or hardware failure
        (memory corruption on critical data/code), or the 2nd kernel is already
        broken by the 1st kernel (it's a broken behavior, but who can guarantee
        that the "crashed" kernel works correctly?).
    
        Usage: add "crash_kexec_post_notifiers" to kernel boot option.
    
        Note that this actually increases risks of the failure of kdump.  This
        option should be set only if you worry about the rare case of kdump
        failure rather than increasing the chance of success.

> 
> This failure is a case in point.
> 
> I think I am at my I told you so point.  This is what all of the testing
> over all the years has said.  Leaving functionality to the peculiarities
> of firmware when you don't have to, and can actually control what is
> going on doesn't work.
> 
> Eric
> 
> 

Thanks
Dave

