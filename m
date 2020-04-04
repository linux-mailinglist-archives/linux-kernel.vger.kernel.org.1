Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E37C619E6B7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 19:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgDDRVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Apr 2020 13:21:24 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:41522 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgDDRVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 13:21:24 -0400
Received: by mail-il1-f196.google.com with SMTP id t6so10554219ilj.8;
        Sat, 04 Apr 2020 10:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1n2uOR6wFgUHEXtF3w9/WEH6BH4ieKdqJajPzMFObBI=;
        b=LqUaTS2tmTqwkvSVJ36XELhdoBM1DNe1aYU72dtwIDiFcOAdu3+3boiLqEinf0/+4e
         iiaHbs1t8SbY6sgViwEGBGhOurLcNa4Pm2CdwI7l7et60sqfgO/B22FnFnrchrOPKQSI
         yh9awobC6ktPqXW+ifFNJ3YkElAnjoCQdzHummgJqXrHGQyWN3QvmmB5JsXuNQBZTJEb
         AyZsdBkvZaOF59RI+ux+wHR34fKEiljmhwus/8/GWdDWVnjXQICdLKdcVBMSzhICDofK
         reMTx79y7mBFF+7ZGum4HWAPdN7zZOC/+wGaoILfcp8zWYwiv5ADKPbBIGyiBszyiHaZ
         vK7A==
X-Gm-Message-State: AGi0PuZmv9l4CMYmkCTc0t6+dVv7VscbxMMWP8mFfdjGCEaVnUL7LiPV
        YLoaKe6fc9h+jRv5EyhwXA==
X-Google-Smtp-Source: APiQypJQmZoJcNGxvGUS5ebio90Mu9iNzLO0TNKqrWWw6ta7vdiuT/lWFRwb1TqO2AyRYUyPJGlFvg==
X-Received: by 2002:a92:881b:: with SMTP id h27mr14581682ild.262.1586020882799;
        Sat, 04 Apr 2020 10:21:22 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j84sm4091586ili.65.2020.04.04.10.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 10:21:22 -0700 (PDT)
Received: (nullmailer pid 28438 invoked by uid 1000);
        Sat, 04 Apr 2020 17:21:20 -0000
Date:   Sat, 4 Apr 2020 11:21:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 14/14] dt-bindings: usb: dwc3: remove old DWC3 wrapper
Message-ID: <20200404172120.GA28402@bogus>
References: <20200326134507.4808-1-narmstrong@baylibre.com>
 <20200326134507.4808-15-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326134507.4808-15-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020 14:45:06 +0100, Neil Armstrong wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> There is now an updated bindings for these SoCs making the old
> compatible obsolete.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/usb/amlogic,dwc3.txt  | 42 -------------------
>  1 file changed, 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/amlogic,dwc3.txt
> 

Acked-by: Rob Herring <robh@kernel.org>
