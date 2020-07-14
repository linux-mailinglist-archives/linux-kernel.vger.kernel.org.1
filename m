Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949EF21F5D7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 17:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgGNPI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 11:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgGNPIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:08:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84772C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:08:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594739333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=abOwsb/H+mxHjN22WO9IsbbGy077NPz9xL3vebfSX5A=;
        b=PiOFeJm6Z/HMxh1fraj4HHFtcqFW1bxQUsdEGzjKuAFCw2Yzum8zp10O1MtlHYxRJrN/lW
        cRimnumFhQouW4/b5Dgjd2BO2jS3AhoAIqjmAZcdMrh2wA9gH2LYqypQHgfzj/sgFcDsxz
        07zWAtfyAY4bjcw6bpEiQRRG8/oRC459KBleTOdBGPuJtb2elApTNijnxDMyVDExlvpOL+
        bGxf65z3dCuE/ata3TsE4xPwGstf05N6vSeqyRAfORmC8BxIEaHeND+/pbmcwgedI+WOCV
        iOpgSlEV/AY6RAkRlvWOZm3HxCWyPQNGZE5ZtQXmKGQat9ushB5PDx1PKkvrXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594739333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=abOwsb/H+mxHjN22WO9IsbbGy077NPz9xL3vebfSX5A=;
        b=8w2x4QmsyaJytPpc/92fuAvQQ2kKl4G8ty+WpyYlxKOtUwPfkyHGrb2iaQDFgH0Mxe8g+y
        vGS6+f7CZeNK8YDg==
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        john.stultz@linaro.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH] timekeeping: correct typo
In-Reply-To: <1594648845-17200-1-git-send-email-claudiu.beznea@microchip.com>
References: <1594648845-17200-1-git-send-email-claudiu.beznea@microchip.com>
Date:   Tue, 14 Jul 2020 17:08:53 +0200
Message-ID: <87r1teuoai.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Claudiu Beznea <claudiu.beznea@microchip.com> writes:
> Correct typo in logarithmic_accumulation() description.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  kernel/time/timekeeping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index d20d489841c8..6b436d7a751f 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -2001,7 +2001,7 @@ static inline unsigned int accumulate_nsecs_to_secs(struct timekeeper *tk)
>   * logarithmic_accumulation - shifted accumulation of cycles
>   *
>   * This functions accumulates a shifted interval of cycles into
> - * into a shifted interval nanoseconds. Allows for O(log) accumulation
> + * a shifted interval nanoseconds. Allows for O(log) accumulation

If you fix the typo, can you please add the missing 'of' as well?

Thanks,

        tglx
