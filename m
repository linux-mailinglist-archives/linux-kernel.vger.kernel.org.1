Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EBA1CE812
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 00:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgEKW2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 18:28:07 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41898 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgEKW2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 18:28:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id 63so1563932oto.8;
        Mon, 11 May 2020 15:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jjl2q+cLjuSYjVSVZ7Mz6CZRstdUfyeubvOcO0Ad1y0=;
        b=TFCiUG4d69PPvC99ACWrIjJbCf1yUKSOYo7am4cTlxD+d5q6b5fM6xeeaXkzuWODgJ
         O2ZA17vCWBA7LkL7zBaVvRKF89tjKBN2o/TsXPxRt3FXW6gx2r8ZPCD0Q4YTMwwVfo+Q
         LYgkb21RY/LjuI2PeIHiiw42/+aYz4XZjU1xVTXYzqWYaRmA+hxXXXaYgLsE7ApdPV4B
         rf0RPNgUXJKtdYzqKaswAezwzPQnX62aHba0CtPCr/UhkfOGsou+jsgv/VMtv4SSMtPc
         BzmPxyxEZLfwriMBCqc020noA7D4JnL82ndic2JUQvLt8zJtA4K5gWg6HbhX0dB+IqT4
         vlvA==
X-Gm-Message-State: AGi0PuZV6QJvtLBZhDcBVB8x/FA2riOk42CQqSFMLuoNJLgJpVd4pATx
        QIN2Fr7VAgkfieW/nywrhw==
X-Google-Smtp-Source: APiQypJ/m39CHMDV/Fwl/hwdXtQG/dqy2DQnkw25aBe2ZDTnI6BMPvzs8kvxmTHdIrQ1atHUEsGfWw==
X-Received: by 2002:a9d:2aa1:: with SMTP id e30mr14504623otb.364.1589236086275;
        Mon, 11 May 2020 15:28:06 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u45sm1352871ooi.41.2020.05.11.15.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 15:28:05 -0700 (PDT)
Received: (nullmailer pid 29930 invoked by uid 1000);
        Mon, 11 May 2020 22:28:04 -0000
Date:   Mon, 11 May 2020 17:28:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: Document allwinner,erratum-unknown1
 property
Message-ID: <20200511222804.GA29872@bogus>
References: <20200426162032.52220-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426162032.52220-1-samuel@sholland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Apr 2020 11:20:32 -0500, Samuel Holland wrote:
> This arch_timer property was added in commit c950ca8c35ee
> ("clocksource/drivers/arch_timer: Workaround for Allwinner A64 timer instability")
> but I omitted the device tree binding documentation. Now
> `make dtbs_check` prints the following warning for all A64 boards:
> 
> timer: 'allwinner,erratum-unknown1' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Resolve this by documenting the erratum property.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  Documentation/devicetree/bindings/timer/arm,arch_timer.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Applied, thanks!
