Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C169D2CB338
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 04:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgLBDTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 22:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgLBDTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 22:19:32 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D3BC0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 19:18:51 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id u16so94070vkb.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 19:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CsvGPuzy8OQfo/wp1KkFEFU2IAaa0VUZ9rbIqaUnY0Q=;
        b=a913NGNKp/kebuNzSug+82bVC3QgxhfrimiPAJZIL56ipkFOdDDYlLAhCp2hJF5MHf
         HMImsfoSqS3q2iAfWuzi9GCdqixVaDf3puaRf0dmzL5PcYh9UTUufCetr9io82HzySrM
         JrDvdR92r9bYvOI8SU6rhzs3PTIv9DTVzstNFk9Heh16XzcJSiN5361jRmys44keAiFB
         xB5pqmkwWejTNMvnPYKMCA9wBq3iGlnvmjSm0c+hfM7MQp4OwzqP3h4aPQ2XtXNJtNhw
         9p1vtLUQCgNtgUwrpCyqLrTREw4l4yNHAa+pAT0ChoTqtVB9aedg2f2BtuQax7HD7rBy
         QVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CsvGPuzy8OQfo/wp1KkFEFU2IAaa0VUZ9rbIqaUnY0Q=;
        b=LGG3x/tWcgUjs089c6jXp2jvAk/B7MlwYQ9aSqljgkzsGQ3tbsL3jRg2J7bV77PiQI
         c6BxZyjG3W3iUUajCoR/g576tFNw36xTV9J1OoHL93aheALMbu4qQQ+EcYJxu9rcPgwY
         Fm1b3ITzwepdPyowR9IJEl6fVFPZXzbc2lrBf/52sbZAf5+Zs6ZyNxbNfZZHbnMkif6f
         02IWPkLMkrLUaVABZMh7JRTc8xsMhoVlQqmwN/w0OY5tzuMCMrh623eH//9j8uTV9Unm
         NcMSb7J8rJkl/xn74j2UcRxhPox8wfIVYN5q2wic0bGkNRoOLxvee3uDjSH8pNWBvjhs
         BKHg==
X-Gm-Message-State: AOAM531DWUrZrZMVvL25ZwBYtjNIzWab/UZLr1Vcj41fqdC45HMUFYmS
        nqGDrqk+vTzlfQ0Z3sbpg7h4sZ8q7MpYe5niTuE1LszpY9sIjw==
X-Google-Smtp-Source: ABdhPJwlMLldscC0LrUxR//iswSAppJ6iQ5PptsiX78YXheEYUv5V5pzlp+HijGI81QtipOtY5XSrkWaQtoOeTtyZK8=
X-Received: by 2002:a1f:5e0b:: with SMTP id s11mr416833vkb.8.1606879130562;
 Tue, 01 Dec 2020 19:18:50 -0800 (PST)
MIME-Version: 1.0
References: <20201201042237.414235-1-badhri@google.com> <20201201103157.GA3191259@kuha.fi.intel.com>
In-Reply-To: <20201201103157.GA3191259@kuha.fi.intel.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Tue, 1 Dec 2020 19:18:14 -0800
Message-ID: <CAPTae5JS3LmkXnytHEWMfGNpYPzdJeff66BMoAOY9f-8qdudeg@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] usb: typec: tcpm: Pass down negotiated rev to
 update retry count
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure. Done ! Just sent out v2 version of the patch.

Thanks,
Badhri.


On Tue, Dec 1, 2020 at 2:32 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Mon, Nov 30, 2020 at 08:22:34PM -0800, Badhri Jagan Sridharan wrote:
> > nRetryCount was updated from 3 to 2 between PD2.0 and PD3.0 spec.
> > nRetryCount in "Table 6-34 Counter parameters" of the PD 2.0
> > spec is set to 3, whereas, nRetryCount in "Table 6-59 Counter
> > parameters" is set to 2.
> >
> > Pass down negotiated rev in pd_transmit so that low level chip
> > drivers can update the retry count accordingly before attempting
> > packet transmission.
> >
> > This helps in passing "TEST.PD.PORT.ALL.02" of the
> > "Power Delivery Merged" test suite which was initially failing
> > with "The UUT did not retransmit the message nReryCount times"
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 2 +-
> >  include/linux/usb/tcpm.h      | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index 3bbc1f10af49..c73bc3a8356a 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -667,7 +667,7 @@ static int tcpm_pd_transmit(struct tcpm_port *port,
> >               tcpm_log(port, "PD TX, type: %#x", type);
> >
> >       reinit_completion(&port->tx_complete);
> > -     ret = port->tcpc->pd_transmit(port->tcpc, type, msg);
> > +     ret = port->tcpc->pd_transmit(port->tcpc, type, msg, port->negotiated_rev);
> >       if (ret < 0)
> >               return ret;
> >
> > diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> > index e68aaa12886f..efaedd7e8a18 100644
> > --- a/include/linux/usb/tcpm.h
> > +++ b/include/linux/usb/tcpm.h
> > @@ -121,7 +121,7 @@ struct tcpc_dev {
> >                             enum typec_cc_status cc);
> >       int (*try_role)(struct tcpc_dev *dev, int role);
> >       int (*pd_transmit)(struct tcpc_dev *dev, enum tcpm_transmit_type type,
> > -                        const struct pd_message *msg);
> > +                        const struct pd_message *msg, unsigned int negotiated_rev);
> >       int (*set_bist_data)(struct tcpc_dev *dev, bool on);
> >       int (*enable_frs)(struct tcpc_dev *dev, bool enable);
> >       void (*frs_sourcing_vbus)(struct tcpc_dev *dev);
>
> I think this will break bisectability. You need to change the users of
> that at in the same commit.
>
> thanks,
>
> --
> heikki
