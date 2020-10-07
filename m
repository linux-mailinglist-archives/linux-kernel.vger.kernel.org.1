Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AC4285EB3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgJGMF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:05:29 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:38583 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727253AbgJGMF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:05:28 -0400
Received: from cust-43cce789 ([IPv6:fc0c:c1a4:736c:9c1a:15d2:fd0f:664c:4844])
        by smtp-cloud8.xs4all.net with ESMTPSA
        id Q8C9k5mLGTHgxQ8CCkFKGK; Wed, 07 Oct 2020 14:05:24 +0200
Message-ID: <27156c3198dfde5e9592758f5f56fe89b90c88dc.camel@tiscali.nl>
Subject: Re: Build regressions/improvements in v5.9-rc8
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Date:   Wed, 07 Oct 2020 14:05:21 +0200
In-Reply-To: <CAHp75VcCkpLUAQU4YHvfeZ7gcUhYQSBp9Q1MZeN4xhYSjRTR1g@mail.gmail.com>
References: <20201005093024.16032-1-geert@linux-m68k.org>
         <CAMuHMdVqpgro9Qzn39fK9R2-2xDm6LDe6uOB5gSTrdRxbecNXQ@mail.gmail.com>
         <20201005125840.GP3956970@smile.fi.intel.com>
         <d1457a75d5f38002c063c3801af7819af43e0bfc.camel@tiscali.nl>
         <CAHp75VcCkpLUAQU4YHvfeZ7gcUhYQSBp9Q1MZeN4xhYSjRTR1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfD2bfPMW6U4Mkte4UTI77NjPkoj53txoMbtHiKDEJUdL0WOjT3P3SL3O/HgtKBH4h56ZDTzOdMsSOhDEefNYFaryi2UQlIH6gp85CFk2lNWPFvohGPkP
 XE9TCtBgRFI1zMyYJBL1u5bs5YS3TGOQLcGIrOBe01NBY7xPYJW/QBEmmY0/Jy306EPkjStuwa7yVHhLAE3Xs0gYQYCqzPRtt6XtSMWhGUovbT2UyyEHyZNB
 f9OQ8CpJ6+0izQ1BqovOj+NGOvIJqH66UGvm3DeSo2WbYspPSajGMX34uGPRFIvkhQ5K4xTniikeNv6tlInIT5HWqCIoWmJRgHu1RQKEy+3/X19TNsJ8AWvI
 s0WoDtU8LWonTkK86DF7KBKiR3tXziLjl8oJV/VYd4t3eVqATxCOt/9PjwdFpq3RxB7UX50SoEmopF68oEHVOpeAk2cPYO8ZGd2LlvGxJUnvyQiLZ7GOqeyK
 WLURUaou4mOYkfyiG9WakehL+dWPgYIOdQ9G4dhlwr19iIqvN6HHZ04do9uP0fxJ9uc5a519FV2nuu3G5tM+q2qAU24FjZW+5xsHu+3aO7pxRph/u+Ae6t8O
 KOey3tMrQ4rFDt4s+ohTcasN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko schreef op wo 07-10-2020 om 14:58 [+0300]:
> Does [1] fix the issue?
> 
> [1]: https://lore.kernel.org/linux-gpio/20201005131044.87276-1-andriy.shevchenko@linux.intel.com/

Yes, it fixes the build error.

Thanks,


Paul Bolle

