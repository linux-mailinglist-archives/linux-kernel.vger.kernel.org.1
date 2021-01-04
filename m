Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5913E2E97D7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbhADO6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbhADO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:58:16 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E47C061795;
        Mon,  4 Jan 2021 06:57:36 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id h186so16592272pfe.0;
        Mon, 04 Jan 2021 06:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/88hWHhawmLwguzthC+DSCLeXl+zHQ4map2EU3yT/Y=;
        b=DwhW+rciBDjyD4tw05k/sk3novSuy4yn3xLsdWjOOymqrcTfwVv8w5lUOZoQ5uF+kP
         ssP8zjgJkXIHnCgwbnvYCgCthdRpylAAqi1M4KKpm2djNiFsyfwzRy0qlbIPU7Lxfa7b
         7zf8EQNg56RBQy78pkP1ig7G2rqX28meo0LRvvNJC8uPNl+Mdw931bi9rg3NY9qa77XQ
         fvLowQMbdPOeEpqe0qdB3kdTIQ8dRR05dBIGd4t+IQdS32jJvxabeznVIg/3g/JcguvV
         CND6cob92RnG/ibMA1WWU+WOHqrQLuYMbVzkWm5EwQ1Q3D/J3HCQfqmTNveY9aX28yfR
         Ke4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/88hWHhawmLwguzthC+DSCLeXl+zHQ4map2EU3yT/Y=;
        b=rDidUPnV+VfLGAnTeONf8i045uXNSN/3VspgsFZ47vHk2X9CdAFI5+r95upd75GuxU
         Rm2M6VCw8U0xbr1hXMDqUrIkZgEQ72KbT5N9hEsgrwyqwKPHLEYXHjoXnlpgv2f3UmlG
         H4TOSlNZ9S6y2MBjSuEr9TzPkXGNcYcSlAQygnZsoROelk3PKJmguNh1as/aTW9luXvw
         5REtNYQzYkUP0qnjEA3a+sYHlXss9gQ/pW8hY5gkWgtwAoTiu+S5qP0lJmUE9X2xGDHp
         TaZREt5qHWV0Ov6Lu7SCm4h4C62la743YQd/8P9WxSZdPeF8ZAF3sNCAXsH4apX9rWWY
         4IbA==
X-Gm-Message-State: AOAM531OdlXdx65qblFh1drElIcLfLk+AZma121Yh53A0aphkSk2uMtA
        NKk6ECn63Dhyuu5zyBvBYK7YtQiTOzh23zSSqGA=
X-Google-Smtp-Source: ABdhPJwgVIn4wwts/k8rW10jgqqRLrWHFH4ncIrTHPra1Y09/ykqbBqbAZoBmpsEqzXJKQajJftBm2Ak9z7vrDDo7Hw=
X-Received: by 2002:a62:528c:0:b029:19e:4a39:d9ea with SMTP id
 g134-20020a62528c0000b029019e4a39d9eamr66979900pfb.20.1609772256200; Mon, 04
 Jan 2021 06:57:36 -0800 (PST)
MIME-Version: 1.0
References: <20201222145603.40192-1-jim2101024@gmail.com>
In-Reply-To: <20201222145603.40192-1-jim2101024@gmail.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Mon, 4 Jan 2021 09:57:31 -0500
Message-ID: <CANCKTBtJ2N2N8tKDo1X8Q0rkDZD_RcSL=KqnwnCd0Wg98ELDsw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional interrupt
To:     Sudeep Holla <sudeep.holla@arm.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE Mes..." 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

Since RobH has reviewed  patch 1/.2 and Florian has acked it, can you
please accept patches 1 & 2?

Thanks,
Jim Quinlan
Broadcom STB

On Tue, Dec 22, 2020 at 9:56 AM Jim Quinlan <jim2101024@gmail.com> wrote:
>
> v4 -- s/message-serviced/a2p/ in the bindings commit message.
>    -- Changed author/s-o-b/committer email address as my company is now
>       appending boilerplate text to all outgoing emails.
>
> v3 -- Changed interrupt name from "message-serviced" to "a2p" (RobH)
>
> v2 -- Correct commit message, s/msg/message/, and remove extra WS on
>       "dt-bindings" commit (Sudeep)
>    -- Change interrupt name to "message-serviced", move irq assignent to end
>       of function. (Sudeep)
>
> v1 -- original.
>
> Jim Quinlan (2):
>   dt-bindings: arm: Add optional interrupt to smc/hvc SCMI transport
>   firmware: arm_scmi: Augment SMC/HVC to allow optional interrupt
>
>  .../devicetree/bindings/arm/arm,scmi.txt      |  8 ++++
>  drivers/firmware/arm_scmi/smc.c               | 38 ++++++++++++++++++-
>  2 files changed, 45 insertions(+), 1 deletion(-)
>
> --
> 2.17.1
>
