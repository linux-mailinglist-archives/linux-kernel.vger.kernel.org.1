Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309D32CEF21
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 15:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbgLDN7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 08:59:55 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38179 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgLDN7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 08:59:54 -0500
Received: by mail-lf1-f68.google.com with SMTP id s27so7748893lfp.5;
        Fri, 04 Dec 2020 05:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3AMuw/iWZYPrxgQGjPvnRlO2sM4xLUVsBSQGTu/oLHM=;
        b=q7ZhSjwumhV0AAZTn4gPTQ91VLJhkMLtZe4AygTCg1ZMDxdjcb7iLK4fEQ8unc1rZo
         Imq4/iG4Yz3ldgH7AnenIV8wr3j6Dfvxt95IAu7eZmzXqfBaOHt23TOQiAU1qCNsnlDH
         d0AmeMd3JVMs3MxoEyQYxzuLbyid4WYOtcPgPOneGCWAkcRty8b+Cjp+LH1GHNPDPA+8
         AYGvmQlyCbg5nb5Vc+ttJPrCcxlMRHH+kyzJz0oZX26Q9t4WIZoThfAvbzXdPLRrlXQR
         zxxpc8jcY5CQYWC9UFmRZI2b5ebXp+Grup2TdYj/XVvoBW1/Dn+hvYgoXAnTeS/ALn/j
         7XWA==
X-Gm-Message-State: AOAM533jKS32y3Ynr7TCIZbcxjY1/fx7D3SGR4kdCTMpahLfUIOJb2NW
        qGd844yo73hESEp9kb4ZgQiHXTCvpFEBSQ==
X-Google-Smtp-Source: ABdhPJyWmuaV3XrMfT656J+V3JUw5VFienVNM6DFOfaotZbqHa9rvo9YtxgQgAixAleTGD/9mUIa7w==
X-Received: by 2002:a19:8406:: with SMTP id g6mr3383105lfd.141.1607090351852;
        Fri, 04 Dec 2020 05:59:11 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id y25sm1687573lfl.108.2020.12.04.05.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 05:59:10 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1klBce-0004Iq-Jq; Fri, 04 Dec 2020 14:59:44 +0100
Date:   Fri, 4 Dec 2020 14:59:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Sheng Long Wang <shenglong.wang.ext@siemens.com>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/6] USB: serial: cp210x: clean up termios handling
Message-ID: <X8pA0PBuFFKUBTwV@localhost>
References: <20201116161826.29417-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116161826.29417-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 05:18:20PM +0100, Johan Hovold wrote:
> Unlike other drivers cp210x have been retrieving the current terminal
> settings from the device on open and reflecting those in termios.
>     
> Due to how set_termios() was implemented this saved a few control
> requests on open but has instead caused problems like broken flow
> control and has required adding workarounds for swapped line-control in
> cp2108 and line-speed initialisation on cp2104.
> 
> This unusual implementation also complicates adding new features for no
> good reason.
> 
> Rip out the corresponding code and the above mentioned workarounds and
> instead initialise the terminal settings unconditionally on open.

> Johan Hovold (6):
>   USB: serial: cp210x: return early on unchanged termios
>   USB: serial: cp210x: clean up line-control handling
>   USB: serial: cp210x: set terminal settings on open
>   USB: serial: cp210x: drop flow-control debugging
>   USB: serial: cp210x: refactor flow-control handling
>   USB: serial: cp210x: clean up dts_rts
> 
>  drivers/usb/serial/cp210x.c | 499 ++++++++----------------------------
>  1 file changed, 104 insertions(+), 395 deletions(-)

I have applied this series for -next now.

Johan
