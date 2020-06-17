Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03891FD892
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 00:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgFQWSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 18:18:20 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:36329 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQWST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:18:19 -0400
Received: by mail-il1-f193.google.com with SMTP id a13so3918571ilh.3;
        Wed, 17 Jun 2020 15:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uz7g0bB18ztxeQgM+/H4yxv4w/AtkVlw+WDwFr6g8Ao=;
        b=gKnmsvCwb1c5MwxE5ncNighG3ZLEm6eIoRgbRC8yJE56pcW7BSSH4W+uR6GuBbWpIG
         df1d6wKOi7ahmSH7A5zqdexHYNk1y0y8Ksr/2LgeKznv0DlOHZrTwzTDUtTNNii5rqnS
         4zkUEvKHsUYE6gsf60Rq+j0zXHUstfKtrylEwCjFXBRCzRZqmt7OVD3Ou6WYuot0F4LE
         QlXEZBFJW6r2nVv0ZshZKokJoWj1T2Y8t7oOdFGYJ5LKk4lQYzZr2Uf8mOUDLHA9gGq2
         RvZHVECmk/hzh4RNFHvcrVEPup8aWMUCz/Dj93jpSCiIEdjYWonFJ/NpCDZ8nj8m9G+5
         A++Q==
X-Gm-Message-State: AOAM532u1V6Am3S1iVlDJvBpHZ3xZLAsb9aE4T6kSVWg/ZAo5blB/b91
        PPlDn/ahcrh2KT1AxbtxPQ==
X-Google-Smtp-Source: ABdhPJwldBKKgVwMhWTp6+BTPDjZ5+GjxiMRxxsH5coqpGLhBPEg/c67Ti4jXWHLFczF1LllOIWBwg==
X-Received: by 2002:a92:cb03:: with SMTP id s3mr1132707ilo.161.1592432298592;
        Wed, 17 Jun 2020 15:18:18 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id t72sm552531ilk.23.2020.06.17.15.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:18:18 -0700 (PDT)
Received: (nullmailer pid 2934152 invoked by uid 1000);
        Wed, 17 Jun 2020 22:18:17 -0000
Date:   Wed, 17 Jun 2020 16:18:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Dmitry Shmidt <dimitrysh@google.com>, jbrunet@baylibre.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: clk: g12a-clkc: Add NNA CLK Source
 clock IDs
Message-ID: <20200617221817.GA2934098@bogus>
References: <20200610083012.5024-1-narmstrong@baylibre.com>
 <20200610083012.5024-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610083012.5024-2-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 10:30:11 +0200, Neil Armstrong wrote:
> From: Dmitry Shmidt <dimitrysh@google.com>
> 
> This adds the Neural Network Accelerator IP source clocks.
> 
> Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  include/dt-bindings/clock/g12a-clkc.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
