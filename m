Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED97329CD1E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 02:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgJ1BkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 21:40:22 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40631 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1833085AbgJ1APc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 20:15:32 -0400
Received: by mail-vk1-f194.google.com with SMTP id i62so795551vkb.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 17:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VMIFRPfFXp5+Fuq3EAh2O9vMUez4aeMqLQumbmhdaS4=;
        b=F2nMAsbYBaseTkT0YXHpSABkkLLemURTdm3mQ8r7JhVQZ+oyxpZQ16sfgKh+QQHGbb
         k/ek4/T4ogEmMut0C/aDnw2m/Iv0/GGEAb+jDm4gXubU1zf4meFepdTDTTUq4cdo+KFH
         r+NpULG7kQyPBa2qw/4UwsjdKefrHtOKO1J4MclyIMc/zvXLVgeQfJ64IcKun8E6YSre
         RZ9BLisoeszMR2xQq55ipudMOeLSYp/ZmgIFwNhHkVpYd3arbQn60ETUjsQ+ysZsfrbN
         I4g1mvzsYU9uEK92w5oOR6JYb4YGT8qjA/KvPcvYEWUpSEMZEuW94LJJJzBLENaAYdho
         8hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VMIFRPfFXp5+Fuq3EAh2O9vMUez4aeMqLQumbmhdaS4=;
        b=tsSc9MrX5su/PFC9+QWWcX/ft15TXSb4pDnHuDh6sSNR5YhIGe3aFC0y5hqvJSxanU
         orbtaUX6dWrkIwy3jeRaaf58tKSQQaAuRTD0TyxhdXCcpUjTaWCKq3MEbi/sUz4i8pnH
         jIaFXf9+dnNlXRznSZyXAZfL928rx+cuiBfXCAcsoS3in4Jqxmu1hjjXkiyfToJnI2AA
         /D8SYa4hOadx14zMwzdXXyeN3vy+AjsOEGSE9wR2dlaEDyc/mej8+iIn7aIt5G+LOKAm
         dSI01UCPuzwgsMCN9Lvdm4w+JwkV16crs2iyLYtMkWJfAmnTi7PPoH1EsZUW/N65ZXKY
         vz4g==
X-Gm-Message-State: AOAM531VEkIyd2KY/C6bE8ycXO5OubCw0sLsSb6y/jAY6tCnE8phnI2c
        TET8K2VjliZ1lrKIQq5ydqgn1MeIhcE=
X-Google-Smtp-Source: ABdhPJxSxRaE2yY7RF3Z+vVv35BeiQb757MNYsjg5seHOkFmbAiDje7HNXWSo21N5hFph3YrOtnhTw==
X-Received: by 2002:a1f:9552:: with SMTP id x79mr3667124vkd.3.1603844130491;
        Tue, 27 Oct 2020 17:15:30 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id d12sm370518vkf.10.2020.10.27.17.15.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 17:15:29 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id r1so1893202vsi.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 17:15:29 -0700 (PDT)
X-Received: by 2002:a67:c981:: with SMTP id y1mr3450565vsk.14.1603844128521;
 Tue, 27 Oct 2020 17:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201027161120.5575-1-elder@linaro.org> <20201027161120.5575-6-elder@linaro.org>
In-Reply-To: <20201027161120.5575-6-elder@linaro.org>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 27 Oct 2020 20:14:51 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdGCBG0tZXfPTJqTnV7zRNv2VmuThOydwj080NWw4PU9Q@mail.gmail.com>
Message-ID: <CA+FuTSdGCBG0tZXfPTJqTnV7zRNv2VmuThOydwj080NWw4PU9Q@mail.gmail.com>
Subject: Re: [PATCH net 5/5] net: ipa: avoid going past end of resource group array
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, evgreen@chromium.org,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 12:38 PM Alex Elder <elder@linaro.org> wrote:
>
> The minimum and maximum limits for resources assigned to a given
> resource group are programmed in pairs, with the limits for two
> groups set in a single register.
>
> If the number of supported resource groups is odd, only half of the
> register that defines these limits is valid for the last group; that
> group has no second group in the pair.
>
> Currently we ignore this constraint, and it turns out to be harmless,

If nothing currently calls it with an odd number of registers, is this
a bugfix or a new feature (anticipating future expansion, I guess)?

