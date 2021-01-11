Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6650E2F1C96
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389766AbhAKRiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:38:19 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51445 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389458AbhAKRiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:38:19 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kz18K-0004GW-RF; Mon, 11 Jan 2021 17:37:36 +0000
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
Message-ID: <9bef4fe5-0eed-03f8-9505-909b669ba49b@canonical.com>
Date:   Mon, 11 Jan 2021 17:37:36 +0000
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

Current ASoC tree now has two commits:

commit 4eeed5f40354735c4e68e71904db528ed19c9cbb
Author: Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat Jan 9 09:15:01 2021 +0530

    ASoC: soc-pcm: return correct -ERRNO in failure path

commit e91b65b36fde0690f1c694f17dd1b549295464a7
Author: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Mon Jan 11 12:50:21 2021 +0300

    ASoC: soc-pcm: Fix an uninitialized error code

..both set ret to non-zero, which I believe will throw a subsequent
warning messagethat's not strictly related.

my fix was acked by zhucancan@vivo.com, so I'm now confused what is the
*correct* fix.

Colin
