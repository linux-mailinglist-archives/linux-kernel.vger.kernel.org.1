Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD6922B7C3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 22:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgGWUa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 16:30:26 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40223 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgGWUa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:30:26 -0400
Received: by mail-io1-f68.google.com with SMTP id l17so7637914iok.7;
        Thu, 23 Jul 2020 13:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yHb+xD8ynAN011pr7vNrT4LxhN7rPIg+zVnoTdpnl/8=;
        b=Vd3Nohh0FjXOs7SvKxpAppcuekz9ydi7Vkpu5k788T6BVmxXpPo4gB+YU8jJrdj/0m
         OGExj2yQvxMBj72+xJjVechOU2GqnmR17q5RVE934XJ6Rp7Zhv3EYVKxscZ0YIPwVL4V
         dUEdJvz2hS/GodICTMYTx2mT6C81tssZWU/exfnM1ALWPCqOy0yO4TGD899R3B9qB085
         5t8RC2je3C+2xv5VyP3Dl+B1X5eabukii32lVheudp2KdqkF0iPrWBmIEH93LfJlQ+K2
         B3QMk92p4UHAqD2vPL9sFXPn/bqWG5BHTHTZlOG3m3VJoltrdijVssVrcxOy33gf8z2w
         o0Ww==
X-Gm-Message-State: AOAM531PXbHmkQmftkVZ+aUlT28+UJrEHNr6wcJkAARtPJ5bDxMbmQXi
        XR/atKKurnPjUIcKIuHxsQ==
X-Google-Smtp-Source: ABdhPJyKres8M7XsIvRrG9U45Hb5uUqG04rfhkHiyYS7JQZbdnlz6SZ0M1ugFCGGbHxX22nAI/WepQ==
X-Received: by 2002:a6b:5a04:: with SMTP id o4mr3923450iob.171.1595536224893;
        Thu, 23 Jul 2020 13:30:24 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f18sm2001506ion.47.2020.07.23.13.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 13:30:23 -0700 (PDT)
Received: (nullmailer pid 810072 invoked by uid 1000);
        Thu, 23 Jul 2020 20:30:22 -0000
Date:   Thu, 23 Jul 2020 14:30:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     rick.tyliu@ingenic.com, hadar.gat@arm.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        dongsheng.qiu@ingenic.com, sernia.zhou@foxmail.com,
        robh+dt@kernel.org, prasannatsmkumar@gmail.com, xuzaibo@huawei.com,
        krzk@kernel.org, arnd@arndb.de, rdunlap@infradead.org,
        mpm@selenic.com, tmaimon77@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, yanfei.li@ingenic.com,
        daniel.thompson@linaro.org, aric.pzqi@ingenic.com,
        gregkh@linuxfoundation.org, zhenwenjin@gmail.com,
        masahiroy@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: RNG: Add Ingenic RNG bindings.
Message-ID: <20200723203022.GA810026@bogus>
References: <20200723062446.84013-1-zhouyanjie@wanyeetech.com>
 <20200723062446.84013-2-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200723062446.84013-2-zhouyanjie@wanyeetech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 14:24:45 +0800, 周琰杰 (Zhou Yanjie) wrote:
> Add the RNG bindings for the JZ4780 SoC and
> the X1000 SoC from Ingenic.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
> 
> Notes:
>     v1->v2:
>     No change.
> 
>  .../devicetree/bindings/rng/ingenic,rng.yaml       | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/ingenic,rng.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
