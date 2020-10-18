Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961EE292010
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 23:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgJRVDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 17:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgJRVDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 17:03:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE36C061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 14:03:35 -0700 (PDT)
Received: from zn.tnic (p200300ec2f250700329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f25:700:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 269F41EC0258;
        Sun, 18 Oct 2020 23:03:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603055014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HwAu3GUBF7amG1UMj2+U4ITJHLPamNq91Zbg5d12q50=;
        b=W1T5dsQh1V77IZFrSeKk23XP7oI8NFw253hJsq67QD/mIEIbBDqZpE5oQ7UyObzeomoeW3
        TAbAW0dm/D8+W6d5KUr714fq1SzFjP1CDE6ZR7/xajmqP8cDHQyFnkLyx1v8wGfxXVrNWF
        BKDmVf894BUlyxELsWqw4jxiBsOxL8s=
Date:   Sun, 18 Oct 2020 23:03:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        jpoimboe@redhat.com, mbenes@suse.cz,
        "peterz@infradead.org" <peterz@infradead.org>,
        shile.zhang@linux.alibaba.com, lkml <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: Fwd: [WARNING AND ERROR]  may be  system slow and  audio and
 video breaking
Message-ID: <20201018210323.GD8364@zn.tnic>
References: <959da1eee73f58a824fe4913b5cacda6de0f392e.camel@rajagiritech.edu.in>
 <b4533bcbb095cf11f01d0adfd50912c52242eb02.camel@rajagiritech.edu.in>
 <20201018174948.GC8364@zn.tnic>
 <328218dc46c4f883dad44d6fb53746c5f35f055d.camel@rajagiritech.edu.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <328218dc46c4f883dad44d6fb53746c5f35f055d.camel@rajagiritech.edu.in>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 01:51:34AM +0530, Jeffrin Jose T wrote:
> On Sun, 2020-10-18 at 19:49 +0200, Borislav Petkov wrote:
> > On Sun, Oct 18, 2020 at 10:42:39PM +0530, Jeffrin Jose T wrote:
> > > smpboot: Scheduler frequency invariance went wobbly, disabling!
> > > [ 1112.592866] unchecked MSR access error: RDMSR from 0x123 at rIP:
> > > 0xffffffffb5c9a184 (native_read_msr+0x4/0x30)

Ok, you forgot to say in your initial mail that this happens when you
suspend your laptop.

Now, this unchecked MSR error thing happens only once because that early
during resume the microcode on CPU1 is not updated yet - and that needs
to be debugged separately and I'll try to reproduce that on my machine -
so the microcode is not updated yet and therefore the 0x123 MSR is not
"emulated" by the microcode, so to speak, thus the warning.

That warning doesn't happen anymore, though, once the microcode is
updated.

But what happens after that is you get a flood of correctable PCIe
errors about a transaction to a device timeoutting:

pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00001000/00002000
pcieport 0000:00:1c.5:    [12] Timeout 

and it looks like that flood is slowing down the machine because it is
busy logging them.

Do

# lspci -nn -xxx

as root. It'll show us which device that 8086:9d15 is.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
