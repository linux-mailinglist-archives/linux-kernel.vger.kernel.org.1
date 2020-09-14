Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D516269957
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgINW7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:59:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34895 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgINW7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:59:05 -0400
Received: by mail-io1-f65.google.com with SMTP id r9so2008687ioa.2;
        Mon, 14 Sep 2020 15:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LCh2smZwgKVHCxnQ9DcuXiZIOWVUKlrP/EzDl1tNmTM=;
        b=Mtnyws66kdSG88TSZRsA7MvGXFnXNCbq7v0J8XhNPfRsP313+ugfPFMGeyOB1rYJ/C
         dPPzVvT8otRvHLIEA4BvG/L0LMqi/iw3MI1Bn/Xu0SkYo63PmT3qspFbAhtQojGXtPui
         zYbNTjBGAodHMU0Us2RpEl3CPSkmxMYQyd0p3XxE18b9eYK9dD8qescm5zdOoSkJSTJq
         HzVw9h4eQC0x6Vydgx4wE0gkpE3U0qMkZKo42vbq0DftKf65qRYRSq9OxgaGOpwxzQED
         ieiVZFBOf7gFc0Lhq4nss8zqK8eY4r54x4IKe1FV2wkmcIDyICZ6Kmn+niQmLfM6uWjS
         12VA==
X-Gm-Message-State: AOAM531rcCbndbBFdJrDla22cEzWG6kzIOzBY0SmsQYCc9qsCWXl5Nnu
        lgO14kceJBKhbvM+W4cKHA==
X-Google-Smtp-Source: ABdhPJwg9SXVtlfD7QKMD3JxTDGoE5iHv83Jvob/8jF4NnmwXRVyMr0Wg3gJ9u9qA/pV61mBnJaPcw==
X-Received: by 2002:a5d:984f:: with SMTP id p15mr13234469ios.70.1600124345336;
        Mon, 14 Sep 2020 15:59:05 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z72sm6739578iof.29.2020.09.14.15.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 15:59:04 -0700 (PDT)
Received: (nullmailer pid 429138 invoked by uid 1000);
        Mon, 14 Sep 2020 22:59:02 -0000
Date:   Mon, 14 Sep 2020 16:59:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        linux-amarula@amarulasolutions.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: display: simple: Add YTC700TLAG-05-201C
Message-ID: <20200914225902.GA429086@bogus>
References: <20200904180821.302194-1-jagan@amarulasolutions.com>
 <20200904180821.302194-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904180821.302194-2-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Sep 2020 23:38:20 +0530, Jagan Teki wrote:
> Add dt-bindings for YTC700TLAG-05-201C 7" TFT LCD panel from
> Yes Optoelectronics Co.,Ltd.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
