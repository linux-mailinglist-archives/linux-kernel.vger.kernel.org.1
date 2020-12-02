Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A532CB3D0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 05:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbgLBEMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 23:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgLBEMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 23:12:21 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2DCC0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 20:11:35 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id m6so112974vkl.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 20:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xtglqhkWZ3g8rxnwzWMhjFDL6xCz7jFKKZM6f0KYfMU=;
        b=SP7/Pecj6b4qSD5XU+UwkE4RYOmIoU99mt2VGbOQYRN1lcQFEyQ7rhHV22LtcvuOOc
         IuBR70yhqHsM9kBzqNfo7xXE2/Q2X5WdTq2oV2oMyv5tUZxUfYZcjgyHGyMQFP6KQmxZ
         oEQX+FZhHqb5+zbFi0sePQeP/3fuKm6pcgyaaDJ8jApZXX17sK+Rx/xZ+Pm4jcgC1FWD
         m2CEUVBh1cSbBhvVEhRLjzjye+jsj9A5t5OqGBaJdmKdZihuMP99++abtBf/EPAEpRxf
         +Rt0NUo1aJW8ElCuYPYTyP4QunmjYTaAykBcmzKgEZk6c/vRVjXozZ+EPVcSKRRUzYN6
         XXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xtglqhkWZ3g8rxnwzWMhjFDL6xCz7jFKKZM6f0KYfMU=;
        b=AKjPJ/z7QYdxHqpoz4YTjIuQtHszgh0FtI8qlEfsZIotJVA5/jhmPv75bKcNyJ0SEd
         QaQ4DhecXSSKa209NF7ITIaiwh3ZxLBEinWhyucsLEhMI3nUImkbjb51MGXiPhwqx7QK
         2oguP5qTTOGfKx7SHKDF9ZHpHgWPxZgD1hD6Q0DiqmgdXN8ZUPCnZkIeXFt7+x0gRoO3
         KuS5Wr3Pn1mE6PoC579uuqGFyH2epb45xiYF6d8Jq0RXAzNQk1JxFYNG9jlEoZUwmAQQ
         fQWrEnCPmKRmgKo+BjByeYuBGdhsT3JXkW+yCKX+AWeJXnlBa4mRgbWuEP8tLP8xq9la
         wKxw==
X-Gm-Message-State: AOAM531mB9j+5dL2TcjBdHF/Oo36tx2GbMEO5+TYsLzW44Fq9w45piLM
        QS0l8MRBTxI4xxstQcDpc/ri4dhWN6VPRdmuFWtT3w==
X-Google-Smtp-Source: ABdhPJzeBw3+LaJMe58JHfH3h3ptXnlcnFsmbafVFQjwUANg6KI1yYV546O9vzzfoCCq9w8EO5M7PeJU8z1bAsHncT8=
X-Received: by 2002:a1f:1bc3:: with SMTP id b186mr475328vkb.18.1606882294515;
 Tue, 01 Dec 2020 20:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20201201013246.32034-1-badhri@google.com> <20201201013246.32034-3-badhri@google.com>
 <20201201131646.GC232197@roeck-us.net>
In-Reply-To: <20201201131646.GC232197@roeck-us.net>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Tue, 1 Dec 2020 20:10:58 -0800
Message-ID: <CAPTae5+kfGryAT02rMMKbdokWfVFBp50h=zwaBHY9GyPz4e5kA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] usb: typec: tcpci_maxim: Enable VSAFE0V signalling
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 5:16 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Nov 30, 2020 at 05:32:46PM -0800, Badhri Jagan Sridharan wrote:
> > Unmask EXTENDED_STATUS_MASK.vSafe0V, ALERT.Extended_Status
> > and set vbus_vsafe0v to enable VSAFE0V signalling.
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpci_maxim.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> > index c1797239bf08..1aabe6abd819 100644
> > --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> > +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> > @@ -112,11 +112,18 @@ static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
> >               return;
> >       }
> >
> > +     /* Enable VSAFE0V detection */
> > +     ret = max_tcpci_write8(chip, TCPC_EXTENDED_STATUS_MASK, TCPC_EXTENDED_STATUS_VSAFE0V);
> > +     if (ret < 0) {
> > +             dev_err(chip->dev, "Unable to unmask TCPC_EXTENDED_STATUS_VSAFE0V ret:%d\n", ret);
> > +             return;
> > +     }
> > +
> >       alert_mask = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED | TCPC_ALERT_TX_FAILED |
> >               TCPC_ALERT_RX_HARD_RST | TCPC_ALERT_RX_STATUS | TCPC_ALERT_CC_STATUS |
> >               TCPC_ALERT_VBUS_DISCNCT | TCPC_ALERT_RX_BUF_OVF | TCPC_ALERT_POWER_STATUS |
> >               /* Enable Extended alert for detecting Fast Role Swap Signal */
> > -             TCPC_ALERT_EXTND;
> > +             TCPC_ALERT_EXTND | TCPC_ALERT_EXTENDED_STATUS;
> >
> >       ret = max_tcpci_write16(chip, TCPC_ALERT_MASK, alert_mask);
> >       if (ret < 0) {
> > @@ -315,6 +322,12 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
> >               }
> >       }
> >
> > +     if (status & TCPC_ALERT_EXTENDED_STATUS) {
> > +             ret = max_tcpci_read8(chip, TCPC_EXTENDED_STATUS, (u8 *)&reg_status);
> > +             if (ret >= 0 && (reg_status & TCPC_EXTENDED_STATUS_VSAFE0V))
> > +                     tcpm_vbus_change(chip->port);
> > +     }
> > +
> >       if (status & TCPC_ALERT_RX_STATUS)
> >               process_rx(chip, status);
> >
> > @@ -442,6 +455,7 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
> >       chip->data.init = tcpci_init;
> >       chip->data.frs_sourcing_vbus = max_tcpci_frs_sourcing_vbus;
> >       chip->data.auto_discharge_disconnect = true;
> > +     chip->data.vbus_vsafe0v = 1;
>
> Why not use true/false ?

Sure. Fixing in v2.

>
> >
> >       max_tcpci_init_regs(chip);
> >       chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
> > --
> > 2.29.2.454.gaff20da3a2-goog
> >
