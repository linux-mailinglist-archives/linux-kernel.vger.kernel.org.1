Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B472D6C46
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 01:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391680AbgLKAFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 19:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391144AbgLKAFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 19:05:02 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67F4C061794
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 16:04:21 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id 4so3672268plk.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 16:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b2XTJ2x1R5xZ66SbR6h8AXcrLWdEHj5DcH/Iefxf3Q4=;
        b=A6zhZ98vZGmItk5taUTdALx1iCQa4bkAu5yRxF7XMlMpPfaAl3DjI4p5UuQZmHIZ/D
         WFSXBA8a8EBHTXa+lsbCQchI7YzHLz3FCzvkEjRJFxr15i1NpGIJKEyuv3Uw0Af2SSN3
         sKdgmPz0mX5mFDX9mDh7g/YTP5R3OdXNL0v4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b2XTJ2x1R5xZ66SbR6h8AXcrLWdEHj5DcH/Iefxf3Q4=;
        b=MJ3ThIhkfIUCIQ0byDrCwECsKz4h5/hQHswl1aY5tZ48n3H5yn1D9KkseyFXmk2luZ
         /rp/iZj2RQxyuAVMorxMpAEEZq6LNot007mZgDG13KGVIGPzUynDsQ3mSvcHDEwIHsx3
         Q66R+/xgactMEg7Y4gFPNzeDP2NcrdPnOSEkYA5UMpbdm/839OhdOgLZQgdoplSdKrgn
         6gQRbj6q0U7MXrHbm9m8yfdk3knfmKeb8SgQDPC7imK1fJzohFgjHtw3HG4gQa8UVUF/
         vG2zjSOpgPBzWSml86tq5PDFsOWu2ieqHcFDjVmPaSVmMcFKuH4lDVATmD5rl9dA9v4J
         +bCg==
X-Gm-Message-State: AOAM530Or0gwTe4Wy9keRo9RlRngbT103HRTAoCXBU5JlXxwEgvWIZnQ
        d1e4F1f2XunjnQBrumNyB3QheA==
X-Google-Smtp-Source: ABdhPJxyhOBKJYPnjJ2YBaiGRbHpCYt2SPOTE6oOxM3QEzT7GA+QV4XtrAXTGw0GM3YW5kVkUAfTgw==
X-Received: by 2002:a17:902:c584:b029:da:cc62:22f1 with SMTP id p4-20020a170902c584b02900dacc6222f1mr8466785plx.54.1607645060625;
        Thu, 10 Dec 2020 16:04:20 -0800 (PST)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id er23sm7837321pjb.12.2020.12.10.16.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 16:04:19 -0800 (PST)
Date:   Thu, 10 Dec 2020 16:04:17 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     mgautam@codeaurora.org
Cc:     Sandeep Maheswaram <sanm@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] usb: dwc3: core: Host wake up support from system
 suspend
Message-ID: <X9K3gXAgUW/6o9dr@google.com>
References: <1603831083-2025-1-git-send-email-sanm@codeaurora.org>
 <1603831083-2025-2-git-send-email-sanm@codeaurora.org>
 <bca7bd32710a118d3583dd4e740ef3e0@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bca7bd32710a118d3583dd4e740ef3e0@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 28, 2020 at 08:01:31AM +0530, mgautam@codeaurora.org wrote:
> Hi,
> 
> 
> On 2020-10-28 02:07, Sandeep Maheswaram wrote:
> > Avoiding phy powerdown in host mode so that it can be woken up by
> > devices.
> > Added hs_phy_mode flag to check connection status and set phy mode
> > and configure interrupts.
> > 
> > Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> > ---
> >  drivers/usb/dwc3/core.c | 14 +++-----------
> >  drivers/usb/dwc3/core.h |  2 ++
> >  2 files changed, 5 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index bdf0925..0e4bc1e 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1672,10 +1672,6 @@ static int dwc3_suspend_common(struct dwc3
> > *dwc, pm_message_t msg)
> >  		dwc3_core_exit(dwc);
> >  		break;
> >  	case DWC3_GCTL_PRTCAP_HOST:
> > -		if (!PMSG_IS_AUTO(msg)) {
> > -			dwc3_core_exit(dwc);
> > -			break;
> > -		}
> 
> 
> This could be a problem for platforms that don't support runtime_suspend
> and rely on dwc3_core_exit to power-down PHY.
> IMO you can continue to do dwc3_core_exit() if runtime_pm isn't enabled
> for the device.

This would imply that USB wakeup isn't supported on such platforms, right?

Could we have a flag that the dwc3-<glue> driver can set to indicate that
wakeup is enabled for this suspend cycle to omit the PHY power-down?

> > 
> >  		/* Let controller to suspend HSPHY before PHY driver suspends */
> >  		if (dwc->dis_u2_susphy_quirk ||
> > @@ -1733,13 +1729,9 @@ static int dwc3_resume_common(struct dwc3 *dwc,
> > pm_message_t msg)
> >  		spin_unlock_irqrestore(&dwc->lock, flags);
> >  		break;
> >  	case DWC3_GCTL_PRTCAP_HOST:
> > -		if (!PMSG_IS_AUTO(msg)) {
> > -			ret = dwc3_core_init_for_resume(dwc);
> > -			if (ret)
> > -				return ret;
> > -			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
> > -			break;
> > -		}
> > +
> > +		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
> > +
> >  		/* Restore GUSB2PHYCFG bits that were modified in suspend */
> >  		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> >  		if (dwc->dis_u2_susphy_quirk)
> > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> > index 74323b1..da63d4a3 100644
> > --- a/drivers/usb/dwc3/core.h
> > +++ b/drivers/usb/dwc3/core.h
> > @@ -1101,6 +1101,8 @@ struct dwc3 {
> > 
> >  	bool			phys_ready;
> > 
> > +	unsigned int            hs_phy_mode;
> > +
> 
> This change should instead be part of the other patch ?
> "usb: dwc3: host: Add suspend_quirk for dwc3 host"

+1
