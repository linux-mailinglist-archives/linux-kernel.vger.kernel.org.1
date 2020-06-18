Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2101FFAB8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 20:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgFRSFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 14:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgFRSFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 14:05:01 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232DBC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 11:05:00 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w7so5620261edt.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 11:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qsN49f4hirUtdZmYoS95c5NGD88R+Y70UvHP8YntzlI=;
        b=OYeM9Z28ushTDNsydouA7yjX+3/+GDzVKigOwo86UF1VY3TrAFG+/GFi7Ai/dW6Maa
         nIklrhk/iNEJnbtakdCuWMju6omiuJkmOOywCP/eg52D98SkQ6klkBcV23zhjsj8uQth
         ZflAUZJFpcdMBUpV4P9WSsWlLGRItxpyxwngLlfnZGYG9f3IzbwLBqGBk4b6QU0APhfC
         Fekb6MfCzZOhcCVlJYXs4eRp+ZXgd+8ct78fnsFesoJhAogKShnZEYhrMFltZ0B08fRx
         huH4IvOX94ERPAcwL+8ltIN72DPrgfp+1GQNDwItB/hc5Y9MoJV2Df9nlg2FrLm9UAfb
         bS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qsN49f4hirUtdZmYoS95c5NGD88R+Y70UvHP8YntzlI=;
        b=AysnjO48CV1Wfau5DujpcpMY4ekUx353e91pN4YDHNWW+vfQeSd9LTWqbk9COlalpC
         uJ+4kRNGNLLX2aFXBGtX14o7w95Fi+JRCekYs8j1PhO2P9lfLaCr4uT1Q5ilGShC3dcp
         rvJfxYwEQ1jUJGvSlFlZxXUWMzwaun8D2PWJAHSdDn9OdQgRgjjAIJ94szV5ULBWcVDL
         oGXIVOL6v8+VtbXGlD/LSZUP3GWa274KFUrP1Pb9Lz41o0MTNrwrIfDtpdak1PlIpEBC
         SID9rgkYfwfJQE1BLexDT9JuWhKh9gQ1EFAt2RA8uUv8SChLk8c8789VrX8JVZXsWtaE
         ystQ==
X-Gm-Message-State: AOAM531KOEIIgoaKe+5+bDiJBk9JKO6XD31UFTEOzEHtjK0iW9FE2IEu
        n43AHBc4/32DvtZ84hAoQgSwSA==
X-Google-Smtp-Source: ABdhPJwQl77DM21JWoNWOj0+8epK/6Y/CwEYYomQcTvPKHlc7pG4NTpS4ocpujLs1ENnB+e8RQHV6w==
X-Received: by 2002:a50:f106:: with SMTP id w6mr5314129edl.131.1592503498760;
        Thu, 18 Jun 2020 11:04:58 -0700 (PDT)
Received: from x1 (i59F66838.versanet.de. [89.246.104.56])
        by smtp.gmail.com with ESMTPSA id r6sm2718734edx.83.2020.06.18.11.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 11:04:57 -0700 (PDT)
Date:   Thu, 18 Jun 2020 20:04:54 +0200
From:   Drew Fustini <drew@beagleboard.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] arm: dts: am335x-pocketbeagle: add gpio-line-names
Message-ID: <20200618180454.GA58092@x1>
References: <20200609142504.GA2955236@x1>
 <20200617170915.GA4185472@x1>
 <20200618170345.GI37466@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618170345.GI37466@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 10:03:45AM -0700, Tony Lindgren wrote:
> * Drew Fustini <drew@beagleboard.org> [200617 17:10]:
> > Tony - does this look ok for 5.9?
> 
> Yes looks OK to me.
> 
> Just wondering, are the line with "NA" not used internally either?
> If the "NA" lines are used internally, we should probably use
> "Reserved" or "Internal" or something like that to avoid later
> on having to patch them with internal device names..

There are many more 'no connects' as the PocketBeagle is much simpler.

There are 12 SYSBOOT pins which just go to fixed pull-up and pull-down
resistors.  I'll change those from "[NC]" to "[SYSBOOT]".

Also, after going through all the enteries again, I noticed 4 lines that
I mislabeled.

I will post a v2.

> 
> > If so, I might start making other variants like BeagleBone Blue and
> > BeagleBone {Green,Black} Wireless and submit those when ready.
> 
> OK yeah makes sense.
> 

thanks,
drew
