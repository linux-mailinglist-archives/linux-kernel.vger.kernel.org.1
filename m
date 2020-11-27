Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083EC2C6E8C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 03:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbgK1CcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 21:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730985AbgK0T51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:57:27 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32B7C061A55
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:34:14 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id d20so8437288lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1RBMXiQOLE13g0hTPPwsor7p7yq+DmjbzJB4mrcFwrc=;
        b=bk5CK6Jab1cYgzYCxJL0J5F2fvtwM2+00EPaujsMTBwIyJ0n6Rje7YjXWaS1WEHn2J
         eF9TB29I9qNJpAzLmg5h9tTjdRDXbkpK39cnjO2g03xMFdx7EM5Dv3p8kmCjTV5TmbpW
         oKJdID83V5n+Md+1mkYj2hF75LTuiOtyzai2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1RBMXiQOLE13g0hTPPwsor7p7yq+DmjbzJB4mrcFwrc=;
        b=gCcwsfPeipwSZh66JI26Dpe+KqAR23Sz61C35EhShQrZZw6V8Aki/d23pJkxlDT7kK
         hCz1nAdooMCCbm7uebFlxl08EE61jSmthng+ym0ywEyuAiXg2IBnmLVLYewhaDOYOO6g
         sNZqX1DeRpJM+byfvFY+sfEHGPlmmwIZ+4BVtuQMisuhCggEtBDEm3MC0XFfuVRyCFNJ
         9+tCjIBfqPgDrcQ9v5v5b3KMmaiqvh+vjGmuzSi9IqGcZHTy5yU1g37ezaNcW5rKJ1fK
         VvdChEDQ9mGl3maVLZ6pQxZN8LYctBKyAW4MPrCFp6R8yN3va/pKySjPFcY/sbdKwYZy
         pRcA==
X-Gm-Message-State: AOAM532pN6pE6CETZQPzTbkwbW7leV4KrdD2yQSMTVyXBzRxe6c1HdrC
        9rPNFJK8xN2ypqwin4wpER8SX7buCqiLyw==
X-Google-Smtp-Source: ABdhPJyCgMaZVbqD8KQoL1ahCUj2QlXgIYZLR3pOjZQqlKo3TjSOq8fsvwaCgr/br39npOolIIhKhA==
X-Received: by 2002:ac2:4465:: with SMTP id y5mr4358412lfl.172.1606505652846;
        Fri, 27 Nov 2020 11:34:12 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id n5sm796237lfb.306.2020.11.27.11.34.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 11:34:12 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id s27so8482275lfp.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:34:11 -0800 (PST)
X-Received: by 2002:a19:3f55:: with SMTP id m82mr4124071lfa.344.1606505651430;
 Fri, 27 Nov 2020 11:34:11 -0800 (PST)
MIME-Version: 1.0
References: <20201127134907.9C8BA221EB@mail.kernel.org>
In-Reply-To: <20201127134907.9C8BA221EB@mail.kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Nov 2020 11:33:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjJwRvUHvwYeqxKayE4RZqowSDyEdB=hpVmqHE-JCFk0g@mail.gmail.com>
Message-ID: <CAHk-=wjJwRvUHvwYeqxKayE4RZqowSDyEdB=hpVmqHE-JCFk0g@mail.gmail.com>
Subject: Re: [GIT PULL] SPI fixes for v5.10-rc5
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 5:49 AM Mark Brown <broonie@kernel.org> wrote:
>
> A few fixes for v5.10, one for the core which fixes some potential races
> for controllers with multiple chip selects when configuration of the
> chip select for one client device races with the addition and initial
> setup of an additional client.

That's a really hard long sentence to read. I was going to try to
rephrase it to be a bit more readable, but gave up.

Anyway, pulled, I just reacted to that explanation not being easy to parse.

             Linus
