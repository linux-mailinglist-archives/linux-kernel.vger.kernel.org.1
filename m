Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA1D2E974F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbhADOcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhADOcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:32:00 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AF0C061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 06:31:19 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id l11so64815727lfg.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 06:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IR1VvMQVXulY7X8akWcW+oqvfmM4zhhR97+Zp8aioFY=;
        b=eufqnLs2z/BQYLh46GNs8McsAJk5HT0ZMS3p2hrfqwiTeZZ3lavxWchIYfwQsRtG2W
         zXII0oJAUqiki1xNyQnzbiyW8ww8VvvWo/zywg0P1gq+ustAe9qIplSHJIaxRwDBaEJK
         GG5uK08PvIe+EPh0UueOPNViz6WdQdzq7cjnUzrq/m5av0MaEE2HYfwXjDnOJFgAcn/i
         sMj/SZah7QT4LNgKu3yJvHXXaC0ATUW3KSkelL66AgBKbhkr3lHACsBNsIw1rtsEA481
         jzx4ylPz1shZ9QqwAjNh5CZTYBU+5yFPXlQJ/b2CGu42eSFgclbBRC8nUIHPHuMfrjfV
         hzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IR1VvMQVXulY7X8akWcW+oqvfmM4zhhR97+Zp8aioFY=;
        b=KLJuZwpnYXmjn3kxZCc3TxOVTV7F4hMt76CrAY1nNKsWgTbJqH1ZGwz/B0838kkUpk
         fJcU6ntsMMrknjz9NVh/p4KvFBBqKsZ68FuFyFTg2kqAe7cIVspiZJ4P8yESBjs0f3KT
         6UZ7WwlT0wM137sCY7j2QH7L/PxywYFwFZRWNfaKfDg59WK7tXmAHqfd3ZX4BWihhMTW
         XjP0tY1du+omuSZxsDGAMe9UPzZ06q1OFkDRPkJn8WtfxI216kLYBdb+2z1Nm0m+4Egz
         TmfegOmlY/EEbQSBwy4iL8F00582ypRCUOBlvECFIIT/nIATPZnMh/o/BiRfgnisb5Ao
         FPEw==
X-Gm-Message-State: AOAM530m9QrFoTs5D/+eL3iS/XTZnu5OX8ddK6PIkfQa14C6hYWOfliv
        7o3vwGoY6wSb+LWnZinV2KSbbsCPByGgK5Z3kBlRoA==
X-Google-Smtp-Source: ABdhPJzaB6PWbOcTECg7R/YOflEqN1JdBUJvlXBMvsyUZ80Txi5rKRW5E1cp3lxTTGfxWLs8QPY+zi2TQ4ond5CrNOk=
X-Received: by 2002:a05:6512:3238:: with SMTP id f24mr31491797lfe.29.1609770678082;
 Mon, 04 Jan 2021 06:31:18 -0800 (PST)
MIME-Version: 1.0
References: <20201211084801.2425-1-zhengyongjun3@huawei.com>
In-Reply-To: <20201211084801.2425-1-zhengyongjun3@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Jan 2021 15:31:07 +0100
Message-ID: <CACRpkdaQ0kOWdtuKT2r0Am_-b8esA0nXPX2oa=wW762beggBCA@mail.gmail.com>
Subject: Re: [PATCH -next] mediatek/pinctrl-moore: convert comma to semicolon
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 9:47 AM Zheng Yongjun <zhengyongjun3@huawei.com> wrote:

> Replace a comma between expression statements by a semicolon.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Patch applied.

Yours,
Linus Walleij
