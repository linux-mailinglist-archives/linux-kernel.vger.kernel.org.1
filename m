Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8B22C7AE9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 20:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgK2TSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 14:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2TSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 14:18:10 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61762C0613D2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 11:17:30 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id k4so12389690edl.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 11:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LaYvdAUmRlNPKDBNivA2dWaWEk14e1Lfm+e5Aneve0s=;
        b=eFNgnuYCzfxHavNAx16ydX/pGZuNUSjHBmDDCAWQDjln+KsANNy/Mic3CzXF8XpiXw
         h+IkHwaqJ/Bw9x834JUlsp7aczAsHqvto+7uYv9Z9DYYLSO58eRtmRAeWaCIZdppZABj
         rc2q0KaTb7GfoRrxY0IQcoQwLqTKJPYVRRogs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LaYvdAUmRlNPKDBNivA2dWaWEk14e1Lfm+e5Aneve0s=;
        b=pOiEXgoYeXZx7gRYIXkU3i+jYXQ00TbHvV5PoyKICIg7X9j6wQYVoI4DE9rUlN2os7
         4pX7x7WFizFTPNplDMsnCCLcCm3cfIEbgLlTb3ezD3WCZqh5G/8ZQnsvj9YJs5LvHsr3
         xzTfgzaZyyqpY0WmMeMopJccE/Z7kxXGBTEhdDbq2VLtXVL6l4PwMXFq+KEjmwcWS2Sq
         JhKhnaeZddeHQqv6EblFiOWhuhSUlFXN4vejo+nm6ykjTZhHfyd+6/EdQ0K5TLJq1KMP
         cyEK8X+cjXPtiXEV2CywqoyH503J7RRVgIWhxQM2BSvHm9oBM+5WBHTi75z6kU1RAao/
         /nPQ==
X-Gm-Message-State: AOAM533VSlDoAHxBlhk/999CMqELtBoN9wUsJJFFpAVwqmTMn4GSSpND
        p7ovLzwAqxePHAaC4BTTlsh/3bwmRn0BWQ==
X-Google-Smtp-Source: ABdhPJyjKqHfDZi8wYvd+tAd/jXpoUivmZ1obf02CViBcJpw39ofjlPzpZBP9Af/gm88t5GFIu7tvA==
X-Received: by 2002:a50:99dd:: with SMTP id n29mr3178020edb.259.1606677448910;
        Sun, 29 Nov 2020 11:17:28 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id n15sm7933421eje.112.2020.11.29.11.17.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Nov 2020 11:17:28 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id h21so18417448wmb.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 11:17:27 -0800 (PST)
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr19952360wml.11.1606677447413;
 Sun, 29 Nov 2020 11:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20201111143755.24541-1-stanimir.varbanov@linaro.org>
In-Reply-To: <20201111143755.24541-1-stanimir.varbanov@linaro.org>
From:   Fritz Koenig <frkoenig@chromium.org>
Date:   Sun, 29 Nov 2020 11:17:14 -0800
X-Gmail-Original-Message-ID: <CAMfZQbxV4CuZ57kv1Nu=VTdd-eK2opMqnduxGGa+KvptaFL7=A@mail.gmail.com>
Message-ID: <CAMfZQbxV4CuZ57kv1Nu=VTdd-eK2opMqnduxGGa+KvptaFL7=A@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Venus stateful encoder compliance
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this patchset adds support for V4L2_ENC_CMD_STOP and
VENUS_ENC_STATE_ENCODING it should also add support for
VIDIOC_TRY_ENCODER_CMD so that those commands are discoverable.  I've
made an attempt at that here:
https://www.spinics.net/lists/linux-media/msg182319.html

On Wed, Nov 11, 2020 at 6:38 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hello,
>
> Here is v2 of the subject patchset.
>
> The patchset starts with few small preparation and fix patches, 1/8 to 5/8.
> 6/8 is redesigned Dikshita's patch and 7/8 add Reset encoder state handling.
> The last 8/8 just delete not needed helper function.
>
> The major changes are:
>  * An attempt to reuse m2m helpers for drain and reset state in 6/8 and 7/8.
>  * Use null encoder buffer to signal end-of-stream in 6/8.
>
> Comments are welcome!
>
> regards,
> Stan
>
> Dikshita Agarwal (1):
>   venus: venc: add handling for VIDIOC_ENCODER_CMD
>
> Stanimir Varbanov (7):
>   venus: hfi: Use correct state in unload resources
>   venus: helpers: Add a new helper for buffer processing
>   venus: hfi_cmds: Allow null buffer address on encoder input
>   venus: helpers: Calculate properly compressed buffer size
>   venus: pm_helpers: Check instance state when calculate instance
>     frequency
>   venus: venc: Handle reset encoder state
>   venus: helpers: Delete unused stop streaming helper
>
>  drivers/media/platform/qcom/venus/helpers.c   |  65 ++---
>  drivers/media/platform/qcom/venus/helpers.h   |   2 +-
>  drivers/media/platform/qcom/venus/hfi.c       |   2 +-
>  drivers/media/platform/qcom/venus/hfi.h       |   1 -
>  drivers/media/platform/qcom/venus/hfi_cmds.c  |   2 +-
>  .../media/platform/qcom/venus/pm_helpers.c    |   3 +
>  drivers/media/platform/qcom/venus/venc.c      | 232 +++++++++++++++---
>  7 files changed, 226 insertions(+), 81 deletions(-)
>
> --
> 2.17.1
>
