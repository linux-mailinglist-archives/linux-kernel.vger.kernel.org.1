Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85342B06E2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgKLNoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbgKLNon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:44:43 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7B1C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:44:43 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 23so6035503wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=To+ZcG/r9vVpmGTgBDlDgjUCMbHCTExbI20k8BWQjAw=;
        b=W+PD2VKQasIWpPzZDio9fbNElNIoCjulot3D66PEGLZAkugr3AWKAB3XypmeTTfnF8
         c6woS+AwCDqSmXQRClfHXVpv7YM3NA3VoziRWWORy8nOETQebySVUvGVd/nTRK4rGWRB
         Cnux95sw7lFkrZQaD8W1dhPKakcMa7M3+6QksDbq1wnjKX7FCpYOysy0vIt1WEVwNFCw
         JUT0FPxJQgZdQ7BTUjydi2GJOswAD6jKJt/yM29jAJgTxN8HFlUUezJUcKn9q5/Ox72N
         IQH+rRwsW+lwfAOijCg/UfyKPkL1gOnrEGySIftwvbtpXwXdLnWfN5Za0/fD6e1BOO1f
         PDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=To+ZcG/r9vVpmGTgBDlDgjUCMbHCTExbI20k8BWQjAw=;
        b=kwOGGYQWJcOPCUAMh3QZHAEX4iZbvKUbWKYFpribllf2FsxoOBSleCI4BRggC1EbcY
         zAdy9uye3zielhhE/C0nmhcINyQWfOzew5hh1MUZYFeQ+M8G6Kq9ZtJgbpOIhVIjX1D9
         kdFwgmcmkR7VKZ1Geb7OXpJOzq2PYhmxWQEmLh5bvotSqW7H2gKff6o9A+Ple/hX3JUH
         PwwHy/qnFtI+UgEq4WCzSV5gJ0wDf8bf7kcaXHKCSTN18/csCHmVFxfTgqQL2lSdnpGH
         7aXsPM0mrwzktB8ju2RL035TD57ulDiIs9eF6ZxZWLiNck7aOHycSGKj4XS2xzBv1jZW
         4tvA==
X-Gm-Message-State: AOAM531v8xU8Jp0R+DmoRjuM/x+ObPBy0VFfGfcZrZjH7FjtlFFziPJz
        5he0oo8ShwW1iPKrwRQyRtMdBA==
X-Google-Smtp-Source: ABdhPJx5CbQywNCBG7tQePsWuRkCM0wYavBBbiZJXSc5QgZNhdOAjtuKa7umBsaCO2JeXLOhnsnTgw==
X-Received: by 2002:adf:fc48:: with SMTP id e8mr27381460wrs.313.1605188682181;
        Thu, 12 Nov 2020 05:44:42 -0800 (PST)
Received: from ?IPv6:2001:861:3a84:7260:5d3c:83d5:8524:33ca? ([2001:861:3a84:7260:5d3c:83d5:8524:33ca])
        by smtp.gmail.com with ESMTPSA id t9sm6744292wrr.49.2020.11.12.05.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 05:44:41 -0800 (PST)
Subject: Re: [PATCH] reset: Add reset controller API
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
References: <20201001132758.12280-1-aouledameur@baylibre.com>
 <CAHNvnFO=kH25CqrAcndVO4xTQ2pGDFi5ZHEALpFaZaGL=e_c0Q@mail.gmail.com>
 <87ac087154f461b6cac632bb62b92b8b94d90a67.camel@pengutronix.de>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Message-ID: <9eb59bf5-0b13-c830-dfe0-a20549769a5b@baylibre.com>
Date:   Thu, 12 Nov 2020 14:44:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87ac087154f461b6cac632bb62b92b8b94d90a67.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Thank you very much for the review.

Please find my comments below:

On 02/10/2020 13:14, Philipp Zabel wrote:

> Hi Amjad,
>
> Thank you for the patch, comments below:
>
> On Thu, 2020-10-01 at 15:55 +0200, Amjad Ouled-Ameur wrote:
>> An update on the patch title, since we don't add an API but extend it,
>> The title should rather be: Add a new call to the reset framework
> I think it should even say what functionality is added, for example
>
> "reset: make shared pulsed reset controls re-triggerable"

Will do !

