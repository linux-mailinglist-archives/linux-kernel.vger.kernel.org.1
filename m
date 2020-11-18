Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADB82B7340
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 01:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgKRAky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 19:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKRAkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 19:40:53 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438C3C061A51
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 16:40:53 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id d17so439952lfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 16:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hlnCGH+LFWSKa3NWbEHZCA+KnyqTJ5mJquycr6mzLC0=;
        b=b35D5dRCngV85Jkliq8amklURhmzxmMXQXkmzvPciHNdKxKKW9BhNIkUxb8Yd7KzCy
         TxHf/H8xRvfgsEb1vKyJdNoECmnkfmfOJWmbefl/A0VFLDLvGdwQjwBkDH+ExPVjWC1i
         TcQeyjHEY3drDUSyOSxOCAWFx97UyAlVjGH0QiKgY9oRQxpnISjGvWWIuFubXekxBV/m
         oNhErG7gPFfWbJ5rukSn7tJ1+57uFlLzEBk6h0TqEksjg1y81DiFYLQxNRfFwHaOFB9n
         7/uTM4jWbKsfgI9cKJQRsY269jsnq3Eo4TiUF3QUbLr11I5uOd1NrwFpVg4g/Oaejv0A
         lf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hlnCGH+LFWSKa3NWbEHZCA+KnyqTJ5mJquycr6mzLC0=;
        b=nrpM82ubCQw6ZRzXO8QWGxyFPwYZLyqbkIJjQfVPCtU8psolu2kWrruqJ94YXP7r53
         A2nGQ1Vi9wulxhHOmMVtfeFw2wgP9KjJ9+hfdtOARR7WlSMLHsRMzwmMcX2EdN6p1zjx
         Fnm40kKI/1r218g4FgpC6gx6dxEFrqaAamCAcpPYlPaZsLebRW5o6tPXvmchdHIzzVxh
         NDyQw/0x5suHeBj0sLFOmKfLHRkEqReaL6bw8+k8OhMksqsiWXkBTdvz26RQ0fNfuX+w
         Z616x9f3zhLvU88sdmx17LQRxFTPUAG8HfSCnpwZZQftOgt0jPr8MEiacCY550C7OLAl
         B6rw==
X-Gm-Message-State: AOAM533zxEQ9EKmOq5bA+pskYiWRS6dYMAZibzkub/StyildZ9MvSLpe
        wGXFBPBmd2jKIonO6VNknB9T/gDEpnAzbt0DM1kuafQZRamgfg==
X-Google-Smtp-Source: ABdhPJwHvhC6sS5DO4wWxQ0fGIfgHWvnruMbSZXZ13Nm+lY/aSnXpasjCmNCCVodVpaIuuBfv35soaLWZ+nIIxzxjCM=
X-Received: by 2002:a19:7b06:: with SMTP id w6mr2870290lfc.260.1605660051811;
 Tue, 17 Nov 2020 16:40:51 -0800 (PST)
MIME-Version: 1.0
References: <1605201148-4508-1-git-send-email-srinivas.neeli@xilinx.com> <1605201148-4508-10-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1605201148-4508-10-git-send-email-srinivas.neeli@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Nov 2020 01:40:41 +0100
Message-ID: <CACRpkdZca9s2ybNx3N2MnrT-YfVPoSq1Enz3gQ6RS2FSQF8F+g@mail.gmail.com>
Subject: Re: [LINUX PATCH V3 9/9] MAINTAINERS: add fragment for xilinx GPIO drivers
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        sgoud@xilinx.com, Robert Hancock <hancock@sedsystems.ca>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 6:13 PM Srinivas Neeli
<srinivas.neeli@xilinx.com> wrote:

> Added entry for xilinx GPIO drivers.
>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> Acked-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Patch applied.

Yours,
Linus Walleij
