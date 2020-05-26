Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F6B1E3368
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 01:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392242AbgEZXG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 19:06:58 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36399 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389802AbgEZXG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 19:06:57 -0400
Received: by mail-io1-f65.google.com with SMTP id y18so3502692iow.3;
        Tue, 26 May 2020 16:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qM7yTTkdzgug0yRlfKz1J9d+bTctskYEmlS+YtPQUx0=;
        b=Hfe5jJZchQp8XxbQ/bQTbhliu6gGjU9T16K2/1rfBMxWlc1TFYxDVXqsWB7prbSc0P
         CW667+eHmAA1bPwGSgET4mwlM6MQKVGHRbWEkdH1Xn7TEpFDzjIG/nsQMRkXzbeOf01H
         DOePZ6ZraYCSzJFnEnSYekCFz699D+9H2z+jaQdFfkRPIEIJIbXr1U0QtrNBk58es5mV
         TzCqT6J13o7i6+1EXuEcxDjFHTZSWzekGQZtcNkcWYbhx9VwANjdLA9MX3Dk5ijTK4id
         elKzWukPdtuYyqoSzYoqXaMgN3au6gIY9eDtAaBKHicFcSq88FncWr+zhjGo5Fs5G8nF
         j4qA==
X-Gm-Message-State: AOAM532STG1SLIspTPazuP7e0u3XUwl5eEHWMtIAqcqbuSRkHnBd4dpg
        nNnXtVcEG8szv3a0J3hU88NcnM4=
X-Google-Smtp-Source: ABdhPJyliFM4XLARzE8rOlqfLPrXTbRE98ugFuGjKDNnMdP2uaXdGeeFWhb3mLqV1iWF0F+VV0o1kg==
X-Received: by 2002:a02:3406:: with SMTP id x6mr32885jae.24.1590534416486;
        Tue, 26 May 2020 16:06:56 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l21sm737449ili.8.2020.05.26.16.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 16:06:56 -0700 (PDT)
Received: (nullmailer pid 560264 invoked by uid 1000);
        Tue, 26 May 2020 23:06:55 -0000
Date:   Tue, 26 May 2020 17:06:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/13] dt-bindings: clock: Add Marvell MMP Audio Clock
 Controller binding
Message-ID: <20200526230655.GA559890@bogus>
References: <20200519224151.2074597-1-lkundrak@v3.sk>
 <20200519224151.2074597-13-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519224151.2074597-13-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 00:41:50 +0200, Lubomir Rintel wrote:
> This describes the bindings for a controller that generates master and bit
> clocks for the I2S interface.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - Fix commit message wording
> - Define MMP2_CLK_AUDIO_NR_CLKS
> - Make clock ids start at 0, not 1
> - Fix dt-bindings/clock/marvell,mmp2-audio.h file name
> - Rename node from "clocks" to "clock-controller"
> 
>  .../clock/marvell,mmp2-audio-clock.yaml       | 74 +++++++++++++++++++
>  .../dt-bindings/clock/marvell,mmp2-audio.h    | 10 +++
>  2 files changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/marvell,mmp2-audio-clock.yaml
>  create mode 100644 include/dt-bindings/clock/marvell,mmp2-audio.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
