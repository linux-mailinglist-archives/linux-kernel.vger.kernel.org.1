Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229BB294F65
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 17:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443875AbgJUPB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 11:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443311AbgJUPB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:01:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B961CC0613CE;
        Wed, 21 Oct 2020 08:01:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c194so2538955wme.2;
        Wed, 21 Oct 2020 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CmZJEeB0EP0to5PUH8qZKDgNuL15HeJtvXK0sppnMfY=;
        b=tBnl1mWsou68tjflJD6zDZkkOPRr2TeeY9wvEfFU5dUBg/566To/0N47y1wt40iT7O
         1beHvrVGKzxTYU+Dy0hK2ncLl9Qey72B2XITh/QH+HBikHNsyFoEIB1FCNA8p4KG4m4x
         0h3oGTF0l+pkLeQ3rHb44QCkOX/gnxIBCU09XqtYMb6Dy4vUweEuIi1bC/0284N0XHML
         quNuA2QTcB+8TnNeILyVWjPVZk4PXB5AwPkPICNNBVZ8JRmtLuytYmkIyrAPzzPfobLE
         MYrSqANObTEiXXmI3Pu2XGpPFxu3/Q6Px1QDW6VjiKNUmikQG936cyzds+QqetwT+p1d
         /EIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CmZJEeB0EP0to5PUH8qZKDgNuL15HeJtvXK0sppnMfY=;
        b=e9dVZN62hZ/h+beN/zRQD17NPFZcMmRSlE3GB+TmzRGMGOQ9DayhmJeuZjR5bgXjZ7
         Sk40bsu0xddYlnHiANVo5N0q4Nemte6rBgMyL987/bvFRORoS6ELux0Ii46P4jPFDlZW
         wDReOT+7eV8KdGQfxBsv7J745FNDw2sniRdQ+aEAXznwRVIhye2BaIwJmGZxJ6umCP68
         ugDLkmC4Egvu9IKJGmfnM4Gbu0BeCCey3uwtxIwOSbsKkccUQOUJUN03Uun7/MfyxG9J
         UGHg3npBctNGj6LBqiif1gDRIk1i16r2YBN8EJCP85+dGTCdF/On2tqfKJI0rHBd94wt
         pv9w==
X-Gm-Message-State: AOAM530S+werJKBnJ5uaqmF30GbRauNQWICbqg0gUdeAOYJqDCTwHSPe
        P29NLNdh7cEqHBbIXvCqhKa05/6jWVA=
X-Google-Smtp-Source: ABdhPJxjrvqirXHdq8HYENHba1GqZ0F12Rjpp5uYlCx8m8Zp8QK1QczgvTmV0od/Kh/XQv3Q91kLxQ==
X-Received: by 2002:a1c:2485:: with SMTP id k127mr3965986wmk.130.1603292483806;
        Wed, 21 Oct 2020 08:01:23 -0700 (PDT)
Received: from mamamia.internal (a89-183-37-0.net-htp.de. [89.183.37.0])
        by smtp.gmail.com with ESMTPSA id h4sm4556821wrv.11.2020.10.21.08.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 08:01:21 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add support for LED2
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?G=c3=a9rald_Kerma?= <gerald@gk2.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201006124455.16617-1-pali@kernel.org>
 <20201019080408.iv7vmj63cgt2i6vg@pali>
From:   Andre Heider <a.heider@gmail.com>
Message-ID: <2b5b0648-eccb-e4b5-fba1-43f03f054a20@gmail.com>
Date:   Wed, 21 Oct 2020 17:01:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201019080408.iv7vmj63cgt2i6vg@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2020 10:04, Pali Rohár wrote:
> Hello! Gregory, I would like to remind you following patch.
> 
> Andre, if you have a time, could you test it too?

I would, but I desoldered all LEDs a long time ago because they're way 
too bright...

Regards,
Andre
