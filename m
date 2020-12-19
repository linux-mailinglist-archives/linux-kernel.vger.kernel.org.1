Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A17A2DEEBB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 13:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgLSM0b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Dec 2020 07:26:31 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:38522 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgLSM0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 07:26:30 -0500
Received: by mail-ed1-f42.google.com with SMTP id cw27so5106757edb.5;
        Sat, 19 Dec 2020 04:26:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EQRDSGRMX4NLa2OWci5QoS1QI/PqgB9GUV3LVowPfkw=;
        b=X1X9ceQC+Gihr1j+METPOOJjJJrO5J6rtrWu6x9H2Dltko2SavK20wuDA2+ScVmP+v
         FkErLkG5HL9COl9m3CZ0MBKBebajYL3g0CSxlj5nlagmhIWpjxhJe1SPaZPXGmbjpZu/
         xTm5NOCv1Y0tDTrZo36xaBP1j4HafpNEbZBTDREdwbgge6IN0XhUoEUcx0LpyTD4v0gu
         MezikqMxjSjv6sPAxentQrYaTClZ7X3i0/Xz6iMt2VUsgcQe80oYvMLvISpw8P04DLTW
         fauz9XbaZhhjdrmYGa+CdapWezqQxFZW1fZthbISdUoJ1R9589LriP5wCxi7zf8fU73d
         KYjg==
X-Gm-Message-State: AOAM5339qscYEQV3g5P+tyZ6lEK32SgtB5cRqF+anqoMnE7awscspGue
        k+sb1jiBdCYPMQpcwC7NSu8=
X-Google-Smtp-Source: ABdhPJxF0fJT0+EHqkFQbKXxIH4ek1AHVDyZScZRhnVbWWwI8enYkhYRyidTHbm1sH9BPuuyNNWTBQ==
X-Received: by 2002:aa7:da03:: with SMTP id r3mr8491739eds.155.1608380748581;
        Sat, 19 Dec 2020 04:25:48 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id qu21sm6679741ejb.95.2020.12.19.04.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 04:25:47 -0800 (PST)
Date:   Sat, 19 Dec 2020 13:25:45 +0100
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
Subject: Re: [PATCH v2 3/4] arm64: dts: imx8mq-librem5-devkit: Disable
 snvs_rtc
Message-ID: <20201219122545.GH13886@kozik-lap>
References: <cover.1608216796.git.agx@sigxcpu.org>
 <01df90b39a0cb05e3abb3a16d150043a85cf0b23.1608216796.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <01df90b39a0cb05e3abb3a16d150043a85cf0b23.1608216796.git.agx@sigxcpu.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 04:13:14PM +0100, Guido Günther wrote:
> The board has it's own RTC chip which is backed by the (optional)
> battery and hence preserves data/time on poweroff when that is inserted.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
