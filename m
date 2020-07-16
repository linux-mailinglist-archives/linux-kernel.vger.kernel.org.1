Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B44222B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 21:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgGPTIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 15:08:23 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:44207 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgGPTIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:08:22 -0400
Received: by mail-il1-f193.google.com with SMTP id h16so6016381ilj.11;
        Thu, 16 Jul 2020 12:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cDpA3rYM1yVNrNZeExXuXrwxkeLlMEpe8XbtLwOxE/E=;
        b=seeZFUu5nwbYH2UsMos/M6WnDCZaJmy6aCd2mkSj31/Xm5cdtZPeRx1zv9dFGj8Ffk
         oyCLKcaUjmLyDdF9hX1iaxk9/A+PM0ufmzRx/zsRFXdpSdSXSnEwFGm+HChtODbJsprp
         BAVLmQeIF19s2VLr3DAwEkwtJQF+6c5xvnwGDDV3jcrBSjOk3YSkdOh6y4Pdw6tU/G/m
         HcsylEw8d5Vhx7YNtRFidQVWCSjwldxs8LI5tvvpdk5YiukmSLvTgu2DMFhOu5nFxJLR
         Z+1IXxpgAIncqZ2sEuJijzqUFkY/i2sI2ewhZSVJOFfT7dxRgSeyfTnBFkjmptB1JRlg
         uqxA==
X-Gm-Message-State: AOAM5315mvR3xnL5AcKgT708bwa4eixnC12IKBZUCPJPYUDJrWnLsDRO
        KGXeMeTKEc+/bWRGB7eWhg==
X-Google-Smtp-Source: ABdhPJzYGfEUybyWdL4OqS0VBQp60v2KMqvKIimCPqW+BTohHRfji7lXRslRbTotCF9Kk4cBkh8m7Q==
X-Received: by 2002:a92:77c1:: with SMTP id s184mr6124392ilc.196.1594926501714;
        Thu, 16 Jul 2020 12:08:21 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f2sm3176638ioc.52.2020.07.16.12.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 12:08:21 -0700 (PDT)
Received: (nullmailer pid 2678347 invoked by uid 1000);
        Thu, 16 Jul 2020 19:08:20 -0000
Date:   Thu, 16 Jul 2020 13:08:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH v4 8/8] dt-bindings: interrupt-controller: Fix typos in
 loongson,liointc.yaml
Message-ID: <20200716190820.GA2678097@bogus>
References: <1594869390-21053-1-git-send-email-yangtiezhu@loongson.cn>
 <1594869390-21053-9-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594869390-21053-9-git-send-email-yangtiezhu@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 11:16:30 +0800, Tiezhu Yang wrote:
> Fix the following typos in loongson,liointc.yaml:
> children -> child
> fron -> from
> connected -> connect
> it's -> its
> 
> Fixes: b6280c8bb6f5 ("dt-bindings: interrupt-controller: Add Loongson LIOINTC")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  .../devicetree/bindings/interrupt-controller/loongson,liointc.yaml    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
