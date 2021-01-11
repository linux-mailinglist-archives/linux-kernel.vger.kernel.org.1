Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF2F2F1D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390083AbhAKR76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbhAKR76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:59:58 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F058C0617A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 09:59:15 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id t16so825557ejf.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 09:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cuQHue2aFICkEz9kv7R1W3R2u1Zdb+DJ+vIipSoyX/8=;
        b=tjrsgg1uET5JjoWglyKX89MzNnJn5jfiKgZRZb9mzwlcJilCLh29jLtHAxgtYvhNXH
         uC4ohdX2/YE0TXbEqJXX5mODcneOnGPFjz+rHDLHnYYnglLMT5tC2vyfM7rbhMOlFOph
         /j8l8k0WILih6RWc7/W5RG363sfGLyssjUeWp6HGZ8KaM1LnsStNQnWPaaC5twbCzbKC
         HtzIEh1/AlnwHYu8m2l9dfWK4M1odyaf9r5B2pa1ykIjxsSoX1ExxTTmx5Wt2nZWeX60
         j/1Ey6mmMeeCAHdy4Y0M/q9b063cgoiR+OizySjnbcGwJB6vUbVgiVXd2dV90mluOMfV
         VvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuQHue2aFICkEz9kv7R1W3R2u1Zdb+DJ+vIipSoyX/8=;
        b=crnI4MxRkuL6JmSrn+ND10i7xJFNzvc900agD43Qsqadd4iCZKewLth/LB59ItfSST
         YD/fcVKkWR2SA6LzLv+mIi3Swunpx/aZdaHC8Zq6GVBHt+cu16w5mFcyhFcVVKD6hrwN
         wLaM7w0P8Ju/nf571bCOD9mEiZfNM3UyKHMYo+g7/jKZplonudq+PNUfk1LOCvkWNo8Z
         Dhb8ud5YZGkKkURuOWn3hY+XjeGqxQwJ9VAvycHJe2N4ZiLXeZ5VcKkW//O/w3e6DpOh
         rhjNfFLlEhl+mWLo8XhBswPLfhI97ZvVEgagXzym8Fb3rU/oBazB7l0VgTO8Ye4nmRqW
         1eXQ==
X-Gm-Message-State: AOAM533mBcT6oAkVRwKjyRuJi0Zu/K3uPX9OOAdfSypyW8D+DypyVJMT
        UOhg50obPVulVTRzkZ4DjOWJxz+RAvY3ZnYiz9rVbw==
X-Google-Smtp-Source: ABdhPJxR9BIaObesgrNJ0PO2y5gTOnh7toLOWdCHdo2Cw6jD7dRUJtspEekzYOotN/XwJEx/37dZ7xAfykzB8ysG0YM=
X-Received: by 2002:a17:906:2b50:: with SMTP id b16mr428955ejg.255.1610387953997;
 Mon, 11 Jan 2021 09:59:13 -0800 (PST)
MIME-Version: 1.0
References: <1610385379-15140-1-git-send-email-loic.poulain@linaro.org> <20210111092837.74115334@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210111092837.74115334@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Mon, 11 Jan 2021 19:06:15 +0100
Message-ID: <CAMZdPi8NsV7srY66T_s_-+GMXUjC-D5ot7GXtaxjO0oMeFBS=g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] bus: mhi: core: Add helper API to return
 number of free TREs
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hemant Kumar <hemantk@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021 at 18:28, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 11 Jan 2021 18:16:17 +0100 Loic Poulain wrote:
> > From: Hemant Kumar <hemantk@codeaurora.org>
> >
> > Introduce mhi_get_free_desc_count() API to return number
> > of TREs available to queue buffer. MHI clients can use this
> > API to know before hand if ring is full without calling queue
> > API.
> >
> > Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> > Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> You put net-next in the subject but this is not CCed to netdev.
> What's the intention?

Oops, thanks for noticing that, going to resubmit.

Regards,
Loic
