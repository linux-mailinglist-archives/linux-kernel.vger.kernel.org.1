Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B69A270B6A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 09:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgISH00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 03:26:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56377 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726041AbgISH0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 03:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600500384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UtdUjKgbLsYk0G9Z0ogGkq4Rldpk6SpW/fYzoloN9BI=;
        b=R5iQRJEMbC6EUZqsWV1vQzRr5FWTjPdwJg3W0U3hzbFGHmDLitCjffn+PoBqu5a75GT96p
        sydzfkQkAbOtdJzCTkoEWHGRc+ZcqqLQp8V8KMW8CK1GHmcQMqUAeiwrOSVWKXfkDslktT
        9Pp2tN4d5XFE9IjSbqWyae2nawHF+DA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-oZxbG2zZP2WPWmUg0JdX4w-1; Sat, 19 Sep 2020 03:26:20 -0400
X-MC-Unique: oZxbG2zZP2WPWmUg0JdX4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56C75ACE22;
        Sat, 19 Sep 2020 07:26:19 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-66.pek2.redhat.com [10.72.12.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C142560CD1;
        Sat, 19 Sep 2020 07:26:16 +0000 (UTC)
Date:   Sat, 19 Sep 2020 15:26:13 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     bhe@redhat.com, Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
Message-ID: <20200919072613.GA3649@dhcp-128-65.nay.redhat.com>
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
 <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/20 at 05:47pm, Andrew Morton wrote:
> On Fri, 18 Sep 2020 11:25:46 +0800 Dave Young <dyoung@redhat.com> wrote:
> 
> > crash_kexec_post_notifiers enables running various panic notifier
> > before kdump kernel booting. This increases risks of kdump failure.
> > It is well documented in kernel-parameters.txt. We do not suggest
> > people to enable it together with kdump unless he/she is really sure.
> > This is also not suggested to be enabled by default when users are
> > not aware in distributions.
> > 
> > But unfortunately it is enabled by default in systemd, see below
> > discussions in a systemd report, we can not convince systemd to change
> > it:
> > https://github.com/systemd/systemd/issues/16661
> > 
> > Actually we have got reports about kdump kernel hangs in both s390x
> > and powerpcle cases caused by the systemd change,  also some x86 cases
> > could also be caused by the same (although that is in Hyper-V code
> > instead of systemd, that need to be addressed separately).
> > 
> > Thus to avoid the auto enablement here just disable the param writable
> > permission in sysfs.
> > 
> 
> Well.  I don't think this is at all a desirable way of resolving a
> disagreement with the systemd developers
> 
> At the above github address I'm seeing "ryncsn added a commit to
> ryncsn/systemd that referenced this issue 9 days ago", "pstore: don't
> enable crash_kexec_post_notifiers by default".  So didn't that address
> the issue?
> 

I hope that commit can be merged in systemd, but we are really not
optimize about that. The discussion is clear there but we did not get
response since Aug 6.

BTW, Kairui sent the systemd pull request 15 days ago, the new update added some
comment.

Thanks
Dave 

