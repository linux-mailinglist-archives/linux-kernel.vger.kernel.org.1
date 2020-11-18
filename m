Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7392B83FB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 19:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgKRSjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 13:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgKRSjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 13:39:31 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44C4C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 10:39:31 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id r9so1479781pjl.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 10:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IS8KqvtGpvchc3pdVmAI45zcVonfW9i7VEyA+0SXwEk=;
        b=KHZ7aizcPD3KFmUYyRLDRAPwX+xZUdeK+inF8t7KSoc8CIO2d4OrwpEDRaX7ZCdzX1
         5ntmaT4E4o50mHiPmm5ata9Fisx1PUskkp25ZUSja6PM2ymMfGTRg8TzsjK9yYeZtLWU
         9FOGPj9Cu5T0uWyKt8rbLtnlAKuJJx5IdNhZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IS8KqvtGpvchc3pdVmAI45zcVonfW9i7VEyA+0SXwEk=;
        b=gcFV1MmdlhzTDHmLshuCIt2yWJ3ift8q6Fwz4X6b4hNETyU40QIe7vOSVpt6E0UOHx
         rWFvGrU0clZQTjOWPNPFwIz7TX7dSxGihIFP9Py38s4odVZyUoKum2XqNvxlhTPQS55/
         V83Du7KKnOy/KCiZJv3A7AQo5sBReok/vTEXOmFlFfeqSME35dXv9/YpisFD9+S1sbqS
         AJgLDIElwSkxf32+rYrENff5WRa2VyaHDr/zsIbbFKZR9kWMEtkogpPsyLWXXBlFqScQ
         0bANkLoyWQwvEtm6xxC3zGUHwdq6FAxs3NCsIRNP7ZPBBeArrf7a+M03D0uKMpDBAtMe
         j2gA==
X-Gm-Message-State: AOAM531Az6htR5mi6W0WU+RMfCrxKc3uzHPIaTCQDhNySrIml/Dh03sq
        IenBtATNucgDcy5Uj7IVEy3kjA==
X-Google-Smtp-Source: ABdhPJweHbHek1SIEw8iwFk9D76M1BOkOrOl/RQAY4++lcIH3vB9PS5TWTzt0p0LaAQdaxqaD7xCUA==
X-Received: by 2002:a17:90b:93:: with SMTP id bb19mr394736pjb.102.1605724771392;
        Wed, 18 Nov 2020 10:39:31 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id 12sm3376992pjt.25.2020.11.18.10.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 10:39:30 -0800 (PST)
Date:   Wed, 18 Nov 2020 10:39:29 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] usb: typec: Product Type time
Message-ID: <20201118183929.GA3652649@google.com>
References: <20201118150059.3419-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118150059.3419-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

Thanks for developing these patches :)

On Wed, Nov 18, 2020 at 06:00:56PM +0300, Heikki Krogerus wrote:
> Hi Prashant,
> 
> The original discussion [1].
> 
> This proposal is in practice a compromise. I came to the conclusion
> that we probable should expose the product type separately after all.
> The reason for that is because we may in some cases actually know the
> product type even when we don't have access to the Discover Identity
> response. UCSI for example in practice gives us at least the cable
> product type even though it does not let us know the response to the
> Discover Identity command.
> 
> So my proposal here is that we add an attribute for the product type
> itself, showing the product type as a string. Then we also add the
> attribute for the product type specific VDOs which we place under the
> identity directory more or less the way you originally proposed.

Sounds good to me.

Best regards,

-Prashant
