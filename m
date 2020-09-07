Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE902605B8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 22:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgIGUhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 16:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729339AbgIGUhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 16:37:20 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695C6C061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 13:37:19 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 60so222715otw.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 13:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tTwmLFT4D0sg0gDhrlEpKR10BQ6He40dUvnRadEWMuQ=;
        b=zDfmIvTf5dYhvZli9R0hA1McIPMKFwerAVRKHhphGT2iUPHVPYctKQRUhN66D7L8b+
         HLFQuIhWxlTePZ98bhqLbXXLDWo3RW5kXpInu9MeKDrQcijDVBPTTK1ihKR9pDi7eAJu
         ViuUF5zT/obtwts24ijlzs/NxagtN+OZQabYJ0JZ2nbP/GH5tIWDVI/PR5caWNEw6Zyi
         5w3NPmefSIRhqrb/1f7FoUR+3tK9DuogOoOWgrBCC/YcpwUHPOXxpBBFEmmshIAL/V0t
         KezOXH2NGRtHH46JDQetrxGGvtTigZ4aN7h6heSoJwCRylBBaKtjR22P86eAJVS0I2m6
         iyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tTwmLFT4D0sg0gDhrlEpKR10BQ6He40dUvnRadEWMuQ=;
        b=NstTo7mRXY8r2N/ex+JHI8MecADdmMPS+wbQ9Cj0DnIsmzdf0TkFFgnIRm5leHK7Hl
         5pXDnfdr3f6+WsatSLVK8aS2aKZnpNHsT2F+33Qs0vII8JiNWR7+CbdZg0UAOkIXwgd/
         V4mk4/upjfnHWTdC47P0yFw2VZbgbflGCL+Yu6l4JR/IIAGp/IF87zRkq9KN9P+H4k3J
         F+0au4VZHGojMs2DN1z9NN5XoSF3X01xQpDeCF6ceYVdnXqxSUq+mNt73bwOzWYtAjKA
         ZX63BdgkF/DePwwVwY5mzIxLFIebw3orpLZ4AjzlsOp/UMLnB5SFC0cAgOOyCSy7XmRG
         48SQ==
X-Gm-Message-State: AOAM532wClV6x/M0k92xcNZHAJabl93ZgqBkElFz9dY38fVRkUf6BQTG
        uo1DzKF66x4MdOnM4wHI/RMXqWM8En40h7J2IDogmA==
X-Google-Smtp-Source: ABdhPJxh5B3k1mwScmwOBxgmVli4yos7AHhnUJdAX8xjaWTS2S/dydEcTzkpiY49bjDafVCAQ1tnPYWwwkWEIj8ZogQ=
X-Received: by 2002:a9d:78a:: with SMTP id 10mr16514442oto.102.1599511038819;
 Mon, 07 Sep 2020 13:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <1597227730-16477-1-git-send-email-rnayak@codeaurora.org> <CALAqxLVQ1uB5Zy1DrFP6K4FgZ0U9rwGterhvzcTws_9O9wWE2g@mail.gmail.com>
In-Reply-To: <CALAqxLVQ1uB5Zy1DrFP6K4FgZ0U9rwGterhvzcTws_9O9wWE2g@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 7 Sep 2020 13:37:07 -0700
Message-ID: <CALAqxLUr9ahtxkQSXnBG7k092bXxM7yANM0RX7jyVksYzhi-ZA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: Fixup OPP table for all qup devices
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>, tdas@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 9:04 PM John Stultz <john.stultz@linaro.org> wrote:
> On Wed, Aug 12, 2020 at 3:23 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
> > This OPP table was based on the clock VDD-FMAX tables seen in
> > downstream code, however it turns out the downstream clock
> > driver does update these tables based on later/production
> > rev of the chip and whats seen in the tables belongs to an
> > early engineering rev of the SoC.
> > Fix up the OPP tables such that it now matches with the
> > production rev of sdm845 SoC.
> >
> > Fixes: 13cadb34e593 ("arm64: dts: sdm845: Add OPP table for all qup
> > devices")
> > Reported-by: John Stultz <john.stultz@linaro.org>
> > Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> > ---
>
> Just wanted to follow up on this, as it's still missing from 5.9-rc3
> and is needed to fix a bluetooth regression on db845c from 5.9-rc1.
>
> Amit has already validated it (on PocoF1 as well), but just in case its useful:
> Tested-by: John Stultz <john.stultz@linaro.org>

Hey Everyone,
  Just wanted to nag folks on this again as it is still missing from
upstream and resolves a bluetooth regression from 5.9-rc1.

thanks
-john
