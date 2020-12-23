Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B0E2E1AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 10:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgLWJ7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 04:59:10 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:37404 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgLWJ7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 04:59:10 -0500
Received: by mail-wm1-f52.google.com with SMTP id q75so5583686wme.2;
        Wed, 23 Dec 2020 01:58:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xNyulP5P8wx7EpdY4CRxJQH6t1IcycLwvmSWhqsgvGY=;
        b=tz/91/jsVBE7PBZzKh0cDkHNkJZZ0M496lELZBPcEu9iNEMDm5wY1tKmGxIMsgh7IP
         LXsB47cuQIWrk+MHJn+xi43Odq8PoIZY7jpXMdaG/Vk/I08tbYXuAz0Dlv/aEsgb4GbU
         IB/7J1dCw165SYte/RcPeljCdt5wfoa/9oY+cnAubKGdfjwQLjg/lUs0JPcSsyzVOeeG
         Hf2/SAmzHDV2w1DeqMHoH4QlxLrbbQM27zQkjacB46RgLfPxodCmEPmbg6P+TA29oDcL
         0hct5AEZBq1W9urLRoG1oZz8YDE7AWti4YHQfd+xgTgFiH8Wcye94qapEH8u6hVWnRLA
         7jAg==
X-Gm-Message-State: AOAM531jDqk1o1TZWi/QTUdLZbnVf+M0R/pc1cUbRVTHNdodbotVP0Gh
        j256PpE6fahKEottOzJSrbKFI9CnbB47JQ==
X-Google-Smtp-Source: ABdhPJy4hO+PfLq9X1KgoqCxDq4JJHs3KZOjYGtF4CagN+Qowkp7p7DlMHg4XsFV+5vytti/267GOg==
X-Received: by 2002:a1c:e246:: with SMTP id z67mr25756820wmg.166.1608717508086;
        Wed, 23 Dec 2020 01:58:28 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id s3sm9014098wmc.44.2020.12.23.01.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 01:58:26 -0800 (PST)
Date:   Wed, 23 Dec 2020 10:58:25 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: dts: imx8mq-librem5: add pinctrl for the
 touchscreen description
Message-ID: <20201223095825.GA11611@kozik-lap>
References: <20201222151347.7886-1-martin.kepplinger@puri.sm>
 <20201222151347.7886-3-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201222151347.7886-3-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 04:13:45PM +0100, Martin Kepplinger wrote:
> In order for the touchscreen interrupt line to work, describe it properly.
> Otherwise it can work if defaults are ok, but we cannot be sure.
> 
> Fixes: 8f0216b006e5 ("arm64: dts: Add a device tree for the Librem 5 phone")
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
