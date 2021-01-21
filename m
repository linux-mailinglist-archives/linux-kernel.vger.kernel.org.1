Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC8D2FF583
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbhAUUKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbhAUUKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:10:25 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC09C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 12:09:39 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id v19so2058936pgj.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 12:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1PBuVr98tisNyNC2AA1cvPVEXnxqIUbtO/yR5FgQiPQ=;
        b=csD8hjg4i4nfK3OO3VeKqrrkT22R5GdmArVqGVFy54ZUOR8p+F3D1ueui+RU6v0iLt
         uDNb5prExVm7e5EOzc7hVw6cdAjiWwLI/rH3XCBE8R1WMnSp1yEFU1vVRX6f6McjYyij
         XAUoup3W+4gkNSWonaWday/B4cyBI8gcNRBhH0SuBg9L2aPB7eRMDPAfnmGD5jXv5KGJ
         U8RnsRI6jzik3lnN9P4Ki/iKqG9MWTbp4LViMZ4/SLfkiRdnQnNw3z7IsRNY7Ewk62N1
         hr8E/K9sstGXYUUJVIk+NkZBHufvATEBuW4CBBB1dFgzqZyFflGjgG1Bu6dd6hoKgj0X
         Tc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1PBuVr98tisNyNC2AA1cvPVEXnxqIUbtO/yR5FgQiPQ=;
        b=hTn7y07WuXuhIVe8IFMZGjIyXpbHbmck1I1HlSu7XnydrGC8LA0G50FTmwvQWjv/uU
         xOUxOIYCw7s0uA7Xmi7Lp8enRvHb2rbAFaF1p+w/3oYFcPcIu05eYYjld0/llgRjTiMv
         EDTXPXeRF4WZJ4Mne7rVCFOzL4l5SzT1K9BS9obPBVZHgbqWk8zuUEnT3W3sQMWxpwVi
         JCGzPxEYUpnSPEnQTNG7fmQJGOpcb8cP0rQzN3PPAuwyMv3JVBxcFU3e3gUFfT1KJzuw
         nN8LySnEgRbm+GzzEkNr0hsRbu+og3gsUVO0KdmHz4eMcRuSNe3B1ZSyTwDuJpmIA5dF
         p0AA==
X-Gm-Message-State: AOAM531DitEo3Bk9gj3dKAj6GnS0HcGvvDDzQY9QVfAnnDZ6eiodfxHc
        fZmKpfr5W2+nLDxd4YCNpuPo8Ik3uMo=
X-Google-Smtp-Source: ABdhPJzCzlBPQNgN11cYcMP6nA2MJmWB9U7wsIPP5ysZYCupQB2GvTpGtwTWJS5VkmYnPc1qeOaxpw==
X-Received: by 2002:a63:af05:: with SMTP id w5mr1005481pge.22.1611259778677;
        Thu, 21 Jan 2021 12:09:38 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v9sm3428705pfm.80.2021.01.21.12.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 12:09:37 -0800 (PST)
Subject: Re: [PATCH] ARM: brcmstb: Add debug UART entry for 72116
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210120200156.2782528-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <01b9fc82-8c80-80b0-3249-5f1bdb03d6c6@gmail.com>
Date:   Thu, 21 Jan 2021 12:09:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210120200156.2782528-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2021 12:01 PM, Florian Fainelli wrote:
> 72116 has the same memory map as 7255 and the same physical address for
> the UART, alias the definition accordingly.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to soc/next, thanks!
-- 
Florian
