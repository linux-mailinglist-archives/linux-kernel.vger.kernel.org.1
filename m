Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23132E0128
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 20:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgLUTjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 14:39:16 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:37168 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgLUTjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:39:13 -0500
Received: by mail-ot1-f51.google.com with SMTP id o11so9836063ote.4;
        Mon, 21 Dec 2020 11:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ttY1M+FC3G45rDi1s1z85NFAcBPkoo042biFstuqmFM=;
        b=KK96J8g+c321Sy6ml0Pcc9hRwM1St6KhLsALIBFqiCDM+qM2JuZMEBUvKw1+y5UCc8
         jgvzM5S5dSL4a13xOU1bBlWpnxnH1YlqUNpVqTTD4bi/uFL9j1+CzghTY4En9/SrwmTq
         aNQF2y4jwTu9PfK+pIc30oLAQt8L4WzzYGf9FFAXi87pryd/u86VqzBrKe964NvujqYw
         ajV/vIbxr6UHFIjIENMXNtnpwly/Iuvu/2W1qOALl4GH57qjzbJYy1gH+mnsaP18++Dd
         ffBwRlo13u0P8yELjc0+rihdnBT4SFgZBctqClC/JMfmlNUjsUGn5qmmKPnrzVgTLF/6
         y+9w==
X-Gm-Message-State: AOAM531vwuyITG7JYN6bu77sLB++aW3qR9fKiCwJk1YdRoMG6EKRjaMj
        ZkNdDxj99KApzI1D7q69sQ==
X-Google-Smtp-Source: ABdhPJw58Y3kr/Fj9RwtyRt8Fd2ZTzGIplLw4fFdZ8CLliz7OHAPbnBdDHAL0QyOSKaX0Z+/mEhM2Q==
X-Received: by 2002:a05:6830:1c24:: with SMTP id f4mr12914322ote.108.1608579512626;
        Mon, 21 Dec 2020 11:38:32 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 8sm4108414otq.18.2020.12.21.11.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 11:38:31 -0800 (PST)
Received: (nullmailer pid 424409 invoked by uid 1000);
        Mon, 21 Dec 2020 19:38:30 -0000
Date:   Mon, 21 Dec 2020 12:38:30 -0700
From:   Rob Herring <robh@kernel.org>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add Webasto SE
Message-ID: <20201221193830.GA424353@robh.at.kernel.org>
References: <20201216162535.9452-1-r.czerwinski@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216162535.9452-1-r.czerwinski@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Dec 2020 17:25:34 +0100, Rouven Czerwinski wrote:
> Add "webasto" entry for Webasto SE: https://www.webasto.com
> 
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
