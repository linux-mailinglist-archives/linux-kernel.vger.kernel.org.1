Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39A8269660
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgINUYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:24:44 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33421 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgINUYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:24:07 -0400
Received: by mail-il1-f195.google.com with SMTP id x2so884057ilm.0;
        Mon, 14 Sep 2020 13:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y0cRQ51IL0zEzJCFRKwuJ6EJ41YrG7bvo7HIxXwI1Uo=;
        b=tWWv2kFVXf7uFl53mVKqo06v3TKlM+74DLbq9HcJ00l9V7Q+55Xf7/agPdxt2E3fZi
         ElX0lxfMPxjkxabUJQml14hUQg39PpgZsCTb4bCrzzp5xG72k11qfhPBgVt6o6O6Yekl
         wZUo1rqyelmn9V2mwIIRO00FyE+ZoC5J/K6P3QLk4w3M+4pgKn+XQ0VSQcH8ur+wONBE
         RmQ67NWI3biP6/sBvSvGuxNElTCzVkCGG/XG2V+bgflPAkLF2fouAnWzSUvSQmzqcuJ0
         G/+85xMHSR5qdTTKbVR+H7KlvK800pfvmI+Gc+jYtlF0lXHqF547A0gkn+vNw9v+mfnu
         wDxg==
X-Gm-Message-State: AOAM531iXHNOHT2cbRxraignDLljCxgNRX800p+PLbVYTYHdKEtt7W6y
        EUOlwY1ST9mC+38JmoXvQ1/0x9FzJazv
X-Google-Smtp-Source: ABdhPJx0buG9EtsZBnxvI1gIEwWgyvUZdRLfiwVbTta20vCS82DJVj4eE1VB2VBzwa18Bi/5BVxmxw==
X-Received: by 2002:a92:b309:: with SMTP id p9mr13261205ilh.125.1600115021249;
        Mon, 14 Sep 2020 13:23:41 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o10sm7706652ilk.36.2020.09.14.13.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:23:40 -0700 (PDT)
Received: (nullmailer pid 178980 invoked by uid 1000);
        Mon, 14 Sep 2020 20:23:39 -0000
Date:   Mon, 14 Sep 2020 14:23:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     meenakshi.aggarwal@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        leoyang.li@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        V.sethi@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm64: add compatible for LX2162A QDS
 Board
Message-ID: <20200914202339.GA178950@bogus>
References: <1599059610-7570-1-git-send-email-meenakshi.aggarwal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599059610-7570-1-git-send-email-meenakshi.aggarwal@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Sep 2020 20:43:29 +0530, meenakshi.aggarwal@nxp.com wrote:
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> 
> Add support for LX2162A, LX2162A is LX2160A based SoC.
> 
> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
