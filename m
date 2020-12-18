Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20422DE0DE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 11:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733184AbgLRKUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 05:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbgLRKUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 05:20:14 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07127C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 02:19:34 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t16so1556940wra.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 02:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DIxCQpzn5k+G2PehMR9egdBIXBLmFw+GOEs1pTdyM0M=;
        b=kxvD9EoLTmWyoJWkqZPtfanZ15cyFwsCaz9xPcj8SSO2ZngV5CnlgLQielCSpg/VdH
         w5Q9DQNY0kCyvZgCZlx4ZleP2mKzmcEsrV7IIEZbH/7S81yWT7sFJe5gUDz5wR6HqqZ1
         /UMuIxN09o05akssAyN47tLN0qMQGS/mbPMh5+/KU9liN+xenlc9ouQqPfS1FfbuhxFG
         0xgUtM1jxxTjHH9ePKGqQkoCbclzuexGkqKbuOz7SK8kcANZeUfMblg5+iqlq3LfshXD
         HLKIgvi6BIcZ4dUFoHV4roA0OEGmEw8twPs9U+Oh6lKsWeMszQt5YUAa3RLkTmi9ib0J
         67GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DIxCQpzn5k+G2PehMR9egdBIXBLmFw+GOEs1pTdyM0M=;
        b=B7EAgDx4Mdd8tYAXFdjg3CjZU70JiSzhXDJtHVcBv45ahO+glhtvDAf9HTQD5kWn3u
         jYEzV7EY3XPMlQQapSkqUtvX3qsum8AWXe2EzZb02MFGoJQE7vqoFuPeB9YH8VyqliE4
         HUf+HFJ7yQMG0Bo5CW6dmrU49hPr99+2rIDTtcrc4moNCXzwdrz/0AgA8zULb+TxNw05
         hbAojyRMQBrPxTcqcsglmuZ4L3OFt9oDzRX0OYjBBE278VqA8PQUmCE2drzQcyzN3WPj
         YvHRb6kvx6U+GRMMKgQmtzRn1NQhtgw/HYj+l56hlUYXRmwTnhJ5qq2OKDQx7ilp8ozs
         e0kA==
X-Gm-Message-State: AOAM531tI4AsKXXJFMvAUHcoz/pBp/DOnSWkTLWpG/slvpBe1CN1uv5K
        w/twOtyTv8VBHPy1qrdbKfM=
X-Google-Smtp-Source: ABdhPJxvi/PwaiuyzVQfz6nt3vAThbvvX2l0Vgu/XhCFmXmzYLYdqsIWpdrTmk8m9fBY2teK3xWvcw==
X-Received: by 2002:a5d:4a06:: with SMTP id m6mr3636252wrq.189.1608286772775;
        Fri, 18 Dec 2020 02:19:32 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id m17sm14376708wrn.0.2020.12.18.02.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 02:19:32 -0800 (PST)
Subject: Re: [PATCH 1/1] mfd: Standardise MFD_CELL_* helper names
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Gene Chen <gene_chen@richtek.com>,
        linux-mediatek@lists.infradead.org
References: <20201217083420.411569-1-lee.jones@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <fac3c0ff-3179-94b4-4c6e-57e100a9f9fb@gmail.com>
Date:   Fri, 18 Dec 2020 11:19:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201217083420.411569-1-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/12/2020 09:34, Lee Jones wrote:
> Start all helpers with "MFD_CELL_".
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Gene Chen <gene_chen@richtek.com>
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

