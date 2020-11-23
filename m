Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6ED52C0A41
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbgKWNSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731646AbgKWNSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:18:04 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AA9C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 05:18:04 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id q1so15837233ilt.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 05:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8GVYu+FzJGPxHeAYn+3oYhbrF8dl3hAe7amTT6QoedQ=;
        b=jEbtRNq2ntpxKh+/JAMPmXvFpLgUhvd5WbADxmzA9Jf7/2ANFqHNI/cPf62prApHkN
         Zv76pd5frLURQBenXbCWRSKMwh85ycFSSUjU6QB0rLyRu0tkNdsjnGTiayj2o0tTHZiD
         q1QtXMnlMTyRb9dhDW1A1C72+DxJR5hE9aoPOYFyPfOcpoVEQgTI0mlWtNmrg66q18b0
         rZo3G1AWD7oAJEY/GC45quSq4L5z/OJs6ocepuyBqwboOUXS9+xLzLtWmJVDuOWzG41f
         zYBW/llrlF/ZVRERJwzOQLKIHW+688d16ory0EvkB6HNFLFgLrtlumG+F5pFO27Y/FoW
         Y7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8GVYu+FzJGPxHeAYn+3oYhbrF8dl3hAe7amTT6QoedQ=;
        b=s5j1jDwe/w1vqeMpRf3uf+INm3SgpAcKJSSvXUYLws0D2tCbong1wkCfGm1HGMM3WK
         tPwip54vOHRxpQuQ2tm+dZHaA4oqu5Atvkq4wIR38n9v/UpMvupR9HOoXAq8123dTV7u
         iSKgnRvc/7R2k4kHqLc8SjEyo91d9ZpoRL6VKaTTjEyqb9ZWxysTEfo8/QI3D+R4b4Ot
         zGBS6BgU9QJEYY5l6DgL//s2+1dh0VjGzjFiR/eaBJcuODdximWc7IH7Ehn/OrX/9wlk
         LjGps88d+hrP+IJp8XDDNAyHSzVpoo3iI4RIjXBYp4u1l5CFHSySQse11ox4cpwD2eTx
         L3YA==
X-Gm-Message-State: AOAM531iEm1Qcux/SgSH45TSN8Dcjm5vNzk3MAdhDdj488kKKwG3+qHp
        /iv1WbtM5s2jSzvcKdwIyGkZTaFIMmm9iu22hB0eG5gVvC4=
X-Google-Smtp-Source: ABdhPJxXoezB+bkDkzia7wlIU0nZt5UFiPhVO71wV9dUFAMWOoazYxY2NqTLV22fb9SH5g7wxER3XHHBGFolzMtfa0s=
X-Received: by 2002:a92:600e:: with SMTP id u14mr33590848ilb.221.1606137483984;
 Mon, 23 Nov 2020 05:18:03 -0800 (PST)
MIME-Version: 1.0
References: <1606132778-34209-1-git-send-email-milan.lakhani@codethink.co.uk> <1606132778-34209-2-git-send-email-milan.lakhani@codethink.co.uk>
In-Reply-To: <1606132778-34209-2-git-send-email-milan.lakhani@codethink.co.uk>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 23 Nov 2020 14:17:53 +0100
Message-ID: <CAKXUXMym-YfjQdDx7DcW8VHZH2bV5DbO6t0EgzmqD5hDe1AOZA@mail.gmail.com>
Subject: Re: [linux-safety] [PATCH 2/2] staging: vt6655: Correct wrappping in rxtx.c
To:     Milan Lakhani <milan.lakhani@codethink.co.uk>
Cc:     forest@alittletooquiet.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-safety@lists.elisa.tech
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 12:59 PM Milan Lakhani
<milan.lakhani@codethink.co.uk> wrote:
>
> Correct line length and alignment in rxtx.c. Reported by checkpatch.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Forest Bond <forest@alittletooquiet.net>
> CC: linux-kernel@vger.kernel.org
> CC: linux-safety@lists.elisa.tech

Milan, I am wondering where you picked up this convention to add these
Cc: and CC: tags in your patch?

Is there some documentation that points out to do that? (That might
need to be fixed...)

Did you observe that on some other commits? I think these tags are
added by some maintainers (probably tool-supported) when they pick the
patches, not by the authors, though.

