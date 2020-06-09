Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B6F1F4942
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 00:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgFIWPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 18:15:19 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:44681 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgFIWPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:15:18 -0400
Received: by mail-il1-f194.google.com with SMTP id i1so20715544ils.11;
        Tue, 09 Jun 2020 15:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SIt9vqsJjlEz6zk3asMipOVTh2DgNRRsKYqkupl1gXg=;
        b=R4PfPuu7ruGQ2sW7S52EvSElX8iMsBrSwCA16pKuFB2l+8imZj6e/5ulc7h1wFOIOX
         sMlkWwnei7Uw0tAh1N8CWJLw/myv4uYeg+yONTEJFrt3ST+6wkUDFMOKX0dB57Kx1OYC
         liXp9BxLTsRZAObYwYsr4Jgx/hY3Ua1aOkdDpzazBfpGlteyIH2R3+xIQ9cDrpvPf4fb
         I4s346teVTV2PWzasj26i6ptbBB+8RAPuX9Rj8fddUP0u/fzoARP1yjumcPBHS68finI
         OMT2EZpsx3+LFtIn04/5y9SnzYKFEYW1zHafcnfGWmgJsNq6AIp8Tt/uF7S/GToldoDn
         JW5g==
X-Gm-Message-State: AOAM5330jyi/usSXXsbQuPsflXW2FX7Z4bAR+0xXCQleZdcML3xDhZRT
        EPnHAGvMbSe87v6vD07/3g==
X-Google-Smtp-Source: ABdhPJxkmZxwK1ql79rrG5xPZG7HoeRwm/ev5DUJldBfp7gAWRH0Wlpng2yYdEmTRj4TYhFcRHYY+g==
X-Received: by 2002:a05:6e02:13f4:: with SMTP id w20mr178303ilj.294.1591740917458;
        Tue, 09 Jun 2020 15:15:17 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id w15sm9922978ilj.21.2020.06.09.15.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:15:17 -0700 (PDT)
Received: (nullmailer pid 1592981 invoked by uid 1000);
        Tue, 09 Jun 2020 22:15:15 -0000
Date:   Tue, 9 Jun 2020 16:15:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     linux-usb@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, zhenwenjin@gmail.com,
        gregkh@linuxfoundation.org, dongsheng.qiu@ingenic.com,
        yanfei.li@ingenic.com, aric.pzqi@ingenic.com,
        devicetree@vger.kernel.org, rick.tyliu@ingenic.com,
        sernia.zhou@foxmail.com, balbi@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: USB: Add Ingenic X1000 and X1830
 bindings.
Message-ID: <20200609221515.GA1592928@bogus>
References: <20200530165253.17445-1-zhouyanjie@wanyeetech.com>
 <20200530165253.17445-2-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200530165253.17445-2-zhouyanjie@wanyeetech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 May 2020 00:52:52 +0800, 周琰杰 (Zhou Yanjie) wrote:
> Add the USB PHY bindings for the X1000 SoC and
> the X1830 SoC from Ingenic.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
>  Documentation/devicetree/bindings/usb/ingenic,jz4770-phy.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
