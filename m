Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF751AE3CB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 19:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgDQR1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 13:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728737AbgDQR1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:27:53 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF5AC061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 10:27:53 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r17so2452365lff.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 10:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5NQST1nyAnu8ptbe8LACwEwOXn5hUjgwJZB1HluWEM=;
        b=BSDsQEQvITDO8FLYNfEM0Jy04yGRqu4vT5WnT4ovVsI9MQ2hNBwuBUKS2lm53hq5Bv
         WHnmjmziBdosh0dRodafXf1uMEqQeME9vosQjgwmwclZP9dIODWxm8GmEinVVsDSTl7o
         MNme38G/piidMQHqHQGf3MIdQ0/f7fGAcyfdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5NQST1nyAnu8ptbe8LACwEwOXn5hUjgwJZB1HluWEM=;
        b=XnirT6rA0NH2lTJQ26tXxcZ4tpjtcvu8fpXARRdA8kjxg7sXLGkHXxskh8PRT23ETv
         JoWt7AWTFjx12RA4/guPswtAD6FHUclj0fmhzUi1lSYoxO3piejcuzTSCyopr6UdFOxA
         BDyw24KWheAiOKTNQTRum7gBe850osuyWsdsPDVgz10M65YfTYg7DRGPV+nQggCIksTV
         6kYoBIVtuRqlqeVYaELcLUGRGInFMyzVp0FvtfK7BM5pzx7NpudovZXqfywKba9BH+aN
         jKwlet064YVlRAyiRT6/k6eJdNSwFh581emI2lJEQ/gXYrWXlqvU+SZcSHWk+rFRqjpD
         zFTg==
X-Gm-Message-State: AGi0PuYXJWE2LoRnFth3QiUjT7EosqHH4J4oI4Ud5s8AvOCHr32DSnPp
        Wv8q+3b3WLNhzJtfOeSfulNeXAzPBDI=
X-Google-Smtp-Source: APiQypJWh61MAD5Il8dxcp9zq5ipRUOwDDWkmNlNp4TQFrA9gwSq37hkF72ErgM8/So9nEzg0nUpIw==
X-Received: by 2002:ac2:420c:: with SMTP id y12mr2833154lfh.26.1587144471217;
        Fri, 17 Apr 2020 10:27:51 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id m18sm18378317lfj.10.2020.04.17.10.27.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 10:27:50 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id z26so2822489ljz.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 10:27:50 -0700 (PDT)
X-Received: by 2002:a2e:870f:: with SMTP id m15mr2800184lji.16.1587144470102;
 Fri, 17 Apr 2020 10:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <2750fd4f-8edc-18c2-1991-c1dc794a431f@kernel.dk> <CAHk-=wiWP0M=ZAim7VVuoR+5ri+Ug+KZDE-TZskma4HV91ACxA@mail.gmail.com>
In-Reply-To: <CAHk-=wiWP0M=ZAim7VVuoR+5ri+Ug+KZDE-TZskma4HV91ACxA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Apr 2020 10:27:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhvP+UQ=A3SHFgT7DUFJ-M7pFPrUusJSFo8p0x8wQUhw@mail.gmail.com>
Message-ID: <CAHk-=whhvP+UQ=A3SHFgT7DUFJ-M7pFPrUusJSFo8p0x8wQUhw@mail.gmail.com>
Subject: Re: [GIT PULL] io_uring fixes for 5.7-rc
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 10:26 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I cannot convince myself it is right. How do you convince yourself?

.. and equally importantly: even if it were to be now correct - how do
you make sure it keeps working when it's so odd and subtle and crazy?

               Linus
