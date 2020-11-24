Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BE22C295F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbgKXOW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:22:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388858AbgKXOW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:22:58 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB0A1206FB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606227776;
        bh=gwenMUOmNagaP0XqHbf89PGPh3jSG2hwNgJOa/BbCQ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EAf6jGMy4CBEMU9eN7CfNopNd0hKIz3yZ0YUrLjNWWUtmFqsN0G7zrO2UIEMRq1b6
         ys9lhaIBaAnNptIvpt5pEZYyr05k/Lcd1F/Jj0yeqE/qEYgBukNP7TFUcKpYRWc/qW
         cNGNwRQZ1vgwKNTUd9vTXvW0d1JwDO3nzU8xTzzY=
Received: by mail-ot1-f50.google.com with SMTP id f12so8021611oto.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:22:56 -0800 (PST)
X-Gm-Message-State: AOAM533M6E5tCn/+GtKwN/dtk2hCn45izDtcXVvFFfWiKzMi4t1cmhSh
        GLEeRqdnFC4DiruZDGlKzjPko+M0SMR5+iqHre8=
X-Google-Smtp-Source: ABdhPJzZ1VfHk6RC6yuxrJKJcrkEyLIGQOV5ruxWpiVmuampsRp5CDDBSfh35GBzq3iZjOH4XKLhSXFvJE8McTfXya8=
X-Received: by 2002:a9d:be1:: with SMTP id 88mr3320516oth.210.1606227776073;
 Tue, 24 Nov 2020 06:22:56 -0800 (PST)
MIME-Version: 1.0
References: <20201119114029.183828-1-juant.aldea@gmail.com> <20201119122737.189675-1-juant.aldea@gmail.com>
In-Reply-To: <20201119122737.189675-1-juant.aldea@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 24 Nov 2020 15:22:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3S+nR0tupEvk7bd0SsMYAd90YtMnL9R3JzzzV-m0pNwA@mail.gmail.com>
Message-ID: <CAK8P3a3S+nR0tupEvk7bd0SsMYAd90YtMnL9R3JzzzV-m0pNwA@mail.gmail.com>
Subject: Re: [PATCH v2] staging: trivial: hikey9xx: fix be32<->u32 casting warnings
To:     Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>
Cc:     Jiri Kosina <trivial@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 1:31 PM Juan Antonio Aldea-Armenteros
<juant.aldea@gmail.com> wrote:
>
> This patch fixes the following warnings reported by sparse, by adding
> missing __force annotations.
>
> drivers/staging/hikey9xx/hisi-spmi-controller.c:164:24: warning: cast to restricted __be32
> drivers/staging/hikey9xx/hisi-spmi-controller.c:164:24: warning: cast to restricted __be32
> drivers/staging/hikey9xx/hisi-spmi-controller.c:164:24: warning: cast to restricted __be32
> drivers/staging/hikey9xx/hisi-spmi-controller.c:164:24: warning: cast to restricted __be32
> drivers/staging/hikey9xx/hisi-spmi-controller.c:164:24: warning: cast to restricted __be32
> drivers/staging/hikey9xx/hisi-spmi-controller.c:164:24: warning: cast to restricted __be32
>
> drivers/staging/hikey9xx/hisi-spmi-controller.c:239:25: warning: cast from restricted __be32
>
> Rationale for #164:
> data is declared as u32, and it is read and then converted by means of
> be32_to_cpu(). Said function expects a __be32 but data is u32, therefore
> there's a type missmatch here.
>
> Rationale for #239:
> Is the dual of #164. This time data going to be  written so it
> needs to be converted from cpu to __be32, but writel() expects u32 and the
> output of cpu_to_be32 returns a __be32.

Both of the casts look very suspicious, I'd leave these in unless
someone can confirm what the actual desired behavior is.

>                              SPMI_SLAVE_OFFSET * slave_id +
>                              SPMI_APB_SPMI_RDATA0_BASE_ADDR +
>                              i * SPMI_PER_DATAREG_BYTE);
> -               data = be32_to_cpu((__be32)data);
> +               data = be32_to_cpu((__be32 __force)data);
>                 if ((bc - i * SPMI_PER_DATAREG_BYTE) >> 2) {
>                         memcpy(buf, &data, sizeof(data));
>                         buf += sizeof(data);

The data comes from a readl(), which contains an endian conversion
on architectures that need it, such as when running the board
in big-endian arm64 mode. Having a second endian-conversion
on little-endian architectures means that the data is always swapped
when it gets written to the register.

In the original code before Mauro's commit 8788a30c12c7 ("staging:
spmi: hisi-spmi-controller: use le32 macros where needed"), the data
was byteswapped, and then written into the fifo register, which
produced no warning but would do a double-swap on a big-endian
kernel, and change the behavior from what it was before.

My guess is that Mauro inadvertently fixed this driver for big-endian
mode, without noticing that it was broken to start with, and that
he did not actually try it with CONFIG_CPU_BIG_ENDIAN.

I think the best way would be to go back to to using swab32p()
(not the open-coded version) and then use writesl() or
iowrite32_rep() with count=1 to write the byteswapped FIFO
register without swapping it again.

      Arnd
