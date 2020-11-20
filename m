Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422712BAB63
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 14:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgKTNgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 08:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgKTNgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:36:45 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B87C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:36:45 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id v11so6989765qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9sozv2P/WIWdmbfvHUStARw9ssObqq8u6/YeFBz3gI=;
        b=mOTU/VbLQABaaNZOWZAKWAXfDPSoJej7gIX8tfeQQlL3db/NfEnZI7ACQFzNSFStoJ
         +D0O602dD2itIyTnalHNQLBmxUqBUS8RCCkwGadL7Mz9p6osbdxh+fx8xYsWp7Tv5o69
         4Zh8X2DO3CWPpOnlMRxtP3Y3L62WPlEXZYojs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9sozv2P/WIWdmbfvHUStARw9ssObqq8u6/YeFBz3gI=;
        b=qJSTVaQtCZXjs8UOSfLHwLdeC//MBXOkueB+VxmHkVwHDn2Sgovj5InhVM0aXAqVKi
         ShTYFYezHVBrkosjd9mN74iqkcKthv3TFsEm0MQxfjGzDGVLbY6P9TZGrbVeaCgDI4Ze
         TBS1XrgWxY4mTTtai46PzPFX8UoseCei0NJlLZfUI+fuBRo+x5HRNHHetvTlPC/f/UkY
         4C+dMe0scciCGrMQ+nQ8LMbX2WwGeDF2XY6XOfWKLh/WoJ108LwGsMxOjRS64Orxz/OQ
         QvHy/5ZF/XzYxiBm+/VatpnS8kbGAL8f4mJu4SgCi+soBWDYq4XwVB/FuiFKMGSACQih
         dDBA==
X-Gm-Message-State: AOAM53073Mc+hS5BRrUJswBa6G/05e/UNWCaPeNonoVoU7IKxyjsBCUc
        7M/l0g3iY+8+4vvLSyywR9YUHH0LF21uH9H7cIhM+w==
X-Google-Smtp-Source: ABdhPJxb4AOlT65o4qBViIMDg4U7OmsRwkSVqxW/PttdM/ZwWdo86yFz0EwuvVizapZAIgeKpPuQYfOcw17H8TZzgJg=
X-Received: by 2002:aed:2e23:: with SMTP id j32mr16530554qtd.132.1605879404460;
 Fri, 20 Nov 2020 05:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
 <20201119063211.2264-3-utkarsh.h.patel@intel.com> <20201119080906.GE3652649@google.com>
 <20201120112218.GE4120550@kuha.fi.intel.com> <20201120120700.GD4160865@google.com>
