Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3677D271666
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 19:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgITRnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 13:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgITRnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 13:43:15 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FD8C061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 10:43:15 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x69so11520872lff.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ejz/GOVvBNgiciatH4EjBRwlfy2MnL1tDSObr2BrKeg=;
        b=cBDZkiv4uiqeUChUbmqRPD8tkvllq4angLGjbI6fcWbyt0pYNQ1SGMQdEdmcewXaXT
         IE5S9J/GFuNXr/rpY1dC/0Yf7uyzIPTs0u+8f3gLaQ3BI+ak5trluGhkQvuTa+ZLZ3HS
         UcueGtftJ4Q3p1fqvR6MgwdAfAMUTTFhAr56U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ejz/GOVvBNgiciatH4EjBRwlfy2MnL1tDSObr2BrKeg=;
        b=MiNZSe+ldL8B9r4wQ5/45CHUYGFbRdEDeAE5DYpY2TwL5HCK912eoiJOeQjOREFuhz
         Yj8O6uMqQMLyRco5Bd4UMRs4ZtGsYUWnNmpAkpiSQPqCWx0SNaSmDtunxvkb8xJhyNUw
         uVrJjfSlSTYshrxmkD5Geteq9frZ7HK1XeoXmaJjd5Gkxaaayy/RLsgWGyQJ6sSf25L8
         nuRc3KAClNAHy1P76A6/2+oXhmtcqDOBniOXlm9c0eFJ8VpIcprtjP+QL4Knau9Svu8U
         kNHrnxz3bEO2KZsFphqWnjv7goMfEGRJ4WmtIaHeJLrs5sXp7cx7Yl5SELvGXniL5Mjr
         0oFA==
X-Gm-Message-State: AOAM532p4Ub0XyHWJjrHsb89yi48t6Wb/tem6aHefwCAkPcM+7IArkq5
        8rwfN8SP4TTj7r+UkKOAOYMgmjDo6otF+Q==
X-Google-Smtp-Source: ABdhPJw5RmrzR+Hy1U5slri6/0dxn5IHdiHZEznMYl7AgieKoxgU5U83UKnLsc7j1TvamOaBvSDcTQ==
X-Received: by 2002:ac2:52ab:: with SMTP id r11mr16144130lfm.118.1600623792940;
        Sun, 20 Sep 2020 10:43:12 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id d24sm1948886lfn.140.2020.09.20.10.43.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 10:43:12 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id a15so9203220ljk.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 10:43:11 -0700 (PDT)
X-Received: by 2002:a2e:84d6:: with SMTP id q22mr13708479ljh.70.1600623791519;
 Sun, 20 Sep 2020 10:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200919091751.011116649@linutronix.de> <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com>
 <87mu1lc5mp.fsf@nanos.tec.linutronix.de> <87k0wode9a.fsf@nanos.tec.linutronix.de>
 <CAHk-=wgbmwsTOKs23Z=71EBTrULoeaH2U3TNqT2atHEWvkBKdw@mail.gmail.com> <87eemwcpnq.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87eemwcpnq.fsf@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Sep 2020 10:42:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgF-upZVpqJWK=TK7MS9H-Rp1ZxGfOG+dDW=JThtxAzVQ@mail.gmail.com>
Message-ID: <CAHk-=wgF-upZVpqJWK=TK7MS9H-Rp1ZxGfOG+dDW=JThtxAzVQ@mail.gmail.com>
Subject: Re: [patch RFC 00/15] mm/highmem: Provide a preemptible variant of
 kmap_atomic & friends
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Vineet Gupta <vgupta@synopsys.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sparc <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 10:40 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> I think the more obvious solution is to split the whole exercise:
>
>   schedule()
>      prepare_switch()
>         unmap()
>
>     switch_to()
>
>     finish_switch()
>         map()

Yeah, that looks much easier to explain. Ack.

               Linus
