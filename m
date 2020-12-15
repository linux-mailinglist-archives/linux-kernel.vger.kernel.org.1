Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204DC2DA9EE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 10:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgLOJSP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Dec 2020 04:18:15 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33814 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgLOJSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 04:18:14 -0500
Received: by mail-ed1-f67.google.com with SMTP id dk8so20224728edb.1;
        Tue, 15 Dec 2020 01:17:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dZQENcWGBI+dh1Iu6ct/S1F9dcvge+tYCMiVe0Z+KKs=;
        b=Gl3ARYbD1g9w0cWv9dVQ9XJIHpDGKNQ0j4eeXeIz+SfssI0chRIEvyXE6c2BlR+Apt
         j1YQ9wBiPuk11zlNRopJimd4EOkTyRUdhLXnOMI3sP1Z3Wx53f1hrwtrjvXQjvmZvsKm
         hrXeBEnfYe3ax0kB5YW1AJ3vTQX5oE5z72SiyHUcrmnS/tBGn/wKmnUXljCpjEW5UQk9
         MICU5LHxCfbb0/9YXcZVV7bVI8Nzubd2ChfufOJhH+kVjW+vnGeG+8YqJr2slFtCK2UY
         0a2tZW9nm0NfMNTTaTiUVj467eHQQve2D1NNY/1WguYFavlajzph/HwJvoVTgQSPB9nS
         Qu1g==
X-Gm-Message-State: AOAM531Cq8OWapRlpwSZh8EuHeenO46ehy+mT1V/tRXc3a8/OGkA+fK6
        JM5zk1oz9LpAp/mGAMFdTuc=
X-Google-Smtp-Source: ABdhPJzyj6ItHNGHotBpHYpNXSrGsP+uSjgbyPB4ibTWWi2Ly5OfFzTeJj8EKPMmRG6BpZiVFYn+1A==
X-Received: by 2002:a50:a692:: with SMTP id e18mr28471961edc.233.1608023852372;
        Tue, 15 Dec 2020 01:17:32 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id ch30sm18207744edb.8.2020.12.15.01.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 01:17:31 -0800 (PST)
Date:   Tue, 15 Dec 2020 10:17:29 +0100
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
Subject: Re: [PATCH 1/4] arm64: defconfig: Enable Librem5 Devkit components
Message-ID: <20201215091729.GC29321@kozik-lap>
References: <cover.1607879709.git.agx@sigxcpu.org>
 <53657bbcaf1292fe58fa8dce497af6734521fb10.1607879709.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <53657bbcaf1292fe58fa8dce497af6734521fb10.1607879709.git.agx@sigxcpu.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 13, 2020 at 06:17:11PM +0100, Guido Günther wrote:
> This enables
> 
> - touchscreen: CONFIG_TOUCHSCREEN_GOODIX
> - charge controller: CONFIG_CHARGER_BQ25890
> - audio codec: CONFIG_SND_SOC_IMX_SGTL5000
> - rtc: CONFIG_RTC_DRV_M41T80
> - magnetometer: CONFIG_IIO_ST_MAGN_3AXIS
> - pwm: CONFIG_PWM_IMX27
> - modem codec: CONFIG_SND_SOC_GTM601
> - modem serial: CONFIG_USB_SERIAL_OPTION

Do not repeat the contents of the patch. We can easily see which configs
you enable. Instead, please name the devices you want to use, not the
CONFIG entries.  Several drivers actually support multiple devices.

Describe also the board you are enabling it for. You wrote only
"Librem5", but I am not sure whether this is specific enough. Is it even
on NXP i.MX processor? Maybe on something else?

This is a generic defconfig so your change will affect everyone.

Best regards,
Krzysztof