In-Reply-To: <20201120120700.GD4160865@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 20 Nov 2020 05:36:33 -0800
Message-ID: <CACeCKadoxnWdCh4sMB8b5Ppb-1gBogoAst1Rz=yBSqEL3fuppw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] platform/chrome: cros_ec_typec: Use Thunderbolt 3
 cable discover mode VDO in USB4 mode
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 4:07 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> On Fri, Nov 20, 2020 at 01:22:18PM +0200, Heikki Krogerus wrote:
> > On Thu, Nov 19, 2020 at 12:09:06AM -0800, Prashant Malani wrote:
> > > Hi Utkarsh,
> > >
> > > On Wed, Nov 18, 2020 at 10:32:09PM -0800, Utkarsh Patel wrote:
> > > > Configure Thunderbolt 3 cable generation value by filling Thunderbolt 3
> > > > cable discover mode VDO to support rounded Thunderbolt 3 cables.
> > > > While we are here use Thunderbolt 3 cable discover mode VDO to fill active
> > > > cable plug link training value.
> > > >
> > > > Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> > > >
> > > > --
> > > > Changes in v3:
> > > > - Added a check for cable's TBT support before filling TBT3 discover mode
> > > >   VDO.
> > > >
> > > > Changes in v2:
> > > > - No change.
> > > > --
> > > > ---
> > > >  drivers/platform/chrome/cros_ec_typec.c | 14 ++++++++++++--
> > > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > > > index 8111ed1fc574..68b17ee1d1ae 100644
> > > > --- a/drivers/platform/chrome/cros_ec_typec.c
> > > > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > > > @@ -514,8 +514,18 @@ static int cros_typec_enable_usb4(struct cros_typec_data *typec,
> > > >   else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
> > > >           data.eudo |= EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYPE_SHIFT;
> > > >
> > > > - data.active_link_training = !!(pd_ctrl->control_flags &
> > > > -                                USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
> > > > + /*
> > > > +  * Filling TBT3 Cable VDO when TBT3 cable is being used to establish
> > > > +  * USB4 connection.
> > > > +  */
> > > > + if (pd_ctrl->cable_gen) {
> > > > +         data.tbt_cable_vdo = TBT_MODE;
> > > > +
> > > > +         if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
> > > > +                 data.tbt_cable_vdo |= TBT_CABLE_LINK_TRAINING;
> > > > +
> > > > +         data.tbt_cable_vdo |= TBT_SET_CABLE_ROUNDED(pd_ctrl->cable_gen);
> > > > + }
> > >
> > > I think the following would decouple Rounded Support and Active Cable Link
> > > Training?:
> > >
> > >     struct typec_thunderbolt_data data = {};
> > > ...
> > >     if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
> > >             data.tbt_cable_vdo |= TBT_CABLE_LINK_TRAINING;
> > >
> > >     data.tbt_cable_vdo |= TBT_SET_CABLE_ROUNDED(pd_ctrl->cable_gen);
> >
> > I agree with this. We should not modify the data that we actually
> > have access to.
> >
> > >     if (data.tbt_cable_vdo)
> > >             data.tbt_cable_vdo |= TBT_MODE;
> >
> > That is wrong. If the LSRX communication is bi-directional, and/or the
> > data rates are non-rounded, the cable has to be TBT3 cable. So I think
> > what you would want is:
>
> Thanks for pointing this out, I didn't consider this case.
>
> >
> >       if (!data.tbt_cable_vdo)
> >               data.tbt_cable_vdo = TBT_MODE;
> >
> > But of course we can not do that either, because we have to set the
> > TBT_MODE bit if there is any other data in tbt_cable_vdo (USB Type-C
> > spec does not define any other valid values except 0x0001 = TBT_MODE
> > for that field). Otherwise the mux driver should consider the data
> > corrupted. So we would have to do this:
> >
> >         if (pd_ctrl->cable_gen &&
> >             pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
> >                 data.tbt_cable_vdo = 0; /* We assume USB4 cable */
> >         else
> >               data.tbt_cable_vdo |= TBT_MODE; /* It is for sure TBT3 cable */
> >
> > But I would not do that. TBT3 cable can also support unidirectional
> > SBU communication and rounded data rates.
> >
> > IMO safer bet for now would be to just claim that the cable is always
> > TBT3 cable until we have access to information that can really tell us
> > is the cable USB4 or TBT3.
>
> Which brings us back to v1 of the patch :S
>
> That still leaves my underlying concern that we'll be telling the Mux
> implementation that a TBT3 cable is connected when in fact it's a USB4
> active cable.
>
> How about we don't set the TBT_MODE bit at all ? IMO it's equally bad as setting it
> always, but with the additional advantage:
>
> - USB4 active cable case : you are covered (since if we unilaterally set
> TBT_MODE then the Active USB4 cable case never gets executed in
> pmc_usb_mux_usb4() in drivers/usb/typec/mux/intel_pmc_mux.c Patch 3/4)
>
> - Bidirectional LSRX non-rounded TBT: Still supported since
>   the code path in the Intel Mux agent is the same.

Thinking about this a bit more, never setting TBT_MODE would mean that
bidrectional LSRX non-rounded TBT would be treated the same as USB4
active cable in the mux agent
code, which is also incorrect (I think)

I need to think about this a bit more, but currently I don't have any
solutions to offer.
