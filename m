Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401D52C98B0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 08:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgLAHwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 02:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgLAHwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:52:43 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63B9C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:51:57 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id pg6so2162388ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADuK0cNQ7kq78gkfL8xTpfoOe44uSQD9QptHDqgz3YM=;
        b=HaxPCqctu1cUCKs5GEjODb0P1my1sjErEcNCB3E8ekqQdcMqoOsB6xhfuT1EcyY3Sn
         cbhEr5RwsVbk8VR1eNO6nDVBTlPgKB2EC1iugVbSH8KJmIfe9KCFnvIj847s/Y+E8F4p
         J14I70QYBAYTRUWIEacSYu7zSmI6a7OFQZpJssGoK7wvZJATWpUzxWfsi+ss7VbaDoS0
         GNfgOgEqTE+LBXznNTrAt6bA52EkCrB++XOJN7SHCgQiTp7sJo2jii92ap1YXCeDy18G
         0YDJhvalDxtcUFgZTjOKTVKYXPUd01H/6VeiAZFMm4e+tVwXU1lDXQ5ORiK3iaRgOSK3
         qAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADuK0cNQ7kq78gkfL8xTpfoOe44uSQD9QptHDqgz3YM=;
        b=LMskbqU7JlUzH0LuIBW1Mla8LTWdv9bUT0s+ZfN9FRIjuDnuYOctdpRWhSCOhY7bmd
         rLn35edk/2hAE5Rs7uc2nmHs4Cybb6xfnnVRtxtUoeGK7E4bQ10YzSyT3yWGOJJ3ZBz+
         EbspVzwODTQgp8ai1B0G0u6tlYYHpKkxO0yv6WC5FrXIMSw+lisTGVBNtgWig70j9+xj
         64K2HQEwJQOJtoVXAUKlcFVd+IkelAhSwQJT1+yRZh/mEii31zz0wVb0gWviNUoF0imv
         cENUR4pt//XN9qDzVGF2wKge5yBENX4CRBOJbb9aC0+ZTt3C6AQjyJ7tMo9vcYLqlJ04
         1nQQ==
X-Gm-Message-State: AOAM532L41PvtgVrTviF7DD0J8/W/y6RQ6YKGzq9ZRgHfasaBU/VJGYu
        SJqEJtnORSz8v1PAtU2hvMLVAyNLUNXvs8GuGdWBqQ==
X-Google-Smtp-Source: ABdhPJxRe4JckyL4y/p4fflrQcfI51YhZv7eqjf7J/riACxh3gP6uG74xxEZq4E43u5dQUlGAZeJOTJOgJzDizORpVM=
X-Received: by 2002:a17:906:2798:: with SMTP id j24mr1814414ejc.328.1606809116202;
 Mon, 30 Nov 2020 23:51:56 -0800 (PST)
MIME-Version: 1.0
References: <X8XqbtkPpEKSfFi2@mwanda>
In-Reply-To: <X8XqbtkPpEKSfFi2@mwanda>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 1 Dec 2020 08:58:11 +0100
Message-ID: <CAMZdPi8eLwLxZQqQYLNQftwivfRYOKJkP1q195aeQ+Z0EX8gCg@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: core: Fix error handling in mhi_register_controller()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Dec 2020 at 08:05, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> There are a few problems with the error handling in this function.  They
> mostly center around the alloc_ordered_workqueue() allocation.
> 1) If that allocation fails or if the kcalloc() prior to it fails then
> it leads to a NULL dereference when we call
> destroy_workqueue(mhi_cntrl->hiprio_wq).
> 2) The error code is not set.
> 3) The "mhi_cntrl->mhi_cmd" allocation is not freed.
>
> The error handling was slightly confusing and I re-ordered it to be in
> the exact mirror/reverse order of how things were allocated.  I changed
> the label names to say what the goto does instead of describing where
> the goto comes from.
>
> Fixes: 8f7039787687 ("bus: mhi: core: Move to using high priority workqueue")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
