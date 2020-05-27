Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DFB1E4E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 21:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgE0Tno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 15:43:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35848 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgE0Tnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:43:43 -0400
Received: by mail-io1-f65.google.com with SMTP id y18so6998433iow.3;
        Wed, 27 May 2020 12:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+A2TULz/fj8mDsfmZ5vK35Wr4pIuPJFpyE39E4KOAY4=;
        b=lErFmAYdRaflHIy2ylHMeNTbtYd2ENn2nZ8RiIR0BkgKiy7V5g9YjibKK58qi9qxL4
         vSi85gyMA1/z0tDpw6IsOG1ieEo4jx6x8lM21Tt2F1HcehMiZ3sdb78zKEHReDFSQax4
         uyt8esy/AuikyxetRpObmPkwvBooEU9fPq+jAGvwHVAHUGCX+a4wjWeM3SWU7/RsmjH3
         VtaRccaZOIN5OxbDhGPySJMOKneMMhJr3+JN3/IFNd6bU9PDI+AcO7oM9n8TJo8rpmVG
         2BY4BdGNprWJr0fJhuRtd7bM9J/s4eYR/unnj0PZhBQDvLfyG9YRG2XqLYL7byg3OniK
         FfaQ==
X-Gm-Message-State: AOAM531MLYhiIwdZ7QIUI2zChfh/2l4BHbUhlGoIhkrVjVIp4v5dH3Ev
        f2D5RF+ffIimVRxV2MLnJZI5KPI=
X-Google-Smtp-Source: ABdhPJwI5OHaSYz7G9L+zyZaUUb8u7vw2TyHHLUM33TRUVXe13dJtj3IwzNg1cxpvlS2I1l13WHZVw==
X-Received: by 2002:a05:6602:1616:: with SMTP id x22mr23066848iow.70.1590608621402;
        Wed, 27 May 2020 12:43:41 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v2sm610339iol.36.2020.05.27.12.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 12:43:40 -0700 (PDT)
Received: (nullmailer pid 2617463 invoked by uid 1000);
        Wed, 27 May 2020 19:43:39 -0000
Date:   Wed, 27 May 2020 13:43:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linus.walleij@linaro.org, broonie@kernel.org,
        patches@opensource.cirrus.com, myungjoo.ham@samsung.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lee.jones@linaro.org,
        robh+dt@kernel.org, cw00.choi@samsung.com
Subject: Re: [PATCH v3 1/7] regulator: arizona-regulator: Move binding over
 to dtschema
Message-ID: <20200527194339.GA2617434@bogus>
References: <20200513095720.8867-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095720.8867-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 10:57:14 +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> No changes since v2.
> 
> Thanks,
> Charles
> 
>  .../bindings/regulator/arizona-regulator.txt       | 18 -----------
>  .../devicetree/bindings/regulator/wlf,arizona.yaml | 37 ++++++++++++++++++++++
>  2 files changed, 37 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/arizona-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/wlf,arizona.yaml
> 

Applied, thanks!
