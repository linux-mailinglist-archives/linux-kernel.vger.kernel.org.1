Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF070290F8E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436674AbgJQFom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436665AbgJQFom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:44:42 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15BDC05BD0C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 20:18:10 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id r24so2551254vsp.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 20:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/TxBUtRgRfSf5LfXE1zKtWYHRGk919Ux3oNSTIYgEGs=;
        b=UIFnMl2RjTfIV6Wv5IFGj9N52TXiacuMUz3YdYfaa7I5eoLrxRR2GahaLIr3PdbL/8
         PA1ouC9IiDjqOmhPnIaxfeW1e6KBZi8mO5UNukW7FQHAh3Kzol/qfta0rjukazUM2jXL
         mTy8vWmNI44o4wcoJ/rpFxYFNCq2zrHArBiz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/TxBUtRgRfSf5LfXE1zKtWYHRGk919Ux3oNSTIYgEGs=;
        b=l6Vt+4o8YQzNdhvm6oJkPhiDPSukA6XQMsi0ZyZoY1P7R4CTXSsnRVUGPZEhBNTA47
         xw9pP50xvxxn/wXo4lr8K3ZB5PBY4aNMsKT+KyH1bKtQwcyXhrvfOUbX4DPTLDTh/R94
         N3gMLJiY/mkh57P1vqcZTHMD2jEFFJel2+xnigrF66mRMIeDU6GhAr6zP/jta7dN8zlj
         3CZZ/hslwroQlbNpk1GTZUt/3UXXyxqqQjF23Xn+NqHPHkNep/muk83NIH6VVI4/+kUc
         W6MRZLqKnCWGpn136hIkvBD7kA7lYC5nn2Uu2ZnA+BtvhaeVTD2VbXjygIQ7qr/dfOb5
         u3oQ==
X-Gm-Message-State: AOAM530D9RON2rHYzkLc0A6E4pBq0mYmhqYW9dSBvFC25QMh31gV5Dcj
        Kscbtf8BPrG7KLkyo72VSj1OJ5BUpVK4lA==
X-Google-Smtp-Source: ABdhPJxGEmTq3BCpIRlwhtfEK2cQfCaFr7fxZ5m3kqqVzw+eDfw9OcJrcsVw0mD4qn4aN+rWeMdiEA==
X-Received: by 2002:a67:33d1:: with SMTP id z200mr4052900vsz.48.1602904689495;
        Fri, 16 Oct 2020 20:18:09 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 64sm615050vky.4.2020.10.16.20.18.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 20:18:08 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id d4so2527516vsk.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 20:18:08 -0700 (PDT)
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr4216646vsp.34.1602904687735;
 Fri, 16 Oct 2020 20:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201014171259.v4.1.I4567b5e7e17bbb15ef063d447cb83fd43746cb18@changeid>
 <20201014171259.v4.3.Id0cc5d859e2422082a29a7909658932c857f5a81@changeid>
 <160281818774.884498.11509417433655580732@swboyd.mtv.corp.google.com> <160290009516.884498.11234055455838582432@swboyd.mtv.corp.google.com>
In-Reply-To: <160290009516.884498.11234055455838582432@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 16 Oct 2020 20:17:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WAVoZ59p51HxBwBNXsXcirRbUAjeGuZ4T9G-O7Tvzqfw@mail.gmail.com>
Message-ID: <CAD=FV=WAVoZ59p51HxBwBNXsXcirRbUAjeGuZ4T9G-O7Tvzqfw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] clk: qcom: lpasscc-sc7180: Re-configure the PLL in
 case lost
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Taniya Das <tdas@codeaurora.org>,
        David Brown <david.brown@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 16, 2020 at 7:01 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Stephen Boyd (2020-10-15 20:16:27)
> > Quoting Douglas Anderson (2020-10-14 17:13:29)
> > > From: Taniya Das <tdas@codeaurora.org>
> > >
> > > In the case where the PLL configuration is lost, then the pm runtime
> > > resume will reconfigure before usage.
> >
> > Taniya, this commit needs a lot more describing than one sentence. I see
> > that the PLL's L value is reset at boot, but only once. That seems to be
> > because the bootloader I have doesn't set bit 11 for the RETAIN_FF bit
> > on the lpass_core_hm_gdsc. Once the gdsc is turned off the first time,
> > the PLL settings are lost and the L val is reset to 0. That makes sense
> > because RETAIN_FF isn't set. This also means the other register writes
> > during probe are lost during the first suspend of the lpass core clk
> > controller. Then when the GDSC is turned on the next time for this clk
> > controller  being runtime resumed we will set the retain bit and then
> > configure the PLL again. BTW, I see that runtime PM is called for this
> > clk controller for all the clk operations. Maybe there should be some
> > auto suspend timeout so that we're not toggling the gdsc constantly?
> >
> > I hacked up the GDSC code to set the bit at gdsc registration time and
> > it seems to fix the problem I'm seeing (i.e. that the PLL is stuck,
> > which should also be in the commit text here). When I try to set the bit
> > in the bootloader though my kernel won't boot. I guess something is
> > hanging the system if I enable the retain bit in the GDSC?
> >
>
> After hacking on this for some time it looks like we can apply this
> patch instead and things are good. The first two patches in this series
> look mostly good to me minus some nitpicks so please resend.

By this you mean the two newlines you mentioned on
<https://crrev.com/c/2473610>, right?  I think all the rest of your
comments were on patch #3 (this patch) which I think we're dropping.

I'm happy to repost a v5 of just patches #1 and #2 with the newlines
fixed next week, or I'm happy if you want to fix them when applying as
you alluded to on the Chrome OS gerrit.  Just let me know.  I just
want to make sure I'm not missing some other nits before I post the
v5.  ;-)

-Doug
