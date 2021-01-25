Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F71D302D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732146AbhAYV1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:27:42 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:46229 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732624AbhAYV0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:26:43 -0500
Received: by mail-oi1-f170.google.com with SMTP id k25so2212216oik.13;
        Mon, 25 Jan 2021 13:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YUiddN9H8b8y6QBHSCLwa/EqcYU5tNvYnDBCmzamMFQ=;
        b=do2jhmP/quRG4OYsAiTIOTjEcAm1qgVaF/1wyGbKi5qZBd/ySNt9+ZqMV+2Fhvolj9
         IWEMpMNTegZh7pg/3j+i1DsIumBzpVuHf3agUJ4aw155KVOWzH4n8MCN1mg3GzbZXQeV
         GruswxS/BwsliSj0DIZ/D36MGIcywdp6uBHmH3GJMn4Md9Pxl70S0b5sw7xiKUbMVlNh
         jjlKLSVhvskm9D77mlI0ARbZqQIYa4DLkdhIeLqnWw/DKsU9L5uLhABE4S9tXQK8Fxd3
         GtG3h46Uieg7mBypVXBfbMXlTVfhS1lSjZtRjMkpENkPAWepCEhl05RCXqqwnEbuzuW1
         xaHQ==
X-Gm-Message-State: AOAM533o6usmzygQxffNKUen2U+QuUs3uVeCQ89Lm2B5BW4og1ZJcTer
        psxTOPa2kc+hjckgvXSuVtIEelLNJw==
X-Google-Smtp-Source: ABdhPJxwYHpKhVFzlzKhS0ECsooki+4JoAGsd9bY9XwF9LZDthCC6SG5F6fEbWf2EfD7hB1j3tfpaQ==
X-Received: by 2002:aca:75d3:: with SMTP id q202mr1295168oic.36.1611609961888;
        Mon, 25 Jan 2021 13:26:01 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 69sm3704322otc.76.2021.01.25.13.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 13:26:01 -0800 (PST)
Received: (nullmailer pid 1026791 invoked by uid 1000);
        Mon, 25 Jan 2021 21:25:59 -0000
Date:   Mon, 25 Jan 2021 15:25:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
Cc:     linux-arm-kernel@lists.infradead.org, BMC-SW@aspeedtech.com,
        lee.jones@linaro.org, joel@jms.id.au, linux-kernel@vger.kernel.org,
        andrew@aj.id.au, haiyue.wang@linux.intel.com,
        linus.walleij@linaro.org, cyrilbur@gmail.com,
        linux-aspeed@lists.ozlabs.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, minyard@acm.org, rlippert@google.com,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v5 1/5] dt-bindings: aspeed-lpc: Remove LPC partitioning
Message-ID: <20210125212559.GA1026734@robh.at.kernel.org>
References: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
 <20210114131622.8951-2-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114131622.8951-2-chiawei_wang@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 21:16:18 +0800, Chia-Wei, Wang wrote:
> The LPC controller has no concept of the BMC and the Host partitions.
> This patch fixes the documentation by removing the description on LPC
> partitions. The register offsets illustrated in the DTS node examples
> are also fixed to adapt to the LPC DTS change.
> 
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.txt    | 100 +++++-------------
>  1 file changed, 25 insertions(+), 75 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
