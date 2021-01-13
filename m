Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6989D2F4D78
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbhAMOpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbhAMOpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:45:12 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F025EC061795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:44:31 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id h4so1776858qkk.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSaLjd0adwc4A9pw9dVhGLGEtgMueESLihkqzNC4nZI=;
        b=fg3LqtnhsOsxsTc67Ngrhxx4sU0hh8IMnJxPVNFfI0CuQ2kTlgx3FRnu4v/sqXbMuV
         2qrkFcwJemXKZqUr3RBtPnGiHc6L5EpeaPGK3wmNCudEoOG5cFGM6Pte5QqKN20woxti
         wYjpadsWUWSf6jxMJIiP54HXSEGegQAv2hsiggh3iXsOam5PWhxOm8tb+AMkA7BC11Sf
         HV5hyMBJrWMEiKWodoVLJcCH7o/gT+uA+vfxn9bHx1aGpyXuW+9wix0najwRG1gdpWPf
         g6j5Qdg6BR2UKDn9r3U/1y+wLc4NBpUEwL7ttsp394eHRYPor0Dabpsy9RGmLIbZ79sk
         Kngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSaLjd0adwc4A9pw9dVhGLGEtgMueESLihkqzNC4nZI=;
        b=nJzM/CeFMDH+O7Z8gbLZAfOJTcrupRZHVtAACfDXwSi9XJ2gA1KDXlhxpd4dft7FD7
         Eo7vPSKko+SRsoM+04Bi0Q5IM3PYrnzb7831TpGn/0KTEcLbF4R2QyvV7hXG30gbuvPG
         Vy9IWsUY2EmIESDgP/wXdm2kaRmDHCQ1vTFR11CTYpdMwVaoAZO3WlXbbVsVgDZY3mP8
         ak+npH6h2f98nNJm+tH8PpqcF1p70qWyn9D/zGTNQSAUK7QMHmrttuoS2KaEOPkZcshv
         R0eZ6yVu8Q9kRW6yLBREs91zTBu8vZpzRwTpMfVLsJyC3eUvaNsM2jI1GVXOwBHUBR9X
         lBCw==
X-Gm-Message-State: AOAM530T98IzJO1zJcJbiT9MEt/wF9tXemqExY66JesYupn9d5klAuR0
        bvNSkEcwi2qW5R+tBOS2zoM/cB/VWtlLBE03xJ+b9A==
X-Google-Smtp-Source: ABdhPJyOqH1iCuaEieL38th4VuKo9+cyf/aH5rUOl/Xt/O/n0I+b0VgH7gGnHkz1v/omJI4yNJnLbdDOjO5EiAtfZ4M=
X-Received: by 2002:a37:2f82:: with SMTP id v124mr2257967qkh.212.1610549070729;
 Wed, 13 Jan 2021 06:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20210105163927.1376770-1-kyletso@google.com> <20210105163927.1376770-2-kyletso@google.com>
 <20210112132925.GC2020859@kuha.fi.intel.com>
In-Reply-To: <20210112132925.GC2020859@kuha.fi.intel.com>
From:   Kyle Tso <kyletso@google.com>
Date:   Wed, 13 Jan 2021 22:44:14 +0800
Message-ID: <CAGZ6i=2j2U6C_gtdz73vMPn_UAdZu=cU+pZguW=d8iZecKE=0g@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] usb: typec: tcpm: AMS and Collision Avoidance
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will McVicker <willmcvicker@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 9:29 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Wed, Jan 06, 2021 at 12:39:25AM +0800, Kyle Tso wrote:
> > This patch provides the implementation of Collision Avoidance introduced
> > in PD3.0. The start of each Atomic Message Sequence (AMS) initiated by
> > the port will be denied if the current AMS is not interruptible. The
> > Source port will set the CC to SinkTxNG if it is going to initiate an
> > AMS, and SinkTxOk otherwise. Meanwhile, any AMS initiated by a Sink port
> > will be denied in TCPM if the port partner (Source) sets SinkTxNG except
> > for HARD_RESET and SOFT_RESET.
> >
> > Signed-off-by: Kyle Tso <kyletso@google.com>
> > Signed-off-by: Will McVicker <willmcvicker@google.com>
>
> So did you and Will develop this patch together?
>
Not really.
Will cherry-picked the patch from our old branch to a later one which
is more close to Upstream.
And I cherry-picked his version so the signed-off is here.
I will remove the signed-off if that is the right move.

