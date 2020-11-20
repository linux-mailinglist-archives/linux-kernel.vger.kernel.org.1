Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4EB2BA4C0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 09:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgKTIg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 03:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgKTIg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:36:27 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02D3C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 00:36:27 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id m9so6714891pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 00:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P8tCjphQcsFX+yvshUO1Kuefw2AH2A0LgC7HFq1U8TI=;
        b=ZaIuETKp1Fjacx7TPouf0HrG3pxdX2zR8WuHLuFstSbLyveKDgsl2LohpSU6OPpNR1
         U2cnPz7m3YVYQYi1vSbE8VvbOTvjEWfrUiqY45q2u+ZnGcRR2ugXX445EtZ+q8cyMqRl
         pYA1w11Su77NwOINiIcWjbGTcX/zYrzmOufVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P8tCjphQcsFX+yvshUO1Kuefw2AH2A0LgC7HFq1U8TI=;
        b=pvXTiELVoo1uH6EIjy0WD41+i8it9JPcqBHm2P2NhDRPowik0KaJYusSzXh+eO90OV
         2zIRmOe7ZW+u9gdJSwf2wFgcNvQPje6risLa4k0H+ZIv/vJz8L53edbCSurqn4dNt+vZ
         uNMG7M8Jn9yumCIpUHDGg5pNI81SP4CKg0lDZ1bshNO92OaCE37iVrIKqKExQ3WIftxh
         AoKDUfjwa+jlLO2Z/Gvx/LABdC4Fxyr0++sLax+yAIYAcNlrdNNz21F4IiIJ1DC8unPj
         ON4qsDc/5jQdoPcDwIOSjHbdeFAeHgY1sPDRCcoPQtAVdg42AzLSAA9s2Zb1tP1DiR8r
         8jBA==
X-Gm-Message-State: AOAM531lftj53jAiMnYY15MtcM11Q6GTAa+Mk+zPvoB2HSGsu3RGEjms
        QML3hVe7U41a/wvwGtFUZQT8bA==
X-Google-Smtp-Source: ABdhPJzHfJSY1spSCgsVYSdN+P4nLes1SzhPq4/vwU/WASuzlKdR5JuJ5itVaTJKIIeRDKigDOhsvQ==
X-Received: by 2002:a63:c944:: with SMTP id y4mr15788825pgg.435.1605861387253;
        Fri, 20 Nov 2020 00:36:27 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id e29sm2278921pgl.58.2020.11.20.00.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 00:36:26 -0800 (PST)
Date:   Fri, 20 Nov 2020 00:36:25 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com
Subject: Re: [PATCH v3 1/4] usb: typec: Use Thunderbolt 3 cable discover mode
 VDO in Enter_USB message
Message-ID: <20201120083625.GB4160865@google.com>
References: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
 <20201119063211.2264-2-utkarsh.h.patel@intel.com>
 <20201120080514.GC4120550@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120080514.GC4120550@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 10:05:14AM +0200, Heikki Krogerus wrote:
> On Wed, Nov 18, 2020 at 10:32:08PM -0800, Utkarsh Patel wrote:
> > When Thunderbolt 3 cable is being used to create USB4 connection, use
> > Thunderbolt 3 discover mode VDO to fill details such as active cable plug
> > link training and cable rounded support.
> > With USB4 cables, these VDO members need not be filled.
> > 
> > Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> > 
> > --
> > Changes in v3:
> > - Changed the commit mesage to reflect why TBT3 VDO is being used.
> > - Added more details in the header file about the usage of TBT3 VDO.
> > 
> > Changes in v2:
> > - No change.
> > --
> > ---
> >  include/linux/usb/typec.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> > index 6be558045942..25731ed863fa 100644
> > --- a/include/linux/usb/typec.h
> > +++ b/include/linux/usb/typec.h
> > @@ -75,6 +75,10 @@ enum typec_orientation {
> >  /*
> >   * struct enter_usb_data - Enter_USB Message details
> >   * @eudo: Enter_USB Data Object
> > + * @tbt_cable_vdo: TBT3 Cable Discover Mode Response
> 
> This is fine..
> 
> > + * @tbt_cable_vdo needs to be filled with details of active cable plug link
> > + * training and cable rounded support when thunderbolt 3 cable is being used to
> > + * create USB4 connection. Do not fill this in case of USB4 cable.
> 
> But this is not. The description of the member tells what the member
> contains, but it does not make sense to explain also how to use the
> member in the same place.

Slightly tangential question here:

Is there a need to mention "active cable plug link training" and "cable
rounded support" at all? Wouldn't it be sufficient to omit those in the
description (in case some mux implementation wants to use the other fields
of the VDO) ?

> Instead you should explain how to use the
> member in the description of the structure. So..
> 
> >   * @active_link_training: Active Cable Plug Link Training
> >   *
> >   * @active_link_training is a flag that should be set with uni-directional SBRX
> 
> Put it here. That will make this much more readable.
> 
> 
> thanks,
> 
> -- 
> heikki
