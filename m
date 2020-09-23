Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691E1274EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgIWC0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 22:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726893AbgIWC0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600827959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IaOuvH8yFcLP2XPWL4s+SHZG/coSY9ya51DgWC/DIGU=;
        b=PxAUyObV0vRZ0stkMFTIx5Qs806HzcPafSaQemCdJrRwJLXBqIV/Ongi/j5cjQaGzhxZ1p
        Vl68E0i9366LwtXpa5Fqq5XnPVFbX/pBC6ynadqNnxycEKv2tXPTBbuldbu5+tFLJalKYP
        0AbhZu3hosCYvMEQhQsTLD0tc9aQBq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-RGscsW6kPv6qxTolwEEfYA-1; Tue, 22 Sep 2020 22:25:55 -0400
X-MC-Unique: RGscsW6kPv6qxTolwEEfYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA7871006704;
        Wed, 23 Sep 2020 02:25:53 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-77.pek2.redhat.com [10.72.13.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 99C1C5C1D0;
        Wed, 23 Sep 2020 02:25:50 +0000 (UTC)
Date:   Wed, 23 Sep 2020 10:25:47 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Eric DeVolder <eric.devolder@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
Message-ID: <20200923022547.GA3642@dhcp-128-65.nay.redhat.com>
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
 <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
 <20200921201811.GB3437@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921201811.GB3437@char.us.oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/20 at 04:18pm, Konrad Rzeszutek Wilk wrote:
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
> 
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

I understand there could be such interest, but we have to keep in mind
that any extra things after a system crash can cause kdump unreliable.

I do not object people to use pstore, but I do object to enable the
notifiers by default.

BTW, crash notifiers are not limited to pstore, there are quite a log of
other pieces like led trigger etc.

Thanks
Dave