> Few nitpicks below.
>

> > +static void tcpm_set_cc(struct tcpm_port *port, enum typec_cc_status cc)
> > +{
> > +     tcpm_log(port, "cc:=%d", cc);
> > +     port->cc_req = cc;
> > +     port->tcpc->set_cc(port->tcpc, cc);
> > +}
> > +
> > +static enum typec_cc_status tcpm_rp_cc(struct tcpm_port *port);
>
> I think you should move the function here instead of adding the
> prototype for it.
>
will fix this in the next patch version.


> > +                     case CMD_DISCOVER_MODES:
> > +                             res = tcpm_ams_start(port, DISCOVER_MODES);
> > +                             break;
> > +                     case CMD_ENTER_MODE:
> > +                             res = tcpm_ams_start(port,
> > +                                                  DFP_TO_UFP_ENTER_MODE);
>
> One line is enough:
>
>                                 res = tcpm_ams_start(port, DFP_TO_UFP_ENTER_MODE);
>
will fix this in the next patch version.

> > +                             break;
> > +                     case CMD_EXIT_MODE:
> > +                             res = tcpm_ams_start(port,
> > +                                                  DFP_TO_UFP_EXIT_MODE);
>
> Ditto.
>
will fix this in the next patch version.

> > +                             break;
> > +                     case CMD_ATTENTION:
> > +                             res = tcpm_ams_start(port, ATTENTION);
> > +                             break;
> > +                     case VDO_CMD_VENDOR(0) ... VDO_CMD_VENDOR(15):
> > +                             res = tcpm_ams_start(port, STRUCTURED_VDMS);
> > +                             break;
> > +                     default:
> > +                             res = -EOPNOTSUPP;
> > +                             break;
> > +                     }
> >
> > -                     port->vdm_retries = 0;
> > -                     port->vdm_state = VDM_STATE_BUSY;
> > -                     timeout = vdm_ready_timeout(port->vdo_data[0]);
> > -                     mod_vdm_delayed_work(port, timeout);
> > +                     if (res < 0)
> > +                             return;
> >               }
> > +
> > +             port->vdm_state = VDM_STATE_SEND_MESSAGE;
> > +             mod_vdm_delayed_work(port, (port->negotiated_rev >= PD_REV30) &&
> > +                                        (port->pwr_role == TYPEC_SOURCE) &&
> > +                                        (PD_VDO_SVDM(vdo_hdr)) &&
> > +                                        (PD_VDO_CMDT(vdo_hdr) == CMDT_INIT) ?
> > +                                        PD_T_SINK_TX : 0);
>
> I don't think you need all those brackets. This would look better, and
> I bet it would make also scripts/checkpatch.pl happy:
>
>                 mod_vdm_delayed_work(port, (port->negotiated_rev >= PD_REV30 &&
>                                             port->pwr_role == TYPEC_SOURCE &&
>                                             PD_VDO_SVDM(vdo_hdr) &&
>                                             PD_VDO_CMDT(vdo_hdr) == CMDT_INIT) ?
>                                            PD_T_SINK_TX : 0);
>
will fix this in the next patch version.


> > +             /*
> > +              * If previous AMS is interrupted, switch to the upcoming
> > +              * state.
> > +              */
> > +             upcoming_state = port->upcoming_state;
> > +             if (port->upcoming_state != INVALID_STATE) {
> > +                     port->upcoming_state = INVALID_STATE;
> > +                     tcpm_set_state(port, upcoming_state, 0);
> > +                     break;
> > +             }
>
> I don't see the local upcoming_state variable is being used anywhere
> outside of these conditions, so please set it inside the condition
> block:
>
>                 if (port->upcoming_state != INVALID_STATE) {
>                         upcoming_state = port->upcoming_state;
>                         port->upcoming_state = INVALID_STATE;
>                         tcpm_set_state(port, upcoming_state, 0);
>                         break;
>                 }
>
will do


> > +             upcoming_state = port->upcoming_state;
> > +             if (port->upcoming_state != INVALID_STATE) {
> > +                     port->upcoming_state = INVALID_STATE;
> > +                     tcpm_set_state(port, upcoming_state, 0);
> > +                     break;
> > +             }
>
> Same here.
>
will do

thanks,
Kyle
