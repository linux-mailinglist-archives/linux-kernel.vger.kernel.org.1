Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6919A21E39A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 01:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGMX1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 19:27:25 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:32907 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgGMX1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 19:27:25 -0400
Received: by mail-il1-f195.google.com with SMTP id a11so12756898ilk.0;
        Mon, 13 Jul 2020 16:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zAVa3lTSYila6966sp8Gn62aDm38C7zi+tjV9vKX43I=;
        b=ec+BX7kRwnIIydh1TGTZBLctpRyHjt9TQ1M71ZO7c03xRhtkrcfu3yYH6QmRDnCL6w
         R7kVGotn1Q9J5m1WUvIE+Cnc9Qs+RfxQbTSoFGfn8sAggsAWtm5/99l7wp9hZpjrJs39
         3TnrPppVAfYAiu9Obc3I1Xz6oE8FtTHYICUTlqHL8d1o6jSdlB5TT1VvcUzZgINShYK3
         ZG6+4QhdD1e/CMyQuPhqgT2K5X+ezf5z32A8eS/04WvxzhGP78fohxSP3agVV87tCaJl
         qU3QmtG7v7B/Xfu86hRfLyxQukvHapEEtqwkdSEiPn+ZuTchG9TiK7uHtYR41kpGHbFR
         +1ZA==
X-Gm-Message-State: AOAM533QbjceL/MqRSYSV3vJc34k8ZcerT1SsQ/jTtedmeGXRCeHu+r+
        Mw8dwKA/lTzQWLCleeFjGQ==
X-Google-Smtp-Source: ABdhPJyXmtIrQdcQjdN9a8VFpJHAVd9PmhEOvZbXOsKiCbcGyeFTONHHYgS8sbR+ZOWoU6/uoSIPiw==
X-Received: by 2002:a92:cd10:: with SMTP id z16mr2300685iln.77.1594682844207;
        Mon, 13 Jul 2020 16:27:24 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f2sm8335325ioc.52.2020.07.13.16.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 16:27:23 -0700 (PDT)
Received: (nullmailer pid 918455 invoked by uid 1000);
        Mon, 13 Jul 2020 23:27:22 -0000
Date:   Mon, 13 Jul 2020 17:27:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     maz@kernel.org, wens@csie.org, tiny.windzz@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de, mripard@kernel.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net
Subject: Re: [PATCH v3 12/16] dt-bindings: irq: sun7i-nmi: Add binding for
 A100's NMI controller
Message-ID: <20200713232722.GA918407@bogus>
References: <20200713021740.17389-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713021740.17389-1-frank@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 10:17:40 +0800, Frank Lee wrote:
> Add a binding for A100's nmi controller.
> 
> Signed-off-by: Frank Lee <frank@allwinnertech.com>
> ---
>  .../bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml      | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
