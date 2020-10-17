Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F000A29123D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 16:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438282AbgJQOL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 10:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438236AbgJQOL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 10:11:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27A4C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 07:11:26 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id q21so3155981pgi.13
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=12Ji5Bjg6Q6+5eR/BATj6e1cUfsvLG8jGphkcoZtqEs=;
        b=T1tIoroiskrApvot4qmdEcSv676E9+PsPQrL8UIy19cwwPYy7m9Wf4CjAzcOuw/528
         9SDZFrfwYhXT1Gk/ps3UXn0i0esdabOCGTOHxBJCS13qdW7GnmcjzD/S6WZ9x74WNsEd
         hZ8Amf2RKauFD7DqiPnNFslTR6ox0JGb6NKieB9W+DKm5J7Wjm/OX5dCcpCzpkGJHHAi
         4XJVYurZoFmEH5krNbqD4q9y+Scw3K1SqJlACTSFUgAJ36+sFqdBcBGhvQPcsswnLxJW
         5lY1rV8czhvnffMOBV7hFLtzOSwykhvBPooA+cllVvAzI65cgogdBnvXxn1F/Mg/22py
         jmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=12Ji5Bjg6Q6+5eR/BATj6e1cUfsvLG8jGphkcoZtqEs=;
        b=Xtje3+jDGwvs0ZdpCSOY+8BbsrwQeQ/Jee+jTcFSBugvL6g9L+ZmggpKPWoUI34uFO
         OUpUjV3FYshyD1zLIxF6Ip5Caw8f7NSqtq3rq6Pjgo3ETzJRt6i195IkSFP5+TCXRDDf
         Q+TGX/YX+zZlX+P77aOpaZ45m4HX8nl35H9APVnbOzLVvpKYHVDwaj1GX43L0AlNFifA
         PEgyzQGOeBvWzK+E50MBfxoT3J80S3kzEf7WQSzWtcwpbZsfXHm2T/9NvdQhCNjSNn0s
         ZyO5yUwbT/+DVZtgHUfAhIz2FcEKmQWwTcNLMYFspNXr0PzjnarCCgFnm2s6xqFL/anL
         GYlw==
X-Gm-Message-State: AOAM5321kfeCERggqA/GVVKS774J6f7NgXrtpcBOxTlO7xQrzARafi5F
        pLVyo3niiYC+7loQerXSfJzO+DcpFlim116M
X-Google-Smtp-Source: ABdhPJwCzxxjLR6d5+9u+pKVZ98sOcfRf9TTR3qMd2Wvz49D6bWNcprTvFqEZf2k1myQVqjVb6PZcg==
X-Received: by 2002:a62:878f:0:b029:155:ec80:9658 with SMTP id i137-20020a62878f0000b0290155ec809658mr8501357pfe.57.1602943886134;
        Sat, 17 Oct 2020 07:11:26 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id f7sm6170615pfd.111.2020.10.17.07.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2020 07:11:25 -0700 (PDT)
Subject: Re: [PATCH] skd_main: remove unused including <linux/version.h>
To:     Tian Tao <tiantao6@hisilicon.com>, Damien.LeMoal@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1602899549-8241-1-git-send-email-tiantao6@hisilicon.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c57d8f33-30d8-61b6-36c7-037211ad9900@kernel.dk>
Date:   Sat, 17 Oct 2020 08:11:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1602899549-8241-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 7:52 PM, Tian Tao wrote:
> Remove including <linux/version.h> that don't need it.

Applied, thanks.

-- 
Jens Axboe

