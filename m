Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB19B2F2079
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391514AbhAKUOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:14:54 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:42048 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390529AbhAKUOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:14:52 -0500
Received: by mail-oi1-f175.google.com with SMTP id l200so638165oig.9;
        Mon, 11 Jan 2021 12:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PqsDdn5SmrDjGKECfj9VFfO8tV50Sl1kSAekhi30k80=;
        b=GdV6m7GLDHss2zXxMOUEKD4gHdEryrEONhznRpIVPbMrR7AfywVGMVj5iBVMXFHTAw
         MQPJ8/MSo2xHJhFo0SvR/V3rNglUzyYJZv3HVWP0rdaV3NENgbhYkTSW3ZySdbeyv9ze
         oMjkoiA5Ws8MObEoPkqvYbbwZQk1zG9lH9lsJtfSt7jLLOe7SbFFz4/hWGr4XFvxFlPF
         pqPZANhGPBwNYwMo8l3VMeFsXcDt7k7Z+8LI6gcEAdmBVi5yf3eKEV4k5DjPVYDKAZOc
         LX2tZSJVK4ahP2mMkzBqswvgVjmSNZWpALEJ48HPZKkoRsKj4kwi4ZPGI5yeeXPM2Ffu
         RwAg==
X-Gm-Message-State: AOAM531joh26/kjXkSULsOL23J5x+JFENQIb7CBTz5it1EYD7H9ZEnp2
        i7DrcGUTbww+BmfKmy7Yag==
X-Google-Smtp-Source: ABdhPJxLHx1AIB2D2DgNNkIRw5L0noFsccA3xq7e4xFqdBW9Wq48al3tXTZNBoyZBfWVisg9ynJupw==
X-Received: by 2002:aca:50ca:: with SMTP id e193mr330212oib.154.1610396051579;
        Mon, 11 Jan 2021 12:14:11 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i1sm168963otr.81.2021.01.11.12.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 12:14:10 -0800 (PST)
Received: (nullmailer pid 2992975 invoked by uid 1000);
        Mon, 11 Jan 2021 20:14:09 -0000
Date:   Mon, 11 Jan 2021 14:14:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: gateworks-gsc: Add fan-tach mode
Message-ID: <20210111201409.GA2992924@robh.at.kernel.org>
References: <1609183716-26529-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609183716-26529-1-git-send-email-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Dec 2020 11:28:36 -0800, Tim Harvey wrote:
> In 7497d4a66c59 ("hwmon: (gsc-hwmon) add fan sensor") a mode
> was added to report RPM's from a fan tach input.
> 
> Add this mode to the dt-bindings for the Gateworks System Controller.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
