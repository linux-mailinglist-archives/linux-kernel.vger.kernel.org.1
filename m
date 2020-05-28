Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23251E53FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 04:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgE1Ce7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 22:34:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46749 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1Ce7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:34:59 -0400
Received: by mail-io1-f65.google.com with SMTP id j8so28319839iog.13;
        Wed, 27 May 2020 19:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q1VgGqYRXtQd5eC2mV4CGy3PLGh8DebA8CCVDX9fCW8=;
        b=Uash2skpZk4MOIvMlS10MSjvVN+/TQ1NdbN/CV8ZnJTc3awfeSvf18OII7iyUxUHRy
         NCFV1T7hIXBvHO7bBwjkXKCdBU4MGGmUmXcyU2sxc1AKIrxN3W+M/ZCEZX0tznI2WmxN
         Du1Rqw49/rXRlOgUaersp2HYG5zYDP9G0Q1Env4ijFm6zkYK+NPMpQFZHJZzNOEqQIh+
         Od4x09yJfU4MDcsHFjC4BOHTRgA5qCqirxWNRHDGmgfMVsu62Om7lFFZuVNWD6ctAjEY
         pqHL33AAFRPMHePB3iSnxbL8ESpkXtPL+Gll1kCnX+WRAqQ7S/1Xcq9Io0seB52OgJsK
         5PPA==
X-Gm-Message-State: AOAM5302FA+lJ0o3GPi++SKJpYQWylxOdvLjSLetwPffWko4XeEpQ3ut
        VGPUOdq/HpAheDeTUJh2eQ==
X-Google-Smtp-Source: ABdhPJz7qBj9iWLJgx9Nd92PbmMvcXrMirbntMfltTLW/znZqM4wt1t1YF2GuGPpT/kP6SOzVU7Sxg==
X-Received: by 2002:a02:b70b:: with SMTP id g11mr828170jam.0.1590633298333;
        Wed, 27 May 2020 19:34:58 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u11sm2098343ili.55.2020.05.27.19.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:34:57 -0700 (PDT)
Received: (nullmailer pid 3251386 invoked by uid 1000);
        Thu, 28 May 2020 02:34:56 -0000
Date:   Wed, 27 May 2020 20:34:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, cw00.choi@samsung.com,
        devicetree@vger.kernel.org, lee.jones@linaro.org,
        lgirdwood@gmail.com, patches@opensource.cirrus.com,
        myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH v3 5/7] ASoC: madera: Move binding over to dtschema
Message-ID: <20200528023456.GA3251118@bogus>
References: <20200513095720.8867-1-ckeepax@opensource.cirrus.com>
 <20200513095720.8867-5-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095720.8867-5-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 10:57:18 +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> No changes since v2.
> 
> Thanks,
> Charles
> 
>  .../devicetree/bindings/sound/cirrus,madera.yaml   | 113 +++++++++++++++++++++
>  Documentation/devicetree/bindings/sound/madera.txt |  67 ------------
>  2 files changed, 113 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/cirrus,madera.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/madera.txt
> 

Applied, thanks!
