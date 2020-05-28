Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717421E6C54
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 22:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407042AbgE1URg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 16:17:36 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:44134 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406952AbgE1URb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:17:31 -0400
Received: by mail-il1-f194.google.com with SMTP id j3so174329ilk.11;
        Thu, 28 May 2020 13:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=89I7qlCTtqr412/2HNZ2mWAqiaX7Wsv+rz/qqSYUNPk=;
        b=ZOxHurfzqxDSztnXtmGMtYG4jK9ChSGJf1BNLnZn69UsR+FhXOqtcI9reveiK5FAfs
         PbEYmrFjIPwgPFw3QgWuMT/NweE/GfFs+bgMZUxYUX5/4GCjz+gKBmzQ+8eOm/IaD+Mx
         Lrvo9ZR96lLs2Q3Zs3bEerGP+b7WalWrYpkgrkjS+0b2vtakmTUkWIBY7V3npojfZH3W
         +3t5FyeURQt08QgtzNjbNC/DaZZNrImIhZJjqQsWaT2qjYhURCkOHXF46DPo7n59QLGP
         2qN23gP3ZWLfkoGlJqcIyDFXcGH6lidSnCYbGufG4wnRKpE8HPQtqjCRqQbPjda9xjoK
         a5rA==
X-Gm-Message-State: AOAM533vMAPFIi6RXZogCZo6S8Y1COiLO7cawDyMKjLpABJJQ2yS+6I2
        mdtAjgbYEA8tQzBy6Yf7vA==
X-Google-Smtp-Source: ABdhPJw5xVvbW66Siyuk+HvVdcGCUwANpqhOcL7xjknAhMFGF/KmArF+e8Aj9e202XVt5qf+XKjY7Q==
X-Received: by 2002:a92:ce8e:: with SMTP id r14mr4563184ilo.265.1590697050149;
        Thu, 28 May 2020 13:17:30 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v15sm3828753ila.57.2020.05.28.13.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:17:29 -0700 (PDT)
Received: (nullmailer pid 608748 invoked by uid 1000);
        Thu, 28 May 2020 20:17:28 -0000
Date:   Thu, 28 May 2020 14:17:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        od@zcrc.me, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 01/12] dt-bindings: display: Convert ingenic,lcd.txt to
 YAML
Message-ID: <20200528201728.GA608691@bogus>
References: <20200516215057.392609-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516215057.392609-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 May 2020 23:50:46 +0200, Paul Cercueil wrote:
> Convert the ingenic,lcd.txt to a new ingenic,lcd.yaml file.
> 
> In the process, the new ingenic,jz4780-lcd compatible string has been
> added.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     This patch comes from a different patchset so it's effectively a V2.
> 
>     Changes were:
>     - lcd_pclk and lcd clocks are in the correct order now,
>     - Add 'port' and 'ports' properties, and document the valid ports.
> 
>  .../bindings/display/ingenic,lcd.txt          |  45 -------
>  .../bindings/display/ingenic,lcd.yaml         | 126 ++++++++++++++++++
>  2 files changed, 126 insertions(+), 45 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/ingenic,lcd.txt
>  create mode 100644 Documentation/devicetree/bindings/display/ingenic,lcd.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
