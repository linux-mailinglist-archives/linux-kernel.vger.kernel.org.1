Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F269C2C2A73
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389282AbgKXOwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388166AbgKXOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:52:44 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F1AC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:52:43 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id r9so22155981ioo.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfzUHau9FtStLRkBsMZ3Hfw9WsRE5iXgwdfPMH0ee1s=;
        b=DiDCed7FSKa/JeRB3epzXJN6Z3PTFD+u5kauX0IXRRJ9j4V9VXpfTvYNIHPBzGABpx
         3mmt0AV0GShFdD1dsz73e/NA8KvLerFEl5RUjwRkcZZ7bqdf/KWEeSnDXOWXhTSKUmNQ
         L8d/guIFJyRwNkz+S1rYDqBSx7ulTpXlhnNwhjbP+ZVq8ONNW7zGBX9LPTYWe8pboS0R
         u9k09upYcrEPkqMJHyoPleaBnHVk2CbKKg+2HQmCix5z88PS2KQ0D6HuSijKOVcoaZzd
         LHcOXXnBbL9B5mITLUs+uv+hRKHCqg5gOzH+hqus0KTkrCTGVfkk1T9tECtdBsgrhk2u
         cEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfzUHau9FtStLRkBsMZ3Hfw9WsRE5iXgwdfPMH0ee1s=;
        b=LqUUSl2wPNWgzKUXhzl6gsoVZ5N6cEU6eP0PVC52+ur1ilob3ZJUz1pIx7rWsUTkmD
         /xIdxEdTla8FapBFGCBxZLIGrxz4pjgaMrLJsbTWo0Ks5pdXzbZTwfFzV35tKAG+5bI1
         hIXgo0ThmvXGtp6FlPT11J8F0Bm2jYCvPQS5GgomVWFGzRjCnAVCCm5zwR8JHw5/PEcD
         QyiAmoyveNNeCerYiTiUxwHLcX4j3WyCRi8TM6VFE6nbCIY0hbUoGpFj2owHFdYYJfqP
         5LWzBo56nHMJJmePPBASrsG+2zgyBwKlP1NxFaHZzszCO+u5P+QJwGzZzC9zUACX2dNO
         zoIg==
X-Gm-Message-State: AOAM531zpCJwbEP/aXGqvv3zR+mNunPmWzgb3AffUHjrRvg4kCLnLAf0
        VcBymX+//CI0HOy2xbBoXLIC8GATJKAxWVyLaXU=
X-Google-Smtp-Source: ABdhPJwiGiDLpDWF2nBPdJuLvQZa7QER69J4mSk03iO1nr2+q/dNipafVE1L5fhc2XZeMoO3Qq8vBSazHFMGWxxLgls=
X-Received: by 2002:a02:830f:: with SMTP id v15mr4574545jag.12.1606229562528;
 Tue, 24 Nov 2020 06:52:42 -0800 (PST)
MIME-Version: 1.0
References: <1606214936-35192-1-git-send-email-milan.lakhani@codethink.co.uk> <1606214936-35192-2-git-send-email-milan.lakhani@codethink.co.uk>
In-Reply-To: <1606214936-35192-2-git-send-email-milan.lakhani@codethink.co.uk>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 24 Nov 2020 15:52:31 +0100
Message-ID: <CAKXUXMyBsWydrqspsWn6HUAGEDVU12y_vY=Tx_4DXGrG0=stQg@mail.gmail.com>
Subject: Re: [linux-safety] [PATCH v2 2/2] staging: vt6655: Use macro in rxtx.c
To:     Milan Lakhani <milan.lakhani@codethink.co.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-safety@lists.elisa.tech, forest@alittletooquiet.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:49 AM Milan Lakhani
<milan.lakhani@codethink.co.uk> wrote:
>
> Use macro for repeated function to get the data duration and timestamp,
> correcting line length and alignment warnings in rxtx.c. Reported by
> checkpatch.
>
> Signed-off-by: Milan Lakhani <milan.lakhani@codethink.co.uk>

Patch looks good.

You need to CC:

devel@driverdev.osuosl.org


