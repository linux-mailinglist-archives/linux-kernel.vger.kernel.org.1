Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16492285E0F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 13:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgJGLZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 07:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgJGLZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 07:25:19 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8948BC061755;
        Wed,  7 Oct 2020 04:25:17 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id j22so1411999qtj.8;
        Wed, 07 Oct 2020 04:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvxFh2lVt/f6BDA0Bx2JmAxB4jOtm8Py2fAMvv0foaM=;
        b=BNoPeubeS3sXBJjI0gkWLOl9TtnB7QMuencLyKdA/jOtb/IGQdLGC84nEomR3w4lx7
         9r0tdf5A85QFnljIjVksg0KJQXlffVvm4hvkE64oEtwYPmJVREvvbhBtreKXlRjgdMSj
         I6sjoizv2hosGo4CNIasokE9hpsVi7mI5ExW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvxFh2lVt/f6BDA0Bx2JmAxB4jOtm8Py2fAMvv0foaM=;
        b=W8KUN9wjhVOkHFfunfSBBfykmnIVmlB6wUeWp0TkfQNltaia9qNJBpAHY2BlKNxG5M
         ODXf9N+MuDHfBWNV4yo4KjlkP7VQL/Oj5JBzH2SaMk/jt9LXpMbROt8VQUKHI+Lv8OV2
         VbwHJim7FhmDAe+JCuSKhHvaTOMU9Jk+OyoC/TIkt4R/NfTxl5xodxXMuaROmYXMB0Qw
         lDKv7DGmg4Ta4edknf9DIDIbRMPhy64qqFl/rmrh4+GbL0sbsCCUTZ3ta/YIgQntq+JN
         Vwj/YtSKgDmPvk1LOHrTHNie8SQDLPEGyKnZT34esjjgmU/VgBjNKPGlrPAB9gKHkMC0
         QuTw==
X-Gm-Message-State: AOAM532YhPOcOERRgIa+I9zQdWdJalPi+82/nvD9/3O1grgV8g53KltA
        hgEUPgJVdHSNzQwGmzQSeMeIDV6/v04KUtH3gZgpQ7ph3p8=
X-Google-Smtp-Source: ABdhPJwRYZfAQA9D02ndfJ8Hwo5EMEXHSivMoq36Tr5vogI302Zi7/RH2rzq66EfzaFRDq87koLxojb4z3VA3ooIm/g=
X-Received: by 2002:ac8:48ca:: with SMTP id l10mr2586401qtr.385.1602069916742;
 Wed, 07 Oct 2020 04:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200930040823.26065-1-ryan_chen@aspeedtech.com> <20200930040823.26065-3-ryan_chen@aspeedtech.com>
In-Reply-To: <20200930040823.26065-3-ryan_chen@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 7 Oct 2020 11:25:04 +0000
Message-ID: <CACPK8Xc2Y1njgtrtjO1bdmkcQR7jDu+oaOBc3R+CWtn+UrEOhQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] usb: host: add uhci compatible support for ast2600-uhci
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, bmc-sw@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 at 04:08, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
>
> Add support for AST2600 SOC UHCI driver.
>
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

USB maintainers, can you please take this patch (2/3)? I will take the
others in this series through the aspeed tree.

Cheers,

Joel


> ---
>  drivers/usb/host/uhci-platform.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
> index 70dbd95c3f06..fa40fe125c2a 100644
> --- a/drivers/usb/host/uhci-platform.c
> +++ b/drivers/usb/host/uhci-platform.c
> @@ -113,7 +113,8 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
>                                 num_ports);
>                 }
>                 if (of_device_is_compatible(np, "aspeed,ast2400-uhci") ||
> -                   of_device_is_compatible(np, "aspeed,ast2500-uhci")) {
> +                       of_device_is_compatible(np, "aspeed,ast2500-uhci") ||
> +                       of_device_is_compatible(np, "aspeed,ast2600-uhci")) {
>                         uhci->is_aspeed = 1;
>                         dev_info(&pdev->dev,
>                                  "Enabled Aspeed implementation workarounds\n");
> --
> 2.17.1
>
