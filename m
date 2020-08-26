Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9F92535EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 19:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgHZRSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 13:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgHZRSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:18:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D92C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:18:42 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t23so3273493ljc.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2pT89N8VTc50vb4WZvr37iDU8cKlOdxTlcFrKtLW66U=;
        b=cMOLov8uCC9JY8w6U13qumCS9ENiAGpNrGXqc146BmlR/vAukuVhgZfHIUqIeUkdg4
         lLbw9ZtMP5viBD8sFKvrK3hno/r9xAlRjIECnyA5JcySvUvAJyflC5m773B/E/NUUD4+
         w7bCHAb/+HOhXubK+D31xy7psk63Dj248+vR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2pT89N8VTc50vb4WZvr37iDU8cKlOdxTlcFrKtLW66U=;
        b=cPEhuv2J4DVgDrF7/La4te3pw3T8/wHT/xbzUMqYaeA2dzt4YUwt/I51InUCeOq+ga
         X4U6HK96uY/e4Hf0UcLFlBCmbwmjaiggGBOB54zVY7UHCA2zlpzMu9uBTgtFXf7xwk/f
         kS6Rftimqhp/LyCJ5E/y5ps1nLLHTRY56JzBoYowzYfilaw8XwFcGZ+K2+6C+crQv0Kb
         m2s0BqGlywyqYmi38zUjNqaXKGpd0xaqYGxzdX4rsbeXJScof3ST32hKzFZsnzA8sMYq
         IiYjtnTW7t+SNXE8FW9WM7ZPkgyhTxvImOKqrN94oQSPgDVESbj3B0X9Ihp4Xk3NdV2/
         /r4w==
X-Gm-Message-State: AOAM532V3KbWpQIY/JfAfJvMtLoIyJXIcwZDru9VOdDZxncdv1HsbQLp
        iOFVe6uPTdWlKpUcgk9/G5Z6G+snB298DA==
X-Google-Smtp-Source: ABdhPJxxb4EcRqKceZTHNnRkBQBhK1lflUqGX8DQhJMd2DhQXwPvjU3ehR8Z9H3Lfk95u+5SLyvUPA==
X-Received: by 2002:a2e:80c9:: with SMTP id r9mr6874490ljg.95.1598462320588;
        Wed, 26 Aug 2020 10:18:40 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id u10sm628153lju.113.2020.08.26.10.18.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 10:18:39 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id w14so3268812ljj.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:18:39 -0700 (PDT)
X-Received: by 2002:a2e:2e04:: with SMTP id u4mr7260728lju.102.1598462319103;
 Wed, 26 Aug 2020 10:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200826134315.GA3882506@kroah.com>
In-Reply-To: <20200826134315.GA3882506@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Aug 2020 10:18:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiMMTpFxd9q7roL+L6dZb3JoQYCF0uP4+7RNHFHbfC29Q@mail.gmail.com>
Message-ID: <CAHk-=wiMMTpFxd9q7roL+L6dZb3JoQYCF0uP4+7RNHFHbfC29Q@mail.gmail.com>
Subject: Re: [GIT PULL] USB fixes for 5.9-rc3
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 6:43 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> USB fixes for 5.9-rc3

I'm dropping this, since it seems to break things more than it fixes.

I see that the breakage is already figured out, but I'll just wait for
the next fixes pull with the fix for the problem.

                Linus
