Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBF7249EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 15:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgHSNEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 09:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgHSNDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:03:41 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC061C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:03:40 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so10801851plt.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ejN3I2ZufYX6NBqQUqeno+sm8YT/7Lwa4+bx/+FXbdA=;
        b=RK3qgkhvRM2gvw0S8x5GDoJP8wGn2aiJDGRVphrf/MgMgy+YwgLX+dNT1C3wt6zrZg
         zmUjFjUiuQ2TuCyjfBnDEy/K637MzELUaKf3W+14o3gGTFR8bC3vfmcNycj2vODDJt5R
         02hxuPxiycQ3DqUe7rW4Rb/Dyv0/7NgOvf9Gww0kvS2mDoV9HeOcIRlcQ0cLS/hkF1oe
         AsZZczxpJZ5MQvzlRZ0O5Gfyii3+Eu7Ee5CTvtaHrbdFescaR+ZyDvaLIUlkNB9dRo56
         6xVVOHS9VdqXuXu1XcEQh35cyLIiipbGoV80IY2VS+QF+grdlkLFV8WzRLhohfzZ5Olv
         UCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ejN3I2ZufYX6NBqQUqeno+sm8YT/7Lwa4+bx/+FXbdA=;
        b=H9T9VILZ3Dm9DAcuxRN0EIRfEp0F0Z7+wSv+bkzjnfhYBmGbwPlndnpOCNuVjSb+FK
         4TC4ln30DBGcucPwdKDQ4Cl3Mv1aqvi1+X1LIs+bR5U/m8OWLzU7bHWlH/v+inbAchUS
         z790Ikk2dMlKVZEmnh8Cb2C70i50R5FIrzeJVEP+a39VIMK2xK031d6oQ+26mwUkDMH7
         RznXx2pE8fejW0+BFvbtqaiOg1/jQMDkxxVmrT/unIj5c7Lf6VUk7nw9dEyNryew51GK
         SOlHukSsLjvhjLQlSkpzM8SGgeBM5+vloTBCJTx/Bk7s4vanIpjQ2j5CQdkvK0QyJFHr
         7D3Q==
X-Gm-Message-State: AOAM532SgakZ7w85/98RuNLBCGiCSvg0gTBj11ljkb93DpoTZrml/MSL
        EisvCV2A+qOz4w5ktPcOL0ioLVLiFDKnl4VT
X-Google-Smtp-Source: ABdhPJzAxffViDj0kPIe6fi+J185UwCphUfnLI8xm2PJkJtQFETAiC9HfWQrFY9NWmRPeyH+Wm/7fA==
X-Received: by 2002:a17:90b:4a4e:: with SMTP id lb14mr4089822pjb.228.1597842218449;
        Wed, 19 Aug 2020 06:03:38 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x9sm28536071pff.145.2020.08.19.06.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 06:03:37 -0700 (PDT)
Subject: Re: [PATCH] block: Convert to use the preferred fallthrough macro
To:     Miaohe Lin <linmiaohe@huawei.com>, paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200819085044.41887-1-linmiaohe@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <035265c0-29e5-059a-0625-ea27609fa38b@kernel.dk>
Date:   Wed, 19 Aug 2020 07:03:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819085044.41887-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/20 1:50 AM, Miaohe Lin wrote:
> Convert the uses of fallthrough comments to fallthrough macro.

Applied, thanks.

-- 
Jens Axboe

