Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB482DDB0C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 22:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbgLQVuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 16:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731892AbgLQVuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 16:50:03 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C695EC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 13:49:22 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qw4so186103ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 13:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cZn0/VDIP8GuviNxwhziCIcMwTUnEGXU1Czf1LyLZ0=;
        b=kCArAph5EJpFqMvdN6tKtStdOo19rKqUKa9IxW5p0saZdwtA0uSMgEURq7Jpa8QKv5
         dW2djHch1dT5Wxq3MghYB94RUP+nQFvCIHAuwAUI3oYGVdJJhGjYJ2/TI5mPbmZ4CQZm
         xb03ERR8QRpeoTVQxS+WTaS066+yNPVG0mbBhlJFAc+GvttyVEoNDbngyziUMtD1M/wF
         NDDDWbAOKepGu+g6M9uWvgshzz/uokz/B8YoK/88DBCLQDQSgpLEXG9q7/rET2FQ1bWG
         mD8VJwnLcWKksVoNPbAqVre4LfJfo69oU8b00FXmjCl82cTxp2DUxsKW3RBfde1c88pV
         J/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cZn0/VDIP8GuviNxwhziCIcMwTUnEGXU1Czf1LyLZ0=;
        b=lKO1N3LXQwYVqE2YJUJqVMmL7L0gYDD3RkdQ+d0hXoDY7NcNvFHGhyy8dOysCVcnwI
         M4aEr8+9Np/up1JwQda+N7X+A+FofCrK4UUjEMqYudwzuctArnYbQnIL+fnoElCedMrg
         G4bCFI8mhcM81O8spMFIX5so4xIBbcuY+N/eHV/cEO0tdJaR9aVo67mONVEDiQA8fXfp
         cD4BiCPOAtH/4Ey30DyiLYigbH18IernIW51dkxiM400AOFf4Cj7gYd9JasCkViaTW/1
         v02usnHJpFvWNZavZVyD1b+rwg4CNEaWuObGZqMYNSl472tB2FIY7RgbOLAu8vNy2P/Q
         GwFw==
X-Gm-Message-State: AOAM532i8nkEIwqv9JFQE/tYTX2hq3ME0318bjcrQB2mFrnuQWh8lhnJ
        lbLv0+u7thDC8O0P0VOJgl4pG6D1iRSSexN1JbAAeg==
X-Google-Smtp-Source: ABdhPJwHnoPTmwaKTlKlW0KQTQMxXtV8C/5O6HNYiljCloUk6q7XDy83A/EPUyLdZemvaQVbJmVyjA8hnnz/4KoNMe0=
X-Received: by 2002:a17:906:2707:: with SMTP id z7mr1078927ejc.418.1608241761522;
 Thu, 17 Dec 2020 13:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20201120092057.2144-1-thunder.leizhen@huawei.com> <7ccddd02-e2e6-ec48-43b8-10700285e61c@huawei.com>
In-Reply-To: <7ccddd02-e2e6-ec48-43b8-10700285e61c@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 17 Dec 2020 13:49:11 -0800
Message-ID: <CAPcyv4hLoqYpLxQhPhGA2XxJPOc6VkonjrHSbyEQa2Y=voF8hg@mail.gmail.com>
Subject: Re: [PATCH 1/1] device-dax: delete a redundancy check in dev_dax_validate_align()
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 1:27 AM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2020/11/20 17:20, Zhen Lei wrote:
> > After we have done the alignment check for the length of each range, the
> > alignment check for dev_dax_size(dev_dax) is no longer needed, because it
> > get the sum of the length of each range.
>
> For example:
> x/M + y/M = (x + y)/M
> If x/M is a integer and y/M is also a integer, then (x + y)/M must be a integer.
>

True... I was going to say that the different error messages might be
useful, but those are debug statements anyways, so I'll apply this.
