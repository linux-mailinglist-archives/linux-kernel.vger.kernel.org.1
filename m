Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F2727BAB8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 04:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgI2COl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 22:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgI2COl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 22:14:41 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C886C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 19:14:41 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t14so2561650pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 19:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NJyfJV0mLhvnopBF7R+bmMKM4pD4/rdCgYSx26wTIQQ=;
        b=WeX9L69GnQyTFblx+JruceS9uLJZT3wTAfEH06yPM7treyDdXRmMfVSB7sqs09v5qk
         fDdfP3kdprwfjBcjC5USwBtO+LCxvGMufjgkvMSIduvWiEIQQ7sfgtd3JznTK9ZhLgzw
         LH2IMDposzLFHkQPVNm8IMBPCaSnwavCQJAqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NJyfJV0mLhvnopBF7R+bmMKM4pD4/rdCgYSx26wTIQQ=;
        b=s8OsvR/CARDOga3DZcuhRYpJKOjxZIp0NRUFqu5Ma9cV1h0GWhVkQAJtOwdFMoAa8y
         b8/wna403dnpTrO+35h/B2gJcsux49EkcPD1E1Sn3ppzYxcVcO92S6UpmCIxix8Lf/dX
         fMu0niQ0BSF1TrBFQiQ6j0o7W6C5iKfl2q5UL/NX+/dKkfbgxNilp22tZ7YCfjCSeFCC
         XT1oOYM1Nzl1Dpa/R6/YLe5q7yqj0z9/7CFYByUs58IjHS9J2IUynRErv5Xq9SAFgk1j
         xdmeqoGg8JQtB+PNt+X4TelFtELU890FPfrkcURa/zTewAwxN53wHiTys1ugfHp+9G7b
         7GZA==
X-Gm-Message-State: AOAM531gLp0tB0/baE5Feg2M1K56RgZoa79u7kUoNADcjx95Mge7KjAp
        dR1mZ6z6c8MOqWhFuvrqo0OD3A==
X-Google-Smtp-Source: ABdhPJzxfQrnv9qqyOeEAlNcjoz6xg6zHl6YLNk0ci2aubO4kcV3KSuIPgoUGDlZ1pvgC8UfFJSDpg==
X-Received: by 2002:a17:902:a713:b029:d2:6356:8761 with SMTP id w19-20020a170902a713b02900d263568761mr2200547plq.77.1601345680707;
        Mon, 28 Sep 2020 19:14:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id l13sm2830722pgq.33.2020.09.28.19.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 19:14:40 -0700 (PDT)
Date:   Mon, 28 Sep 2020 19:14:39 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add binding for discrete
 onboard USB hubs
Message-ID: <20200929021439.GC1099144@google.com>
References: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <CAD=FV=XWphkhFmEk6dzGn7h2mY5xBHY554rOfn+bSi5Nci27gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=XWphkhFmEk6dzGn7h2mY5xBHY554rOfn+bSi5Nci27gA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 03:13:26PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Sep 28, 2020 at 10:14 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > +examples:
> > +  - |
> > +    usb_hub: usb-hub {
> > +        compatible = "realtek,rts5411", "onboard-usb-hub";
> > +        vdd-supply = <&pp3300_hub>;

I will admit that using the name 'vdd' for a sole supply is somewhat
arbitrary, if anybody has better suggestions I'm open to it :)

> > +    };
> > +
> > +    usb_controller {
> 
> Super nitty nit: prefer dashes for node names.

ack

> > +        dr_mode = "host";
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        /* 2.0 hub on port 1 */
> > +        hub@1 {
> > +            compatible = "usbbda,5411";
> 
> Presumably we need something in the bindings for "usbbda,5411" ?

I'm not sure how this should look like in a .yaml. Rob, do you have any
suggestions?

Strictly speaking the compatible string isn't needed, the driver will match
the device without it based on VID/PID and the port.

> > +            reg = <1>;
> > +            hub = <&usb_hub>;
> > +        };
> > +
> > +        /* 3.0 hub on port 2 */
> > +        hub@2 {
> > +            compatible = "usbbda,411";
> 
> Presumably we need something in the bindings for "usbbda,411" ?

ditto
