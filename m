Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659B827B865
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgI1Xnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgI1Xnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:43:42 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824C4C0613DF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 15:13:41 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id x203so1737756vsc.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 15:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m8BYx0WkoWgdHVH2dPVlZsYwU7RwXyK6H4QoTRAqX6c=;
        b=TSmFxQCggv2HBOhytrDlGhImhekd6aLI0sbFHWM4gaZ7w70MENTGQer0SSKJHDwy/d
         KY5kZ5LVy0ZiLckrZ9i3mENPAVAayYpYUzSfJt4ti0sQhySay3VPyd68nSxUtevR0TLS
         sf8vs50LVtxk9CkoXLDOoxbcYzL50yRaveDLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m8BYx0WkoWgdHVH2dPVlZsYwU7RwXyK6H4QoTRAqX6c=;
        b=tcjmHSApTMwIg0EZIwZiP6mamJvYBo/RyN9VoGGzHAAliE8osuzNon69JvW3mmzWUh
         N7k99MmS+y7lzQMDi2I/Le3Rhx1SQUlses9oEbDFt3lTrRZJBP7R0/vx76viRPC++usJ
         48yP0i7ua5LEnFiijyXHdEk6JeHf4frvEtrADziayWRY35fVsm6fgCZUwAglO6iiSfA/
         evFfauY9UZnc/RIJWGCnbh6GLuhn9UI3a8ootACN64EZI2l/e0LtfzcDJmEAV1efenVv
         ypo+taQkjND9p5Jo1NDlzVBux7SOwM8HleVM4GWJfB15+erJ84zgE3tIQy0WbY1pvYdu
         535w==
X-Gm-Message-State: AOAM532k5AMlWkThMCCFy5ZS24CAp9fNXxzdCp9yQRvRPWAhlysfTt6d
        OMXvu7f+3Ayr1hPg29gRrOz3gCte7JtSeQ==
X-Google-Smtp-Source: ABdhPJyuZO3FxGimziiYkOavT+08TPJjKHH1uHpQ6PE7tFSoWGc+6FiND8c/X9NY+Kbb8KG6+RrYiQ==
X-Received: by 2002:a67:7cc6:: with SMTP id x189mr1404306vsc.20.1601331219379;
        Mon, 28 Sep 2020 15:13:39 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id w186sm314499vsw.1.2020.09.28.15.13.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 15:13:38 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id j3so1755318vsm.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 15:13:38 -0700 (PDT)
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr1297894vsp.34.1601331217905;
 Mon, 28 Sep 2020 15:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
In-Reply-To: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Sep 2020 15:13:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XWphkhFmEk6dzGn7h2mY5xBHY554rOfn+bSi5Nci27gA@mail.gmail.com>
Message-ID: <CAD=FV=XWphkhFmEk6dzGn7h2mY5xBHY554rOfn+bSi5Nci27gA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add binding for discrete onboard
 USB hubs
To:     Matthias Kaehlcke <mka@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 28, 2020 at 10:14 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> +examples:
> +  - |
> +    usb_hub: usb-hub {
> +        compatible = "realtek,rts5411", "onboard-usb-hub";
> +        vdd-supply = <&pp3300_hub>;
> +    };
> +
> +    usb_controller {

Super nitty nit: prefer dashes for node names.


> +        dr_mode = "host";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        /* 2.0 hub on port 1 */
> +        hub@1 {
> +            compatible = "usbbda,5411";

Presumably we need something in the bindings for "usbbda,5411" ?


> +            reg = <1>;
> +            hub = <&usb_hub>;
> +        };
> +
> +        /* 3.0 hub on port 2 */
> +        hub@2 {
> +            compatible = "usbbda,411";

Presumably we need something in the bindings for "usbbda,411" ?


-Doug