> but it is not guaranteed to be.  This patch addresses that, and adds
> support for programming the 5th resource group's limits.
>
> Rework how the resource group limit registers are programmed by
> having a single function program all group pairs rather than having
> one function program each pair.  Add the programming of the 4-5
> resource group pair limits to this function.  If a resource group is
> not supported, pass a null pointer to ipa_resource_config_common()
> for that group and have that function write zeroes in that case.
>
> Fixes: cdf2e9419dd91 ("soc: qcom: ipa: main code")
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  drivers/net/ipa/ipa_main.c | 89 +++++++++++++++++++++++---------------
>  1 file changed, 53 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> index 74b1e15ebd6b2..09c8a16d216df 100644
> --- a/drivers/net/ipa/ipa_main.c
> +++ b/drivers/net/ipa/ipa_main.c
> @@ -370,8 +370,11 @@ static bool ipa_resource_limits_valid(struct ipa *ipa,
>         u32 i;
>         u32 j;
>
> +       /* We program at most 6 source or destination resource group limits */
> +       BUILD_BUG_ON(IPA_RESOURCE_GROUP_SRC_MAX > 6);
> +
>         group_count = ipa_resource_group_src_count(ipa->version);
> -       if (!group_count)
> +       if (!group_count || group_count >= IPA_RESOURCE_GROUP_SRC_MAX)
>                 return false;

Perhaps more a comment to the previous patch, but _MAX usually denotes
the end of an inclusive range, here 5. The previous name COUNT better
reflects the number of elements in range [0, 5], which is 6.

>         /* Return an error if a non-zero resource limit is specified
> @@ -387,7 +390,7 @@ static bool ipa_resource_limits_valid(struct ipa *ipa,
>         }
>
>         group_count = ipa_resource_group_dst_count(ipa->version);
> -       if (!group_count)
> +       if (!group_count || group_count >= IPA_RESOURCE_GROUP_DST_MAX)
>                 return false;
>
>         for (i = 0; i < data->resource_dst_count; i++) {
> @@ -421,46 +424,64 @@ ipa_resource_config_common(struct ipa *ipa, u32 offset,
>
>         val = u32_encode_bits(xlimits->min, X_MIN_LIM_FMASK);
>         val |= u32_encode_bits(xlimits->max, X_MAX_LIM_FMASK);
> -       val |= u32_encode_bits(ylimits->min, Y_MIN_LIM_FMASK);
> -       val |= u32_encode_bits(ylimits->max, Y_MAX_LIM_FMASK);
> +       if (ylimits) {
> +               val |= u32_encode_bits(ylimits->min, Y_MIN_LIM_FMASK);
> +               val |= u32_encode_bits(ylimits->max, Y_MAX_LIM_FMASK);
> +       }
>
>         iowrite32(val, ipa->reg_virt + offset);
>  }
>
> -static void ipa_resource_config_src_01(struct ipa *ipa,
> -                                      const struct ipa_resource_src *resource)
> +static void ipa_resource_config_src(struct ipa *ipa,
> +                                   const struct ipa_resource_src *resource)
>  {
> -       u32 offset = IPA_REG_SRC_RSRC_GRP_01_RSRC_TYPE_N_OFFSET(resource->type);
> +       u32 group_count = ipa_resource_group_src_count(ipa->version);
> +       const struct ipa_resource_limits *ylimits;
> +       u32 offset;
>
> -       ipa_resource_config_common(ipa, offset,
> -                                  &resource->limits[0], &resource->limits[1]);
> -}
> +       offset = IPA_REG_SRC_RSRC_GRP_01_RSRC_TYPE_N_OFFSET(resource->type);
> +       ylimits = group_count == 1 ? NULL : &resource->limits[1];
> +       ipa_resource_config_common(ipa, offset, &resource->limits[0], ylimits);
>
> -static void ipa_resource_config_src_23(struct ipa *ipa,
> -                                      const struct ipa_resource_src *resource)
> -{
> -       u32 offset = IPA_REG_SRC_RSRC_GRP_23_RSRC_TYPE_N_OFFSET(resource->type);
> +       if (group_count < 2)
> +               return;
>
> -       ipa_resource_config_common(ipa, offset,
> -                                  &resource->limits[2], &resource->limits[3]);
> -}
> +       offset = IPA_REG_SRC_RSRC_GRP_23_RSRC_TYPE_N_OFFSET(resource->type);
> +       ylimits = group_count == 3 ? NULL : &resource->limits[3];
> +       ipa_resource_config_common(ipa, offset, &resource->limits[2], ylimits);
>
> -static void ipa_resource_config_dst_01(struct ipa *ipa,
> -                                      const struct ipa_resource_dst *resource)
> -{
> -       u32 offset = IPA_REG_DST_RSRC_GRP_01_RSRC_TYPE_N_OFFSET(resource->type);
> +       if (group_count < 4)
> +               return;
>
> -       ipa_resource_config_common(ipa, offset,
> -                                  &resource->limits[0], &resource->limits[1]);
> +       offset = IPA_REG_SRC_RSRC_GRP_45_RSRC_TYPE_N_OFFSET(resource->type);
> +       ylimits = group_count == 5 ? NULL : &resource->limits[5];

Due to the check

> +       if (!group_count || group_count >= IPA_RESOURCE_GROUP_DST_MAX)
>                 return false;

above, group_count can never be greater than 5. Should be greater than?
