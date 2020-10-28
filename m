Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7CE29E0D5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgJ1WDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729478AbgJ1WBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:01:32 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC746C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:01:32 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id a12so452156ybg.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X61PD0Eqa415e78dHBCu8gVP7gz9DiO/HA7a3ClV984=;
        b=NEOWjCOdoW+dKxV90REiSNshDKbdF16fZjphJCyW4sXCsrz9B1bTlOsgmoBmn5SiEj
         Ttg/Sbh7iyvA1URHLm7Yhnoeex0MgCqwY9HsUCdVIe+5eud+5/AjV+fgOBuFzWp9p1bY
         GHQw4cFWy+Exvei93CFPwEI3PCFpZ5owzNGTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X61PD0Eqa415e78dHBCu8gVP7gz9DiO/HA7a3ClV984=;
        b=JJh/lNlkt6yC8WVqrTNjbe2NOcZ3g4nys/w7Alr3KrGajD0Ygydmc++TXEavsMLvi4
         ULePb0vXpJAaKfpLLPy981Z1815rIY9Dykbnq+h8hKwxLM/TQ1KTbYWNaRLyNANFhyE1
         5O4mmx+mEa1RMZP6ekEIWh+32RKGqZWUO4KZKy6+2zkdWAKMRkwIzLbkYvIkqbVkj/Dq
         jL+Jrq6+EL4orZmz8H0Dv7gUWrUimrj/DKLD1EHnfY1JO4zfEivlqVWEvRxWCtkesRLV
         C0vMOVNBRIMQE66+z1K7a/9ljMQplW3F3YsvPfyv/OYwUFAw56gnNID7c6MTEFuTD89V
         YJ4g==
X-Gm-Message-State: AOAM531F+xTa2dAuUvMLTkTwmwtBwS3mVbZ+G3LkuLEoHbqNxdV/bnfM
        HDFg8HqRCMjl5U09lwsEJJ5cCTALc87F1g==
X-Google-Smtp-Source: ABdhPJz3wKCI1R1v82li77slb+pKYKtURPSYLGW2vkwuJGiuqtcBV8nGA0rinAewwypUB8TJX2fMWA==
X-Received: by 2002:a9f:2f15:: with SMTP id x21mr791147uaj.104.1603910701381;
        Wed, 28 Oct 2020 11:45:01 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id o2sm27776vkd.16.2020.10.28.11.45.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 11:45:00 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id y78so110630vsy.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 11:45:00 -0700 (PDT)
X-Received: by 2002:a67:e3b9:: with SMTP id j25mr594499vsm.37.1603910699981;
 Wed, 28 Oct 2020 11:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <1603904469-598-1-git-send-email-pillair@codeaurora.org>
In-Reply-To: <1603904469-598-1-git-send-email-pillair@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 28 Oct 2020 11:44:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V0apTHaemMKvRx1HWLaO9ArC2t4ohfZ7-CthFz2NiA2A@mail.gmail.com>
Message-ID: <CAD=FV=V0apTHaemMKvRx1HWLaO9ArC2t4ohfZ7-CthFz2NiA2A@mail.gmail.com>
Subject: Re: [PATCH v2] ath10k: Fix the parsing error in service available event
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

On Wed, Oct 28, 2020 at 10:01 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
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
> Fixes: cea19a6ce8bf ("ath10k: add WMI_SERVICE_AVAILABLE_EVENT support")
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
> Changes from v1:
> - Access service_map_ext only if this TLV was sent in service
>   available event.
> ---
>  drivers/net/wireless/ath/ath10k/wmi-tlv.c | 4 +++-
>  drivers/net/wireless/ath/ath10k/wmi.c     | 5 +++--
>  drivers/net/wireless/ath/ath10k/wmi.h     | 1 +
>  3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> index 932266d..7b58341 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> @@ -1401,13 +1401,15 @@ static int ath10k_wmi_tlv_svc_avail_parse(struct ath10k *ar, u16 tag, u16 len,
>
>         switch (tag) {
>         case WMI_TLV_TAG_STRUCT_SERVICE_AVAILABLE_EVENT:
> +               arg->service_map_ext_valid = true;
>                 arg->service_map_ext_len = *(__le32 *)ptr;
>                 arg->service_map_ext = ptr + sizeof(__le32);
>                 return 0;
>         default:
>                 break;
>         }
> -       return -EPROTO;
> +
> +       return 0;

I notice your v2 now returns 0 for _all_ unknown tags.  v1 just had a
special case for "WMI_TLV_TAG_FIRST_ARRAY_ENUM".  I don't have enough
experience with this driver to know which is better, but this change
wasn't mentioned in the changes from v1.  I guess you had a change of
heart and decided this way was better?


>  }
>
>  static int ath10k_wmi_tlv_op_pull_svc_avail(struct ath10k *ar,
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
> index 1fa7107..2e4b561 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
> @@ -5751,8 +5751,9 @@ void ath10k_wmi_event_service_available(struct ath10k *ar, struct sk_buff *skb)
>                             ret);
>         }
>
> -       ath10k_wmi_map_svc_ext(ar, arg.service_map_ext, ar->wmi.svc_map,
> -                              __le32_to_cpu(arg.service_map_ext_len));
> +       if (arg.service_map_ext_valid)
> +               ath10k_wmi_map_svc_ext(ar, arg.service_map_ext, ar->wmi.svc_map,
> +                                      __le32_to_cpu(arg.service_map_ext_len));

Your new patch still requires the caller to init the
"service_map_ext_valid" to false before calling, but I guess there's
not a whole lot more we can do because we might be parsing more than
one tag.  It does seem nice that at least we now have a validity bit
instead of just relying on a non-zero length to be valid.

It might be nice to have a comment saying that it's up to us to init
"arg.service_map_ext_valid" to false before calling
ath10k_wmi_pull_svc_avail(), but I won't insist.  Maybe that's obvious
to everyone but me...


-Doug
