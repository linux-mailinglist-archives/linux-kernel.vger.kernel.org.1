Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE902CB38A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 04:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbgLBDfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 22:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgLBDfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 22:35:19 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32BBC0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 19:34:38 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id g23so78289uan.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 19:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fluNiW0usfpNoBzf3WmHyIECVUbDXjTWi0FHwHEVwcM=;
        b=FUuhl0fJ1Vh6GPjj8/4D/7AmJ2lD8B1khYpe02T9YRRYpo6hF9szOOv27eFzNpt8Y9
         fy3qtbSPbStoNzfG4GbG00yLOlvTtU+ZRPuJPDFYbqyruIWeb0NhU1mnN9Ifn/ZTHDy/
         enlVbkgzCh6nRZAJhzwHOxETPT6fDezA7uMM5gInQrtlSinDr5BrndoHYVDycwJQNJno
         isnxOedc8er0yuISOupIeKtZPPm7X2x7IotuxeIKoQvgPi3S6EjlG8BWNK2A8qijNuT6
         3SobMNysTFo3FtBrdcpXaw7+VBmD9/BFIpGl7Wy60QCqlL5MJrEJBS3wULLPjWeQMTkB
         MCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fluNiW0usfpNoBzf3WmHyIECVUbDXjTWi0FHwHEVwcM=;
        b=aGkyFDmVFhJ4QvPUozy4io6V44xYiuxfJs2BqzrDKfE1OkUTUeLQJvIg+lBAxUBLLL
         5h8BYjPzS0zj7OGRfzNW33np1MFp1F0GD+Unf8DSR5qrTYEjJRyZmW+W3fkiu4VKjEV9
         6qbnSbqEZHyFlSgH0UuRDEM83rQSLI3DU1dt3UFcEd96rGxPCwx+XQxybvkR/PD4Sz1M
         atPJZU6NcxzQFr7wB8VHOhDndqWZzx2UNbyN7ezt27hvSn/7fRnWOztEEp802NrUjaAY
         0drnyAIncD9vQ3BkTMmeo0oBwIfYRQexZJpHuKS1vowviHoh2OPvRY9ycoZasjx+yJZ4
         usyg==
X-Gm-Message-State: AOAM530HyrAnco+sZHiUtBjoIBH25KoY4+x8360Uudswazjd1WuSqNnH
        GN/tRj1FCqgbx2df6klnMjSO6Y2qyxio+GnssS6C/OxgP+ocqPbr
X-Google-Smtp-Source: ABdhPJwvA2rDahI8jaSEl93OQl+LH0Kg2JQQiBbJIKL1LG3n72IT/D4+MKir/AX6rAQfYegkkoUuiha9XPbyutY1NVc=
X-Received: by 2002:ab0:d90:: with SMTP id i16mr437493uak.23.1606880077544;
 Tue, 01 Dec 2020 19:34:37 -0800 (PST)
MIME-Version: 1.0
References: <20201201013246.32034-1-badhri@google.com> <20201201013246.32034-2-badhri@google.com>
 <20201201132749.GD232197@roeck-us.net>
