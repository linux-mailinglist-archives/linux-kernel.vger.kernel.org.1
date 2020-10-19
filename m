Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BA3292D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgJSRvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:51:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36112 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJSRvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:51:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id x7so727972wrl.3;
        Mon, 19 Oct 2020 10:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2H48pFUB04Yx3mpVrK6vWlmBBdtDZ5EYUnmrXaYeElA=;
        b=Xo59NDRQaOafOXgV3wv5+JCHKuDiRZTzZ+beiRCbELvp4I7jJK74oqn1mY4vQk4R3x
         vN5o0d3e5wybJBf960uOFngbqGWMBe+MPxxpoFyG0jOYY6YiYbOVpvb+JDF/SOEmhaKd
         TujNrjR5EccTxJK2tHXLED69SXOJbFxm9Scb0cg0gSfuVPk1VHtj4vji+RNgLG3Ltlfi
         nhdm7d0f1Q/T1zYwr2CQRbyWHGpOS8iW4RAp0clNdr4MKSlCjOK3uLMx9BUvaI+RRA3m
         K7x57Qxe7ShObyZjoZc6OORGB7hWOwwCvToSAk9n3e484k6oN8+wTuVJsCdV35yN56wi
         YaGg==
X-Gm-Message-State: AOAM5338IpZ4tIS9EICC86kuZS+huspAvedCynW41p0oKbQtjLLzJiyS
        SwTipK6oMbUO3UoYdX2MrNo=
X-Google-Smtp-Source: ABdhPJykSgWfRfKmIpCPlKj8qTWqT2VkcWJR7uBqAqq+7PgShL1PCaQgUlUNP7HKaJe2TaQ0G07VSA==
X-Received: by 2002:adf:a51d:: with SMTP id i29mr391951wrb.409.1603129900170;
        Mon, 19 Oct 2020 10:51:40 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id h3sm548094wrw.78.2020.10.19.10.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:51:39 -0700 (PDT)
Date:   Mon, 19 Oct 2020 19:51:36 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: defconfig: Enable additional sound drivers on
 i.MX8M Mini
Message-ID: <20201019175136.GA94694@kozik-lap>
References: <20201008212706.870115-1-aford173@gmail.com>
 <20201008212706.870115-3-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008212706.870115-3-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 04:27:06PM -0500, Adam Ford wrote:
> The i.MX8M Mini has micfil and SPDIF support but the drivers
> are not being loaded.
> 
> This patch updates the defconfig to add support for these drivers.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
