Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5C822FFA5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 04:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgG1Cck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 22:32:40 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45771 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgG1Ccj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:32:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BG1115sGBz9sTj;
        Tue, 28 Jul 2020 12:32:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1595903558;
        bh=GVppKHacNBK9byV2AhBgk8LPoELuuI3KrLw/+QEzQ/Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pjVPeiiBTIagXa4E93EO9ZTHN2JESxXsOXdz5cEZY3SxtPrEkItcko61k/i3vbklZ
         CawiMR+OssdGfPNCK+IbvIsAiMY4fr4Eet+dGsELz/2XviC4InQZlCn7rKEeH0FJE0
         /kptzj1ZdRjUUSHI0cFYR8/1UqEmRiF8qboxXJVaLYKpcqIXcyOVF2D3guVk0S60md
         cjsMTtnvZuZ+rA5gUbJJ3V1bh2hFf+6iIMl0CoXmPmagfMU7Tkaf98lwV4DJ84SfNv
         jUeExm8DqOLXZbGLafozLXfJfaEAtm+phntYLJJscW6Hsmhl3qe3zvzjSonY3805ak
         vpFxI8xE5875A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] powerpc/mm: Remove custom stack expansion checking
In-Reply-To: <87tuxtrrvb.fsf@dja-thinkpad.axtens.net>
References: <20200724092528.1578671-1-mpe@ellerman.id.au> <20200724092528.1578671-4-mpe@ellerman.id.au> <87tuxtrrvb.fsf@dja-thinkpad.axtens.net>
Date:   Tue, 28 Jul 2020 12:32:33 +1000
Message-ID: <87eeow74ji.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:
> Hi Michael,
>
> I tested v1 of this. I ran the test from the bug with a range of stack
> sizes, in a loop, for several hours and didn't see any crashes/signal
> delivery failures.
>
> I retested v2 for a few minutes just to be sure, and I ran stress-ng's
> stack, stackmmap and bad-altstack stressors to make sure no obvious
> kernel bugs were exposed. Nothing crashed.
>
> All tests done on a P8 LE guest under KVM.
>
> On that basis:
>
> Tested-by: Daniel Axtens <dja@axtens.net>

Thanks.

Always nice to have someone review my patches!

cheers
