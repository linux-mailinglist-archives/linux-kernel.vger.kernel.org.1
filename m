Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A556F28A1BD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbgJJWQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:16:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728877AbgJJSnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 14:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602355399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b3T/uhWZZo1nQKpbMvJVb5wVVBmliojws1bKYVeo/nA=;
        b=b1hW6Up9na9/H5QYsySMZXAmYKOeq5tCcSFnjREqpaz8YLhsNIw/HIZ+B4P766Jdw3ieT7
        7bPVnZwK8KfEnv49tjdY4EEheK3GbisdPxH0J81j6avg4FtmbOfU0nCC5hJDDnRNt5kVVG
        xf28Vh5c9e3l5ZDnePtJts9hYrb7qpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-QYmtt5OlNiau9SIU8B6cBg-1; Sat, 10 Oct 2020 13:55:34 -0400
X-MC-Unique: QYmtt5OlNiau9SIU8B6cBg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B63AF1005E5D;
        Sat, 10 Oct 2020 17:55:31 +0000 (UTC)
Received: from treble (ovpn-112-146.rdu2.redhat.com [10.10.112.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5036F60C13;
        Sat, 10 Oct 2020 17:55:23 +0000 (UTC)
Date:   Sat, 10 Oct 2020 12:55:20 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, dima@arista.com,
        will@kernel.org, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, viro@zeniv.linux.org.uk,
        ldufour@linux.ibm.com, amanieu@gmail.com, walken@google.com,
        ben.dooks@codethink.co.uk, tglx@linutronix.de,
        bigeasy@linutronix.de, mingo@kernel.org,
        vincent.whitchurch@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, wangle6@huawei.com,
        luohaizheng@huawei.com
Subject: Re: [PATCH] arm:traps: Don't print stack or raw PC/LR values in
 backtraces
Message-ID: <20201010175520.fczgnp66ey2vghkr@treble>
References: <20201009075957.110017-1-nixiaoming@huawei.com>
 <20201009080849.GM1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201009080849.GM1551@shell.armlinux.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 09:08:50AM +0100, Russell King - ARM Linux admin wrote:
> On Fri, Oct 09, 2020 at 03:59:57PM +0800, Xiaoming Ni wrote:
> > Printing raw pointer values in backtraces has potential security
> > implications and are of questionable value anyway.
> > 
> > This patch follows x86 and arm64's lead and removes the "Exception stack:"
> > dump from kernel backtraces:
> > 	commit a25ffd3a6302a6 ("arm64: traps: Don't print stack or raw
> > 	 PC/LR values in backtraces")
> > 	commit 0ee1dd9f5e7eae ("x86/dumpstack: Remove raw stack dump")
> > 	commit bb5e5ce545f203 ("x86/dumpstack: Remove kernel text
> > 	 addresses from stack dump")
> > 
> > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> 
> I am really not happy about this - it hurts at least my ability to
> debug the kernel when people post oopses to the mailing list. If
> people wish to make the kernel harder to debug, and are prepared
> to be told "your kernel is undebuggable" then this patch is fine.

At least on x86 we've had this for four years now, without any apparent
harm to debugability.  scripts/faddr2line helps.

-- 
Josh

