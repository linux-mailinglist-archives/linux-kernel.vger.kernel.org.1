Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48DF1E4E77
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 21:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgE0Tor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 15:44:47 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33711 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgE0Toq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:44:46 -0400
Received: by mail-il1-f196.google.com with SMTP id y17so23119701ilg.0;
        Wed, 27 May 2020 12:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ezqpncSP+so+GMtHN0GoHq59MSX0XPIXvACL9VZwvc=;
        b=fYy7tnv9uoxJYRJmwOtYeideAqODFd7JRRGBXvVQVFC42mR5R5ZSHSOjqRHre46DWV
         mMPMwj4rHn7jVjyCzweuQ7Q2ODL6eaOBe+IiwrznE+6BwDj1Q+iKOy9159Bzg+RnrLMM
         e8U9wMg1Ph84DWOGiEwX/sYqnBoRxTSnMzTVYEQU6IhD2AKQrIzISsmRf7qPNh0pjhz4
         xxf5lZWB5TaVgwh8YZyXZH0eZBf0fHyEdSpr9xBilLpd3cq9NkvktvzHLv949I2i5Z1+
         epvh/cW2lhLJ2ZhWhDVeK3GLmpaziA/vBpvIpFATRdnMONkIXTWvVK85Lg9tt54yZ1wi
         RqAQ==
X-Gm-Message-State: AOAM530PbSV9UT5pAEvmuaz9HcpMvDEGNhLxkXldBo/5UTvFHbn0gPzn
        8HTB72IYrRwRI1Ej96+UzA==
X-Google-Smtp-Source: ABdhPJw5xR+WhPv+66P4Q6B5NBxNP8HoPoKWI6OCFZcUgXyvdt7rJCbZLeUp3ovW1s3gIL5w8wpIBg==
X-Received: by 2002:a92:3d8b:: with SMTP id k11mr5468393ilf.122.1590608680896;
        Wed, 27 May 2020 12:44:40 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id z75sm2138197ilc.50.2020.05.27.12.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 12:44:40 -0700 (PDT)
Received: (nullmailer pid 2619201 invoked by uid 1000);
        Wed, 27 May 2020 19:44:39 -0000
Date:   Wed, 27 May 2020 13:44:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linus.walleij@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, cw00.choi@samsung.com,
        robh+dt@kernel.org, lgirdwood@gmail.com,
        patches@opensource.cirrus.com, lee.jones@linaro.org,
        myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] mfd: arizona: Move binding over to dtschema
Message-ID: <20200527194439.GA2619148@bogus>
References: <20200513095720.8867-1-ckeepax@opensource.cirrus.com>
 <20200513095720.8867-4-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095720.8867-4-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 10:57:17 +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v2:
>  - Removed a couple more redundant descriptions
> 
> Thanks,
> Charles
> 
>  Documentation/devicetree/bindings/mfd/arizona.txt  | 101 -------
>  .../devicetree/bindings/mfd/wlf,arizona.yaml       | 289 +++++++++++++++++++++
>  MAINTAINERS                                        |   8 +-
>  3 files changed, 293 insertions(+), 105 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/arizona.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/wlf,arizona.yaml
> 

Applied, thanks!
