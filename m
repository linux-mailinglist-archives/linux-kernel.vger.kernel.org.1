Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9721E4D38
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 20:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgE0Spi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 14:45:38 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37986 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389214AbgE0S1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:27:10 -0400
Received: by mail-il1-f196.google.com with SMTP id q18so3953698ilm.5;
        Wed, 27 May 2020 11:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZvQhsfkFlA/Oh3QWp+W6frDo076kraj8anhhLdL6bbk=;
        b=aig2ieMIF9q03HwH3YnNpItHS0FHpU62g0NvauvGbTi3gtShUxZzdgyazL1aMw70JK
         EFMpwx0JY3RgVAgQKTk0Fh8rWMufawlU+480rkZhi3FU+0+1ztu1RoPOb793svN/xw4x
         dBnoD3N0a4rn84UtRPhGdK8jeQ1o6Z16SyU+hrObe/vE1+B2hSi4Ilh7bc5Bnn9xfeh9
         bUspnyP4UVnZVnSIyfj/MnB1nW4t7eYlV9C0TjlM+BeHdww/c4fwTvG1UO96CyB5PijX
         DGHT0n8pkzEkg8t+wi0K0hpDN34YbbvClXJwcXDfF72rAXiYDpNNAelFxg17x2S4M9IQ
         ootw==
X-Gm-Message-State: AOAM533+AoyD672spkrjwgM3EEkA4nYDicaTlkoV9B+hmd22fyYTdsbw
        0ntWadSNy9NHfGmaGrle3g==
X-Google-Smtp-Source: ABdhPJyZguAbhJfNPR/1LeofmJy5ESLApTtq2YSIYTTvCksLfyA5dAI/XIdpU5e6VyT3XlOgIEiElQ==
X-Received: by 2002:a92:495d:: with SMTP id w90mr6846331ila.275.1590604029523;
        Wed, 27 May 2020 11:27:09 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b22sm2051080ill.6.2020.05.27.11.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 11:27:08 -0700 (PDT)
Received: (nullmailer pid 2511916 invoked by uid 1000);
        Wed, 27 May 2020 18:27:08 -0000
Date:   Wed, 27 May 2020 12:27:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Qi Zheng <arch0.zheng@gmail.com>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of/fdt: Remove redundant kbasename function call
Message-ID: <20200527182708.GA2458626@bogus>
References: <20200512154909.279788-1-arch0.zheng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512154909.279788-1-arch0.zheng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 11:49:09PM +0800, Qi Zheng wrote:
> For version 1 to 3 of the device tree, this is the node full
> path as a zero terminated string, starting with "/". The
> following equation will not hold, since the node name has
> been processed in the fdt_get_name().
> 
> 	*pathp == '/'
> 
> For version 16 and later, this is the node unit name only
> (or an empty string for the root node). So the above
> equation will still not hold.
> 
> So the kbasename() is redundant, just remove it.

There's 2 occurrences of this. Can you remove the other one too.

Rob
