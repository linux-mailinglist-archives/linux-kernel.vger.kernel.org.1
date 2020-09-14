Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E4E26965D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgINUYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:24:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44910 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgINUYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:24:22 -0400
Received: by mail-io1-f65.google.com with SMTP id g128so1519371iof.11;
        Mon, 14 Sep 2020 13:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L47Wr53DwNenaQtlXpt/RvnPV0Mj1KdFsOYEAKHHgJM=;
        b=lOpHQY8x9OdANn6UQCramm1+4ZzvVXbE3VnLRa/yvgRUCujp0/2VSDhG/6T+3S0Jxb
         NxfzwQSJb4i5t/nNY9rp2/N6sIvm4DiVzs/wq4nbIe1h248KcZgfQE31YgtddjgaZLgr
         9DTEM2XErpig97VZbHGNIZyZpZOD8D9iWzn1DGSy1PDR9YXG6sychMmx6LD657NAXhC2
         igFrqHVhREbQOG5kBO3yJoRcmWiRZzXcz+bYmft1vHqtQEcNjkQt/af2g2lxTN3fRzfW
         QOxrUF8F06qMIKF1pL5PN1IVAGNU+ThewxNygpZIOx+SJ22uM4oWWIFRhjq1AKExymcl
         qW6g==
X-Gm-Message-State: AOAM531PtqWL8OXfEpRdRhy8SXFsSWrw4kJ7Ajj/BxLWK4PeE7fZCZ1B
        APQmkGIJXSmc1ZMMPRieQg==
X-Google-Smtp-Source: ABdhPJyg4ikLwX3W3iZGCT6sHarUQxriyzmJxrbeomqmR2F9mbVkURzRIGrIqptKPZdKHiS11cUSsg==
X-Received: by 2002:a02:76d5:: with SMTP id z204mr14178152jab.93.1600115061335;
        Mon, 14 Sep 2020 13:24:21 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id d1sm7407980ila.67.2020.09.14.13.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:24:20 -0700 (PDT)
Received: (nullmailer pid 180119 invoked by uid 1000);
        Mon, 14 Sep 2020 20:24:18 -0000
Date:   Mon, 14 Sep 2020 14:24:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: Re: [PATCH] ASoC: dt-bindings: aries-wm8994: Match compatibles with
 enum
Message-ID: <20200914202418.GA180065@bogus>
References: <20200902160025.20922-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902160025.20922-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Sep 2020 18:00:25 +0200, Krzysztof Kozlowski wrote:
> The common pattern for enumerating compatibles is enum, not oneOf.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/sound/samsung,aries-wm8994.yaml          | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
