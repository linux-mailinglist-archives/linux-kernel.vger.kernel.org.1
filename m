Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A84F271618
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 18:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgITQ7i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 20 Sep 2020 12:59:38 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:34416 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITQ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 12:59:38 -0400
Received: by mail-ej1-f66.google.com with SMTP id gr14so14614238ejb.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 09:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MfsSQb4YyC6QpW16JeAa+I8SM3Ii8qzNcoiOTlTKrKM=;
        b=U/0hHI9Pth0Wae56HJHFp9mwJvJsmqwZr5DN01G3kHzD9KAwaC9W47+fPYPsmyUhkO
         YWjcueclCs4dza2OY4eKJzHUTL9EWqfaBis5zK5iMHyxFXvt2e4MhkW2LcvlqaO2+a2D
         3MH2d49TUXGDkm1o3jE4Pegdmmf+iNbbOW+5DMU15oa1E10CtGR5vFmMUOl0vHXuBUny
         cqinLrDt2+bsdHboUtpR0S/fcmtV5EzJEhdGyOENGkwsuu8Lm2lFPQTXcU2F2bNwkxan
         DGZFf5BNClcx4ugAlGkfKvab8giNy6uL+RMutWu1aqHXxgkI7SfJG8rzC9Jf7nlNRjeS
         sLOg==
X-Gm-Message-State: AOAM533mKCxS5BN8wWegvOoD44J3OCP27i5rsMzMWlvvvpGAnRIZ6WnZ
        fR3zw3cEAH2rQqipyg7xRls=
X-Google-Smtp-Source: ABdhPJyVXaZi7s1Jw2gGn0zCgb0pPBwQt3pes/zmugXbcCnfMxu9BYf/h9SJHLTtvzOm71pElQ8GMQ==
X-Received: by 2002:a17:907:10db:: with SMTP id rv27mr44518896ejb.223.1600621176285;
        Sun, 20 Sep 2020 09:59:36 -0700 (PDT)
Received: from kozik-lap ([194.230.155.191])
        by smtp.googlemail.com with ESMTPSA id p11sm6801349edu.93.2020.09.20.09.59.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Sep 2020 09:59:35 -0700 (PDT)
Date:   Sun, 20 Sep 2020 18:59:33 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] memory: emif: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20200920165933.GB16677@kozik-lap>
References: <20200917125113.103550-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200917125113.103550-1-miaoqinglang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 08:51:13PM +0800, Qinglang Miao wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Along with this change, we get additionally:
>         .owner          = THIS_MODULE,
>         .llseek         = seq_lseek,
> 
> 1. The llseek method is used to change the current read/write position
> in a file which can be ignored if you don't use it.
> 2. The owner is not even a method. Instead, it is a pointer to the
> module that “owns” this structure; it is used by the kernel to maintain
> the module's usage count which can be ignored.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
> v2: based on linux-next(20200917), and can be applied to
>     mainline cleanly now.
> 
>  drivers/memory/emif.c | 22 ++--------------------

Thanks, applied.

Best regards,
Krzysztof

