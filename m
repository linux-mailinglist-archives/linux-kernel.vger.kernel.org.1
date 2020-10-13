Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C539B28D010
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbgJMOSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:18:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40172 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbgJMOSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:18:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id l4so106830ota.7;
        Tue, 13 Oct 2020 07:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Q+dAvDiJtBl28GZIwp7V8U0T78A8ymLuInx1USRJMb4=;
        b=OGbPUx5SQ38eJdqEcXfFMYDqcVrdPDt+PbjPphu82fjUX/RrK9pEBdkJxSJ5AvgrW8
         EvFEIWbWfMcoksm4e+P/UuvTQxD0mrI4Tm+MClvOtQc7+n8rTOQ77ZGr8LEfA+P7JLYN
         /UrIQMyuLYtS6gr/VpZrQ1e50d8cKfvcjF3LruTa5j5squAKfbA/VZvHkho3lqg4snaV
         SMAe/0ZWDqMF8uF5zKw7xJ6khex9Z3UECwKABHBcgS6TQgyi2kYTBym7gZipTflnqt5M
         0oQtuNGOiUhQ4LgbcWfEp3TzZteGaEEh6aJkjVSLkIpk6gm213MDnTmE65Rgwj0uXfEQ
         /zrQ==
X-Gm-Message-State: AOAM533Is1fGOOF8BcIMtnlZhGUCP2LwHZ2KVMiV4qAkVa0DsudRYlln
        GPLYALT+jIeMcF6CXSB9Fw==
X-Google-Smtp-Source: ABdhPJxWgiOqq5RQBm4uJSt0DbKwL5vrSat8U1QdEPdUVyNWlHBfN5AjABX0f+36vsyeVvJJrQH3GQ==
X-Received: by 2002:a05:6830:199:: with SMTP id q25mr21074388ota.263.1602598709185;
        Tue, 13 Oct 2020 07:18:29 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j10sm6816501ota.56.2020.10.13.07.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 07:18:28 -0700 (PDT)
Received: (nullmailer pid 3442832 invoked by uid 1000);
        Tue, 13 Oct 2020 14:18:27 -0000
Date:   Tue, 13 Oct 2020 09:18:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: Add JZ4775 bindings.
Message-ID: <20201013141827.GA3442768@bogus>
References: <20201008093100.88405-1-zhouyanjie@wanyeetech.com>
 <20201008093100.88405-2-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201008093100.88405-2-zhouyanjie@wanyeetech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Oct 2020 17:30:59 +0800, 周琰杰 (Zhou Yanjie) wrote:
> Add the dmaengine bindings for the JZ4775 SoC from Ingenic.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
>  include/dt-bindings/dma/jz4775-dma.h | 44 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 include/dt-bindings/dma/jz4775-dma.h
> 

Acked-by: Rob Herring <robh@kernel.org>