>> Le jeu. 1 oct. 2020 à 15:28, Amjad Ouled-Ameur
>> <aouledameur@baylibre.com> a écrit :
>>> The current reset framework API does not allow to release what is done by
>>> reset_control_reset(), IOW decrement triggered_count. Add the new
>>> reset_control_resettable() call to do so.
>>>
>>> When reset_control_reset() has been called once, the counter
>>> triggered_count, in the reset framework, is incremented i.e the resource
>>> under the reset is in-use and the reset should not be done again.
>>> reset_control_resettable() would be the way to state that the resource is
>>> no longer used and, that from the caller's perspective, the reset can be
>>> fired again if necessary.
>>>
>>> This patch will fix a usb suspend warning seen on the libretech-cc
>>> related to the shared reset line. This warning was addressed by the
>>> previously reverted commit 7a410953d1fb ("usb: dwc3: meson-g12a: fix shared
>>> reset control use")
>>>
>>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>>> Reported-by: Jerome Brunet <jbrunet@baylibre.com>
>>> ---
>>>   drivers/reset/core.c  | 57 +++++++++++++++++++++++++++++++++++++++++++
>>>   include/linux/reset.h |  1 +
>>>   2 files changed, 58 insertions(+)
>>>
>>> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
>>> index 01c0c7aa835c..53653d4b55c4 100644
>>> --- a/drivers/reset/core.c
>>> +++ b/drivers/reset/core.c
>>> @@ -207,6 +207,19 @@ static int reset_control_array_reset(struct reset_control_array *resets)
>>>          return 0;
>>>   }
>>>
>>> +static int reset_control_array_resettable(struct reset_control_array *resets)
>>> +{
>>> +       int ret, i;
>>> +
>>> +       for (i = 0; i < resets->num_rstcs; i++) {
>>> +               ret = reset_control_resettable(resets->rstc[i]);
>>> +               if (ret)
>>> +                       return ret;
>>> +       }
> This is tricky, as we can't really roll back decrementing
> triggered_count in case just one of those fails.
>
> I think reset_control_array_resettable has to be open coded to first
> check for errors and only then loop through all controls and decrement
> their triggered_count.

I agree with this, it is risky to start decrementing before checking for
errors. The V2 will include an open coded version of this function.

>>> +
>>> +       return 0;
>>> +}
>>> +
>>>   static int reset_control_array_assert(struct reset_control_array *resets)
>>>   {
>>>          int ret, i;
>>> @@ -324,6 +337,50 @@ int reset_control_reset(struct reset_control *rstc)
>>>   }
>>>   EXPORT_SYMBOL_GPL(reset_control_reset);
>>>
>>> +/**
>>> + * reset_control_resettable - decrements triggered_count of the controlled device
>>> + * @rstc: reset controller
> It is more important to document the purpose of the function than the
> mechanism by which it is achieved. triggered_count is an implementation
> detail.
>
> Maybe "allow shared reset line to be triggered again" or similar.

Roger that, will do in V2.

>
>>> + *
>>> + * On a shared reset line the actual reset pulse is only triggered once for the
>>> + * lifetime of the reset_control instance, except if this function is used.
>>> + * In fact, It decrements triggered_count that makes sure of not allowing
>>> + * a reset if triggered_count is not null.
>>> + *
>>> + * This is a no-op in case triggered_count is already null i.e shared reset line
>>> + * is ready to be triggered.
> This is not a good idea IMHO. It would be better to document that calls
> to this function must be balanced with calls to reset_control_reset, and
> then throw a big warning below in case deassert_count ever dips below 0.
>
> Otherwise nothing stops drivers from silently decrementing other
> driver's trigger count by accidentally calling this multiple times.

I do agree, accidental calls should be reported by warnings.

>>> + *
>>> + * Consumers must not use reset_control_(de)assert on shared reset lines when
>>> + * reset_control_reset has been used.
>>> + *
>>> + * If rstc is NULL it is an optional clear and the function will just
>>> + * return 0.
>>> + */
>>> +int reset_control_resettable(struct reset_control *rstc)
>>> +{
>>> +       if (!rstc)
>>> +               return 0;
>>> +
>>> +       if (WARN_ON(IS_ERR(rstc)))
>>> +               return -EINVAL;
>>> +
>>> +       if (reset_control_is_array(rstc))
>>> +               return reset_control_array_resettable(rstc_to_array(rstc));
>>> +
>>> +       if (rstc->shared) {
>>> +               if (WARN_ON(atomic_read(&rstc->deassert_count) != 0))
>>> +                       return -EINVAL;
>>> +
>>> +               if (atomic_read(&rstc->triggered_count) > 0)
>>> +                       atomic_dec(&rstc->triggered_count);
> I think this should be
>
> 		WARN_ON(atomic_dec_return(&rstc->triggered_count) < 0);

That is even better, having this warning means that the call has not

been properly used.

>
> regards
> Philipp

Next version of the patch will be sent soon, include everything we

have discussed.

Sincerely,

Amjad

