Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A5D2DEBA1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 23:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgLRWdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 17:33:14 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:37089 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725836AbgLRWdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 17:33:14 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kqOIU-000s3X-8m; Fri, 18 Dec 2020 23:32:26 +0100
Received: from p5b13a238.dip0.t-ipconnect.de ([91.19.162.56] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kqOIU-0041lK-0s; Fri, 18 Dec 2020 23:32:26 +0100
Subject: Re: [PATCH v2 05/15] ia64: convert to legacy_timer_tick
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-ia64@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Anatoly Pugachev <matorola@gmail.com>
References: <20201030151758.1241164-1-arnd@kernel.org>
 <20201030151758.1241164-6-arnd@kernel.org>
 <59efce0e-a28d-9424-82ca-fb7f3a1b9c29@physik.fu-berlin.de>
 <CAK8P3a0s5Wt=9sZXAV1JzebZFXVy4qn3KNvygEfPeH3eVMyO_w@mail.gmail.com>
 <ccc941a9-9b7f-2a37-664e-c01d60c200da@physik.fu-berlin.de>
Message-ID: <7df57999-40dc-507a-acba-605a4057c83e@physik.fu-berlin.de>
Date:   Fri, 18 Dec 2020 23:32:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ccc941a9-9b7f-2a37-664e-c01d60c200da@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.162.56
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd!

On 12/18/20 11:13 PM, John Paul Adrian Glaubitz wrote:
>> I've attached a patch for a partial revert of my original change, this
>> should still work with the final cleanup on top, but restore the loop
>> plus the local_irq_enable()/local_irq_disable() that I dropped from
>> the original code. Does this make a difference?
> 
> I'll give it a try and report back.

Yes. That solves the timer issues. Now there is unfortunately still a
second, unrelated regression with the hpsa driver that was introduced
by one of the ia64 patches in the mm tree from Andrew which makes the
hpsa driver not load at all.

Haven't figured out yet what the problem is.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

