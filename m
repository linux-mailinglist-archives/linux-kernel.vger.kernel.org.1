Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C2E282A4E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 12:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgJDK7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 06:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDK67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 06:58:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6544AC0613CE;
        Sun,  4 Oct 2020 03:58:54 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u3so3562556pjr.3;
        Sun, 04 Oct 2020 03:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y8R13MrEUeHU+M2+OfMCzecQHtp4h9EaF+xa9gESpa8=;
        b=VQ3nxo/dd4KDAeCJnlToDINx6uvb1hzyreMLbofLc1Lnf8kz9Nj76ab/HJBsBh9qd5
         BjyWNzsHoo7+LudounhLzlkptxZ5e2qwAYrLS05z1yO3o2GlsQgxGJeiqlPkHJV/p+4V
         iFAKkcXc0O87KYUJfaGCuMfDLNxHpjjaVIShbzw+ooC2VF0O+K/fmXqrGqL2j8IKAJ0y
         2/wCipWPDpBtDyqh6KgSssjTelM57O93imjwqyvdMRpd6EUJ3SbxwNf5s/u2ut0+eQUQ
         6cbALKHYz95ad/CEaM7/bxJ57mtBmEbsTTAZY7Vkxkx+o1bHjZc2s43EyVUM1LzXxuh2
         3N7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y8R13MrEUeHU+M2+OfMCzecQHtp4h9EaF+xa9gESpa8=;
        b=kvrnOqW/r6lZamj1sobMjUTYpw5rwcjhvhBATUUjzuDEuOnQbiDhKZDRcmnSwPbC9b
         SLm4tXfIwmGcubM4i9BxaBrPXebaGGhRTcG6a+L+jLKQVFJJcjuOEGvTFOmOvcQCr3/J
         GpYV/r57N1l6STvBeHIB935mJSIEWHuDYo+QpxG7ANv38tRiv9hYk++afkqJCOvVBfGC
         Ia0AAUhXNoFkD2AeyIQXEaN12o/Rh9W16nQEMiUxy3l53mmd5xLay4qksq0n5J3EmCwv
         f9zcTJUFzt/dyuDdIf39gX8Jcp/1PTovjVNm5zZwwgkBl58DiS8+HHlhdl5sBs3zwc7r
         vM7g==
X-Gm-Message-State: AOAM530y6q16Ma+GUE+2HTFLiMes7VOslUIx/6yit8e4K0qTLWRkKb2q
        PiCub+KFj9051xRJDQgOKiE=
X-Google-Smtp-Source: ABdhPJzo4tYDYMN4QPqKFJ9QWagdn8EpJPAQRXK3B5M4gk3ofjxcN409cs5uQsZPzrbzvbpGwPtBOg==
X-Received: by 2002:a17:90a:4043:: with SMTP id k3mr11450036pjg.141.1601809133834;
        Sun, 04 Oct 2020 03:58:53 -0700 (PDT)
Received: from [192.168.1.5] ([110.77.216.3])
        by smtp.googlemail.com with ESMTPSA id g4sm7310799pgg.75.2020.10.04.03.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 03:58:53 -0700 (PDT)
Subject: Re: [PATCH] USB: serial: option: Add Telit FT980-KS composition
To:     Leonid Bloch <lb.workbox@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Leonid Bloch <leonidb@asocscloud.com>
References: <20201004095703.2633-1-lb.workbox@gmail.com>
From:   Lars Melin <larsm17@gmail.com>
Message-ID: <886eb499-4db4-1d61-2e67-0335423bf077@gmail.com>
Date:   Sun, 4 Oct 2020 17:58:49 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201004095703.2633-1-lb.workbox@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/2020 16:57, Leonid Bloch wrote:
> This commit adds the following Telit FT980-KS composition:
> 
> 0x1054: rndis, diag, adb, nmea, modem, modem, aux
> 
> AT commands can be sent to /dev/ttyUSB5.
> 

Please submit a verbose lsusb listing for the device, I can't imagine 
that the adb interface should be handled by the option serial driver so 
there will never be a ttyUSB5.


thanks
Lars

