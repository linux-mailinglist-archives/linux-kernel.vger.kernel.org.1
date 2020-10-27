Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C92929A6CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509208AbgJ0InW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:43:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43553 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509198AbgJ0InU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:43:20 -0400
Received: by mail-lj1-f196.google.com with SMTP id d24so788470ljg.10;
        Tue, 27 Oct 2020 01:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IDGEgmFavpKO4fp7M3bkMj6x/TJd1CMCX/SREqDS2mM=;
        b=Jhv5r3gXXI1gG/b5EmJ9P4BxODNc1pN/990DMFojBNjvZqEJHHUmY0LUiG+l4RXJ2t
         waIzDNrYU3H4MRnIIllTPLp5cM6KCJ3DfYj/nNKFQwwNxE1Z+pN8IegZ9H9zWiJzNPgB
         ZSStgBWAiYUKBdeVdn/W94x+YEfgnya2g/OZbL8K8U/UN8cc2DAzIWvZXMjHR2yawcgk
         Z2yQ9yVuN9VWDS87VE2vTdPO2hPUMWLVmMQZTDs48BuaGu65WBXmQRr04iloKlaCd2Pv
         BYt96GRBqGkLf6zg0prL1XmPD7n/Z6Ke4n53xNvmRxn439e83g97Gki6MVxS0zWZb+RI
         Hjqw==
X-Gm-Message-State: AOAM531Wc9UzHh3t75+qiCKKN5sax5tkgyfsx39TkejjPqL+tU0F/TqG
        7pqdGLYiF+CJ/mJaJskiM904Nn0eghY3xA==
X-Google-Smtp-Source: ABdhPJx8PIV6r0X1nC7Ris/OSi6eqnU1e6uJSJQkT+2XugtfL6xEn0af0F+zj7O/brQCgwdiHZCASQ==
X-Received: by 2002:a2e:b619:: with SMTP id r25mr631316ljn.465.1603788198601;
        Tue, 27 Oct 2020 01:43:18 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id x18sm95794ljx.2.2020.10.27.01.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 01:43:17 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kXKZZ-0002C1-3B; Tue, 27 Oct 2020 09:43:17 +0100
Date:   Tue, 27 Oct 2020 09:43:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ziyi Cao <kernel@septs.pw>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: serial: option: add Quectel EC200T module
 support
Message-ID: <20201027084317.GF4085@localhost>
References: <17f8a2a3-ce0f-4be7-8544-8fdf286907d0@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17f8a2a3-ce0f-4be7-8544-8fdf286907d0@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 12:08:06AM +0800, Ziyi Cao wrote:
> Add usb product id of the Quectel EC200T module.
> 
> Signed-off-by: Ziyi Cao <kernel@septs.pw>
> ---

For reference, can you provide the output of "lsusb -v" for this device?

Johan
