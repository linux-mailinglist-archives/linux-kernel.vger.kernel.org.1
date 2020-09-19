Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64AA270983
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 02:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgISArp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 20:47:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgISArp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 20:47:45 -0400
Received: from X1 (unknown [67.22.170.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC4D521D20;
        Sat, 19 Sep 2020 00:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600476465;
        bh=GFKsAemW7eKRuJ6K11IiY8exAIttJyNQaweQ9T2fkIo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kuJSQHj6kqUn/d6d0FUUL3Wxi5+lt/cxNWDddHZZVy01MHrFaukn+IPCdx1woPla6
         PJmxi9Nekevk02mColMXI0b04UuyfG7QcdY3NtDdJwIQhdHO2n6jerN+51Qw6jBT64
         oC6Ea1iVCeglIjgWjfSzI6cxispirMrVInuXHP1E=
Date:   Fri, 18 Sep 2020 17:47:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dave Young <dyoung@redhat.com>
Cc:     bhe@redhat.com, Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot
 time
Message-Id: <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
In-Reply-To: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 11:25:46 +0800 Dave Young <dyoung@redhat.com> wrote:

> crash_kexec_post_notifiers enables running various panic notifier
> before kdump kernel booting. This increases risks of kdump failure.
> It is well documented in kernel-parameters.txt. We do not suggest
> people to enable it together with kdump unless he/she is really sure.
> This is also not suggested to be enabled by default when users are
> not aware in distributions.
> 
> But unfortunately it is enabled by default in systemd, see below
> discussions in a systemd report, we can not convince systemd to change
> it:
> https://github.com/systemd/systemd/issues/16661
> 
> Actually we have got reports about kdump kernel hangs in both s390x
> and powerpcle cases caused by the systemd change,  also some x86 cases
> could also be caused by the same (although that is in Hyper-V code
> instead of systemd, that need to be addressed separately).
> 
> Thus to avoid the auto enablement here just disable the param writable
> permission in sysfs.
> 

Well.  I don't think this is at all a desirable way of resolving a
disagreement with the systemd developers

At the above github address I'm seeing "ryncsn added a commit to
ryncsn/systemd that referenced this issue 9 days ago", "pstore: don't
enable crash_kexec_post_notifiers by default".  So didn't that address
the issue?
