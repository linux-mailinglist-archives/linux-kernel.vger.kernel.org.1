Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE611DD2F8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 18:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgEUQTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 12:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgEUQTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:19:41 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC61AC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:19:40 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z206so1143729lfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIZDqXyVoJ9gXghdJYiCEKQMjkIgQruodsIsQe4U9dY=;
        b=BrekDs2JD+FzZFLruCXCuGD0Mu8sx1xv/IFDqsRUwkYc08YCvYiQjgly85qxl4NA0G
         WHHro40yVkTqswRWpJkzs5MEqP4KFXZx2rEVgsu0xe3SmhztFADeO7Z94hysY6t4LD8A
         AoUpMnF2V3N3NLAFUDiIthmFJc+18kTPTwZ48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIZDqXyVoJ9gXghdJYiCEKQMjkIgQruodsIsQe4U9dY=;
        b=fYDTeonTGP7mmMFStGqyA2bLfX+LjcHl5OGjchtwE8qI84HGvXLtiriatX8JErgBbZ
         ffr3O8i1pg2XfHGbtPypXn9KAGON9mUC0DHte0O4joX4SWHmEv01hutx9hAovpu5dg3P
         ya0NbQyTn6jxrhLfsf7NaUnYkCX8hMbwm5ai+eYZz9b9oSwt8aAH54q2wr66oZHwbxDD
         Deh8lc2+y4UQV+RJpQW9RztVqXzT5N0jZRPpmzZXu5xroc8Gn0ZXfcIdytrX/slmH968
         Eeb86++BiPndIOO5yux4JGQG3t6MEQpcoxouxzCCHFbJTx1+Efk2krzlVeK38KAtEDYL
         QPJw==
X-Gm-Message-State: AOAM533aZOE848nCxJGjWNGuGntCBf2LMSe2Yt58MyU/uhXrShZyXf0i
        NvftGOebTNf/tvnShGm/PbXHlvNFE0g=
X-Google-Smtp-Source: ABdhPJyo7rC3W35oAyuscWmpvKPULU+Xcxjqm7lsZDpdH8e0y5x9O/7cPJAirAtGlzU8q/PNb0M+Kg==
X-Received: by 2002:ac2:4c05:: with SMTP id t5mr3474712lfq.150.1590077979017;
        Thu, 21 May 2020 09:19:39 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id c11sm1827715lji.17.2020.05.21.09.19.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 09:19:38 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id w15so4755409lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:19:38 -0700 (PDT)
X-Received: by 2002:ac2:4114:: with SMTP id b20mr510711lfi.34.1590077977634;
 Thu, 21 May 2020 09:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200521010337.229177-1-swboyd@chromium.org>
In-Reply-To: <20200521010337.229177-1-swboyd@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 21 May 2020 09:19:00 -0700
X-Gmail-Original-Message-ID: <CAE=gft7p8E+6JB4Ukrt2wDXeWeuoUik4ovmikYvHDhTP+s=HGg@mail.gmail.com>
Message-ID: <CAE=gft7p8E+6JB4Ukrt2wDXeWeuoUik4ovmikYvHDhTP+s=HGg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Move mss node to the right place
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 6:03 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The modem node has an address of 4080000 and thus should come after tlmm
> and before gpu. Move the node to the right place to maintainer proper
> address sort order.
>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Sibi Sankar <sibis@codeaurora.org>
> Fixes: e14a15eba89a ("arm64: dts: qcom: sc7180: Add Q6V5 MSS node")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Thanks for the cleanup.

Reviewed-by: Evan Green <evgreen@chromium.org>
