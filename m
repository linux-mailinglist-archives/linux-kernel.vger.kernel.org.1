Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2C32E012A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 20:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgLUTjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 14:39:48 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:44016 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLUTjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:39:47 -0500
Received: by mail-ot1-f51.google.com with SMTP id q25so9829177otn.10;
        Mon, 21 Dec 2020 11:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Dsg/jChUoWSyTk5qMEaMa+qPJEAfvYynR80mwKo9kU=;
        b=Eott9HiAiYIHL9+VnlVxhmLutWdisLyNsnutgWA6TZpQ/c/pXgC2+bmNvIlnMB4kJc
         KNDNNJR3ei3oPQzxTbBGwb43NgvCYBY3xu+f5hKAYkcCAqluQpecP5s/KSWm60IPn6b8
         FB4sxsfPSJjA9YMOlkEKlSzyLG1CNAjNq3kowPlxJT4N07BQTH3GWNaILGTbPh+NL22Z
         EMZC57okmWjR4WJ7ug4I8QX1ZT/CY1K0TW9Nf9K+3EbFDVc5POJ9ndQ2KWRlRs5g+Hln
         rDB2a5ieC/c8QyHCdkWzutTk5usdO3HG2ADT54g+sgfGzG54oRtOQD+txftJDFvY3CF3
         IQyg==
X-Gm-Message-State: AOAM530tYlmOb5GkgkkNjsk8rrx4EE08XkRPb3ekdsy/KXqKHsf0Lc3b
        vBelTvxZKjLrSsX9OZn2dMdTYeCE/Q==
X-Google-Smtp-Source: ABdhPJxY0JH8jwpUE7xNwJU3ew9icbFthNj7OT3z2DiII+P59wW2WBgSONbEVPo9Tox//IOGb3ntJQ==
X-Received: by 2002:a05:6830:84:: with SMTP id a4mr13494942oto.261.1608579546634;
        Mon, 21 Dec 2020 11:39:06 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 109sm3978423otj.12.2020.12.21.11.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 11:39:05 -0800 (PST)
Received: (nullmailer pid 425375 invoked by uid 1000);
        Mon, 21 Dec 2020 19:39:04 -0000
Date:   Mon, 21 Dec 2020 12:39:04 -0700
From:   Rob Herring <robh@kernel.org>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc:     Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        kernel@pengutronix.de, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: fsl: add Webasto ccbv2
Message-ID: <20201221193904.GA425320@robh.at.kernel.org>
References: <20201216162552.9730-1-r.czerwinski@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216162552.9730-1-r.czerwinski@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Dec 2020 17:25:51 +0100, Rouven Czerwinski wrote:
> Add Webasto ccbv2 i.MX6UL based board.
> 
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
