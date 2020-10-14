Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E43C28EA34
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbgJOBew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732273AbgJOBeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:34:37 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132EAC05112A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 16:08:07 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id x185so417834vsb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 16:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NY8uHKKpja9Uac1xehW411eyYV4U0oSKh6doZcj/Pf4=;
        b=O8Vspp7ChzMcAAxZoKhsRbZSqDQruKcZgoXKzDouzA9zAbLJ48ZPbzUNS6moMSAi1f
         RcATXgQRYZjLe+VADRc1BvaJ4rXXzOzHLJzHNJIk9SVTTd2KYp0r/c28iBZuU45zy0sn
         GRaJn9sIPrVWQ1deTzEpCRjVaC8qvtrBtMgQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NY8uHKKpja9Uac1xehW411eyYV4U0oSKh6doZcj/Pf4=;
        b=kCQ4kRVXrJmILGNxHUxBmiLlJfsjGBvibiRvpOx4VpAQYb4ecwVqTXDTgJAjH7v8da
         IfKdiCEvhcP3OgB5gl2gLjKqJ5dJY6fMFKuMtREDm6lQO4dsYoiaEZVRRstzagcSRSRv
         DpmL2j4tXZACXNZ5hDP5b82vjPcUhm5coWneciYYPpEn72l5QpVwLUtLlgaFACnDR2Po
         p8uolCvnUHUXaWvwhFIl9NZrqBtCQNV/drW+AfsfbN2N9AyIhBPCDYT32ZSo9F0p+J94
         Twa149rrhXum1RF9L60v2Q4is10czOp+EVS0SP0qX2ueefKQp2Mx69seQVRlLP9UK9FY
         bOOA==
X-Gm-Message-State: AOAM5331R24/5ytJ/gl2O1Dp34n9dD2M4Xkwu4VM1trvGGedJ/VnsxSb
        i+6qY07kNxkcjA7JBoXv1mSYKN8icYviZw==
X-Google-Smtp-Source: ABdhPJzu+qeySr+wPbsFIaBj3a4AAuJO8RfaDK4Ay3e3YDrE7PglOsPphg6smO99FrGfDYscrAHQ+g==
X-Received: by 2002:a67:d392:: with SMTP id b18mr881765vsj.59.1602716885700;
        Wed, 14 Oct 2020 16:08:05 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id j5sm136529vsq.24.2020.10.14.16.08.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 16:08:04 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id r9so260035uat.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 16:08:04 -0700 (PDT)
X-Received: by 2002:ab0:4923:: with SMTP id z32mr699751uac.121.1602716884104;
 Wed, 14 Oct 2020 16:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201014140507.v3.1.I4567b5e7e17bbb15ef063d447cb83fd43746cb18@changeid>
 <20201014140507.v3.2.I75c409497d4dea9daefa53ec5f93824081c4ecbe@changeid>
 <160271345117.884498.6375969749730135625@swboyd.mtv.corp.google.com>
 <CAD=FV=UipL42FLRARc4V34bqEukaB=WQzAdr2Si2RUjPaAmE4g@mail.gmail.com> <160271644762.884498.446447786516269652@swboyd.mtv.corp.google.com>
In-Reply-To: <160271644762.884498.446447786516269652@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 14 Oct 2020 16:07:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VTEQMqnmC_OMtADTdrs+2zxCd8ODSRpxtxP6SKBnx2qg@mail.gmail.com>
Message-ID: <CAD=FV=VTEQMqnmC_OMtADTdrs+2zxCd8ODSRpxtxP6SKBnx2qg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] clk: qcom: lpass-sc7180: Disentangle the two clock devices
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Taniya Das <tdas@codeaurora.org>,
        "ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
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

On Wed, Oct 14, 2020 at 4:00 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Doug Anderson (2020-10-14 15:28:58)
> > Hi,
> >
> > On Wed, Oct 14, 2020 at 3:10 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Douglas Anderson (2020-10-14 14:05:22)
> > > > diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
> > > > index abcf36006926..48d370e2108e 100644
> > > > --- a/drivers/clk/qcom/lpasscorecc-sc7180.c
> > > > +++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
> > > > @@ -356,12 +356,48 @@ static const struct qcom_cc_desc lpass_audio_hm_sc7180_desc = {
> > > >         .num_gdscs = ARRAY_SIZE(lpass_audio_hm_sc7180_gdscs),
> > > >  };
> > > >
> > > > +static void lpass_pm_runtime_disable(void *data)
> > > > +{
> > > > +       pm_runtime_disable(data);
> > > > +}
> > > > +
> > > > +static void lapss_pm_clk_destroy(void *data)
> > > > +{
> > > > +       pm_clk_destroy(data);
> > > > +}
> > >
> > > Why are these helpers added again? And do we even need them? Can't we
> > > just pass pm_runtime_disable or pm_clk_destroy to the
> > > devm_add_action_or_reset() second parameter?
> >
> > Unfortunately, we can't due to the C specification.  Take a look at
> > all the other users of devm_add_action_or_reset() and they all have
> > pretty much the same stupid thing.
>
> Ok, but we don't need two of the same functions, right?

How would you write it more cleanly?  I suppose I could allocate an
extra structure somewhere and put in a tuple of (function_pointer,
dev_pointer) there and pass that as the data.  Then I could do:

  struct fp_dp_tuple {
    void (*fn)(void *);
    struct device *dev;
  };

  struct fp_dp_tuple *tuple = data;
  tuple->fn(tuple->dev);

...but now I've got to create that tuple and stash it somewhere,
right?  ...or am I missing some super easy/obvious solution for how I
can know whether to call pm_runtime_disable() or pm_clk_destroy()?


> > ...actually, do we even need the runtime_disable in the error path?
> > When the dev goes away does it matter if you left pm_runtime enabled
> > on it?
> >
>
> I don't know. The device isn't destroyed but maybe when the driver is
> unbound it resets the runtime PM counters?

Certainly it seems safest just to do it...

-Doug
