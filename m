Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5963A270A48
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 04:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgISCyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 22:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgISCyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 22:54:00 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90486C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 19:54:00 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id d18so2509932uav.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 19:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YwIKrth7tYJPF7+z3Nto/9YjegvW9VBp7/QyzsiYMn0=;
        b=e7S7ENxmJ/7DWnFswzJufgY8ywuXmcOXN9cQNitublLijI8AFQODk2r33cFrWPbQCL
         9/2EY065UtTzOdOtqcBtiMBBuKTWXl4+6DcRzPqgsPPEASVe8HYcTLLs3/bNp/FK8ZV7
         Az7MPnslghIkftQ+wCOW3IzuANm05ccf/4arwNjUvB5falJvWuxyJBS/xNFkAcLWpIb+
         XYcCwii1jR2F5JNz34kgJfa6NOo3CrfALlF2n2Qg6yeOBcLlbEwaVLJCTFHNbupz2VRj
         ZTSRxIXlshD6sDCTMGpfZbXdkPySMtyt1m6wHsYW7E0XbefzB+9ae/nX2LRBFeb0OHiM
         nZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YwIKrth7tYJPF7+z3Nto/9YjegvW9VBp7/QyzsiYMn0=;
        b=o9XBOr9q6DIjlFuw+rQ6YT/X+x3/xzVMhego7hJyPsXWUHn+djd79z/EGoUvMyOonG
         ZHus5k/D0ZKdIIUKdIvpbmyiErCEGP2H9wwDrwZ4kc0shUTvB14yxTqYWwHFS8zOXvxj
         Znaxk7P5qPOs8W/SfwcDUsIihHqLNFYARb6tBeLxD+VB8/rtSYVrhadkWtX3XrnqIS2X
         ZrSH1cL0xuKgzMxdLg+uJAbO4upjyn/jbgZxaCMTTIH+WeKQVIkQa8K1XXV9ajoPkkZ7
         pnh31qvp9C34S1fJhYa4jUPwETRkgJPGzq6sqXnhJdRsTkpVNt2aroWR9aPqxlmJHYWM
         X9fQ==
X-Gm-Message-State: AOAM5338lDy0fzEkvsynlzMaxA9bQDkA5hLKyopxGLs2x1ZhxRhbxlfQ
        3URxa2zVXP9Gbw9ZGo6SrKc6s3w9Ay0ve/x2K5GooNp1BFxHOQ==
X-Google-Smtp-Source: ABdhPJytgx7MYHC4QXL2ZpNmp5sQXDy9TCGGzCNRYIhdFgqf2FE/spyMp67u/5ZEwObSOHklg6a8F0d7ce+xzF0penU=
X-Received: by 2002:a9f:366e:: with SMTP id s43mr7671448uad.69.1600484038765;
 Fri, 18 Sep 2020 19:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200917101856.3156869-1-badhri@google.com> <20200917101856.3156869-11-badhri@google.com>
 <20200918142007.GF1630537@kuha.fi.intel.com>
In-Reply-To: <20200918142007.GF1630537@kuha.fi.intel.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Fri, 18 Sep 2020 19:53:22 -0700
Message-ID: <CAPTae5KNabvw7sHyCdj2BE6xPDqfmOQaEm3fXTMx_LxMtuYP-g@mail.gmail.com>
Subject: Re: [PATCH v7 11/11] usb: typec: tcpci_maxim: Implemnent set_auto_vbus_discharge_threshold
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 7:20 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Thu, Sep 17, 2020 at 03:18:56AM -0700, Badhri Jagan Sridharan wrote:
> > Programs VBUS_SINK_DISCONNECT_THRESHOLD based on the power_role,
> > voltage requested as sink, mode of operation.
> >
> > The programmed threshold is based on vSinkDisconnect and
> > vSinkDisconnectPD values.
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> > Changes since v1:
> > - Changing patch version to v6 to fix version number confusion.
> >
> > Changes since v6:
> > - Rebase on usb-next.
> > ---
> >  drivers/usb/typec/tcpm/tcpci_maxim.c | 48 ++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> > index 723d7dd38f75..8289b596d2ee 100644
> > --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> > +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> > @@ -137,6 +137,52 @@ static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
> >               return;
> >  }
> >
> > +static int max_tcpci_set_auto_vbus_discharge_threshold(struct tcpci *tcpci, struct tcpci_data *data,
> > +                                                    enum typec_role port_role,
> > +                                                    enum typec_pwr_opmode mode, bool pps_active,
> > +                                                    u32 requested_vbus_voltage_mv)
> > +{
> > +     struct max_tcpci_chip *chip = tdata_to_max_tcpci(data);
> > +     u32 threshold = 0;
> > +     u8 pwr_ctrl;
> > +
> > +     /*
> > +      * Indicates that vbus is going to go away due PR_SWAP, hard reset etc.
> > +      * Do not discharge vbus here.
> > +      */
> > +     if (requested_vbus_voltage_mv == 0)
> > +             goto write_thresh;
>
> I would assume that step is the same for every TCPC, no?
I agree so moved to tcpci.c code.
>
> > +     if (port_role == TYPEC_SINK) {
> > +             max_tcpci_read8(chip, TCPC_POWER_CTRL, &pwr_ctrl);
> > +             if (pwr_ctrl & TCPC_FAST_ROLE_SWAP_EN) {
> > +                     /* To prevent disconnect when the source is fast role swap is capable. */
> > +                     threshold = 3500;
> > +             } else if (mode == TYPEC_PWR_MODE_PD) {
> > +                     if (pps_active)
> > +                             threshold = (95 * requested_vbus_voltage_mv / 100) - 850;
> > +                     else
> > +                             threshold = (95 * requested_vbus_voltage_mv / 100) - 1250;
> > +             } else {
> > +                     /* 3.5V for non-pd sink */
> > +                     threshold = 3500;
> > +             }
> > +     } else {
> > +             /* 4V for source */
> > +             threshold = 4000;
> > +     }
> > +
> > +     threshold = threshold / TCPC_VBUS_SINK_DISCONNECT_THRESH_LSB;
> > +
> > +     if (threshold > TCPC_VBUS_SINK_DISCONNECT_THRESH_MAX) {
> > +             dev_err(chip->dev, "VBUS_SINK_DISCONNECT_THRESH out of range");
> > +             return -EINVAL;
> > +     }
> > +
> > +write_thresh:
> > +     return max_tcpci_write16(chip, TCPC_VBUS_SINK_DISCONNECT_THRESH, threshold);
>
> So couldn't tcpci.c write that register? This callback would then just
> calculate the value. I just want to avoid boilerplate.
Done !
>
> The threshold has type u32, but you still pass it to
> max_tcpci_write16(). Is that on purpose (doesn't the compiler
> complain)?
I didnt see any warnings ! I don't know why.
It wouldn't overflow though as TCPC_VBUS_SINK_DISCONNECT_THRESH_MAX
has a max value of 0x3ff. Have corrected it though and moved the code
to tcpci.c in v8.

Thanks,
Badhri

>
> thanks,
>
> --
> heikki
