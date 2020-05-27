Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225BE1E342F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 02:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgE0Ayi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 20:54:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32902 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgE0Ayi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 20:54:38 -0400
Received: by mail-io1-f67.google.com with SMTP id k18so24223371ion.0;
        Tue, 26 May 2020 17:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LQ0AEtFdgMYX11AAAtMlvJCMw5YRfrXYb6pTIuRGDRE=;
        b=jcbQ4U9JLhZvr19u5GglcsMRLnuZeUF7rrIO0y5aWCm9+AHWSLexRhLtxN6OjXclwo
         Oe9v4MiLNSRqiJdRtDNIlfHHlJ90tKI1vWEQ2JLrzISEPBvfo/Jc8t+mJqsGFML2KncO
         xCNe7pVnBMqtxHdHVH0ycTAdgHK37Lbx2nt9GBhXSv4SgzpAYA/YibKEmYpa1qsyF3jW
         Kjdkscn3XDehKV5YFHS43cPbu47XgiatMq57tnHULkEYTaqah1bF7pWinrKDStYIsKKB
         F/hG62PcQpYeQcb0AjpG8KZPnaGk+qFA0J/HZmLsNJAEKPPxfj9C33nFb8NZtQ58CFE0
         Nfvg==
X-Gm-Message-State: AOAM533fbHvbNYCa7sBE6ENNTIDqnZWHgatguzy+WouzSq6ZCHz35NvX
        xeFDqkhSuH/BIwL9TjPPXA==
X-Google-Smtp-Source: ABdhPJxk3+nRGpfBbG0rGSRpyT1TEqAiEij6VgOVAAYR53jqwRo4TgZGHe7pWZA+llYpQJAmlqeWZw==
X-Received: by 2002:a6b:7017:: with SMTP id l23mr4890125ioc.140.1590540877119;
        Tue, 26 May 2020 17:54:37 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id c7sm821178ilf.36.2020.05.26.17.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 17:54:36 -0700 (PDT)
Received: (nullmailer pid 781634 invoked by uid 1000);
        Wed, 27 May 2020 00:54:35 -0000
Date:   Tue, 26 May 2020 18:54:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     zhenwenjin@gmail.com, linux-clk@vger.kernel.org,
        dongsheng.qiu@ingenic.com, sboyd@kernel.org,
        sernia.zhou@foxmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, mturquette@baylibre.com,
        paul@crapouillou.net, linux-kernel@vger.kernel.org,
        aric.pzqi@ingenic.com
Subject: Re: [PATCH v10 3/6] dt-bindings: clock: Add X1830 bindings.
Message-ID: <20200527005435.GA781399@bogus>
References: <20200526144044.71413-1-zhouyanjie@wanyeetech.com>
 <20200526144044.71413-5-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200526144044.71413-5-zhouyanjie@wanyeetech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020 22:40:41 +0800, 周琰杰 (Zhou Yanjie) wrote:
> Add the clock bindings for the X1830 Soc from Ingenic.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
> Notes:
>     v2->v3:
>     Adjust order from [3/5] in v2 to [4/5] in v3.
> 
>     v3->v4:
>     Adjust order from [4/5] in v3 to [3/4] in v4.
> 
>     v4->v5:
>     Rebase on top of kernel 5.6-rc1.
> 
>     v5->v6:
>     Add missing part of X1830's CGU.
> 
>     v6->v7:
>     No change.
> 
>     v7->v8:
>     Rebase on top of linux-next.
> 
>     v8->v9:
>     No change.
> 
>     v9->v10:
>     Add missing "X1830_CLK_TCU".
> 
>  .../devicetree/bindings/clock/ingenic,cgu.yaml     |  2 +
>  include/dt-bindings/clock/x1830-cgu.h              | 55 ++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>  create mode 100644 include/dt-bindings/clock/x1830-cgu.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
