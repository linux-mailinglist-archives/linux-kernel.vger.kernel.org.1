Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61F42DAA00
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 10:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgLOJXQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Dec 2020 04:23:16 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:44308 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgLOJXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 04:23:16 -0500
Received: by mail-ej1-f67.google.com with SMTP id w1so21967659ejf.11;
        Tue, 15 Dec 2020 01:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/9w385wlUATcbu/BRZ3nKfi6j/KecII4JZgpQFtJQ+4=;
        b=ojHZT36gj7j/VVTk2qtUvrO+keOkG+SnTDh68aJgooeMC1QgQNyBsIz9chBWBhz9VW
         6wSG1wjEDKmCit9Frncj9QzGMGkXP4yCzwbX35t/jZu9AsBKHIyOSkfPhSU8KPEXalnk
         XXo3OJ2U/zOWYGt6rdWrVSnG2kTP6zgotWZOokqGBvjFwr0Iyn20C41TLfBdu+PpYcN+
         RiX1CgbC7iXu1WFnNWYrEe0EFllBxOmDXbs0j25MdyHX0eSQ/36ywFonqiyXqhRJzj8o
         qMkao3p0XycF+TJT7bzxHIZzRFQgt8bTzV/vzHrd9gVbmE+Hepi79OtxONZkkEM5R0FN
         2cGw==
X-Gm-Message-State: AOAM533BneMGda372xhb/CEz/alE4oec5b8RrA30b1iHfV36UdHJUwQN
        Q6iMsB8Jr9Sds/+5143UnXs=
X-Google-Smtp-Source: ABdhPJzvo600kKu4UAXQhjrjOoca2NtJXg4sl6YhDNOyXY4do962Yi2coL+1zcjaWBQrQ4QHSOasjg==
X-Received: by 2002:a17:906:518a:: with SMTP id y10mr26635712ejk.323.1608024154099;
        Tue, 15 Dec 2020 01:22:34 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id p3sm943016ejx.0.2020.12.15.01.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 01:22:32 -0800 (PST)
Date:   Tue, 15 Dec 2020 10:22:31 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Angus Ainslie <angus@akkea.ca>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: imx8mq-librem5-devkit: Drop custom clock
 settings
Message-ID: <20201215092231.GF29321@kozik-lap>
References: <cover.1607879709.git.agx@sigxcpu.org>
 <3ecaf4b895deefafc3fc467e56dcff5d1afe8ac7.1607879709.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <3ecaf4b895deefafc3fc467e56dcff5d1afe8ac7.1607879709.git.agx@sigxcpu.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 13, 2020 at 06:17:14PM +0100, Guido Günther wrote:
> Otherwise the boot hangs early on.

And previously it was booting or maybe never tested? Maybe the issue is
actually different, e.g. you miss some power domains?

Best regards,
Krzysztof