> ---
>  drivers/staging/vt6655/rxtx.c | 51 ++++++++++++++++---------------------------
>  1 file changed, 19 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index 508e1bd..c5dfe3c 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -423,6 +423,10 @@ s_uGetRTSCTSDuration(
>         return cpu_to_le16((u16)uDurTime);
>  }
>
> +#define getDurationTimeStamp(byDurType, byPktType, wRate) \
> +       (cpu_to_le16((u16)s_uGetDataDuration(pDevice, (byDurType), cbFrameLength, (byPktType), \
> +               (wRate), bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption)))
> +
>  static
>  __le16
>  s_uFillDataHead(
> @@ -467,15 +471,10 @@ s_uFillDataHead(
>                         } else {
>                                 /* Get Duration and TimeStamp */
>                                 buf->duration_a =
> -                                       cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength,
> -                                                                           byPktType, wCurrentRate, bNeedAck, uFragIdx,
> -                                                                           cbLastFragmentSize, uMACfragNum,
> -                                                                           byFBOption));
> +                                       getDurationTimeStamp(DATADUR_A, byPktType, wCurrentRate);
>                                 buf->duration_b =
> -                                       cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B, cbFrameLength,
> -                                                                           PK_TYPE_11B, pDevice->byTopCCKBasicRate,
> -                                                                           bNeedAck, uFragIdx, cbLastFragmentSize,
> -                                                                           uMACfragNum, byFBOption));
> +                                       getDurationTimeStamp(DATADUR_B, PK_TYPE_11B,
> +                                                            pDevice->byTopCCKBasicRate);
>                         }
>
>                         buf->time_stamp_off_a = vnt_time_stamp_off(pDevice, wCurrentRate);
> @@ -492,14 +491,11 @@ s_uFillDataHead(
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
> +               buf->duration_a = getDurationTimeStamp(DATADUR_A, byPktType, wCurrentRate);
> +               buf->duration_b = getDurationTimeStamp(DATADUR_B, PK_TYPE_11B,
> +                                                      pDevice->byTopCCKBasicRate);
> +               buf->duration_a_f0 = getDurationTimeStamp(DATADUR_A_F0, byPktType, wCurrentRate);
> +               buf->duration_a_f1 = getDurationTimeStamp(DATADUR_A_F1, byPktType, wCurrentRate);
>
>                 buf->time_stamp_off_a = vnt_time_stamp_off(pDevice, wCurrentRate);
>                 buf->time_stamp_off_b = vnt_time_stamp_off(pDevice, pDevice->byTopCCKBasicRate);
> @@ -517,12 +513,11 @@ s_uFillDataHead(
>                                           byPktType, &buf->a);
>
>                         /* Get Duration and TimeStampOff */
> -                       buf->duration = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength, byPktType,
> -                                                                           wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
> -                       buf->duration_f0 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F0, cbFrameLength, byPktType,
> -                                                                              wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
> -                       buf->duration_f1 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1, cbFrameLength, byPktType,
> -                                                                               wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
> +                       buf->duration = getDurationTimeStamp(DATADUR_A, byPktType, wCurrentRate);
> +                       buf->duration_f0 = getDurationTimeStamp(DATADUR_A_F0, byPktType,
> +                                                               wCurrentRate);
> +                       buf->duration_f1 = getDurationTimeStamp(DATADUR_A_F1, byPktType,
> +                                                               wCurrentRate);
>                         buf->time_stamp_off = vnt_time_stamp_off(pDevice, wCurrentRate);
>                         return buf->duration;
>                 }
> @@ -537,11 +532,7 @@ s_uFillDataHead(
>                         buf->duration = dur;
>                 } else {
>                         /* Get Duration and TimeStampOff */
> -                       buf->duration =
> -                               cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength, byPktType,
> -                                                                   wCurrentRate, bNeedAck, uFragIdx,
> -                                                                   cbLastFragmentSize, uMACfragNum,
> -                                                                   byFBOption));
> +                       buf->duration = getDurationTimeStamp(DATADUR_A, byPktType, wCurrentRate);
>                 }
>
>                 buf->time_stamp_off = vnt_time_stamp_off(pDevice, wCurrentRate);
> @@ -558,11 +549,7 @@ s_uFillDataHead(
>                 buf->duration = dur;
>         } else {
>                 /* Get Duration and TimeStampOff */
> -               buf->duration =
> -                       cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B, cbFrameLength, byPktType,
> -                                                           wCurrentRate, bNeedAck, uFragIdx,
> -                                                           cbLastFragmentSize, uMACfragNum,
> -                                                           byFBOption));
> +               buf->duration = getDurationTimeStamp(DATADUR_B, byPktType, wCurrentRate);
>         }
>
>         buf->time_stamp_off = vnt_time_stamp_off(pDevice, wCurrentRate);
> --
> 2.7.4
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#198): https://lists.elisa.tech/g/linux-safety/message/198
> Mute This Topic: https://lists.elisa.tech/mt/78474577/1714638
> Group Owner: linux-safety+owner@lists.elisa.tech
> Unsubscribe: https://lists.elisa.tech/g/linux-safety/unsub [lukas.bulwahn@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>
