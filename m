Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B68929139F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 20:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438856AbgJQSWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 14:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438802AbgJQSWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 14:22:13 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09834C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 11:22:11 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i2so6260180ljg.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 11:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvfrPQKqDIUDWKr4bvF9zseBtYlgWNO2Udg9wjc+J0k=;
        b=X/atbA5ghjwxGuDohIm6DWhvDxovv16cntrov/K/0HDMXAWJ51CDi4OMyWKrhwWWGD
         tdZHgjyvMJCOGFTb1HHCFyFZiwsxQWWophssZz6Kve39ZrC95pZ+5G5k+b2QPLi4wTDz
         MykSD+HdImlY3WRMqruqM22jNtThdFkydsFLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvfrPQKqDIUDWKr4bvF9zseBtYlgWNO2Udg9wjc+J0k=;
        b=jBxEtA3CHUfLo1Ubs0brYkX86h2enW2X61Tb7ZgHpJht2RQMv5nqP0c+RXozmTg3rQ
         qUBD/DSln9xA6FeawKulp+fBJ69iqeg/0OaCaG8KUiVb8ua4uM4/eKEJZN79dIzkHrv0
         YPka/7aSaLU8oPvM3EVkD2CMhcTR915V+Mc15sw9fYjBtL/Dd178bDXLDtFvU8UltIH7
         g0+8tiFQk/uivxV0Q+i2oYcMITQaxzGNxk3gDX+OSM/z4HXLI55SPkDSXbLjAkNDgKcb
         iF5lwmEl0e32Qki5ob3Syi6yLM3R2pQp2Wc9BXi8q+3gs39yDARZ9KKCnzkOjk2QoJWk
         xpCw==
X-Gm-Message-State: AOAM530AxVAHM6a2JFbnU14b/csbnst35m1GxIiYc/t8PD8wXw4tlVgb
        Mm55ek1cG0qtakFtctnUDSo5b5XoIj3Ggg==
X-Google-Smtp-Source: ABdhPJxtQ2x5qzwpQYDnKpb2eZ6Q32cg6xCb6PKIQhp8VSPhmxZXmnG5dVgZ2KE7q9N7dH1P6tQADg==
X-Received: by 2002:a2e:b557:: with SMTP id a23mr3882166ljn.5.1602958929362;
        Sat, 17 Oct 2020 11:22:09 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id t28sm2148189lfd.100.2020.10.17.11.22.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2020 11:22:07 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id d24so7533558lfa.8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 11:22:07 -0700 (PDT)
X-Received: by 2002:a19:4186:: with SMTP id o128mr3076848lfa.148.1602958927056;
 Sat, 17 Oct 2020 11:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201016185155.GA233060@nvidia.com>
In-Reply-To: <20201016185155.GA233060@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 17 Oct 2020 11:21:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijsaWEh-Lz-2_6RwuaXyRCr4SREq7HshzNCKOxKvQhyA@mail.gmail.com>
Message-ID: <CAHk-=wijsaWEh-Lz-2_6RwuaXyRCr4SREq7HshzNCKOxKvQhyA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 11:52 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> You'll need to apply this fixup to the merge commit (it is in the tag
> for-linus-merged for reference):

Ugh. That's unbelievably and unnecessarily ugly.

There's no point in that unnecessary "ret" variable and the "goto out"
etc, when all the error cases can be handled much more directly.

So I resolved that merge issue somewhat differently. I can't test the
end result, but it looks TriviallyCorrect(tm).

Famous last words. Feel free to make fun of me and call me names if that breaks.

           Linus

I did it v
