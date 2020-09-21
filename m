Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87913273385
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 22:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgIUUNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 16:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgIUUM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 16:12:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6152FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 13:12:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mm21so346223pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=W/Kxd3ZsTJKzJEkeZeLlo7BrMx4l7UcmMdHw88y51RQ=;
        b=hVYFLWChiCBjVwypKK0nyxvfd37bkITGsEBYxWBdD10OR6NdYz0pzW1BJbHzXslJo0
         xtK3VvUkMzKZbsQ7aCfvV6ZlkuAvQfTmGBV7ZSh1zyrAUTEkGDeSJAXhqEtbyVOTczYF
         jER8++ADxIio0/I76KHHvyQQhit8ZCWm8qIE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=W/Kxd3ZsTJKzJEkeZeLlo7BrMx4l7UcmMdHw88y51RQ=;
        b=lPa8qWuRskajXC79CyM6I8blAaUDTAOk3ohJaKeWxfPtKAPY0WS2H/H3nXmRHcxqLd
         Loo62UegvnN/QZ2G/4XQCF8Q6K1kWgpejvyfPowddRuPZwDD8oC0/vZpoXSiXjqBGPR4
         zqiUeVN8j2metmIaE6Zv/KRB/JsoPOZ10tf3LRuJ3L7A5puzzaJSqtqpHoPtxIJDwI8u
         /xYYPTamN4NxS0pkHOCIktrisEbNEjZATsjcgkXlZNQkxMme9eQCQ2uBA2hHlgh3JZig
         FghPQ085iZY5pixPcGN7Es8Bb2lhK2NDP4vrl2toYdqzVot3O/1o1gJbo27VrpNPyI5V
         WEjA==
X-Gm-Message-State: AOAM531LYP2r4W/+UbT6YUUe6GhqAWb9V395rkyjX5WZfsLeI2J1QRr8
        rhyCEJ1BLu+0dKAjV2JOocm2Qg==
X-Google-Smtp-Source: ABdhPJyehtYtEUeW5/Zkf7avMtNZ6qZZdA9mko0zR33iKWVQ2TSolZX0a+lsDR+hlvIgP+9qaZ5HRg==
X-Received: by 2002:a17:90b:3cb:: with SMTP id go11mr802317pjb.152.1600719178625;
        Mon, 21 Sep 2020 13:12:58 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id l188sm12643094pfl.200.2020.09.21.13.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 13:12:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f6cb2d7bc02dab409030ec42bf1d17c9@codeaurora.org>
References: <20200917122558.23110-1-rojay@codeaurora.org> <160037421089.4188128.9425314091585708436@swboyd.mtv.corp.google.com> <f6cb2d7bc02dab409030ec42bf1d17c9@codeaurora.org>
Subject: Re: [PATCH V4] i2c: i2c-qcom-geni: Add shutdown callback for i2c
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     wsa@kernel.org, dianders@chromium.org,
        saiprakash.ranjan@codeaurora.org, gregkh@linuxfoundation.org,
        mka@chromium.org, akashast@codeaurora.org,
        msavaliy@qti.qualcomm.com, skakit@codeaurora.org,
        vkaur@codeaurora.org, pyarlaga@codeaurora.org,
        rnayak@codeaurora.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        sumit.semwal@linaro.org, linux-media@vger.kernel.org
To:     rojay@codeaurora.org
Date:   Mon, 21 Sep 2020 13:12:56 -0700
Message-ID: <160071917655.4188128.4175000228517858211@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting rojay@codeaurora.org (2020-09-21 04:21:04)
> Hi Stephen,
>=20
> On 2020-09-18 01:53, Stephen Boyd wrote:
> > Quoting Roja Rani Yarubandi (2020-09-17 05:25:58)
> >> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c=20
> >> b/drivers/i2c/busses/i2c-qcom-geni.c
> >> index dead5db3315a..b0d8043c8cb2 100644
> >> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> >> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> >>  };
> >>=20
> >>  struct geni_i2c_err_log {
> >> @@ -307,7 +311,6 @@ static void geni_i2c_abort_xfer(struct=20
> >> geni_i2c_dev *gi2c)
> >>=20
> >>         spin_lock_irqsave(&gi2c->lock, flags);
> >>         geni_i2c_err(gi2c, GENI_TIMEOUT);
> >> -       gi2c->cur =3D NULL;
> >=20
> > This looks concerning. We're moving this out from under the spinlock.
> > The irq handler in this driver seems to hold the spinlock all the time
> > while processing and this function grabs it here to keep cur consistent
> > when aborting the transfer due to a timeout. Otherwise it looks like=20
> > the
> > irqhandler can race with this and try to complete the transfer while
> > it's being torn down here.
> >=20
> >>         geni_se_abort_m_cmd(&gi2c->se);
> >>         spin_unlock_irqrestore(&gi2c->lock, flags);
> >>         do {
> >> @@ -349,10 +352,62 @@ static void geni_i2c_tx_fsm_rst(struct=20
> >> geni_i2c_dev *gi2c)
> >>                 dev_err(gi2c->se.dev, "Timeout resetting TX_FSM\n");
> >>  }
> >>=20
> >> +static void geni_i2c_rx_msg_cleanup(struct geni_i2c_dev *gi2c)
> >=20
> > So maybe pass cur to this function?
> >=20
>=20
> Sorry, i did not understand why to pass cur to this function?

I'm suggesting to copy the cur data out of the gi2c pointer and then
pass it to these functions so that it can't race with another transfer.
Something like an atomic exchange may work. I haven't thought about it
deeply, but we need to make sure the irq handler can't race with the
cleanup functions.
