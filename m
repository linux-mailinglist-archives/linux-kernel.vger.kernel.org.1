Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FD52314D9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 23:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgG1VhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 17:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgG1Vg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 17:36:58 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B61C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 14:36:58 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k13so2911053plk.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 14:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I+u/jJVuOl4Tt6bR3GTQhwRJ5pXoO4J/DZnB10u/ssM=;
        b=TkMDP6ZegCZZNlpwjtYuA8ZS26v7I0GINLRYmD9+VVPyJxGU4qqF0jBKA0KUtU8zsR
         pdq8UKphCd3tm8HkiOdI/Jzz5N5s+8KMykbwbbXPR0dBxB8eZmXveaSZ7Ju5PM9V8T30
         216DlgoINignBaCoz6GO0or5gplDbj9afLAH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I+u/jJVuOl4Tt6bR3GTQhwRJ5pXoO4J/DZnB10u/ssM=;
        b=kebxP5BZUOpwLSaRIcl9Ie+f/pBU4Tw5n94+NuEFuMW8wOrOsdJIQRgMB8F8b1xiqE
         mEcOxUV38fwvGke9Smvx4ihcAfJxBJERTmBzSxxBuEpqK8cdzphr/T0aN1dkDS/uHmgI
         nouhGvwMrm9TvWGlSQI1FFQCa4jhzcvGCm2toz95ccBsuglm3rmfSdEoDrg+TLeDKzhX
         e/85ohoV5rYjsbANymJ2GFrjm94nUAwmcye3tkdiLF1uUt9Ll6lfIyJI+bMZdxttTz/P
         zaFKOFO3Qu58u61l+GeCQyRwuzWESoJnxks0cEUsev1KJ4xvOfd9IeWvl8LOuDPGLGuG
         bo4w==
X-Gm-Message-State: AOAM532S6Mab19GNFOcFJFxP2chlsYMHYKaRGwiIpzc9OCMnaHdeYM65
        pW178osLQb4d7NA6CP7DqdONrg==
X-Google-Smtp-Source: ABdhPJxnh+1AFY5KueYE9vINO/eArVxK/D8hyRZdUw8kcXZz+KcuYbh7GWP01/WIHIU2CsI02TEeCQ==
X-Received: by 2002:a17:90a:8e:: with SMTP id a14mr6596006pja.206.1595972217935;
        Tue, 28 Jul 2020 14:36:57 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id nk22sm73563pjb.51.2020.07.28.14.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 14:36:57 -0700 (PDT)
Date:   Tue, 28 Jul 2020 14:36:55 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Azhar Shaikh <azhar.shaikh@intel.com>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        heikki.krogerus@linux.intel.com, utkarsh.h.patel@intel.com,
        casey.g.bowman@intel.com, rajmohan.mani@intel.com
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Send enum values to
 usb_role_switch_set_role()
Message-ID: <20200728213655.GC2996678@google.com>
References: <20200728212446.2699-1-azhar.shaikh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728212446.2699-1-azhar.shaikh@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Azhar,

On Tue, Jul 28, 2020 at 02:24:46PM -0700, Azhar Shaikh wrote:
> usb_role_switch_set_role() has the second argument as enum for usb_role.
> Currently depending upon the data role i.e. UFP(0) or DFP(1) is sent.
> This eventually translates to USB_ROLE_NONE in case of UFP and
> USB_ROLE_DEVICE in case of DFP. Correct this by sending correct enum
> values as USB_ROLE_DEVICE in case of UFP and USB_ROLE_HOST in case of
> UFP.
nit: DFP
> 
> Fixes: 7e7def15fa4b ("platform/chrome: cros_ec_typec: Add USB mux control")
> Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
> Cc: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 3eae01f4c9f7..eb4713b7ae14 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -590,7 +590,8 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
>  		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
>  
>  	return usb_role_switch_set_role(typec->ports[port_num]->role_sw,
> -					!!(resp.role & PD_CTRL_RESP_ROLE_DATA));
> +				       resp.role & PD_CTRL_RESP_ROLE_DATA
> +				       ? USB_ROLE_HOST : USB_ROLE_DEVICE);
>  }
>  
>  static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
> -- 
> 2.17.1
> 
