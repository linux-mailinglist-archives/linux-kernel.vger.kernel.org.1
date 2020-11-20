Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65C62BB0D4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgKTQmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:42:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730146AbgKTQl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:41:59 -0500
Received: from [192.168.0.50] (89-70-52-201.dynamic.chello.pl [89.70.52.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99E482225B;
        Fri, 20 Nov 2020 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605890519;
        bh=RsU56jrCTRWv4W91wOKbnibTHglkZi7P7QfGXIPhqpA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gJLOhvR5L5VgwE7TZnkHSW4qrYnNWQ3fXTc25doOGPDRRdRWM6O+TLfG3+fFkU9jO
         8iYrkx0KgVOtEAIajKdMvqYFqXiolSPDlZNoGIvIKqg9Voyn3ChCG9UI9glRsANZ+g
         5H4KKLgNW934lKUFbc3lTVL8ZWoWVuT6F8VpPKLo=
Subject: Re: [PATCH 34/38] ASoC: samsung: i2s: mark OF related data as maybe
 unused
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20201120161653.445521-1-krzk@kernel.org>
 <20201120161653.445521-34-krzk@kernel.org>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <d4387617-bdfe-e80c-8d8a-5597d3bf67f4@kernel.org>
Date:   Fri, 20 Nov 2020 17:41:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201120161653.445521-34-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/20 17:16, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
> 
>    sound/soc/samsung/i2s.c:1646:42: warning: ‘i2sv5_dai_type_i2s1’ defined but not used [-Wunused-const-variable=]
>    sound/soc/samsung/i2s.c:1639:42: warning: ‘i2sv7_dai_type’ defined but not used [-Wunused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski<krzk@kernel.org>

Reviewed-by: Sylwester Nawrocki <snawrocki@kernel.org>
