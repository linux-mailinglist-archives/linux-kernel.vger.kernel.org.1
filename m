Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8F628B5B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbgJLNOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:14:42 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40123 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbgJLNOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:14:41 -0400
Received: by mail-ot1-f66.google.com with SMTP id l4so15767540ota.7;
        Mon, 12 Oct 2020 06:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbLIhCOPNSjWOQaghAyPRVWzbVrxqBRGdH57khM7u7E=;
        b=lssaW2ddrNi66kAKk2bNR3+ow2fS/8XhsCjYjmDtP89XTF9Bu4b3u0v9WCwtvUtDYW
         GOXLiLolOu9v9OKx8LHWfQY8IHbIXJYWY59tCytWqdpjur9+FBlQvXIIlLmguI+08qGb
         BuSytt8WizuSkqALuGX+kN2CE3zG87VnNU+lH0Qw4AqOC8CuBvnwa3c0uaOtYtYy+Fv5
         Nty24yL7fS49Rag3AuHawSQbqIk9w0E+cwxHShoSa0PwJ4s7eNq+wM5B0jKNjKkuHyTN
         Uur6/RLTOPuhOdeszJskCfJrm2Hz0t2S8rW4QpZMGZ0y7lSZuL+k8tuXuqyqhdcW1d8/
         g7jw==
X-Gm-Message-State: AOAM530OyKLR/EI8sPWQqeY9mar4XBZnoPNH48x1NyyfvMQqaaRvI6Yj
        xSceKamSKPY905tGqJxLMT+ho1XjsZTS+q6cH3w=
X-Google-Smtp-Source: ABdhPJxQ5OO/ggjyZpIV+Sqss7Q3IkWkzvdN60XWu45G9tXKXUPSGXGSLle8lOet30oUW8t+MfpiF57J8C2ncxOc0R4=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr18910378otb.250.1602508478612;
 Mon, 12 Oct 2020 06:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201008154651.1901126-1-arnd@arndb.de> <20201008154651.1901126-2-arnd@arndb.de>
In-Reply-To: <20201008154651.1901126-2-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Oct 2020 15:14:27 +0200
Message-ID: <CAMuHMdW22uxMj3=Yfyz9uZoofT_aNxL2kV6UERgAYbRcw7yb2w@mail.gmail.com>
Subject: Re: [PATCH 01/13] timekeeping: add CONFIG_LEGACY_TIMER_TICK
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 5:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
> All platforms that currently do not use generic clockevents roughly call
> the same set of functions in their timer interrupts: xtime_update(),
> update_process_times() and profile_tick(), sometimes in a different
> sequence.
>
> Add a helper function that performs all three of them, to make the
> callers more uniform and simplify the interface.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
