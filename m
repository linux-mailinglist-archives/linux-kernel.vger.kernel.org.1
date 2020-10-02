Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FC2280FCA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 11:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbgJBJZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 05:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJBJZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 05:25:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E4FC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 02:25:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so985700wrn.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 02:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YE4BkDw7pw/Lfvi3q3uojYvMQTaYWdQVRY5SQ6Mi1Ao=;
        b=mUrPGKMiUAmjG+PhqFAmc9z0VK3qPvIJBYwvDOoslO4rjp7rgCOuTMR/6cSXC7Li2c
         XTZeIgpQS8b/qiWYQckr1/Mzy4LxKyBkCxqFFk3FTGWV/hqfFEDyJl6nPUR0A4CGg8Th
         hNEOcXPFRNjGa9U7+8erdb9mGnP9wfycSKV6d+RoDYVSe91Qh0hsunWjRnXFegduip28
         OMCNwUNJaLccxPXKhXWSnECceEWQLxrGn7xe/27PiedplhUtO1nfAQegAUQ1aNVFG/Nu
         WJ8FKGe6m2LQBV6Gm+7+ThrFokVI3PRv59psUeytbdvl8hQLGBWzBSSpkqMUoVNldj2O
         Y1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YE4BkDw7pw/Lfvi3q3uojYvMQTaYWdQVRY5SQ6Mi1Ao=;
        b=tXbjsHjrvMnXeDpYms1zHqC1RQXizv5eMx5IrXZo50DN8F5scDLjfh8YIKDswNU5sl
         HkzPp97v2kA1mrjOU05gPwYsg+zuZ39FzALJbVkce0K9dErUPcsxHsi5RzOpOdm3ccW2
         Cfh07J207Geb12q67YRQyLvXaAIihqBdYC+PklNCSFidBQS7OwX7E2vseSZBI6dwORxL
         qyp+vP2D71Lkn3Tk+Z6oGGn7AnuDIw2X7f65A5TDsEwtbxIbeYfQU6lmT7GTN1Xi+NYL
         TXqqx5B0s7aPU8jOYa7iXrl0gBuHymkj4IU43MVcNbQpptfiMxVVfKgkFZdjkO4dftx+
         Bzhg==
X-Gm-Message-State: AOAM530mPgjut0308mY/WpansdXepUZzX8ZfxmHeJ13mcaNCCkf2J0mk
        PIkEwEc8z0zSJSjqgYX2nI4=
X-Google-Smtp-Source: ABdhPJwNA4+A7fKCkNGZHL+rhL+nYYhSFgvaLDQ4qJT9xTAGZYLUGRJDL/bSHZlFrrEHdRU6xOvXtQ==
X-Received: by 2002:a5d:5512:: with SMTP id b18mr2069353wrv.229.1601630699671;
        Fri, 02 Oct 2020 02:24:59 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id v9sm1187338wrv.35.2020.10.02.02.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 02:24:59 -0700 (PDT)
Subject: Re: [PATCH v2 07/12] soc: mediatek: pm-domains: Add extra sram
 control
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        drinkcat@chromium.org, hsinyi@chromium.org, weiyi.lu@mediatek.com,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201001160154.3587848-1-enric.balletbo@collabora.com>
 <20201001160154.3587848-8-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <564daa4c-c8be-7743-a2e2-a29013b17049@gmail.com>
Date:   Fri, 2 Oct 2020 11:24:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201001160154.3587848-8-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/10/2020 18:01, Enric Balletbo i Serra wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> For some power domains like vpu_core on MT8183 whose sram need to do clock
> and internal isolation while power on/off sram. We add a cap
> "MTK_SCPD_SRAM_ISO" to judge if we need to do the extra sram isolation
> control or not.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2:
> - Nit, split readl(ctl_addr) | pd->data->sram_pdn_bits in two lines.

Nit: si was done in 2/12 :)

Regards,
Matthias
