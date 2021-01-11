Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AF72F1BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389241AbhAKRIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:08:31 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50186 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729405AbhAKRI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:08:29 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kz0fS-0001uP-Rx; Mon, 11 Jan 2021 17:07:46 +0000
Subject: Re: [PATCH][next] ASoC: soc-pcm: Fix uninitialised return value in
 variable ret
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?B?5pyx54G/54G/?= <zhucancan@vivo.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210108123546.19601-1-colin.king@canonical.com>
 <20210111163551.GA33269@sirena.org.uk>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <02666c81-5b0b-fe48-5d9d-63f2f007bfba@canonical.com>
Date:   Mon, 11 Jan 2021 17:07:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210111163551.GA33269@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2021 16:35, Mark Brown wrote:
> On Fri, Jan 08, 2021 at 12:35:46PM +0000, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Currently when attempting to start the BE fails because the
>> FE is not started the error return variable ret is not initialized
>> and garbage is returned.  Fix this by setting it to 0 so the
> 
> This doesn't apply against current code, please check and resend.
> 
Just to double-check, which tree should I be working against?

Colin
