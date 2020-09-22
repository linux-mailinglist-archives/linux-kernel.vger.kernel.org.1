Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47B8274D14
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 01:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgIVXGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 19:06:24 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:42698 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVXGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 19:06:24 -0400
Received: by mail-il1-f194.google.com with SMTP id t13so18958134ile.9;
        Tue, 22 Sep 2020 16:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gjm5+Zesu8Yoh2GVae26uPdTm5uq4kgbYXEPkw0xlNg=;
        b=HmLyKiqh4CVd5KqcGUkQwCsFb6zt2KTO6gBkeNnE2i/i6Cux1ZouPpRHOywFsLq17I
         4qHhzXNb0bmdFVvdT5uMsBIiIZsi4mhiFOpOmy9e2vsAxat+1qHjyIGPwJd2Q1r5SIYa
         pSKrrysQOwSNiiSF/eGjyMPI0MQCQuN8n1T1VditGNQSpi5KFUI8L9HtcySxs+aEpOSD
         +IoX6bVhiMWCo7QZPM2sf6SjEz/krCvrMEVriGF0V6kpGXVl0Gru3w5IHZuFuERa47F/
         GET4BMwVdWMlv2xQ7aK0x/aRY1PFu1DBun1ZbRo5aMVy3cj48ebLKRtYFR1HHQ15SuJQ
         EQeg==
X-Gm-Message-State: AOAM531meRIcvb1SyI1ipjSTxjFaYp1GvXGZKW8wQ3nctB0uQt1ht0V/
        Jgn9VSGUGbWPdEKK758j4A==
X-Google-Smtp-Source: ABdhPJzushuHeezpNXGP0hY1HlG7P8qplJsGs6Aw1mgutOlVzmSPMbIrVMPbjdopZFTXVq4WNLPetQ==
X-Received: by 2002:a05:6e02:6c8:: with SMTP id p8mr6657006ils.259.1600815983332;
        Tue, 22 Sep 2020 16:06:23 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id f4sm9616251ilk.52.2020.09.22.16.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 16:06:22 -0700 (PDT)
Received: (nullmailer pid 3433782 invoked by uid 1000);
        Tue, 22 Sep 2020 23:06:21 -0000
Date:   Tue, 22 Sep 2020 17:06:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     olivier.sobrie@silexinsight.com, robh+dt@kernel.org,
        mpm@selenic.com, herbert@gondor.apana.org.au,
        yanfei.li@ingenic.com, zhenwenjin@gmail.com, aric.pzqi@ingenic.com,
        rdunlap@infradead.org, hadar.gat@arm.com, tmaimon77@gmail.com,
        devicetree@vger.kernel.org, qianweili@huawei.com, krzk@kernel.org,
        linux-crypto@vger.kernel.org, xuzaibo@huawei.com, wahrenst@gmx.net,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        daniel.thompson@linaro.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, masahiroy@kernel.org,
        dongsheng.qiu@ingenic.com, geert+renesas@glider.be
Subject: Re: [PATCH 1/2] dt-bindings: RNG: Add Ingenic TRNG bindings.
Message-ID: <20200922230621.GA3433726@bogus>
References: <20200913161021.120226-1-zhouyanjie@wanyeetech.com>
 <20200913161021.120226-2-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200913161021.120226-2-zhouyanjie@wanyeetech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 00:10:20 +0800, 周琰杰 (Zhou Yanjie) wrote:
> Add the TRNG bindings for the X1830 SoC from Ingenic.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
>  .../devicetree/bindings/rng/ingenic,trng.yaml      | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/ingenic,trng.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