> Signed-off-by: Milan Lakhani <milan.lakhani@codethink.co.uk>
> ---
>  drivers/staging/vt6655/rxtx.c | 63 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 49 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index 508e1bd..4073c33 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -492,14 +492,29 @@ s_uFillDataHead(
>                                   pDevice->byTopCCKBasicRate,
>                                   PK_TYPE_11B, &buf->b);
>                 /* Get Duration and TimeStamp */
> -               buf->duration_a = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength, byPktType,
> -                                                                     wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
> -               buf->duration_b = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B, cbFrameLength, PK_TYPE_11B,
> -                                                                      pDevice->byTopCCKBasicRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
> -               buf->duration_a_f0 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F0, cbFrameLength, byPktType,
> -                                                                         wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
> -               buf->duration_a_f1 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1, cbFrameLength, byPktType,
> -                                                                        wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
> +               buf->duration_a = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A,
> +                                                                     cbFrameLength, byPktType,
> +                                                                     wCurrentRate, bNeedAck,
> +                                                                     uFragIdx, cbLastFragmentSize,
> +                                                                     uMACfragNum, byFBOption));
> +               buf->duration_b = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B,
> +                                                                     cbFrameLength, PK_TYPE_11B,
> +                                                                     pDevice->byTopCCKBasicRate,
> +                                                                     bNeedAck, uFragIdx,
> +                                                                     cbLastFragmentSize,
> +                                                                     uMACfragNum, byFBOption));
> +               buf->duration_a_f0 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F0,
> +                                                                        cbFrameLength, byPktType,
> +                                                                        wCurrentRate, bNeedAck,
> +                                                                        uFragIdx,
> +                                                                        cbLastFragmentSize,
> +                                                                        uMACfragNum, byFBOption));
> +               buf->duration_a_f1 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1,
> +                                                                        cbFrameLength, byPktType,
> +                                                                        wCurrentRate, bNeedAck,
> +                                                                        uFragIdx,
> +                                                                        cbLastFragmentSize,
> +                                                                        uMACfragNum, byFBOption));
>

Now to this change... it seems reasonable to refactor this into a
dedicated function or macro because this is largely "copy-and-paste"
calls with slight variable on a single argument.

How about proposing such a change instead?

>                 buf->time_stamp_off_a = vnt_time_stamp_off(pDevice, wCurrentRate);
>                 buf->time_stamp_off_b = vnt_time_stamp_off(pDevice, pDevice->byTopCCKBasicRate);
> @@ -517,12 +532,32 @@ s_uFillDataHead(
>                                           byPktType, &buf->a);
>
>                         /* Get Duration and TimeStampOff */
> -                       buf->duration = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength, byPktType,
> -                                                                           wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
> -                       buf->duration_f0 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F0, cbFrameLength, byPktType,
> -                                                                              wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
> -                       buf->duration_f1 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1, cbFrameLength, byPktType,
> -                                                                               wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
> +                       buf->duration = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A,
> +                                                                           cbFrameLength,
> +                                                                           byPktType,
> +                                                                           wCurrentRate, bNeedAck,
> +                                                                           uFragIdx,
> +                                                                           cbLastFragmentSize,
> +                                                                           uMACfragNum,
> +                                                                           byFBOption));
> +                       buf->duration_f0 = cpu_to_le16((u16)s_uGetDataDuration(pDevice,
> +                                                                              DATADUR_A_F0,
> +                                                                              cbFrameLength,
> +                                                                              byPktType,
> +                                                                              wCurrentRate,
> +                                                                              bNeedAck, uFragIdx,
> +                                                                              cbLastFragmentSize,
> +                                                                              uMACfragNum,
> +                                                                              byFBOption));
> +                       buf->duration_f1 = cpu_to_le16((u16)s_uGetDataDuration(pDevice,
> +                                                                              DATADUR_A_F1,
> +                                                                              cbFrameLength,
> +                                                                              byPktType,
> +                                                                              wCurrentRate,
> +                                                                              bNeedAck, uFragIdx,
> +                                                                              cbLastFragmentSize,
> +                                                                              uMACfragNum,
> +                                                                              byFBOption));
>                         buf->time_stamp_off = vnt_time_stamp_off(pDevice, wCurrentRate);
>                         return buf->duration;
>                 }
> --
> 2.7.4
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#187): https://lists.elisa.tech/g/linux-safety/message/187
> Mute This Topic: https://lists.elisa.tech/mt/78451464/1714638
> Group Owner: linux-safety+owner@lists.elisa.tech
> Unsubscribe: https://lists.elisa.tech/g/linux-safety/unsub [lukas.bulwahn@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>
