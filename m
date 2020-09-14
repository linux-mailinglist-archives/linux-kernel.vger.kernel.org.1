Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9C626979D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 23:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgINVVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 17:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgINVVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 17:21:02 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9620C061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 14:21:01 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id o14so320670ual.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 14:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h40Mkmyzjmx1oaGV6NYYOclBhWIiyDBMii4EWAbUUYU=;
        b=EPnLS1RhlA0wyyP1OC7VacOLKiJxMMjRQpvYSkhipIR0qf9WC8RK564fIcvVVeFKbz
         fC8LFeojctt1+gVlRo9X5MbmDgK1ToWp8Y9sHgCHcIzjscTuyvmbWS+p1l6qjzJAWhYZ
         9Qu2jHMXie6FHKJSZDUVVMKxmHVG0KLRa2AC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h40Mkmyzjmx1oaGV6NYYOclBhWIiyDBMii4EWAbUUYU=;
        b=D0j4tv1Aq1zRxGz3CMoeOa4E4Vso6/eRBnMw07PvL6N9THfUmIlRDypCtxpRHEyfct
         OCIRJX/64ueNSO8C5EBjz4ouvMwSxqL33fFZU0afcNQY+hF+QXh15e0YOudlT2AZlO9g
         V43ZDQA0zqgAdPNVLN2yqAxAhfc6qM2pBFbB99vB3P843nAWm2Zg9I8FsIN3Rw2K1daW
         vCddIZT56THEnhN6cD4FCB6jTUKQ2aTQs68pqk9kEfwLaBmN/7oTj3ntJLz1kjV2iGE2
         EoSdiw2FmjXyC8071r1GSgmIIuHVRiZ/oKrX9g6e8TbgoIkWlO1PQFaGJ617Bs6ouFj8
         ZOkQ==
X-Gm-Message-State: AOAM532JKTa6/WEnKNsqFPiwKI0ujLlP6eXfJ1jXvYmTQJ0zZFQnsnI7
        sstGr1+LhCxW4CAc5n+3BZXxUKEgUIYVlg==
X-Google-Smtp-Source: ABdhPJzuJjzkI+LqZNOf1oQZxmvMCCvzOWV8dNhNwQ6oTNl1Ab4z84EhrskXxOGuPvru1A+R5ddw4Q==
X-Received: by 2002:ab0:706:: with SMTP id h6mr7223983uah.11.1600118459704;
        Mon, 14 Sep 2020 14:20:59 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id y72sm1983310vky.19.2020.09.14.14.20.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 14:20:58 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id e14so712985vsa.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 14:20:58 -0700 (PDT)
X-Received: by 2002:a67:ff97:: with SMTP id v23mr8916922vsq.11.1600118458295;
 Mon, 14 Sep 2020 14:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <1600091917-7464-1-git-send-email-skakit@codeaurora.org> <1600091917-7464-3-git-send-email-skakit@codeaurora.org>
In-Reply-To: <1600091917-7464-3-git-send-email-skakit@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 14 Sep 2020 14:20:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WsU87ZWvhsPAWAnrQmK60SvZoxrefZDdW4y4i1MAEmwg@mail.gmail.com>
Message-ID: <CAD=FV=WsU87ZWvhsPAWAnrQmK60SvZoxrefZDdW4y4i1MAEmwg@mail.gmail.com>
Subject: Re: [PATCH V6 2/4] arm64: dts: qcom: sc7180: Add wakeup support for
 BT UART on sc7180-idp
To:     satya priya <skakit@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        msavaliy@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 14, 2020 at 6:59 AM satya priya <skakit@codeaurora.org> wrote:
>
> Add the necessary pinctrl, interrupt property and a suitable sleep config
> to support Bluetooth wakeup feature.
>
> GPIO mode is configured in sleep state to drive the RTS/RFR line low.
> If QUP function is selected in sleep state, UART RTS/RFR is pulled high
> during suspend and BT SoC not able to send wakeup bytes.
>
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
> Changes in V2:
>  - This patch adds sleep state for BT UART. Newly added in V2.
>
> Changes in V3:
>  - Remove "output-high" for TX from both sleep and default states
>    as it is not required. Configure pull-up for TX in sleep state.
>
> Changes in V4:
>  - As per Matthias's comment, removed drive-strength for sleep state
>    and fixed nit-pick.
>
> Changes in V5:
>  - As per Matthias's comments, moved pinmux change for sleep state,
>    pinctrl and interrupt config to the board specific file.
>
> Changes in V6:
>  - As per Doug's comments changed subject, deleted interrupts property.
>  - As per Bjorn's comments changed commit text and rationale for RTS,
>    TX and RX.
>
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts | 55 +++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
