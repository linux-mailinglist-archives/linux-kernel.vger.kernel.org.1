Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D131E4BF1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 19:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391113AbgE0Rej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 13:34:39 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:44272 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390984AbgE0Rei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:34:38 -0400
Received: by mail-il1-f194.google.com with SMTP id j3so24851554ilk.11;
        Wed, 27 May 2020 10:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eEGnzOVokk32OQNCpauQqJQNJOfZnAg7FW8OPsQsazA=;
        b=tgPHJi41241Jl1FnW1D0BwdwAspnveHQ28oeIiJAvAqA2vcuu6BUxUP7jwMaeecpl8
         uCgIqwvAc3eJK/7FCNsLlojYlUnLExdbufJEs1m4JATERqkaFHvrFNSppbUd0m47bOJy
         IzIfX1FC9ILCQwyH++vgk8J1BnsU4VwfyXDrXLXh9peg52RrYYv7kmJyq5YjlXT279U5
         6/CRQyiv9kt5XWvzWkhMi3N835GHKZlSmOaiZu6HWLUinTzrxwqPMsqjfoHpVW2GucFF
         pbeLWZ+DFdPvFh3BnISaaBDb/1Gn6ZtfCQpRwGWGYXhek48U+8jV90cn1rPbqRPB0Znn
         PhfQ==
X-Gm-Message-State: AOAM530UGzH57sY30n3T2eBgxZ7+jIHXJBMYUwd8+KXB9xP04GWGs04h
        fJF1+trHxdsRY0Jx0TC9L8N6wsQ=
X-Google-Smtp-Source: ABdhPJwCDC0YrgrZpF5OGosH4URn71w/FGNE+SY/vo39G7m9TPvQq8/pR56Uz7h1o49ErORUBE0HYw==
X-Received: by 2002:a92:7414:: with SMTP id p20mr7037011ilc.77.1590600877820;
        Wed, 27 May 2020 10:34:37 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id x8sm1869233ilo.81.2020.05.27.10.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 10:34:37 -0700 (PDT)
Received: (nullmailer pid 2411785 invoked by uid 1000);
        Wed, 27 May 2020 17:34:36 -0000
Date:   Wed, 27 May 2020 11:34:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     devicetree@vger.kernel.org, sernia.zhou@foxmail.com,
        sboyd@kernel.org, zhenwenjin@gmail.com, mturquette@baylibre.com,
        yanfei.li@ingenic.com, aric.pzqi@ingenic.com, paul@crapouillou.net,
        dongsheng.qiu@ingenic.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, rick.tyliu@ingenic.com,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v11 4/7] dt-bindings: clock: Add X1830 clock bindings.
Message-ID: <20200527173436.GA2411605@bogus>
References: <20200527085449.55573-1-zhouyanjie@wanyeetech.com>
 <20200527085449.55573-5-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200527085449.55573-5-zhouyanjie@wanyeetech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 16:54:46 +0800, 周琰杰 (Zhou Yanjie) wrote:
> Add the clock bindings for the X1830 Soc from Ingenic.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
> 
> Notes:
>     v11:
>     New patch, split from [3/6] in v10.
> 
>  include/dt-bindings/clock/x1830-cgu.h | 55 +++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 include/dt-bindings/clock/x1830-cgu.h
> 

Acked-by: Rob Herring <robh@kernel.org>
