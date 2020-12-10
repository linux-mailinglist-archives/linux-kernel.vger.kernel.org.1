Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DE02D5849
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 11:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgLJKdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 05:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgLJKdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 05:33:52 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FA5C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:33:12 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id p12so2101016qvj.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6nfEy7jb4JxUEN3UyBm4VG+qNR9wioZAF6quKu0rvhQ=;
        b=UivoiDMfsRAwmZ/ZLGjUImJpkcyCQo02ymzAKS7rp6+ceFp9V1DnsjBzxirP4Rzt/4
         9Im9/toCJyxJbeG8opl2ngddMKgyKT2+mtJrcAhNkmvalLFxOcT/uivTCNjhnid7buqU
         QsRW138BI3fo1Ts6x9aGLtV7zE/rhkvEj3emo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6nfEy7jb4JxUEN3UyBm4VG+qNR9wioZAF6quKu0rvhQ=;
        b=gUVRwJymytg3jTwXZWeZdlvN3ckgW27IsHZrJ67gJR5cEHGzD3rju3/2++v+ul26OT
         b7M+inzZdgC61usJ0Rq8bCxoN6ORkVBNlFvgc+t+pKJaaUQHPWChHT7GVj0r2SOVk0Td
         HAMCtrrC8K9hw/VUydQU1HDb9DW8HbfbQreLBq4G5Gu1dFneh6IwNMzjYtdWpGF3e3YG
         st6aqE7B78uKPRDm3qQE58Od+I8dLygsDWAckxk9gm343ZViildxxyExBHCKA94uRz9g
         UrOBaMm1SrY+hl0oXT22oQ93Y+RchClAA7m1ZXvqJ01o0PuRR+c+GScfdc/VwAJAndme
         SshQ==
X-Gm-Message-State: AOAM531zbTVtWOy0wBTl7wEA8buxRyYguRBcvwk/h7NfF3HKhgi8luvO
        lUWZLOQXo2TbwVifGNuNj1SMud8WYwq8lYOkhqpXhQ==
X-Google-Smtp-Source: ABdhPJzZGRjhEeNNEDGAWAw+JmsON7yXLlAyf0iR1s+9MtHGwvfratcRgIz5ZM01Ii2KY29VX/Ss2pqrNPcIr18iTC0=
X-Received: by 2002:a05:6214:140d:: with SMTP id n13mr4614903qvx.45.1607596391428;
 Thu, 10 Dec 2020 02:33:11 -0800 (PST)
MIME-Version: 1.0
References: <20201201134330.3037007-1-daniel@0x0f.com> <20201201134330.3037007-2-daniel@0x0f.com>
 <20201209163536.GB566058@robh.at.kernel.org>
In-Reply-To: <20201209163536.GB566058@robh.at.kernel.org>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 10 Dec 2020 19:33:00 +0900
Message-ID: <CAFr9PXmuCJJ0LXTcH56Dv_ddePaqLtVFVgeJdv7hVN7yRRyj-Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] dt-bindings: mstar: Add binding details for mstar,smpctrl
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>, SoC Team <soc@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        olof@lixom.net, Arnd Bergmann <arnd@arndb.de>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, 10 Dec 2020 at 01:35, Rob Herring <robh@kernel.org> wrote:
> On Tue, Dec 01, 2020 at 10:43:21PM +0900, Daniel Palmer wrote:
> > This adds a YAML description of the smpctrl node needed by the
> > platform code for the MStar/SigmaStar Armv7 SoCs to boot secondary cpus.
>
> You need an 'enable-method' string defined too.

The machine has smp ops set so I didn't think this was needed?
I was going to convert it to using enable-method in the cpu node but
the same code is used to enable the secondary cpu in all of the chips
with a second cpu so I didn't think I was really needed.

Thanks,

Daniel
