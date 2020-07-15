Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BE222164F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 22:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgGOUgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 16:36:39 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35320 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOUgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:36:38 -0400
Received: by mail-il1-f193.google.com with SMTP id t18so3183081ilh.2;
        Wed, 15 Jul 2020 13:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BJXqP+XSa8G42ZyuDhISJ/0QmN/qD/vI4ezaEI9n1jk=;
        b=p4nFhlTzE0KKtv6xXcVUU0+ExVtfRcu2iPb0aUQUGet9HGspCQM1CLARGgWXaegcWk
         NOic0SnrPYvZOPFZp/HBq2eKKqXhOe7cCvn+UXtj0w5NF31F7nkBpjZ8EzTt7Pf488aq
         1T6a2XMVwAtZf3TGkX3RrG+3LV6xwL2FFGhfOBu+d/7mk8pSQJpHC8aynM8Ul+nXtcC2
         2z89DzdtzhO88pk2OHE931tKEqJ8gkFv9eG6h27ak7ANlz9ut89B1V0ZKDfQa8sdcYFq
         tRaS41a1dBpHmTicBppjPG+oA0vRC8CfXVl2CztE8czX/7zS1tsE+bztZ9pezJO5rIaC
         +YeA==
X-Gm-Message-State: AOAM530+VbEfz2a5Zow6XbEU/NL5FJzReNqcMPTgUQr9Semnhyk1OOfp
        cJpKVE1lZYeqrK/TVL/S/Q==
X-Google-Smtp-Source: ABdhPJy9wtrz0U4Y6iejGJoArzuSrlG0r9+g5Y1CnR9WU06vnjI5mV5Fd3x5SusqG0Fm/xx1Hy0YLg==
X-Received: by 2002:a05:6e02:5c4:: with SMTP id l4mr1265616ils.209.1594845397644;
        Wed, 15 Jul 2020 13:36:37 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f9sm1577464ilq.9.2020.07.15.13.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:36:37 -0700 (PDT)
Received: (nullmailer pid 775848 invoked by uid 1000);
        Wed, 15 Jul 2020 20:36:36 -0000
Date:   Wed, 15 Jul 2020 14:36:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wenchao Hao <haowenchao22@gmail.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org
Subject: Re: [PATCH] of/address: Fix variable name in comment of of_iomap
Message-ID: <20200715203636.GA775752@bogus>
References: <20200701162444.9494-1-haowenchao22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701162444.9494-1-haowenchao22@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Jul 2020 00:24:44 +0800, Wenchao Hao wrote:
> The first variable name of of_iomap is np while previous
> comment write device here.
> 
> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
> ---
>  drivers/of/address.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
