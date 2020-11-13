Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E342B25AB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgKMUkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMUkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:40:07 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D11C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:40:07 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id s9so12348782ljo.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j+UYuHX/xlcs/QoTm1INkKZ2RVPr1mCH7O5gRwKYkGM=;
        b=GDeUlsMaueN1d0gaJX9GJGm+VpDHNNBQoQn0bGnbn4rfwBaTWY3MwNP6hTQiHZ0jM/
         /w6iDL9GLdPeaUWfFMsQol69iw6pDKAx44A7BBnIELXWPlkdYAehUT/eGoDoTDdxV45Z
         ExCzCkgJOifCofvhTLbG/JBG/q/s21rSQQaxrX0enyPh8QaHydpqT/dXNFNJyitRJT0b
         GsdYaHuhswp+nSbCH3FoTcqFkf2iyP1h7pvtHnP2hmOVdTe1zePKhBOBdRrtLwd7IXBc
         TFfvMM+Er7d3OctnsRb1m8GQ4mop6RuwUi829i7aDvUlo/RrJFboDZJ3eLhLiQ3CuOUM
         Se7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j+UYuHX/xlcs/QoTm1INkKZ2RVPr1mCH7O5gRwKYkGM=;
        b=IXSs5xFqBmEe81ld1SsssiFX3siyFA8/vrJxainBEf03w746zeu8kMsOvhQXtunGBp
         TiDz4zbnTi6qUtPXuPCUDibXgtadFt98+oTNSxWD/Bsyy647MG46yi4enFluNG0TbCM+
         DRA9XKzzwMFFj+N495l9xHkf+/Wnwigwi5Aom+hDJFXg2lbxrZs3PsSERXJJw9DWLK1z
         W+C7s9IL+7cLIFYhikHl02oRlgF7ay+rssZXz7kPxJqX7SxH6nvlCqOYTAXa9QmbpA81
         2vhNbDnYrk/L2bqhqG3g+KqNpZ27ezqemOEDe+0khk/37osbDs4RiexV7gMTpTfXy+dr
         xaDQ==
X-Gm-Message-State: AOAM530/wuTg2X4OUiw9GdpFYiOfQg8oqcTShNA+rhYLlWvuxb1ISuaW
        YqOLEe/WXfwuev9lXWjx7uCy3V8c+AFwuFtPWiBgDoJ0jUJaYw==
X-Google-Smtp-Source: ABdhPJyVmGpwL0R7Q+hfxZtdTfM0gTeENn+wFUWe2MhKEwGSwxXPKFxBn5IrPbwdWYQYfkBuaNQ0zVKkTUqYfqtbf7o=
X-Received: by 2002:a2e:b0f6:: with SMTP id h22mr494815ljl.212.1605300005211;
 Fri, 13 Nov 2020 12:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20201112234907.3761694-1-rkir@google.com> <X645op2c70msQ+o3@kroah.com>
In-Reply-To: <X645op2c70msQ+o3@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Fri, 13 Nov 2020 12:39:54 -0800
Message-ID: <CAOGAQerDMua6cPxomAPdEHvCQYt66E=CL888WxeiqfKX4DPyOQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: staging: retire drivers/staging/goldfish
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Lingfeng Yang <lfy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, thank you for looking into this.

On Thu, Nov 12, 2020 at 11:44 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 12, 2020 at 03:49:07PM -0800, rkir@google.com wrote:
> > From: Roman Kiryanov <rkir@google.com>
> >
> > Android Studio Emulator (goldfish) migrated
> > to Intel HDA.
>
> When was that?

At least one year, our 4.14 kernel does not include this option into
the defconfig, 4.4 includes it, but probably we don't need it.

> What about the other goldfish drivers?

There are only four goldfish divers we use in R: goldfish_pipe,
goldfish_battery, goldfish_sync and
goldfish_address_space. The goldfish_battery one is fully upstreamed
but I need to cleanup
Kconfig's (this is why I sent this patch). The goldfish_pipe one has
off-tree changes.
The goldfish_sync and goldfish_address_space are not in the kernel tree at all.

The rest can be retired - I will send patches.

The goldfish_pipe driver will be replaced by virtio-vsock and
virtio-console eventually.
We considered retiring goldfish_battery by switching to ACPI_BATTERY but ACPI
is not available (at least in GKI) on arm64.

Regards,
Roman.
