Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858A128D012
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgJMOSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:18:49 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45896 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgJMOSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:18:49 -0400
Received: by mail-ot1-f65.google.com with SMTP id f37so79977otf.12;
        Tue, 13 Oct 2020 07:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dae2xYnzqBO+3frL/y8m9i4y1WOTJI4I0MuoranCsFU=;
        b=Ue+6bOfZ81iTES1RkFK/D3KeyHzgN2v3NuSlvw7vCVL9WwkD33j20n2CAhEwcRbGTr
         k3pclP3pvAOUrXNdwEzZTNuCyRdCkmw5GRNldnpfzSl5/dlYLsQyg0FU+xxdia3NsoTq
         nzgQlVpvLvocWeXc4j/OK6nNCrDnAWUHKxwJ07VRhT1rV4eghtQrq8RpXWfcM3yhgmC+
         weQjLvCN9Oske0wVmvjlWczqit0zlC3uzfc2cG69VUfKd0nAQ31q/UlG8ghMeR6vI5dF
         kG8mxmEMQO9SSUePHLmU0RO2b0uAeXdOSzuVVf7iqd6c0Kne9ODFhdSaOhCy3wEEumlT
         ao2g==
X-Gm-Message-State: AOAM531CZhVcJV1S1evyT7gfpa2nOZu8F9SB9rXD/TCHQXOtHXNhTBEh
        CjssG8Z6Ksblvmv294mNZA==
X-Google-Smtp-Source: ABdhPJzmVaBtOCdcFZgA7hLf66RAw3u2RWauczwjU/bLQy3rQlP7ZpJrlRrfkqB5Z0xebOYPEzjSGg==
X-Received: by 2002:a9d:84e:: with SMTP id 72mr7830016oty.237.1602598728068;
        Tue, 13 Oct 2020 07:18:48 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m29sm789865otj.38.2020.10.13.07.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 07:18:47 -0700 (PDT)
Received: (nullmailer pid 3443354 invoked by uid 1000);
        Tue, 13 Oct 2020 14:18:47 -0000
Date:   Tue, 13 Oct 2020 09:18:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: dmaengine: Add X2000 bindings.
Message-ID: <20201013141847.GA3443325@bogus>
References: <20201008093100.88405-1-zhouyanjie@wanyeetech.com>
 <20201008093100.88405-3-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201008093100.88405-3-zhouyanjie@wanyeetech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Oct 2020 17:31:00 +0800, 周琰杰 (Zhou Yanjie) wrote:
> Add the dmaengine bindings for the X2000 SoC from Ingenic.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
>  include/dt-bindings/dma/x2000-dma.h | 54 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 include/dt-bindings/dma/x2000-dma.h
> 

Acked-by: Rob Herring <robh@kernel.org>
