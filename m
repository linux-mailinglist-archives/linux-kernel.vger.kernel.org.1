Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FB12C4FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 09:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbgKZIDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 03:03:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39403 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgKZIDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 03:03:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id s13so1382100wmh.4;
        Thu, 26 Nov 2020 00:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s8u0GP23qDOSeM1D2brxZfZl6FgFTmnoBYV41ukmE/k=;
        b=fZLnYl7irlEu/yNZsi28YJ/s8ve9RvNu2FCCMk8FUFu47I3NeVqgm3M8X6gOXSDIec
         oqv0r4yBgHYwdXw8khbnWjhrNPOPupAS/mc+e/RwQgBBgVPjdHN/uG+vvFL4Jk7Gb83A
         /xYVbeLXhzeNaM68h5U42j0b1SBmaaIqnCvQb8GcaeH55c3TYI/J24CpzvvOd5leYDNi
         SjdbY+q75hL6JHKW831KnkAhTYV/5bq8ImCPn0El57R6NdCXIjDFXExOdnwXf47SsE+i
         6vhROi5m5NzAixRYKxS9G3fXWI8/yCaTJuRvWTfWM0Spw30rhKyDMV9Awtjr3oi/Wmo7
         XUvA==
X-Gm-Message-State: AOAM531XH0vnr/NacmKdtkqoB1KCRc2TAj3kQxDgWg7r7OPsW/ph/rUn
        DlD3GOz+NaHmjmATrGzqhYo=
X-Google-Smtp-Source: ABdhPJwStgiEbq6kndIHhkeGtEwcXjTWb91nIp7UGJ9+FsyJ/CK0wz2Q24X3XEYE2wbPSmfHSGoySw==
X-Received: by 2002:a7b:c94d:: with SMTP id i13mr1875524wml.130.1606377798092;
        Thu, 26 Nov 2020 00:03:18 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id v6sm7983100wrb.53.2020.11.26.00.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 00:03:16 -0800 (PST)
Date:   Thu, 26 Nov 2020 09:03:15 +0100
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
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm-beacon-som: Fix RTC aliases
Message-ID: <20201126080315.GA4347@kozik-lap>
References: <20201125210339.1071419-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201125210339.1071419-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 03:03:38PM -0600, Adam Ford wrote:
> On the i.MX8MM Beacon SOM, there is an RTC chip which is fed power
> from the baseboard during power off.  The SNVS RTC integrated into
> the SoC is not fed power.  Depending on the order the modules are
> loaded, this can be a problem if the external RTC isn't rtc0.
> 
> Make the alias for rtc0 point to the external RTC all the time and
> rtc1 point to the SVNS in order to correctly hold date/time over
> a power-cycle.
> 
> Fixes: 593816fa2f35 ("arm64: dts: imx: Add Beacon i.MX8m-Mini development kit")

There is no bug here so this is not a fix. Please remove the "fix" from
the title and "Fixes" tag.

This is purely for making user-space RTC lookup easier, nothing to fix.

Best regards,
Krzysztof
