Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC38E2A7085
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 23:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbgKDWb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 17:31:58 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45284 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbgKDWb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 17:31:58 -0500
Received: by mail-ot1-f65.google.com with SMTP id k3so247879otp.12;
        Wed, 04 Nov 2020 14:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wmC/MczJhz01hxbRPciJvRVJKYl2F1OprS8aSpaaQqA=;
        b=kca+j3YLrnSItPr+k5pU8eh1d7fo71rDRPO6WtPP3EXWib8IF0wFokFJUz9oiIACl2
         wkzyiCWx67AusX1YANZOD3OpHJrJY3GJcpK/G8m3s90oi88jxx01OVUgTqIIQxtoXOna
         FgbOcoXZtJU+Mh3SiZS8yCHiAD58wvToxg37uHQaasv8fR9uXa5021TdlRBwkoL7RerS
         q9If43/B3kh9IirOW8ZE4USmYjsAt/wtwozK3zV+QCDW/IirZQ1sF+RFNaKPnF8q6J3P
         hFrzr+rzuAWJ15xP8LcYZaEjGsk5V9x9Hjx23uyZoJxY43wJX1chUY8MN/a9jaIuWgAI
         gVGw==
X-Gm-Message-State: AOAM532KNoVcQaTihtw2uhLe0q4S3jPReW+47QCB6N8tgV/uYQa5MMo2
        5kbFfEWQ0ff1Xoonaf7DfQ==
X-Google-Smtp-Source: ABdhPJzxOhc4fAKgzmwcDfkvqHimxkghYOsAR6veO9EiBHWi0NJ+BYNTWEPI+RoJC4mDfhZhzqlauQ==
X-Received: by 2002:a05:6830:22d2:: with SMTP id q18mr6975110otc.305.1604529117531;
        Wed, 04 Nov 2020 14:31:57 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q18sm772243otf.46.2020.11.04.14.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 14:31:57 -0800 (PST)
Received: (nullmailer pid 44867 invoked by uid 1000);
        Wed, 04 Nov 2020 22:31:56 -0000
Date:   Wed, 4 Nov 2020 16:31:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/2] extcon: fsa9480: Rewrite bindings in YAML and extend
Message-ID: <20201104223156.GA44788@bogus>
References: <20201101004357.1076876-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101004357.1076876-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Nov 2020 01:43:56 +0100, Linus Walleij wrote:
> This rewrites the FSA9480 DT bindings using YAML and
> extends them with the compatible TI TSU6111.
> 
> I chose to name the file fcs,fsa880 since this is the
> first switch, later versions are improvements.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/extcon/extcon-fsa9480.txt        | 21 --------
>  .../bindings/extcon/fcs,fsa880.yaml           | 52 +++++++++++++++++++
>  2 files changed, 52 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
>  create mode 100644 Documentation/devicetree/bindings/extcon/fcs,fsa880.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
