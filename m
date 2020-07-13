Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F9521AB95
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 01:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGIX2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 19:28:53 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45170 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgGIX2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:28:53 -0400
Received: by mail-io1-f66.google.com with SMTP id e64so4129742iof.12;
        Thu, 09 Jul 2020 16:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Au39COXULcLItjiF+6L8MUVVfSHmQLmmw2aIEwpt5Q=;
        b=q4mfYNIfENgqaRCjtnHEdk2o53nPzwDz+alqtEUW0J7w31aV0fClJHY/K30CMm19wt
         9qrOwmTE15XgRethQGE3ktl4MhENdJlzkxro3q66FIY6d7GQ3vUp06T7xSowqk9rmvVR
         7nYosgNHfR0LWju0yzcdrhFXaloGNAFBjQ9EXHSeBu/vTdYQ26B3+527v7rnvEb67ccA
         Gv4MuUN8Q5e1hbjyhS7z0wWdwM7UNgR0y5vSzxv3/mJi07gn/DwesQ8n3J40EFM6cvW4
         lrTEF0kLxpRFsdLc3YEeSL2MH0cJ0y0Ym7/XEEzTFA1Mmue4cb9uIwEV4xqhsISTdO3e
         yq3Q==
X-Gm-Message-State: AOAM530rWAzuUsE7WFh5f2PIMLNcpYXeUpU/rfUEl/u4f28Y3RZXo5NE
        Y2wFSzgkM6b4hJSKlVOu1w==
X-Google-Smtp-Source: ABdhPJyozy/fAk+3uupOWcOK06YXVnwlglg0aKM37J+l4lJVLCzIF+edk4spk2R4pUR/B8/H07hTBQ==
X-Received: by 2002:a05:6602:229a:: with SMTP id d26mr44698583iod.57.1594337332315;
        Thu, 09 Jul 2020 16:28:52 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id v62sm2684847ila.37.2020.07.09.16.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:28:51 -0700 (PDT)
Received: (nullmailer pid 1099701 invoked by uid 1000);
        Thu, 09 Jul 2020 23:28:50 -0000
Date:   Thu, 9 Jul 2020 17:28:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     benjamin.gaignard@st.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: st,stmfx: Remove I2C unit name
Message-ID: <20200709232850.GA1099649@bogus>
References: <20200702113233.5327-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702113233.5327-1-festevam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Jul 2020 08:32:33 -0300, Fabio Estevam wrote:
> Remove the I2C unit name to fix the following build warning with
> 'make dt_binding_check':
> 
> Warning (unit_address_vs_reg): /example-0/i2c@0: node has a unit name, but no reg or ranges property
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/st,stmfx.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
