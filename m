Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872351B7DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 20:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgDXSSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 14:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbgDXSSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:18:17 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83906C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:18:17 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id c17so10414864uae.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IyAAaOwFK7ul7d9czQcmoPsUFdvkN9A5K/n4TydUE7s=;
        b=PF+kY+n18N6Y8sxBrsgfpMsiJrDvPdLp7v6zKmnMnR+nF9jYyMmXusEJ65ZmgOTgo7
         jaIYJG5iBR3nlo17YckUo9KEvEJsZ4SQDkGJbHsPinLM670SN8oDB5nrrstzmRzRoLGx
         URl+TGalt+yIGIzbDtOZv8ZfmyO19a4tV2XLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyAAaOwFK7ul7d9czQcmoPsUFdvkN9A5K/n4TydUE7s=;
        b=Dyy/0F25S6iVGj++rqGAygpFp7iHFVCN8cz77ErA46G3RMXa05JzKUIoI+PVan+LH4
         WNZc507UH2LrJM7EQLcH9JwP8H8KJxRK9pHH9MFZxuoolTxO/y0mqgTnSWMc7NQS9Xny
         mU27vJpEwyZ5zh9moXBBh0Es6f25POMvT/CVB9zGaBcchMsyG381hapeGN0lesqHbfJX
         NTPJjZyTVK4KBCMjlBtx6VqPSQwt5pG8cm75KHflpcUqs1/tauI/8/rrvhu6fikn6JwQ
         y3d5EKUCUr2E0Z4iwFww4MMlkWVFl3VdnaWiduY+3qnbBO42w7t2o1dJ+auS7EhotiCW
         CRIg==
X-Gm-Message-State: AGi0PubLCprhK05Sz8/kLe4PwclsF5x3XbSA3U1b2ukuU3j3IRofoZLR
        37yGANMcaXyY66aXZbX4eHIbUsFr/28=
X-Google-Smtp-Source: APiQypKtDN1vX4Z9WW9po+5ok6thGRizvy+ZC8Qf/IDRK3qrgembM+w025i0EzD2qI9IeSWq6TAyAg==
X-Received: by 2002:ab0:268a:: with SMTP id t10mr8494515uao.20.1587752296101;
        Fri, 24 Apr 2020 11:18:16 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id f16sm1555597uaq.3.2020.04.24.11.18.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 11:18:13 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id z16so10418959uae.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:18:12 -0700 (PDT)
X-Received: by 2002:ab0:b88:: with SMTP id c8mr8784752uak.0.1587752291944;
 Fri, 24 Apr 2020 11:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <1587716031-28199-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1587716031-28199-1-git-send-email-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Apr 2020 11:17:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X8NY+3pECsF27SC80FQmzewJ1gSs48wzB=PTYRZ4pCaA@mail.gmail.com>
Message-ID: <CAD=FV=X8NY+3pECsF27SC80FQmzewJ1gSs48wzB=PTYRZ4pCaA@mail.gmail.com>
Subject: Re: [PATCH] serial: amba-pl011: Support earlycon_kgdboc
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-serial@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 24, 2020 at 1:15 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Implement the read() function in the early console driver. With
> recently added earlycon_kgdboc feature, this allows you to use kgdb
> to debug fairly early into the system boot.
>
> We only bother implementing this if polling is enabled since kgdb can't
> be enabled without that.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Depends on kgdb patch series: https://lkml.org/lkml/2020/4/21/1179
>
>  drivers/tty/serial/amba-pl011.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

This is the first time I've ever looked at the code for this
particular serial driver, but with that caveat your patch looks right
to me.  Specifically:

* Code, naming, and style of your new read routine match the existing
write routine used for earlycon.

* The read routine looks to read the same registers / works the same
as the main "polling" read routine, pl011_get_poll_char().

Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
