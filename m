Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B542A9B96
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgKFSHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:07:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726034AbgKFSHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604686024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5nM9DcY6LK1ZTK0WBQbt1EV41MUCkdtc0oZOmII8m4g=;
        b=GB4l/feH9UOR3UKvVMEIjIhi7EuXCmHosPA16pnxfT6buqNZfXW/c1/5y7+NU3SDlsWlGk
        JDelFn1sQFhXOdfLDj989pEZHw1ZFplwXcN6XJxki4rAUSm2wCkfigWV6pLiWJRHXkLtwd
        EiRQi6A39QGqGP7bAg+azkTHiglQatQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-udipSmXqM0iU7pOl8ER5Bw-1; Fri, 06 Nov 2020 13:07:00 -0500
X-MC-Unique: udipSmXqM0iU7pOl8ER5Bw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42EBE1DE00;
        Fri,  6 Nov 2020 18:06:59 +0000 (UTC)
Received: from treble (ovpn-116-174.rdu2.redhat.com [10.10.116.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 813E5261A0;
        Fri,  6 Nov 2020 18:06:44 +0000 (UTC)
Date:   Fri, 6 Nov 2020 12:06:28 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Message-ID: <20201106180628.r4emdw3yoxfzryzu@treble>
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 06:04:15AM +0000, Shinichiro Kawasaki wrote:
> Greetings,
> 
> I observe "WARNING: can't access registers at asm_common_interrupt+0x1e/0x40"
> in my kernel test system repeatedly, which is printed by unwind_next_frame() in
> "arch/x86/kernel/unwind_orc.c". Syzbot already reported that [1]. Similar
> warning was reported and discussed [2], but I suppose the cause is not yet
> clarified.
> 
> The warning was observed with v5.10-rc2 and older tags. I bisected and found
> that the commit 044d0d6de9f5 ("lockdep: Only trace IRQ edges") in v5.9-rc3
> triggered the warning. Reverting that from 5.10-rc2, the warning disappeared.
> May I ask comment by expertise on CC how this commit can relate to the warning?
> 
> The test condition to reproduce the warning is rather unique (blktests,
> dm-linear and ZNS device emulation by QEMU). If any action is suggested for
> further analysis, I'm willing to take it with my test system.

Hi,

Thanks for reporting this issue.  This might be a different issue from
[2].

Can you send me the arch/x86/entry/entry_64.o file from your build?

-- 
Josh

