Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AB428C161
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391008AbgJLTVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:21:17 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42217 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730275AbgJLTVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:21:17 -0400
Received: by mail-ot1-f66.google.com with SMTP id m13so16813302otl.9;
        Mon, 12 Oct 2020 12:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bDPx3gJbG2CpVJ6aCSdfBbWW1HjsWj+9+ilZev1TlOQ=;
        b=KZxuEpNhBuGnPPUCdviakjWMCYsKMZ8wD80OyQDHLAQusTPEFX85N1PCKtIR5Oc2Xn
         sgVs56zdYYTNSYqWf1bATSOZNIJ/kO+6rHlfzd/+PWxK31mCwB8ED/JLQfWUcWkW4sbW
         V5CMUpI6mmQeTKGSb4hLvTAtIo5ldW3Ob6pExeftmwwOz1aL+B420vClvPxZmJWwP26g
         gPiyYEf2ntL1tEGkbZbTkpUInobdk8dqiqzOVYqjLMGl4haVLw4zWIXZPPyqNNtns3cg
         B6QfW0ePbHoLjolRz386Qa/25efteHs6DjAbt1ChOXN9wQ0XaINmqZpuxmI+f5zq4YU7
         1dbA==
X-Gm-Message-State: AOAM533+cfZqHdPuoUQn3+N0QRVOyUvNezepvgP6XfnSI5TJSg+4kR1V
        zkqj3rJNqx4hWxGpptXV8g==
X-Google-Smtp-Source: ABdhPJw/4sppoLAPM1GFsYwKrqpR8AaTvfdRnnsfE2ptYh6DHCLhGTrUTKut0LsveqNvpS/12rG/Eg==
X-Received: by 2002:a9d:6954:: with SMTP id p20mr18379195oto.189.1602530476200;
        Mon, 12 Oct 2020 12:21:16 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m1sm9428947otq.30.2020.10.12.12.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 12:21:15 -0700 (PDT)
Received: (nullmailer pid 1940143 invoked by uid 1000);
        Mon, 12 Oct 2020 19:21:14 -0000
Date:   Mon, 12 Oct 2020 14:21:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: fix broken doc refs due to yaml
 conversion
Message-ID: <20201012192114.GA1938842@bogus>
References: <cover.1602245659.git.mchehab+huawei@kernel.org>
 <ba7319ab47bc7e80a57667f700ab677ceaa3ca8c.1602245659.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba7319ab47bc7e80a57667f700ab677ceaa3ca8c.1602245659.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 02:15:30PM +0200, Mauro Carvalho Chehab wrote:
> Several *.txt files got converted to yaml. Update their
> references at MAINTAINERS file accordingly.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/clock/hi6220-clock.txt | 2 +-
>  MAINTAINERS                                              | 9 ++++-----
>  .../devicetree/bindings/net/wireless/silabs,wfx.yaml     | 2 +-
>  3 files changed, 6 insertions(+), 7 deletions(-)

Doesn't apply for me.
