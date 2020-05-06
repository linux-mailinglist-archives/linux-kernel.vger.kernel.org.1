Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA351C7AFE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 22:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgEFUMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 16:12:38 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40884 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgEFUMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:12:37 -0400
Received: by mail-ot1-f65.google.com with SMTP id i27so2453813ota.7;
        Wed, 06 May 2020 13:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e+vn9EFSA0UGxoYXwE1EVzF8LOPmMyHze30Po1rkro0=;
        b=p56iCFpHuTm37uIAUa7DUcEeRX/VL0Uel3nf8hz9cDhcTkYMX3ErMFREcQ3jgpR2VL
         pFek2E0yT/Y+Bygx4gpOMldOS4MPx5fUoFCxwHSQBebnU8nm1I69CrfrXezvap7WU05f
         tZmF8iExA1WGIlo9kXwLVHsNAv0ZB4iZprEwYlonIddFGr8P4cS5KR1fExlsspj9+PBs
         OrjIYLzCvgo0m13CDJafngqY5M6o+yUOvnVWld5qG3Mw+cxkvzIOIQxKkfKmeHeqeRBk
         q+UhhWTlOtYpF8uxgqLXkESMcQWA+tDEbO6qwWMd0b0aquyOyjDO9SsfPRFQ4yuvLP+R
         uMbA==
X-Gm-Message-State: AGi0PuYxxUXTY1YxQKrPsZYAh3rXeb9SEWuTddAQB/phuVm603/RZU+S
        oZ9mRqdSzVoLD+ruXQMfPw==
X-Google-Smtp-Source: APiQypKFp1fXOaDvxKO48NzVwW+KRP+mYewDEAYdGEby8SRscKRUph/tJl+f9aaKBbZIMCVBbTTVqg==
X-Received: by 2002:a9d:12e3:: with SMTP id g90mr7344939otg.247.1588795956372;
        Wed, 06 May 2020 13:12:36 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n9sm758855otl.76.2020.05.06.13.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 13:12:35 -0700 (PDT)
Received: (nullmailer pid 14836 invoked by uid 1000);
        Wed, 06 May 2020 20:12:34 -0000
Date:   Wed, 6 May 2020 15:12:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     lee.jones@linaro.org, jdelvare@suse.com, linux@roeck-us.net,
        srinivas.kandagatla@linaro.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, nick@khadas.com,
        linux-amlogic@lists.infradead.org, art@khadas.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 1/8] dt-bindings: mfd: add Khadas Microcontroller bindings
Message-ID: <20200506201234.GA14756@bogus>
References: <20200421080102.22796-1-narmstrong@baylibre.com>
 <20200421080102.22796-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421080102.22796-2-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 10:00:55 +0200, Neil Armstrong wrote:
> This Microcontroller is present on the Khadas VIM1, VIM2, VIM3 and Edge
> boards.
> 
> It has multiple boot control features like password check, power-on
> options, power-off control and system FAN control on recent boards.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/mfd/khadas,mcu.yaml   | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
