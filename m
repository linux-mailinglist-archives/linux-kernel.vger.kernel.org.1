Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7AA2A12C2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 02:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgJaByK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 21:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaByK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 21:54:10 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ADCC0613D5;
        Fri, 30 Oct 2020 18:54:10 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lt2so218764pjb.2;
        Fri, 30 Oct 2020 18:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ldYdIZUCPtRBuaJd3Pfmcs1j7OO61x1AmnRQICBqUzw=;
        b=pfIilmuapsdAVkjx4m5RZsgHZ5LIjYtlfPfHBC2bvVxkItkxpra0vgG5oyAomWe497
         bfkqiSY5ZS51JZfyFDxmkYlwuVA3RHPYfh5nXO4RXJxqd/N/5MJfoGqyJFJSSDe2u4OY
         FriSV1RR1XeQHIUxD20ovJlg1vW1cN83Eo7p/zCWUXTSFUG5YajWHa3E3mn+sUEvIQdM
         VLVxqzNyMd06JWvKINowGEsKl9mdpXoAHIlmLNJi6KTtfiZuST/ggtedrVYnQSA79mSp
         I3ZvKcNBQOzVkCDBYmrxdjESIAen3tRZFgLahFmCk1sw1nLbS3uP7ThU0vwJBRPuFUQT
         /nMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ldYdIZUCPtRBuaJd3Pfmcs1j7OO61x1AmnRQICBqUzw=;
        b=d54iLjSjJ1+xg44YNYYOxDKmP9he8sWs6jE9pSpFts2cwNNDy7KwgD7/zY9n6xC+y3
         hYCfBPBs/REhjf2Fgufjb75IOTomp2OGaq35g+aaJ6lBNu0ZSVxcHZHuOlQpsYhWBhwz
         DpMOENFTNFWf5gE2CqvGSlCWPi6fJ5u8uNgMMc0Vtnfw35fBNH9VBTM2GZE+Web1pKub
         9MnfytpRRdPSFajiGdppIEqg2UXh7bBDzXOq9AsLHvJOSeKepMXuNRDI/So9ku/2e2XJ
         i1IwWRePF4m57SPnLdWIRSUGy7nY+y8TDizhnjTAyKpaIIo9RbsUnDJf0H0pJvL3us+n
         MZbQ==
X-Gm-Message-State: AOAM533a2pEnEmv1Jv0sZa8eYmqr3PxvM0Ib7XlOUu59RGcLXxjZGy+W
        UTpyZhiXRf9qbDuTmeYhdWCDsp8mcOs=
X-Google-Smtp-Source: ABdhPJxHlrMNny19tXs0QOssYWqzqAQVpkpxSDP0CF2yFNWiVvbhgwUxPKMsjUzzzI/IVMKf0LYY9g==
X-Received: by 2002:a17:902:7681:b029:d6:42d5:6af3 with SMTP id m1-20020a1709027681b02900d642d56af3mr11627028pll.12.1604109248831;
        Fri, 30 Oct 2020 18:54:08 -0700 (PDT)
Received: from [10.230.28.254] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g22sm7152814pfh.147.2020.10.30.18.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 18:54:07 -0700 (PDT)
Subject: Re: [PATCH -next v2] usb: Mark sync_all_pins() with static keyword
To:     Zou Wei <zou_wei@huawei.com>, alcooperx@gmail.com,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1604108889-15205-1-git-send-email-zou_wei@huawei.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <71fd1c46-a674-a3a8-666c-d4240a866470@gmail.com>
Date:   Fri, 30 Oct 2020 18:54:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604108889-15205-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/2020 6:48 PM, Zou Wei wrote:
> Fix the following sparse warning:
> 
> ./brcmstb-usb-pinmap.c:219:6: warning: symbol 'sync_all_pins' was not declared. Should it be static?
> 
> The sync_all_pins has only call site within brcmstb-usb-pinmap.c
> Mark it static as suggested.
> 
> Fixes: 517c4c44b323 ("usb: Add driver to allow any GPIO to be used for 7211 USB signals")

Not sure if the Fixes: tag is entirely appropriate here, but sure, why not.

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
