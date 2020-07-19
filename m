Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0324522525E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 17:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgGSPAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 11:00:38 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:33660 "EHLO
        mx.tkos.co.il" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgGSPAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 11:00:38 -0400
Received: from tarshish (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 43799440428;
        Sun, 19 Jul 2020 18:00:33 +0300 (IDT)
References: <20200719145028.3370-1-miguelborgesdefreitas@gmail.com> <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Baruch Siach <baruch@tkos.co.il>
To:     miguelborgesdefreitas@gmail.com
Cc:     a.zummo@towertech.it, devicetree@vger.kernel.org,
        alexandre.belloni@bootlin.com, festevam@gmail.com,
        s.hauer@pengutronix.de, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: dts: imx6qdl-cubox-i: enable DSM for the RTC
In-reply-to: <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
Date:   Sun, 19 Jul 2020 18:00:32 +0300
Message-ID: <87pn8reei7.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On Sun, Jul 19 2020, miguelborgesdefreitas@gmail.com wrote:
> From: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
>
> Signed-off-by: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
> ---

The commit log should explain why you enable this for Cubox-i. The
information is in your cover letter. But the cover letter is not
preserved in the git commit log history.

Thanks,
baruch

>  arch/arm/boot/dts/imx6qdl-cubox-i.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
> index e3be453..a226c4e 100644
> --- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
> @@ -144,6 +144,7 @@
>  	rtc@68 {
>  		compatible = "nxp,pcf8523";
>  		reg = <0x68>;
> +		pm-enable-dsm;
>  	};
>  };


-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
