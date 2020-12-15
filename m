Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BE42DA9FD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 10:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgLOJWW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Dec 2020 04:22:22 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:34314 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgLOJWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 04:22:00 -0500
Received: by mail-ej1-f65.google.com with SMTP id g20so26662538ejb.1;
        Tue, 15 Dec 2020 01:21:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=//FALzxYbFGtEUMe6jBU4ORRGeka+rMPtH7D3TvmPhI=;
        b=KzRZ0ci0o8KYvX0m5dJelCZS8OitT1GiAlgnM30F9xh1oZf5TptSjH52UjPTHpBksa
         Yv+Px1rqp7mea2SQ4xmJVmjn2AtCRHlNL2e0tynnSjs5QdAOaHEwkuvQmUqQlTwY6dBR
         Z4GYpk6rYn49zgNuKjl4EfRABIR4TnZA0EAYaaimuWZBN2NR9N7sNmea7oqRv+ZtGEEA
         KQBIrHvsKMTNztwH+OSVz9a8u5U9K5LULjgxEGvJvHGR5Ys38ZFnVOPaZlLle6t1YADE
         MMZdlbKN+7MmXCQnXgu0Qrx6Tw8Uo51HLU1lQE+N8qAZBna05NGYCmxfH2MvbloVqHoU
         Vbag==
X-Gm-Message-State: AOAM531JrPVX3FuQoOnWEVBOM/so05KUKvnHo9vpaXDicxtqE7L5veGQ
        nwUvRuOrqUf6w0jcTT4NlSM=
X-Google-Smtp-Source: ABdhPJzaooja2f1mG2FlaNQPLp6j25k/Vu0TYaMqLxI0n4BCbaJz6RRJtD58j0j8ybZg/jVvqNW3GQ==
X-Received: by 2002:a17:906:7f0b:: with SMTP id d11mr5596470ejr.7.1608024078847;
        Tue, 15 Dec 2020 01:21:18 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id d18sm17778233edz.14.2020.12.15.01.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 01:21:17 -0800 (PST)
Date:   Tue, 15 Dec 2020 10:21:16 +0100
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
Subject: Re: [PATCH 3/4] arm64: dts: imx8mq-librem5-devkit: Mark more
 regulators as always-on
Message-ID: <20201215092116.GE29321@kozik-lap>
References: <cover.1607879709.git.agx@sigxcpu.org>
 <7adc87ee6a5aea7b7d635ce1a0fbc4e2d8def7ed.1607879709.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <7adc87ee6a5aea7b7d635ce1a0fbc4e2d8def7ed.1607879709.git.agx@sigxcpu.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 13, 2020 at 06:17:13PM +0100, Guido Günther wrote:
> They power vital parts of the board and low power consumption is not
> really an issue here. It also brings things more in line with what
> Purism is using downstream.

I don't find it a proper explanation.  Not all regulators power vital
parts of board.  Having regulators always on makes people to skip adding
proper supplies thus not describing the HW properly.

Aligning with downstream without clear reason (just because) is also not
a good reason.

Please reduce the choice only to core regulators or describe it really
why they have to be always on.

Best regards,
Krzysztof
