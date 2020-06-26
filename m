Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5148420BBB1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 23:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgFZViB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 17:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZViA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:38:00 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8E3C03E97A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:37:59 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id m62so6255802vsd.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=je2upLQiNvR0YfyZwqkhD75KKdpn0DZdcrHJes6BiIc=;
        b=RthFPEqOul77xm5bP15m2z+OMgivB1Mb+BzePQWZ57fEQJvSG3Fkg3cCr5Me11XlqC
         GURO9UDwDTHOKxcOHQkT/OprpV3A1IuPf6eh7TcHrZ/baw3UxLv7EZFzCgr+/TdAg6vx
         RLikwq6ApS+HqQ3I/nbeo0DqT4sOsHQiaMKNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=je2upLQiNvR0YfyZwqkhD75KKdpn0DZdcrHJes6BiIc=;
        b=H0FbtCFa6NQZ7WsvoeplQfZbex2H4dEgF251V0Zmw86wh889CsVK444/Ahq0xoS6Mm
         v2t63OzFvmiFLNjdWad/5tlBJrI94jtkXxpPifjTIytRLtf8DG0vHraxEJQehbtyP/p6
         sFPmRZ2bI8ALXurKgCI+f/DlNK0kgsNcoR7Ya2A5GmbjVEKsdDs+MgLKbMBHFbL62YhZ
         d3TFuJantDDK1MfBZBnHrsVaPdBe/b8O7p9kSMx+YpzgnOXLtD5wfVd7P4Fi5aMGHJhz
         oSjt4CqwiY0gjFVe1iV6gw076T/o2Lusi+Wlf0jI1sYnjh6vWtPq9x2CBNrXhAMrW8N+
         eWMA==
X-Gm-Message-State: AOAM532ooit+tgLnQe+ldD/Zy0lG8IQjxcHhJt94oD4MmSdGJieQtQ2N
        dDBBK3FMsj8FwJR3Awdziw46U60D/B8=
X-Google-Smtp-Source: ABdhPJwCXtq8Sw274bM8W72PW0giO3qESw2S8HuIVeoBTozucrtpBUYBw2njrK/QItToF2HDVcjwdg==
X-Received: by 2002:a05:6102:243b:: with SMTP id l27mr3954372vsi.173.1593207478911;
        Fri, 26 Jun 2020 14:37:58 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 75sm516648uai.10.2020.06.26.14.37.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 14:37:58 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id g44so3482799uae.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:37:57 -0700 (PDT)
X-Received: by 2002:ab0:54cd:: with SMTP id q13mr3917857uaa.91.1593207477223;
 Fri, 26 Jun 2020 14:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <1593193967-29897-1-git-send-email-pillair@codeaurora.org>
In-Reply-To: <1593193967-29897-1-git-send-email-pillair@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 26 Jun 2020 14:37:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V_ynwukeR92nbJXkuQ7OAW4mLaTjxko7fXt5aEfDUNhA@mail.gmail.com>
Message-ID: <CAD=FV=V_ynwukeR92nbJXkuQ7OAW4mLaTjxko7fXt5aEfDUNhA@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Add interrupt summary based CE processing
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 26, 2020 at 10:53 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
>
> Currently the NAPI processing loops through all
> the copy engines and processes a particular copy
> engine is the copy completion is set for that copy
> engine. The host driver is not supposed to access
> any copy engine register after clearing the interrupt
> status register.
>
> This might result in kernel crash like the one below
> [ 1159.220143] Call trace:
> [ 1159.220170]  ath10k_snoc_read32+0x20/0x40 [ath10k_snoc]
> [ 1159.220193]  ath10k_ce_per_engine_service_any+0x78/0x130 [ath10k_core]
> [ 1159.220203]  ath10k_snoc_napi_poll+0x38/0x8c [ath10k_snoc]
> [ 1159.220270]  net_rx_action+0x100/0x3b0
> [ 1159.220312]  __do_softirq+0x164/0x30c
> [ 1159.220345]  run_ksoftirqd+0x2c/0x64
> [ 1159.220380]  smpboot_thread_fn+0x1b0/0x288
> [ 1159.220405]  kthread+0x11c/0x12c
> [ 1159.220423]  ret_from_fork+0x10/0x18
>
> To avoid such a scenario, we generate an interrupt
> summary by reading the copy completion for all the
> copy engine before actually processing any of them.
> This will avoid reading the interrupt status register
> for any CE after the interrupt status is cleared.
>
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
>
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/ce.c | 63 ++++++++++++++++++++++--------------
>  drivers/net/wireless/ath/ath10k/ce.h |  5 +--
>  2 files changed, 42 insertions(+), 26 deletions(-)

I'm not an expert on this driver, but your change seems sane to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

With your patch I can no longer find a place to put in a magic delay
and reproduce the crash, thus:

Tested-by: Douglas Anderson <dianders@chromium.org>


If it matters, my WiFi firmware reports this:

WLAN.HL.3.2.2-00490-QCAHLSWMTPL-1

...and it should also be WCN3990.


-Doug
