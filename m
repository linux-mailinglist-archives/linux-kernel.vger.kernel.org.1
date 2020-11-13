Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D709E2B1C82
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgKMNvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgKMNvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:51:10 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C27CC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:51:10 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id f23so13560412ejk.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vsGn3bem5nMvAjLpbhwxfUdSF/h2bPF70W9wumlMdBw=;
        b=vTj9XGocJsDdmxBbt4qvs70XHcdNB4X0t9XGIS9bRj5oZgDO51fyrmXi2eSkzPyUT/
         yPXNJOHKchrYIh9qAUn4o4XvvgqC0GoNl7cOm1DJc6B6qZhE5wrTGHwjCQAseBp2QyHC
         xOHyRA5qmm/6z5keXX0/3qygnFDCJBZ95sOLbcXHzKchx2NQFVX0IjtjKXahZbGyedNl
         btE8eks/8p4GHVeGdXywzorxmEPS+t8V+KYsSWRZMw8g7uFOiQ4j9CxBBB4qyhRDYqT4
         Jd3WY995w2J6MoJbc1cCqtLEplzJ+x6s5hQaRE6WYlfpzfCxGZ19EtjV6ZJw1uqdp1qL
         D0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vsGn3bem5nMvAjLpbhwxfUdSF/h2bPF70W9wumlMdBw=;
        b=P37n225fSqvboSuc7RDb/1OHp/FkxtwIHA5vzf+SJ3LpbMQz2CklN5pvq3P+il0eYM
         oP9nHMIt8mGu7koeDfW5hpI2vFiqdTOk6bCJJWRHk9sOxgOqNAwzvE/Td/YaOLF83iBA
         vXLJ87VAenZkNBip7j5Yj37MUXWEXWu05cxMI4NBTgH1jJYS3wunBhZONGRMXfVxyPrj
         Z/gij/ZSboWlWIipgZFhcMHh3v7vZgMWvNI0Mhjweqjy3ClQsZq8TSOa7NVvJ5F3tUwE
         rTGTQOQMXH7ZBw3Hq2C2cmw3NW+bb3nAUO+DaXXjdibeKPqvnqhGD5SYCTw+xPGOJR8x
         S7Fw==
X-Gm-Message-State: AOAM531oH+wbiKkhoFLWOnf4mpjyN6RZjjihnxXPXl9xZWR9ANjLuo9u
        s72TBQsDHF0D9MvzLEnCAhZBE4LTrMJhf/UrBELcluR6rSs=
X-Google-Smtp-Source: ABdhPJzzVV+FAd8BWTU2Ot2l+Gih+TBQaZIdRURXY5UDRKWxoFyTNbwm0NZESZUUZppVU3psiS8BGqd/OnHtJIi4QCY=
X-Received: by 2002:a17:906:16d6:: with SMTP id t22mr2136557ejd.376.1605275468961;
 Fri, 13 Nov 2020 05:51:08 -0800 (PST)
MIME-Version: 1.0
References: <20201113122328.22942-1-jcmvbkbc@gmail.com> <87zh3ll6hw.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87zh3ll6hw.fsf@nanos.tec.linutronix.de>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 13 Nov 2020 05:50:57 -0800
Message-ID: <CAMo8BfKEr-89awEnV072uWR=4fniDRJ0drWmZrtnyvj-mANk0A@mail.gmail.com>
Subject: Re: [PATCH] highmem: fix highmem for xtensa
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Nov 13, 2020 at 5:40 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, Nov 13 2020 at 04:23, Max Filippov wrote:
> > Fixmap on xtensa grows upwards, i.e. bigger fixmap entry index
> > corresponds to a higher virtual address. This was lost in highmem
> > generalization resulting in the following runtime warnings:
>
> Sorry for not noticing.
>
> > Fix it by adding __ARCH_HAS_POSITIVE_FIXMAP macro and implementing
> > vaddr_in_fixmap and fixmap_pte primitives differently depending on
> > whether it is defined or not.
>
> What's wrong with just doing the obvious and making the fixmap defines
> the other way round?

It becomes really awkward when we get to support high memory with
aliasing data cache: we must think about the actual virtual addresses
assigned to pages and it feels much simpler when it's done this way.

-- 
Thanks.
-- Max
