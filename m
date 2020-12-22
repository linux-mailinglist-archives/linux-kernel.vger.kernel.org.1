Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B722E0393
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 01:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgLVAqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 19:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgLVAqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 19:46:21 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2332C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 16:45:40 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id j1so6536286pld.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 16:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vguIITGYik298tZjiRhsb9faiY6NgmDMyom+xtgPKKU=;
        b=krA8Jx27hTvRfr1bEBDRfKptm2xC8I/6gjD2XRUXKAFxLBiZ5SYGPo+I7DLaFKO+km
         RgcJdjJaaXA9UbSYOTGjGMyCS2s3+GWyeJMniMEx9RQS6Qz/REfd107sUd9adxLbD76B
         YIqssSk9wHPZzVgXCG7Xwcs0Gq1q5vJusqTQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vguIITGYik298tZjiRhsb9faiY6NgmDMyom+xtgPKKU=;
        b=V9i/VqS+den3gBzdwrDEkErovvk+fylZ8qMGmykFFPm+6V8SKq8Da7/IYRAFOAsZ8s
         3Ey9essJ8g/AMUgz8HSL2DG6TaxKb2W96lC/U0XXsrKg6b73PKreViShdi+YSTUPiYOS
         O6v0JlvkqOkjhNTCZhzV4PWBSEhu6TydeZdHvoIOlNW6CSrvND/bWUvAg5QSK4epg9g+
         haVXaxD9WhEWvmmEeX7TU6LdeBmcJx+ak1VgZxiAm42/09bzsAhl3Lg+lwa1HdtPcGo6
         7I9EHrZ5d5WdGo2gnEU7SKe0WYUoCBF/XFYpKwMxKe65hhL0NLusG3QhPFh7yRmtvuIj
         v7qQ==
X-Gm-Message-State: AOAM530S++k6k8yHMFIGuZCzjBrfBCcu2N1PMtvATr0e9D6BnqZ4lCO1
        5c9Ta17V5VenqM8FsZryXEyvQQ==
X-Google-Smtp-Source: ABdhPJy/s4Ym9J+sghrKuHZstUVRTTXvDD+/M+1lOVT+m75qrhHrPrwNe1K0UVpK7eQfo2rNc1uajQ==
X-Received: by 2002:a17:90b:388b:: with SMTP id mu11mr19901275pjb.17.1608597940448;
        Mon, 21 Dec 2020 16:45:40 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id ci2sm16172825pjb.40.2020.12.21.16.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 16:45:39 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:45:38 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, enric.balletbo@collabora.com,
        bleung@chromium.org, heikki.krogerus@linux.intel.com,
        rajmohan.mani@intel.com
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_typec: Send mux
 configuration acknowledgment to EC
Message-ID: <X+FBsu+VNsEJlgBp@google.com>
References: <20201210060903.2205-1-utkarsh.h.patel@intel.com>
 <20201210060903.2205-3-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210060903.2205-3-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Utkarsh,

On Wed, Dec 09, 2020 at 10:09:03PM -0800, Utkarsh Patel wrote:
> In some corner cases downgrade of the superspeed typec device(e.g. Dell
> typec Dock, apple dongle) was seen because before the SOC mux configuration
> finishes, EC starts configuring the next mux state.
> 
> With this change, once the SOC mux is configured, kernel will send an
> acknowledgment to EC via Host command EC_CMD_USB_PD_MUX_ACK [1].
> After sending the host event EC will wait for the acknowledgment from
> kernel before starting the PD negotiation for the next mux state. This
> helps to have a framework to build better error handling along with the
> synchronization of timing sensitive mux states.
> 
> This change also brings in corresponding EC header updates from the EC code
> base [1].
> 
> [1]:
> https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/master/include/ec_commands.h
> 
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

I'm not sure what the maintainers' preference is for the header (same
patch or separate patch). FWIW:

Reviewed-by: Prashant Malani <pmalani@chromium.org>

Thanks,

-Prashant
