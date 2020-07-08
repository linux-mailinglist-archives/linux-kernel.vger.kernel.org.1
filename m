Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C0B2182A5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 10:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgGHIjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 04:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgGHIjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:39:35 -0400
Received: from [192.168.0.50] (89-70-52-201.dynamic.chello.pl [89.70.52.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF3F21D6C;
        Wed,  8 Jul 2020 08:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594197575;
        bh=8v00HsesZ/yoYMitcpoPiDdEOdjfr31bHEWutYYi8K0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Bkd31+YWVBIlAFY4FlWJxPEhsQ74gF6+5bz7FTW7rX6YdEmb7DOxScpZ5fpCpQyR5
         4s7TLJiKrCIYiIl0/s+h/eSDg7AEuK5/U2Pe9B2wLCASLFFZZfFp0Q5d2OncsmdpLN
         t3qnU58t3IRftZ6jTGHtfFcZ0tg529c6Y1AF6S48=
Subject: Re: [PATCH v2 14/28] ASoC: samsung: pcm: Demote half-documented
 kerneldoc header
To:     Lee Jones <lee.jones@linaro.org>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaswinder Singh <jassisinghbrar@gmail.com>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
 <20200707143742.2959960-15-lee.jones@linaro.org>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <f85a033f-b435-2611-5be5-1c83edf8cd42@kernel.org>
Date:   Wed, 8 Jul 2020 10:39:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707143742.2959960-15-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 16:37, Lee Jones wrote:
> Ideally the author or someone 'in the know' should come back and
> provide the remainder of the documentation.  Until the kerneldoc
> checkers have been satisfied, let's just demote the header to a
> standard comment block.

Thanks for the patch Lee, Pierre-Luis Bossart has already corrected the 
documentation by adding missing entries in patch:

[PATCH v3 03/13] ASoC: samsung: pcm: fix kernel-doc

> Fixes the following W=1 kernel build warning(s):
> 
>   sound/soc/samsung/pcm.c:127: warning: Function parameter or member 'lock' not described in 's3c_pcm_info'
>   sound/soc/samsung/pcm.c:127: warning: Function parameter or member 'sclk_per_fs' not described in 's3c_pcm_info'
>   sound/soc/samsung/pcm.c:127: warning: Function parameter or member 'idleclk' not described in 's3c_pcm_info'
>   sound/soc/samsung/pcm.c:127: warning: Function parameter or member 'pclk' not described in 's3c_pcm_info'
>   sound/soc/samsung/pcm.c:127: warning: Function parameter or member 'cclk' not described in 's3c_pcm_info'

--
Regards,
Sylwester
