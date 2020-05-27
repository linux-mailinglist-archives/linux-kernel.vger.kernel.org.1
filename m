Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432421E4C40
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 19:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391528AbgE0RpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 13:45:13 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:45414 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387564AbgE0RpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:45:12 -0400
Received: by mail-il1-f196.google.com with SMTP id 9so6469854ilg.12;
        Wed, 27 May 2020 10:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I9TPy0t0r7dSvS0Zzgr1lWRHOL4KGYxQvJlUxGn8jM8=;
        b=P7EGvfl6NaTcYrmPGl6X/dxrc+xhSAxuBwaYawCnjHvnmn67m7P7mIRhnG35BFtuW4
         2ZIljouJZ9kc9NXYhhHm7jZuPQ0FByTM83neUH37qzSQ6c2kN+vVqwsRDmdWl9wYvOGt
         nXQW+SIwssxK4jgeHHNKvF5Vdqk07nH4SoB9WiMPlARTckBLKdz8KzAGkgU7otE7g3Hd
         hCvp9VVUEGCYwgmBwv9m8UdhVC42YY/Xe7fUoYiCn5TT2piMVL1O2tost9dWCEYM+wXG
         4jP5haaETxdaGOZUQicfYFt5OLn3lxYM8+6IFrlKq+GbNezJFcwunQow//tsJKARh+3D
         En9w==
X-Gm-Message-State: AOAM530j2myhn768frbqiUvpP9TCcgYGIucaJ6L+dzeFoeG7lqLk/UYv
        xtpjGqH432va05g2VWegjw==
X-Google-Smtp-Source: ABdhPJzIlIEDCZnDLRqrKu3BwU47IfsOVT8bD7cFnLhHISpdClWRPNqxMTTeNb0UJvqQzLMgNwwaAA==
X-Received: by 2002:a92:d94b:: with SMTP id l11mr7013138ilq.105.1590601511506;
        Wed, 27 May 2020 10:45:11 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id o70sm2006483ild.3.2020.05.27.10.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 10:45:10 -0700 (PDT)
Received: (nullmailer pid 2436105 invoked by uid 1000);
        Wed, 27 May 2020 17:45:09 -0000
Date:   Wed, 27 May 2020 11:45:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     devicetree@vger.kernel.org, mturquette@baylibre.com,
        broonie@kernel.org, robh+dt@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, linux@roeck-us.net,
        jdelvare@suse.com, linus.walleij@linaro.org,
        patches@opensource.cirrus.com, lgirdwood@gmail.com
Subject: Re: [PATCH v3 1/5] hwmon: lochnagar: Move binding over to dtschema
Message-ID: <20200527174509.GA2435968@bogus>
References: <20200512152359.11839-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512152359.11839-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 16:23:54 +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> No changes since v2.
> 
> Thanks,
> Charles
> 
>  .../devicetree/bindings/hwmon/cirrus,lochnagar.txt | 26 ----------------
>  .../bindings/hwmon/cirrus,lochnagar.yaml           | 35 ++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.yaml
> 

Applied, thanks!
