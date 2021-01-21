Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A842FE1E8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbhAUFmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbhAUFfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 00:35:11 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB528C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 21:34:29 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 31so632058plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 21:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BZJRlF7u0VCjyl764v54L9KZQYrS2OHYWTQUXDooLZI=;
        b=LxZ6thPWna9By4NO2WlAw0SS16XiHyUBBKlg4ro7OUkmd1z+IZe0XQLAUMx6D0e6JW
         hYgrS5zSzSSyGjaNQ6pHCh10IBu6zmHkl2dFxIyWWXgN8WUC4TfvmRaXpID0t8ZAKBED
         qpUug6hjqz/6Ntl/qw4DpFr5XSgikzUY2HPdfZyx+dPu3R/tOn3bMORengryHAueoHqU
         MD+xpMw/Ijdq51ZJ4DH8K8a5AP7X6pv2kmG11OxOz+WiTGtIC2UGJo2DDajsjN/x6jXT
         ffnOgPmYaKMU1I35HH27380UZLPO0ZzIXpiNdEOdfuO9Ybebb525Xzi+OEEWODKBgirb
         bu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BZJRlF7u0VCjyl764v54L9KZQYrS2OHYWTQUXDooLZI=;
        b=SoPu8glEEYFqF+hXyIkHKz16OqTq7fbp8ztFGd/3IYe3rFzY8vmA6NzFzYK6LtPLdb
         0j1qi2md22GORlLwqO1+Opl2KsW2FNoF9VadeT/FY+JmH9xK6YaOUhgn5Uj+fde+GlN0
         SSUSFesqv2tKoQ+OGDcd1utpJVti7gGrnM7Oe06BZaBGILRl6Y/1LCK/2eut/m5tT9yw
         kOPP8xEvdhpAOZxx27VPyNlTqJs8Cbdh8WeDhBkljFEoo5MsRNN8LQ3k9mEi1pZq5G+S
         bpVpO8tvuu8ckYsT5KplibUW1MLfBp8yJTRib0xK8rdbe8/Bv3yC+dlbuJRcO65iHXJa
         TLFw==
X-Gm-Message-State: AOAM531P2i89MIFpBs8gBp5ttsrUchlqiz+5Avdi9cnzwqpMHBzqTRcO
        cxw40ldyTeTLIwpZe/VJm35nlw==
X-Google-Smtp-Source: ABdhPJxonNOSk9WeDiYGITO5kswMBx9yLzWy4AQ5Hc1gjDmVAA8wziho1f1SPLbr6KCRCqI6/yPzyg==
X-Received: by 2002:a17:90b:4005:: with SMTP id ie5mr4042555pjb.104.1611207269303;
        Wed, 20 Jan 2021 21:34:29 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id gb12sm1671069pjb.51.2021.01.20.21.34.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 21:34:28 -0800 (PST)
Date:   Thu, 21 Jan 2021 11:04:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org
Subject: Re: [PATCH V5 5/5] of: unittest: Statically apply overlays using
 fdtoverlay
Message-ID: <20210121053426.4dw5oqz7qb4y7hvm@vireshk-i7>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
 <696c137461be8ec4395c733c559c269bb4ad586e.1611124778.git.viresh.kumar@linaro.org>
 <20210121005145.GF5174@yekko.fritz.box>
 <7d6adfd9-da1e-d4ca-3a04-b192f0cf36b0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d6adfd9-da1e-d4ca-3a04-b192f0cf36b0@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-01-21, 23:14, Frank Rowand wrote:
> It is a convenient FDT to use because it provides the frame that the overlays
> require to be applied.  It is fortunate that fdtoverlay does not reject the use
> of an FDT with overlay metadata as the base blob.

> This is probably a good idea instead of depending on the leniency of fdtoverlay.

I believe fdtoverlay allows that intentionally, that would be required
for the cases where we have a hierarchy of extension boards or
overlays.

A platform can have a base dtb (with /plugin/;), then we can have an
overlay (1) for an extension board (with /plugin/;) and then an
overlay (2) for an extension board for the previous extension board.

In such a case overlay-(2) can't be applied directly to the base dtb
as it may not find all the nodes it is trying to update. And so
overlay-(2) needs to be applied to overlay-(1) and then the output of
this can be applied to the base dtb.

This is very similar to what I tried with the intermediate.dtb
earlier.

-- 
viresh
