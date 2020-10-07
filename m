Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6E4285F6D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgJGMpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:45:35 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:60951 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727253AbgJGMpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:45:35 -0400
Received: from cust-43cce789 ([IPv6:fc0c:c1a4:736c:9c1a:15d2:fd0f:664c:4844])
        by smtp-cloud8.xs4all.net with ESMTPSA
        id Q8p0k5ytWTHgxQ8p3kFRHm; Wed, 07 Oct 2020 14:45:33 +0200
Message-ID: <5f5c303d30eaa32c21131502cc6f28db9d655329.camel@tiscali.nl>
Subject: Re: Build regressions/improvements in v5.9-rc8
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Richard Weinberger <richard.weinberger@gmail.com>
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
Date:   Wed, 07 Oct 2020 14:45:30 +0200
In-Reply-To: <CAFLxGvyvgSvcizZFZxezFKhZCP79yyMuM7izFbcUtzRTpiOb6A@mail.gmail.com>
References: <20201005093024.16032-1-geert@linux-m68k.org>
         <CAMuHMdVqpgro9Qzn39fK9R2-2xDm6LDe6uOB5gSTrdRxbecNXQ@mail.gmail.com>
         <20201005125840.GP3956970@smile.fi.intel.com>
         <d1457a75d5f38002c063c3801af7819af43e0bfc.camel@tiscali.nl>
         <CAFLxGvyvgSvcizZFZxezFKhZCP79yyMuM7izFbcUtzRTpiOb6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLmECytRh1QUsTdE8IrpXEKLtVO35SBA9ERidZmlQS5ltBJyPZG8+6+gVf1IKAYJO2ui0/nJD8V5RAHdw09IHCeLzUGV0IU2XQpuHtb24KGtvEDU1R6i
 YHLacu0Xlp1uozYD9aZ9oWEcOg7OHfRGudC6VuGe4I7D3BooWlz9aClFmk++1gdI3b+XGmkurrssYE1l2cM5YV/fZ9udsMEA+LqR2lnaqmFgYeXvOwU1VpVe
 GuSegzWYt5i7Xd60W87QipjckDxamUtK4nMO6/fPoe/6XPpRFAxp6RTt15LDlxUK41XmUcwEKHyHe3J9DxEenRXZLFEp0JLo7+nJcIW8z6tzo0D58PKQy00R
 1+fNfRuWpzSlODU+4buLW9uebXymIPShdboCQkKlm9SDIZMf3P3A/N+MHSAMXx3ifQ94DFMyZs1yvteoJbPyLv8CLCgUrQFhEEMBiDuTOzKlflBFnNh0PQe7
 NEBOuViOL0LCBKxgf2ospXs8/w+AzFLvCRQlwyHWmz/UIr6XTOvAw0LexU5Wkh5R97DJRZFihZzkpLfKiQkZf+1vlblKs2mQcV6V07g3ssGqkh2ZURkrSdnj
 CeJJCaCr2fMkazZ9cNJQfudQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Weinberger schreef op wo 07-10-2020 om 14:08 [+0200]:
> UML has no ia32 emulation and therefore no in_ia32_syscall().
> Maybe you can check for CONFIG_IA32_EMULATION too?

The pending fix is:
    #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)

Since this check guards in_ia32_syscall() just checking CONFIG_IA32_EMULATION
should do too.

(Way outside my limited expertise, but anyway: is does look odd to see a call
to in_ia32_syscall() in drivers/. All other calls are in arch/x86/. Isn't this
a bit too x86 specific for an arch independent driver?)

Thanks,


Paul Bolle

