Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F415F2CC39C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389264AbgLBRZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:25:01 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:42681 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgLBRZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:25:00 -0500
Received: by mail-ej1-f67.google.com with SMTP id d17so5522435ejy.9;
        Wed, 02 Dec 2020 09:24:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2sc0ZAAHRXcUf7Jh+rsNeKSeZviDs3vmfEzs+OIFiiE=;
        b=V1KWV55Iiro17IqgdgblA9Q8kDtLdvzu7aNavF4Yf26TuHk15kv3VwneQwKZ5VzrbP
         unt0OyO24InpsdL2jnN5xly4//4AhiJ1UjjdJx19yMwcqbgUUYiReaTME/W3xfdt+hoW
         9yxeaw6a74Yf68VT5tD89zApm8WFuPUf/4WYSCW1VnJUJk3JbMmrLX7NCsTAOx1BDj/+
         9jz5MOY85aL1OuCotaSJ6Gqoj7FWiFTFLp/sewnN+Wh2k1tswu3gEO0O0C6eq6foxdmy
         FZpL5n6RuqtbuSm9+a3+/kIDmZnnrd2anZf01Ju0m0MwxWpC+9eaFd5c1bwzcTxTCVml
         0zPw==
X-Gm-Message-State: AOAM533P3JGs1qTqiDSigOK3obf+1F4iL48mb4rWiRUu/eIV1oEz8u/r
        bwbPIVrUg6hM6gCK9D0tckw=
X-Google-Smtp-Source: ABdhPJzVhSOKgnz6Ebn5c+ICMB7IhdOUHlT2xetEKRPDWEIhfu6sKNBDNyRQEJ8saucFsF/uW0FF4Q==
X-Received: by 2002:a17:906:451:: with SMTP id e17mr794669eja.228.1606929858528;
        Wed, 02 Dec 2020 09:24:18 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id ch30sm441460edb.8.2020.12.02.09.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 09:24:17 -0800 (PST)
Date:   Wed, 2 Dec 2020 19:24:16 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 07/10] dt-bindings: arm: fsl: Add Engicam i.Core MX8M
 Mini C.TOUCH 2.0
Message-ID: <20201202172416.GB3490@kozik-lap>
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
 <20201202121241.109952-8-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202121241.109952-8-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 05:42:38PM +0530, Jagan Teki wrote:
> i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.
> 
> C.TOUCH 2.0 is a general purpose carrier board with capacitive
> touch interface support.
> 
> i.Core MX8M Mini needs to mount on top of this Carrier board for
> creating complete i.Core MX8M Mini C.TOUCH 2.0 board.

This should be squashed with previous one. You basically add support for
both similar boards so there is no reason to split the bindings change
into two.

Best regards,
Krzysztof
