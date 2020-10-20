Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AAD293C03
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406433AbgJTMmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:42:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36089 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406275AbgJTMmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:42:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id e2so1719687wme.1;
        Tue, 20 Oct 2020 05:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TAVX8VJqdu8cm48vulsFemIl4/HIDhsviNkB/yLnP7A=;
        b=RleVexZ18nbhBcpjk5XDKIQQt1s0Fl4RchywGlPSaSIKbULvtZstuti8DfOOmy7YRz
         lSQT6qrN9b1u4QEaOL3g/bL6kQ4KU9OIItVjkV+JVNIG7Ok/mkvMnT5GM2euP2D4msSw
         hWg7pkmBgTmH0OWetn3ki7aVo0MccIV/yxWBjGiq1xw/ge4gsDFlQdIbCWaSzYbPJqgY
         Yfp44Y8XNqTPgb9v8Q6n2AARe70V1pHs9VcPxFUkVy/ymy1iE2SWLd41pWv+r6+fgC9x
         eZ5C+0GTt0W2DDPmF26M2FvFrRXsJlDvegXWbP7nBbOxXr+ASoBrv7X/FhUyJ5Qrb6ZJ
         m1Lw==
X-Gm-Message-State: AOAM530K5RH+i7MBH7IQ2OaSFYfdHqzUJtHAszM/h1N4pY7MeR6qIL+w
        T53lUCJsav5/otvMEfeoDoU=
X-Google-Smtp-Source: ABdhPJy59H5xlrK2/ydGIdjf7RXmKyrFx3WD+dvAOYos8me6/lyOSubpK6L+TOWcQbD5EbVpfHyVRw==
X-Received: by 2002:a1c:6856:: with SMTP id d83mr2824414wmc.71.1603197769542;
        Tue, 20 Oct 2020 05:42:49 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id x1sm2864683wrl.41.2020.10.20.05.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:42:48 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:42:46 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/29] arm64: dts: apm: Harmonize DWC USB3 DT nodes name
Message-ID: <20201020124246.GT127386@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-26-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-26-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:55PM +0300, Serge Semin wrote:
> In accordance with the DWC USB3 bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> named despite of the warning comment about possible backward
> compatibility issues.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 4 ++--
>  arch/arm64/boot/dts/apm/apm-storm.dtsi     | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
