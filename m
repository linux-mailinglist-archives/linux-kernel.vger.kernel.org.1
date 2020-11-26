Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C2C2C4FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 09:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388642AbgKZIHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 03:07:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43780 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731457AbgKZIHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 03:07:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id s8so1088423wrw.10;
        Thu, 26 Nov 2020 00:07:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a3ZeRES82glp/ESVkrw8r5rJKHDjdPhl9dQN3iqL2dM=;
        b=PE9uR1uCEYn8e7Raid/M7fHYw9L0bT9ROYl6DlTPJJR4V+S2U6ojz0WgKPwcUcuNZ7
         dpXdP8R8U2WyqlyxHT2eMVY/uzKIqG0sb9ERMdzYP20rbvsJiM7RzeYEjsGKKxcPTx+t
         1aogxaXlSKkLTDpXNUD4Jz748lA0PV7TnUuq5cTpBvd9CmI7MouShiE9qr2j0XnIgzxt
         ucDEbXJnKjTuRGU8V89oWGA80iGBGfjnCstvNXY+J08r5aN3T7pRR6ayObXHNBlu9TdJ
         UL+TVlYwhkNJK7fKr4zKDTjkEkksY1CWISKIh5zK2ejGR5QLXgIY/5bEfZkBAa3q5Yh/
         GbbQ==
X-Gm-Message-State: AOAM532DmH6SJbcWid0tk022tbevvChXnq7klss+HyErDS7I3KvlVXw/
        kA0w0I3CIUJMQEwW+xjXO3s=
X-Google-Smtp-Source: ABdhPJzyyzAo4v01XsEoV1VcmfHcNIMsy/fn3brXPQpnEXdBAUrXd3alDnXOmWESuFAJBfNnypZndA==
X-Received: by 2002:a5d:688b:: with SMTP id h11mr2187850wru.417.1606378032000;
        Thu, 26 Nov 2020 00:07:12 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h20sm7287786wmb.29.2020.11.26.00.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 00:07:10 -0800 (PST)
Date:   Thu, 26 Nov 2020 09:07:08 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: imx8mm-beacon-som:  Fix PMIC clock error
Message-ID: <20201126080708.GB4347@kozik-lap>
References: <20201125210339.1071419-1-aford173@gmail.com>
 <20201125210339.1071419-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201125210339.1071419-2-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 03:03:39PM -0600, Adam Ford wrote:
> The PMIC throws an errors because the clock isn't assigned to it.
> Fix this by assigning the clocks info.
> 
> Fixes:  acb01032e11a ("arm64: defconfig: Enable clock driver for ROHM BD718x7 PMIC")

Hi,

This is not the correct Fixes tag. The defconfig change did not
introduce any bug in DTS. The error message was there before, regardless
of defconfigs. Defconfigs are merely a development or distro aid, not a
definition of working state.

If it really was a bug, then the commit adding DTS is to blame.

Second, I am not sure if there is a bug here to fix - having incomplete
DTS is a bug? Missing device nodes in DTS is a bug?

Also, pay attention to proper white spaces. There is only single
whitespace after ':' and no blank line after entire Fixes tag.

Best regards,
Krzysztof
