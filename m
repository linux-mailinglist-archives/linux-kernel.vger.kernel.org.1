Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA3E2BB0E3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgKTQrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:47:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729303AbgKTQrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:47:06 -0500
Received: from [192.168.0.50] (89-70-52-201.dynamic.chello.pl [89.70.52.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 926A92075A;
        Fri, 20 Nov 2020 16:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605890826;
        bh=YDvxkQfSjvu+0SikCKKbCn6uLgy8FVGGQiRe0c5xiVc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uBXWip375+XrF/ZE+X8BkpJr4ozZgbjVbQ2q8dwSjTuDAjNTsZT3I92JcRHuzIJic
         MJyvQ4uheRuTbvgeo9XgfMC2J5tgXuR1bt1BMkX3eGUxwvDYIGCcB2/8mCnqFm5mHp
         nRA3nwLX/6KSiPnCi/NNedYmx12+ex8xW9SvwXyM=
Subject: Re: [PATCH 38/38] ASoC: samsung: smdk_wm8994: remove redundant
 of_match_ptr()
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20201120161653.445521-1-krzk@kernel.org>
 <20201120161653.445521-38-krzk@kernel.org>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <cc848379-073f-f6f5-53bc-f3ca9abf915c@kernel.org>
Date:   Fri, 20 Nov 2020 17:47:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201120161653.445521-38-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/20 17:16, Krzysztof Kozlowski wrote:
> of_match_device() already handles properly !CONFIG_OF case, so passing
> the argument via of_match_ptr() is not needed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Sylwester Nawrocki <snawrocki@kernel.org>

