Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55621F4B56
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 04:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgFJCWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 22:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFJCWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 22:22:45 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5D0C05BD1E;
        Tue,  9 Jun 2020 19:22:45 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y18so352486plr.4;
        Tue, 09 Jun 2020 19:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UpfONqHOTnPkMZI1MuZIK6j7EXHEnIyi1MFBGT9FXEA=;
        b=dMQRy+Gp5fMQtRBL8EX0XCXRRd9k8EdV1ldu8ZaCdpLe7rBBQxMquJ36WWEmNUoT/K
         MUHvzmAFnuO10U79TmazJZX4rFRU04WjwPczqmhhgShahd6kXZMjJM7u3Q/ARC/0fe5+
         SUGQjfdFo3lcXQGrDG+6aCIqRNcWpZsO6Oqw7ilikMHuu3AUSD3gpV5JhK6l71Piwyno
         6O1ApwsVeiTwhPI+S3IYP2GtMvY7GePmdilTVmfbypUd2E/8AHpGF0PakV/NX/rEzyhu
         9baoLc3XAWoK3ZQ4vGXhX0gBHCT3/1w2+skjZsXU8EOqFczeDb+OalNDj0ClPd80ez45
         bvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UpfONqHOTnPkMZI1MuZIK6j7EXHEnIyi1MFBGT9FXEA=;
        b=Azl5K3CZAvO7V4gXWGCQZAIy9MZjjepbMzBd3kRfYV5ngAcmBSaE1C5OQ8n7YxKVp8
         dlWQm8b15Jiq47DD6mq+u9LXhUXRobg/DCad+8PWWvseHzSliD92BMyTiDG0yhWK17Uf
         VNMgWPXiNVgYOnjUIr8MxSeLGKRmoRg4Afx5TM7Cv3UWmqhWfmCy5YoS55K1ordta25C
         aNRv72GysYiO21sGE4ow6/jmlAmmotgdhRurzUW9+1uC1yMNLT7lc09kafwecTndOl79
         p/6TT+W3u9S0H3+ZEyEYLKurgWLQ+Dehmu+g3cwI50yTRuueAae6r8615Rjfzemzn/XK
         BWRQ==
X-Gm-Message-State: AOAM533q82GMPP1UddF4DVJaIMzkh+lNwSlCw9t9h3Ou4cwKObOnO1Lv
        CKv5ieyluk6giidN5S2j+ELO/VAD
X-Google-Smtp-Source: ABdhPJzaaYXoIL6215yKQWaWFR4LG1Geaz3r+nF0Ie6KUmiSAO7bVi4+B83Uaghj2fAMv8mERp0jPQ==
X-Received: by 2002:a17:90b:430f:: with SMTP id ih15mr750281pjb.61.1591755764484;
        Tue, 09 Jun 2020 19:22:44 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m7sm11163371pfb.1.2020.06.09.19.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 19:22:43 -0700 (PDT)
Subject: Re: [PATCH] clk: bcm63xx-gate: fix last clock availability
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        mturquette@baylibre.com, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, lkp@intel.com,
        jonas.gorski@gmail.com, f4bug@amsat.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200609110846.4029620-1-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <916f6100-34d4-cd5c-025d-de236546daa2@gmail.com>
Date:   Tue, 9 Jun 2020 19:22:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609110846.4029620-1-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/2020 4:08 AM, Álvaro Fernández Rojas wrote:
> In order to make the last clock available, maxbit has to be set to the
> highest bit value plus 1.
> 
> Fixes: 1c099779c1e2 ("clk: add BCM63XX gated clock controller driver")
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
