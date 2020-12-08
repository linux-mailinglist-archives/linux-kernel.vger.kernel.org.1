Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2B62D2F12
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 17:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgLHQGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 11:06:22 -0500
Received: from mail-oo1-f68.google.com ([209.85.161.68]:46031 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730375AbgLHQGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:06:22 -0500
Received: by mail-oo1-f68.google.com with SMTP id q20so2376742oos.12;
        Tue, 08 Dec 2020 08:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yYjR6LgKie9eiCJ/VKItxEnxCgLzgk8sCL7SBmc2/Oo=;
        b=iYORbIlTa9rqdRArIm/hVActhXYaZlHOYSEPyojkS0zqsGsCwRGbVsbBro88AiEgV3
         bsP0dBhrwz7ztHc+6hyA6gXzHq1kab7rO+xF/VMtJ5o5jhKJ1xWBHg1rf7nuBQ+iWz3w
         ubhOc3mDbHNlBZZ0ZokCJkD+0YoNnUMo6VqedO1nCgtjjafFsfXX8TEZ48UfnhJKi6Vt
         02yAV5XF9zaVMWCV4WYy2CQvN9XASnvEivRCvSEi5EI6xGG52Nn1ujeG6E7XI/I3GNBg
         EqwSNYoFwz+FrQ0cz0Aac+uLUs1u0aAPpW69f4u3A3hd7Yw5YA3Vnrsq2JGGW2uaDgb9
         Fu4g==
X-Gm-Message-State: AOAM530fImIvBfCK8ezVDrgWhg+wHhKpEjS6/HxL8/oUduJ8WHBolNkJ
        ij0oGMicKOQuUOPkstz8ZA==
X-Google-Smtp-Source: ABdhPJwdAAB0dkfJFPYn6SZc55Cbcr67pIWOpiKKNkav0GOD/J/N2nAjlWd4klcLUaTMyXrWGYrxZQ==
X-Received: by 2002:a4a:4592:: with SMTP id y140mr2017378ooa.26.1607443541155;
        Tue, 08 Dec 2020 08:05:41 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y204sm2371266oiy.38.2020.12.08.08.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:05:24 -0800 (PST)
Received: (nullmailer pid 2613809 invoked by uid 1000);
        Tue, 08 Dec 2020 16:05:04 -0000
Date:   Tue, 8 Dec 2020 10:05:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     aric.pzqi@ingenic.com, linux-clk@vger.kernel.org,
        yanfei.li@ingenic.com, mturquette@baylibre.com,
        devicetree@vger.kernel.org, paul@crapouillou.net,
        dongsheng.qiu@ingenic.com, robh+dt@kernel.org,
        rick.tyliu@ingenic.com, linux-kernel@vger.kernel.org,
        zhenwenjin@gmail.com, sernia.zhou@foxmail.com, sboyd@kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: clock: Add missing clocks for Ingenic
 SoCs.
Message-ID: <20201208160504.GA2613759@robh.at.kernel.org>
References: <20201125172618.112707-1-zhouyanjie@wanyeetech.com>
 <20201125172618.112707-3-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201125172618.112707-3-zhouyanjie@wanyeetech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 01:26:16 +0800, 周琰杰 (Zhou Yanjie) wrote:
> Add CIM, AIC, DMIC clocks bindings for the X1000 SoC, and CIM, AIC,
> DMIC, I2S clocks for the X1830 SoC from Ingenic.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
>  include/dt-bindings/clock/x1000-cgu.h | 3 +++
>  include/dt-bindings/clock/x1830-cgu.h | 4 ++++
>  2 files changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
