Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D90229D2F3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgJ1Vj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgJ1Vjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:39:54 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FD4C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:39:53 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id s17so518371qvr.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4FKhx870r+O+udSKu/8m8SAsZRC12Si58IDOFhUuhu8=;
        b=oFn4hf8+E5lFqfHFsv6RdFf3tapZc5eWM4HJlmFHZVp2oL3NV38xM1HyoimZxyRC8X
         UF+YfdfcSn6kpDtL7ntVwue4XJC8AvtQwEhB25kha9OA9lSXzc8z6yfMPxMZkFTn5M8t
         tgJUP6FYcZ3vF9fAIewsfHMW7qEYaUl1H9QJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4FKhx870r+O+udSKu/8m8SAsZRC12Si58IDOFhUuhu8=;
        b=blQA+6BU9STuFiCtHYqS0Ijowhu6NHPCPLw38euajh+/iBB6DZrmbOefVd5zlV6kdK
         Jc4t5BnrW6fvHxdX5Skxp9lKxmx7nkr5Qn33jnw16cDLKf6IBzqSd2DYDBjq3F2eQb5b
         llP0oBk7BDMdDQTBHqQHYYNFvq+G1xrTXpI3NKdTrLO061l/AvTxg4xPPAikfrESreb2
         aopVWyaeGJO2+19xjl96zKU9DhynOiTk+X0kHUpj75WhYgP3HZcmcd0U5LPRgbOZrMTR
         1XiAYliA/dsZRdyi9D0uZ8C5l1AqcHznTkeDMtBjIhh97MGgDzr9R47lhWYCCYsDJsT1
         i/Jw==
X-Gm-Message-State: AOAM532ihQN3oviE+H7Tp+7gMeXv0Z9nPpFT+ntB3BtT0cikFl1gVRik
        vblU1zJuewifas+xS/hnkNnyBTA/biBgJw==
X-Google-Smtp-Source: ABdhPJxSjYh2cWHmv/N3eBcN/SHEEjO9G/h1P1sXLCEvP/Ga1V+QMLghN7AKrI+wYRGqJQYZbS1IEQ==
X-Received: by 2002:a1f:1852:: with SMTP id 79mr5467228vky.6.1603895847637;
        Wed, 28 Oct 2020 07:37:27 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id o12sm591510vke.22.2020.10.28.07.37.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 07:37:26 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id s6so2949412vss.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 07:37:26 -0700 (PDT)
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr5590736vsp.34.1603895846114;
 Wed, 28 Oct 2020 07:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <1603811067-23058-1-git-send-email-pillair@codeaurora.org>
In-Reply-To: <1603811067-23058-1-git-send-email-pillair@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 28 Oct 2020 07:37:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XRyeXcE93nZgOy+x5eWcHcKKwbJccuWFkx+cA8tEXwZQ@mail.gmail.com>
Message-ID: <CAD=FV=XRyeXcE93nZgOy+x5eWcHcKKwbJccuWFkx+cA8tEXwZQ@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Fix the parsing error in service available event
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Abhishek Kumar <kuabhs@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 27, 2020 at 8:20 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
>
> The wmi service available event has been
> extended to contain extra 128 bit for new services
> to be indicated by firmware.
>
> Currently the presence of any optional TLVs in
> the wmi service available event leads to a parsing
> error with the below error message:
> ath10k_snoc 18800000.wifi: failed to parse svc_avail tlv: -71
>
> The wmi service available event parsing should
> not return error for the newly added optional TLV.
> Fix this parsing for service available event message.
>
> Tested-on: WCN3990 hw1.0 SNOC
>
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/wmi-tlv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> index 932266d..3b49e29 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> @@ -1404,9 +1404,12 @@ static int ath10k_wmi_tlv_svc_avail_parse(struct ath10k *ar, u16 tag, u16 len,
>                 arg->service_map_ext_len = *(__le32 *)ptr;
>                 arg->service_map_ext = ptr + sizeof(__le32);
>                 return 0;
> +       case WMI_TLV_TAG_FIRST_ARRAY_ENUM:
> +               return 0;

This is at least slightly worrying to me.  If I were calling this
function, I'd expect that if I didn't get back an error that at least
"arg->service_map_ext_len" was filled in.  Seems like you should do:

case WMI_TLV_TAG_FIRST_ARRAY_ENUM:
  arg->service_map_ext_len = 0;
  arg->service_map_ext = NULL;
  return 0;

...and maybe add a comment about why you're doing that?

At the moment things are working OK because
ath10k_wmi_event_service_available() happens to init the structure to
0 before calling with:

  struct wmi_svc_avail_ev_arg arg = {};

....but it doesn't seem like a great idea to rely on that.

That all being said, I'm just a drive-by reviewer and if everyone else
likes it the way it is, feel free to ignore my comments.

-Doug
