Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535262E1AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 11:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgLWJ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 04:59:33 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:32923 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgLWJ7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 04:59:33 -0500
Received: by mail-wr1-f54.google.com with SMTP id t30so18053012wrb.0;
        Wed, 23 Dec 2020 01:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QWP1RktMTYfsl0fKzYCCQin4ZcwvidMtCHL6zQrN284=;
        b=YSmY+8LKaoW/AA+oKYdPFwbpCWli9Kn+yz8plsfETHRvWUitOFnIfJLNzYIEAp6eUB
         7xvZHjOB2ns3UXGGUaPr7pSKPxw1OUub4HwqfSmyh4mps0cT8Wp4D47O/N/FbEfr5TKy
         C9Dv9FHaM2I2iUgKBtVW5l00bR+IONh1eUqwmARr+LyKp7Gv+BEKbmdA09q51rYUNlV7
         JeH2uocophnyOd5eyDuH1Hd8RaTByTLIs7OGOzS/9eQ/cBhyvn/arEPwKSVLQpEe/jw8
         ZvkezAtY3uMBoCVBoOD+xrXjFY5pztW7si9/GCZ8n3fyp1ZZgkDNSmgH9E+1ZiB/ZwSX
         WcGA==
X-Gm-Message-State: AOAM531gLVVnHHJuAc4WP92shBZ98xHXEuZjpYfhhM4UB1uI5Paw6lkO
        7LB8SZQFftvZ0YrKzkKom3Q=
X-Google-Smtp-Source: ABdhPJwHW+EgtqX+b/mAV/tabaT1OoBl6ncVwl9nzsD8vQQrKSD/Ux6WqKiSQc6e54EmSQ9o5Lboew==
X-Received: by 2002:a5d:4f90:: with SMTP id d16mr28172923wru.120.1608717531682;
        Wed, 23 Dec 2020 01:58:51 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id w13sm34073722wrt.52.2020.12.23.01.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 01:58:50 -0800 (PST)
Date:   Wed, 23 Dec 2020 10:58:49 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: dts: imx8mq-librem5: Move usdhc clocks
 assignment to board DT
Message-ID: <20201223095849.GB11611@kozik-lap>
References: <20201222151347.7886-1-martin.kepplinger@puri.sm>
 <20201222151347.7886-4-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201222151347.7886-4-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 04:13:46PM +0100, Martin Kepplinger wrote:
> According to commit e045f044e84e ("arm64: dts: imx8mq: Move usdhc clocks
> assignment to board DT") add the clocks assignment to imx8mq-librem5.dtsi
> too.
> 
> Fixes: e045f044e84e ("arm64: dts: imx8mq: Move usdhc clocks assignment to board DT")
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
