Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E863C2A91E7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 09:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgKFI7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 03:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgKFI7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:59:11 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FB7C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 00:59:09 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 62so419317pgg.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 00:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qvb1L9BWALoNrCQYIYJHNR59TiCln8vaa4t7/IvGDgs=;
        b=N/BDCDWf4OFlTVodpwlybVmRFPHRt3QkD4rDFx8rgLmeaKPUIWAiyHjKfxu8QZ3zeb
         RuU5+1ZEfmTYgnK14iX+w2wXbGlix+IK3wRT5x1VuTywQB22fq7w/l8hOR4M/MHAQMjk
         Rm6PoNM34fAgLwEWmPH2hx9d26Yjk5Hi2y6YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qvb1L9BWALoNrCQYIYJHNR59TiCln8vaa4t7/IvGDgs=;
        b=moXc3Tpst8jE+FfP8QhACLwjJY5hgmcp6++ypqFrO+Sv3xmTB3DbchWoJLFnaITpHp
         +YPFVLchGjXONB3tI/wb1CGe56lD071QOpmpCz79D1tJs4ws52w2QaQSiNo/zL7KyLLa
         FeZ/405CjNVBxNawUDZbo4j7xTkW5tlJBKJaP8jUvecgB5pI+qu0JUU9cg5zrELZYLXb
         Krw+tl2CI/xfoMCS/93U2O5ScpQHFW+1KapDGch+s93UEj3CDBc0cBmsV9pUCDAUrFjQ
         jylZ6rzsRHqqQ0RnYOQWgdVZqrNzdC5Ck18eol+Odre5PejzbJkEFGETQ7iKdgiX0La6
         848w==
X-Gm-Message-State: AOAM533H2mBmlaQaTI+9ZbzUE6odXPbSbCQ5dKqC0noI6/Rnc4eSyVKP
        Y698uxuHkvwoQNjOB9XAVvGjZA==
X-Google-Smtp-Source: ABdhPJy0rSjPBSE5rmZ5SHn6Ob0qzoL7NwUmx8Xx5gInc49oh5WDVFeTJEixCpMCcJvB7BI/sEYQkA==
X-Received: by 2002:a17:90a:e615:: with SMTP id j21mr1365966pjy.26.1604653149145;
        Fri, 06 Nov 2020 00:59:09 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id j6sm971431pgt.77.2020.11.06.00.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 00:59:08 -0800 (PST)
Date:   Fri, 6 Nov 2020 00:59:07 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com,
        dzigterman@chromium.org, alevkoy@chromium.org,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 6/6] platform/chrome: cros_ec_typec: Store cable plug type
Message-ID: <20201106085907.GA823981@google.com>
References: <20201106012758.525472-1-pmalani@chromium.org>
 <20201106012758.525472-7-pmalani@chromium.org>
 <20201106072059.GA2614221@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106072059.GA2614221@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for looking at the patch.

On Fri, Nov 06, 2020 at 08:20:59AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Nov 05, 2020 at 05:28:03PM -0800, Prashant Malani wrote:
> > Use the PD VDO Type C cable plug type macro to retrieve and store the
> > cable plug type in the cable descriptor.
> > 
> > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_typec.c | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> Where are the first 5 patches in this series?

I believe I'd cc-ed you (and linux-usb) on the following patches in the
series(modified git_cc[1] which adds individual patch get_maintainers.pl to the cover
letter, patch 1 and patch 2):
cover letter:
https://lore.kernel.org/lkml/20201106012758.525472-1-pmalani@chromium.org/
patch 1/6 (cros-ec-typec cleanup):
https://lore.kernel.org/lkml/20201106012758.525472-2-pmalani@chromium.org/
patch 2/6 (cros-ec-typec cleanup):
https://lore.kernel.org/lkml/20201106012758.525472-2-pmalani@chromium.org/
patch 5/6 (PD VDO header patch):
https://lore.kernel.org/lkml/20201106012758.525472-6-pmalani@chromium.org/
patch 6/6 (this patch):
https://lore.kernel.org/lkml/20201106012758.525472-7-pmalani@chromium.org/

Did you not receive these?
> 
> 
> > 
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index 5e7f0b4ebbec..0a2a8b0f8115 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -709,6 +709,7 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
> >  		.port = port_num,
> >  		.partner_type = TYPEC_PARTNER_SOP_PRIME,
> >  	};
> > +	uint32_t cable_plug_type;
> 
> u32 please, this isn't userspace code :)

Will fix this in the next version.
> 
> >  	int ret = 0;
> >  
> >  	memset(disc, 0, EC_PROTO2_MAX_RESPONSE_SIZE);
> > @@ -722,8 +723,26 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
> >  	/* Parse the PD identity data, even if only 0s were returned. */
> >  	cros_typec_parse_pd_identity(&port->c_identity, disc);
> >  
> > -	if (disc->identity_count != 0)
> > +	if (disc->identity_count != 0) {
> > +		cable_plug_type = VDO_TYPEC_CABLE_TYPE(port->c_identity.vdo[0]);
> > +		switch (cable_plug_type) {
> > +		case CABLE_ATYPE:
> > +			desc.type = USB_PLUG_TYPE_A;
> > +			break;
> > +		case CABLE_BTYPE:
> > +			desc.type = USB_PLUG_TYPE_B;
> > +			break;
> > +		case CABLE_CTYPE:
> > +			desc.type = USB_PLUG_TYPE_C;
> > +			break;
> > +		case CABLE_CAPTIVE:
> > +			desc.type = USB_PLUG_CAPTIVE;
> > +			break;
> > +		default:
> > +			desc.type = USB_PLUG_NONE;
> > +		}
> >  		desc.active = PD_IDH_PTYPE(port->c_identity.id_header) == IDH_PTYPE_ACABLE;
> > +	}
> 
> So you save it but what happens with the value?

The type C connector class framework exposes it via syfs to user-space when we
register the cable via typec_register_cable() in patch 4/6 [2].

I'll go ahead and CC
you and linux-usb on the entire series for the next version.

[1]: https://lwn.net/Articles/585782/
[2]:
https://lore.kernel.org/lkml/20201106012758.525472-5-pmalani@chromium.org/

Best regards,