In-Reply-To: <20201201132749.GD232197@roeck-us.net>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Tue, 1 Dec 2020 19:34:01 -0800
Message-ID: <CAPTae5+e9Pibj7RXE=4tzvyJLRudMgPhsEqrWtFjgsQRc+C5eQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] usb: typec: tcpci: Add support to report vSafe0V
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 5:27 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Nov 30, 2020 at 05:32:45PM -0800, Badhri Jagan Sridharan wrote:
> > This change adds vbus_vsafe0v which when set, makes TCPM
> > query for VSAFE0V by assigning the tcpc.is_vbus_vsafe0v callback.
> > Also enables ALERT.ExtendedStatus which is triggered when
> > status of EXTENDED_STATUS.vSafe0V changes.
> > EXTENDED_STATUS.vSafe0V is set when vbus is at vSafe0V and
> > cleared otherwise.
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpci.c | 55 ++++++++++++++++++++++++++--------
> >  drivers/usb/typec/tcpm/tcpci.h |  6 ++++
> >  2 files changed, 49 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> > index 12d983a75510..e281b8bee4db 100644
> > --- a/drivers/usb/typec/tcpm/tcpci.c
> > +++ b/drivers/usb/typec/tcpm/tcpci.c
> > @@ -402,6 +402,19 @@ static int tcpci_get_vbus(struct tcpc_dev *tcpc)
> >       return !!(reg & TCPC_POWER_STATUS_VBUS_PRES);
> >  }
> >
> > +static int tcpci_is_vbus_vsafe0v(struct tcpc_dev *tcpc)
> > +{
> > +     struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> > +     unsigned int reg;
> > +     int ret;
> > +
> > +     ret = regmap_read(tcpci->regmap, TCPC_EXTENDED_STATUS, &reg);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return !!(reg & TCPC_EXTENDED_STATUS_VSAFE0V);
> > +}
> > +
> >  static int tcpci_set_vbus(struct tcpc_dev *tcpc, bool source, bool sink)
> >  {
> >       struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> > @@ -554,12 +567,22 @@ static int tcpci_init(struct tcpc_dev *tcpc)
> >               TCPC_ALERT_RX_HARD_RST | TCPC_ALERT_CC_STATUS;
> >       if (tcpci->controls_vbus)
> >               reg |= TCPC_ALERT_POWER_STATUS;
> > +     /* Enable VSAFE0V status interrupt when detecting VSAFE0V is supported */
> > +     if (tcpci->data->vbus_vsafe0v) {
> > +             reg |= TCPC_ALERT_EXTENDED_STATUS;
> > +             ret = regmap_write(tcpci->regmap, TCPC_EXTENDED_STATUS_MASK,
> > +                                TCPC_EXTENDED_STATUS_VSAFE0V);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> >       return tcpci_write16(tcpci, TCPC_ALERT_MASK, reg);
> >  }
> >
> >  irqreturn_t tcpci_irq(struct tcpci *tcpci)
> >  {
> >       u16 status;
> > +     int ret;
> > +     unsigned int raw;
> >
> >       tcpci_read16(tcpci, TCPC_ALERT, &status);
> >
> > @@ -575,18 +598,17 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
> >               tcpm_cc_change(tcpci->port);
> >
> >       if (status & TCPC_ALERT_POWER_STATUS) {
> > -             unsigned int reg;
> > -
> > -             regmap_read(tcpci->regmap, TCPC_POWER_STATUS_MASK, &reg);
> > -
> > -             /*
> > -              * If power status mask has been reset, then the TCPC
> > -              * has reset.
> > -              */
> > -             if (reg == 0xff)
> > -                     tcpm_tcpc_reset(tcpci->port);
> > -             else
> > -                     tcpm_vbus_change(tcpci->port);
> > +             ret = regmap_read(tcpci->regmap, TCPC_POWER_STATUS_MASK, &raw);
> > +             if (ret >= 0) {
> > +                     /*
> > +                      * If power status mask has been reset, then the TCPC
> > +                      * has reset.
> > +                      */
> > +                     if (raw == 0xff)
> > +                             tcpm_tcpc_reset(tcpci->port);
> > +                     else
> > +                             tcpm_vbus_change(tcpci->port);
> > +             }
>
> This change seems unrelated to this patch. Besides that, are you sure that
> ignoring an error from regmap_read() is sensible here ?

Sorry should have split that into a separate patch. I was actually intending
to do the following where tcpm calls are not made if TCPC_POWER_STATUS_MASK
read returns error. The code was previously ignoring the error.

               if (!ret) {
                        /*
                         * If power status mask has been reset, then the TCPC
                         * has reset.
                         */
                        if (raw == 0xff)
                                tcpm_tcpc_reset(tcpci->port);
                        else
                                tcpm_vbus_change(tcpci->port);
             }

This is reasonable right ?

                }

>
> Overall, it may make sense to improve error handling in this driver, but I think
> it should be done in a separate patch.
>
> >       }
> >
> >       if (status & TCPC_ALERT_RX_STATUS) {
> > @@ -622,6 +644,12 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
> >               tcpm_pd_receive(tcpci->port, &msg);
> >       }
> >
> > +     if (status & TCPC_ALERT_EXTENDED_STATUS) {
> > +             ret = regmap_read(tcpci->regmap, TCPC_EXTENDED_STATUS, &raw);
> > +             if (ret >= 0 && (raw & TCPC_EXTENDED_STATUS_VSAFE0V))
> > +                     tcpm_vbus_change(tcpci->port);
> > +     }
> > +
> >       if (status & TCPC_ALERT_RX_HARD_RST)
> >               tcpm_pd_hard_reset(tcpci->port);
> >
> > @@ -699,6 +727,9 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
> >                       tcpci_set_auto_vbus_discharge_threshold;
> >       }
> >
> > +     if (tcpci->data->vbus_vsafe0v)
> > +             tcpci->tcpc.is_vbus_vsafe0v = tcpci_is_vbus_vsafe0v;
> > +
> >       err = tcpci_parse_config(tcpci);
> >       if (err < 0)
> >               return ERR_PTR(err);
> > diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> > index 3fe313655f0c..116a69c85e38 100644
> > --- a/drivers/usb/typec/tcpm/tcpci.h
> > +++ b/drivers/usb/typec/tcpm/tcpci.h
> > @@ -49,6 +49,9 @@
> >  #define TCPC_TCPC_CTRL_ORIENTATION   BIT(0)
> >  #define TCPC_TCPC_CTRL_BIST_TM               BIT(1)
> >
> > +#define TCPC_EXTENDED_STATUS         0x20
> > +#define TCPC_EXTENDED_STATUS_VSAFE0V BIT(0)
> > +
> >  #define TCPC_ROLE_CTRL                       0x1a
> >  #define TCPC_ROLE_CTRL_DRP           BIT(6)
> >  #define TCPC_ROLE_CTRL_RP_VAL_SHIFT  4
> > @@ -155,11 +158,14 @@ struct tcpci;
> >   *           is sourcing vbus.
> >   * @auto_discharge_disconnect:
> >   *           Optional; Enables TCPC to autonously discharge vbus on disconnect.
> > + * @vbus_vsafe0v:
> > + *           optional; Set when TCPC can detect whether vbus is at VSAFE0V.
> >   */
> >  struct tcpci_data {
> >       struct regmap *regmap;
> >       unsigned char TX_BUF_BYTE_x_hidden:1;
> >       unsigned char auto_discharge_disconnect:1;
> > +     unsigned char vbus_vsafe0v:1;
> >
> >       int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
> >       int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
> > --
> > 2.29.2.454.gaff20da3a2-goog
> >
