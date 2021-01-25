Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E34303460
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbhAZFXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbhAYJ7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:59:07 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAF8C061352
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 01:58:03 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id u7so2523592ooq.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 01:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gdta58PoWmtu6e7uN9H109dtWomdId8gGVo4iHeqt88=;
        b=fV8fdKnejyryuPs55rwRZ26aKdhNIT3xcjuCTD4stVmVjK9A1Fsol8Vn6za2Nlq4Yi
         eePY7y51sjRcXiOXpryPTdyrIiwuYHvuOYnMI1h9F50r+9PGxLXHjo3hbO+Q0ayAjV7p
         O5HUYj2H8k+4UJNvSKkh1id4l7siWnNSYTHs3+sdQCn8RANUrulO0aIiKVCGRJunNrGU
         K0uXdfoDc64dH8RnS3go5g00/qj2c0pHskeLOs8JskTek2FRN2M865HXrG6i7P1cZEMw
         GAQBXl0rTZOiV96/ag9ypNwe3U+cX8u6TqSy3P/dBjOXN2j3LqmJorHHGnI0l7B6z14U
         JoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gdta58PoWmtu6e7uN9H109dtWomdId8gGVo4iHeqt88=;
        b=SNCIgP1AYLU9j7GTjx33aAqG/dmjJbTP1TtGynsFLQpm54aPRT4fZ5MzYRHluvLBdZ
         cMlulsAKq50SxgqpZpeZI7wDqEVx+6GztMLN+d7NGT3XSanawY9RT4m66aHdWglOfzfD
         Q3yBvtQlWv4BNGok65Sma/Mk3Kgg5ubi7th2esRIGc1QqqHBiv6/rMYrAd2l/7+zY2mi
         4T911gYPKDt+xh0X+bnFeS7WlC0rqjC5p3eBpIQyS7VDJ6s4nURXflIkRrTzvTvGWJBi
         QLr7eg68l8gA4cdsjtxwhgNaGKdbB7NqT+F1NzBHByR3FwXWRyo46Fd+JYd2hHf8eGD+
         WZKg==
X-Gm-Message-State: AOAM533GhPszGGMu7awWVuKljQdA0bH9+sZwpZclBnOkH16hB6sKFVG+
        WcfyQ+fxBGJ7RWj8Gqgzq8ssZA4yW0ILul8LU/rx/ptvOqQ=
X-Google-Smtp-Source: ABdhPJxKwolVPl9GSYzQ72NMQqgfHvx1b/haUyn3tfYc8+iwE8PiKfqFuOXkDJKXPKI8gXh1AhAAYYknS/kMMVHXF6E=
X-Received: by 2002:a4a:51c3:: with SMTP id s186mr8553ooa.6.1611568683019;
 Mon, 25 Jan 2021 01:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20210125095445.1524477-1-jens.wiklander@linaro.org>
In-Reply-To: <20210125095445.1524477-1-jens.wiklander@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 25 Jan 2021 10:57:52 +0100
Message-ID: <CAHUa44GtqJhvX7jUvKWu08J+A2EWqewzosMsez3mwGZ9gA21Uw@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: remove need_resched() before cond_resched()
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rouven and Sumit,

On Mon, Jan 25, 2021 at 10:55 AM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Testing need_resched() before cond_resched() is not needed as an
> equivalent test is done internally in cond_resched(). So drop the
> need_resched() test.
>
> Fixes: dcb3b06d9c34 ("tee: optee: replace might_sleep with cond_resched")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/call.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Can you please test to see that this works in your setups too?

Thanks,
Jens
