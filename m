Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0018B2CE102
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgLCVpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 16:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbgLCVpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:45:22 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34738C061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 13:44:36 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id x26so2146800vsq.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 13:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6T24NQIEL2Q3npImIjb4SqD2n+RAY5kl9vQ1djFk73c=;
        b=mqtjKFfBu9ozxPIpUO/HkMSeirSUBhvKgfZjs9Uy+d7ZgvenL68CH2T/ykAXUEWCvA
         460kAUzJbfL+Hx2V4IrfVHPUPk0JC5zlH3Ut5YtXlmcmj/BqXX5Zr02UkezRB2LgJs35
         Vw9LTmLVj8aXO3Ho5GZo0o7efANKakrcfoXHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6T24NQIEL2Q3npImIjb4SqD2n+RAY5kl9vQ1djFk73c=;
        b=uiCxAaHnOGlc8WrB2zq/8+Hd1zXLB1AGUhZrh4CeB5F+qoRagV8NtUrEU7E7ONqkXg
         8melRMbG/e0BdfNMTZZkxBD4jThrMLxEnwVXB39HNdPr+whnyQBlRXt/Nf1nuxYPNPq8
         oVkt+OuaXa8RP5aKlubznOwIePvAn8cVarEQwBUTW0EBKTHUbbClG8thkgoL1W8+y5nc
         N1m7yHMNLaiek48Y8vsOzexU/2CpWxeN6G5Bl07VvQ64579Nlkug7bH5f0RLGr8BwY07
         7EqNJlRNyk4vGx1oVJHyxb+HfSGbsqJKysNgOIao2EGlYm0MC+ZmeMouM8kkYSuLi65V
         niRA==
X-Gm-Message-State: AOAM530oBUeZexCBWdowa0NDCJeZ4yvS7fOMEhnChdDF4OuroqepzJaJ
        FIRHCGSpLR92r7PKKAwNFKU4Uc4I/kO+tg==
X-Google-Smtp-Source: ABdhPJxSbVFY4eHDZqIXw9rQc6wPOyGnJ3m8E3vXgWWS00gr61UQK+cNxCxbldjxrd3pepSBtTsoDg==
X-Received: by 2002:a67:2907:: with SMTP id p7mr1386238vsp.21.1607031874823;
        Thu, 03 Dec 2020 13:44:34 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id r128sm117797vkr.13.2020.12.03.13.44.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 13:44:33 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id r9so775021vkf.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 13:44:33 -0800 (PST)
X-Received: by 2002:a1f:9f04:: with SMTP id i4mr1331869vke.7.1607031873197;
 Thu, 03 Dec 2020 13:44:33 -0800 (PST)
MIME-Version: 1.0
References: <1606203086-31218-1-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1606203086-31218-1-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Dec 2020 13:44:21 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V60zVYkFGQvAu6qfpumBL6+fm_9ziRCSiN7Um7+ra6zw@mail.gmail.com>
Message-ID: <CAD=FV=V60zVYkFGQvAu6qfpumBL6+fm_9ziRCSiN7Um7+ra6zw@mail.gmail.com>
Subject: Re: [PATCH v2] soc: qcom: rpmh: Remove serialization of TCS commands
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Srinivas Rao L <lsrao@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 23, 2020 at 11:32 PM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> @@ -423,8 +422,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
>                         cmd = &req->cmds[j];
>                         sts = read_tcs_cmd(drv, RSC_DRV_CMD_STATUS, i, j);
>                         if (!(sts & CMD_STATUS_ISSUED) ||
> -                          ((req->wait_for_compl || cmd->wait) &&
> -                          !(sts & CMD_STATUS_COMPL))) {
> +                          (cmd->wait && !(sts & CMD_STATUS_COMPL))) {
>                                 pr_err("Incomplete request: %s: addr=%#x data=%#x",
>                                        drv->name, cmd->addr, cmd->data);
>                                 err = -EIO;

In my review of v1 all those months ago, the way we left things was
that I disagreed with this part of the patch, and I still do.  I think
you should leave things the way they were in tcs_tx_done().  Copying
my un-responded-to comments from v1 here for you:

In your patch in __tcs_buffer_write(), if "wait_for_compl" is set then
"CMD_MSGID_RESP_REQ" will be added for every message in the request,
right?  That's because you have this bit of code:

/* Convert all commands to RR when the request has wait_for_compl set */
cmd_msgid |= msg->wait_for_compl ? CMD_MSGID_RESP_REQ : 0;

That means that if _either_ "cmd->wait" or "req->wait_for_compl" is
set then you expect the "sts" to have "CMD_STATUS_COMPL", right?
That's exactly the code that used to be there.

Said another way, if "req->wait_for_compl" was set then it's an error
if any of our commands are missing the "CMD_STATUS_COMPL" bit, right?


> @@ -30,7 +30,7 @@ enum rpmh_state {
>   *
>   * @addr: the address of the resource slv_id:18:16 | offset:0:15
>   * @data: the resource state request
> - * @wait: wait for this request to be complete before sending the next
> + * @wait: ensure that this command is complete before returning

In my response to v1 I suggested that a comment would be nice here.
Something akin to:

Setting "wait" here only makes sense in the batch case for active-only
transfers.

This is because:
* rpmh_write_async() - There's no callback and rpmh_write_async()
doesn't set the "completion" to anything so there's nobody that cares
at all

* DEFINE_RPMH_MSG_ONSTACK - always sets wait_for_compl.

-Doug
