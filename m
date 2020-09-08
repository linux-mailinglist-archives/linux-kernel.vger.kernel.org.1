Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983F8261745
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 19:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgIHR36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 13:29:58 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:57035 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731789AbgIHR31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:29:27 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 0892b1cd
        for <linux-kernel@vger.kernel.org>;
        Tue, 8 Sep 2020 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=mqjBG2eyKf9WfashkF7sbHwX2A4=; b=znOTxi
        mhb8G81iYoy+f/yTeW4GMiHepLhCboJJd++kcoezc4jQuPctQr0eepjGiXUOtQzp
        vAqpA5KY0+L06CR87DSWhOdBO3fOl0DxR1NQ5sfE9Lr7JnaAzMZ+cZuXC9E8DO2U
        hi6JAx/Mx8PJgdqOR5d3sQ6G731jtyBztZcWKHUygBVuuq0/iJp/d4F8jASr1TDi
        g0LXoykzcM3hIINlzbpquj8y4e86Gkun+rKpD1pzs6U2L3oGGNenwDc/x1WQf5s2
        ivLJyZX4XDyelFk9rF6yyJgQ5cPRbk7TtJaV2Zl0P51HFYVNQjJ+feNLDQVi7+fR
        Z1P/WKheDT4bHGWw==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8bf06f7b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 8 Sep 2020 17:00:29 +0000 (UTC)
Received: by mail-il1-f172.google.com with SMTP id x2so16196901ilm.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 10:29:23 -0700 (PDT)
X-Gm-Message-State: AOAM533+J3NcseFxlQbRuLekuuLd+5K8fi174+2VhVGpzmPp2gkwqtAb
        oi0W29SlrPOsxRDUqW5ZDUYoerfhwiv8ZsY1gtQ=
X-Google-Smtp-Source: ABdhPJyB4z78i54yyN+zYBswZH2l7qDwtQt69HPtrItYij1MckdaS8iU1cignYtocr8VudHDVjyWDAfzfruOfNr324Q=
X-Received: by 2002:a92:c9c5:: with SMTP id k5mr24594830ilq.231.1599586162847;
 Tue, 08 Sep 2020 10:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200907094843.1949-1-Jason@zx2c4.com> <20200907100647.GB10657@zn.tnic>
 <22617e57e541e460fac09db04fdb370f8e96e8ef.camel@linux.intel.com>
 <CAHmME9rh8N-Qui2KVxGP33Aar5tao_obA70XKwR2x5Qp1AytTw@mail.gmail.com> <20200908172558.GG25236@zn.tnic>
In-Reply-To: <20200908172558.GG25236@zn.tnic>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 8 Sep 2020 19:29:11 +0200
X-Gmail-Original-Message-ID: <CAHmME9pKfvPGf97BM1=VdUL1uU_8aOoc4+QOu6b51XnPz3SkRA@mail.gmail.com>
Message-ID: <CAHmME9pKfvPGf97BM1=VdUL1uU_8aOoc4+QOu6b51XnPz3SkRA@mail.gmail.com>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
To:     Borislav Petkov <bp@alien8.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 7:26 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Sep 08, 2020 at 07:12:44PM +0200, Jason A. Donenfeld wrote:
> > > Overclocking is not architectural I/F and is supported by some special
> > > CPU skews. I can't find any public document to specify the commands
> > > which can be used via this OC mailbox. I have to check internally to
> > > see if there is any. To add a proper sysfs interface we have to make
> > > sure that we are not allowing some random commands to hardware and
> > > crash the system.
> >
> > Well you can definitely crash the system this way -- undervolting can
> > result in all sorts of nice glitching. You might be able to even
> > programmatically undervolt to compromise the kernel in clever ways (a
> > lockdown bypass, I guess, but who cares).
> >
> > That's why I initially suggested this was pretty squarely in the realm
> > of hobbyists and should just be added to that whitelist.
>
> If that MSR can cause all kinds of crazy, I'd prefer writes to it from
> userspace to be completely forbidden, actually. And if force-enabled,
> with a BIG FAT WARNING each time userspace writes to it.

Well that's not cool. And it's sure to really upset the fairly sizable
crowd of people who rely on undervolting and related things to make
their laptops remotely usable, especially in light of the crazy
thermal designs for late-era 14nm intel cpus. Tools like
intel-undervolt have been a godsend in that regard. I came here
posting a patch to remove the annoying message you added for that use
case. Now you want to just totally remove that feature all together
from the kernel? Sounds like a regression in functionality I simply
can't get behind. I know that my laptop, at least, would suffer.

Jason
