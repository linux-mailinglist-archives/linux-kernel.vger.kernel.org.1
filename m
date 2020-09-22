Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEEA273804
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbgIVB0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbgIVBZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:25:41 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B64C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 18:25:41 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b124so10912908pfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 18:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I0eUgn+1/7SqcuhuU2PZ8mvA7ls7+b+G4GSVOgPbobY=;
        b=kg8LSqWa36Ui9Tdtw/52MLWHs/0S3TsA7XUaYFrzUiUHk0pMc0PJ4h+8QuRWbyA/KU
         lUG0m+I7x+A3iyXDQAaXbOfntCWoJtUOHWMRxcvBTjveRDhgoOZGppRilADR8nVf41uF
         n2P4kQsHz8fGes3WE9s1raOr7yalEEPejdulw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I0eUgn+1/7SqcuhuU2PZ8mvA7ls7+b+G4GSVOgPbobY=;
        b=KG9MfQ4PMPeQ+ywc1VCGOYkKCumYS4X5Wfjy2ENPJ+6bHGS4pKq+cwgXLRW69VOHPe
         rXwaqkaouA/GU6Fr8YC8EkmwH6zx07GWRVdb7yvaq5lyrYWxPGcU0y/Rq3p+Pi1yU0ja
         B/PllRKTbqpKzJz++qgNMXZMCSEszHCcvrEtwgNmIvhzo0PvxZc/384T0XwDbD4ldkmA
         hO/mAaND345Cy4sCwEW42X72TBsK8F2gr8PMBK4zR79uDybmZp1sfooNxy6RUJamEzrk
         uaVGsjss04uHMP3VXoOm57Hkv8tItcnWfvC2VgTCV+r9bBdDqC7UJFWA8iWIxnPgWq4v
         kBrw==
X-Gm-Message-State: AOAM533S3/6O6k4OFmmqnEdPlurlI67k2lSLTtdUb5rjhM+OcbT5P/QN
        abTmJHU/Wfn08G32hlnGKp08PA==
X-Google-Smtp-Source: ABdhPJygjesAPhrh79F6hkbBlCGP7bPlLKt44quSkQStNoFZ6zbETbNEnZb8C4aZ1S7dZp3yYjnj1w==
X-Received: by 2002:a17:902:b90b:b029:d1:cbf4:bcd1 with SMTP id bf11-20020a170902b90bb02900d1cbf4bcd1mr2324246plb.29.1600737940566;
        Mon, 21 Sep 2020 18:25:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id e27sm13050093pfj.62.2020.09.21.18.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 18:25:40 -0700 (PDT)
Date:   Mon, 21 Sep 2020 18:25:38 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 2/2] USB: misc: Add onboard_usb_hub driver
Message-ID: <20200922012538.GF21107@google.com>
References: <20200917114600.v2.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200917114600.v2.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200917195416.GA1099735@rowland.harvard.edu>
 <20200922004158.GC21107@google.com>
 <20200922010812.GA1238082@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922010812.GA1238082@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 09:08:12PM -0400, Alan Stern wrote:
> On Mon, Sep 21, 2020 at 05:41:58PM -0700, Matthias Kaehlcke wrote:
> > > > +	put_device(hub->dev);
> > > 
> > > Is there a matching get_device somewhere (like in _find_onboard_hub)?
> > > If so, I didn't see it.  And I don't see any reason for it.
> > 
> > Yes, implicitly, of_find_device_by_node() "takes a reference to the
> > embedded struct device which needs to be dropped after use."
> 
> Okay.  In that case it probably would be better to do the put_device()
> right away, at the end of _find_onboard_hub().

ok

> There would be no danger of the platform device getting freed too soon 
> if you make onboard_hub_remove unbind the associated USB hub devices.

Yes, I'll add the unbinding as you suggested earlier

> But there would still be a danger of those devices somehow getting 
> rebound again at the wrong time; this suggests that you should add a 
> flag to the onboard_hub structure saying that the platform device is 
> about to go away.

Indeed, we want to avoid that. I'll add a flag to the struct as you
suggested.
