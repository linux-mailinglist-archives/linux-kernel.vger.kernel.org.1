Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DAF2BB4D6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 20:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgKTTHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 14:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgKTTHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:07:03 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53BBC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:07:03 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id j19so8084766pgg.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=11Eta9PcDmID7GuvdD9NV69zOyzPlPo2uoTpizVJNq0=;
        b=CyTX47cyF+niHWQLzKah4aKrFGiMHUofouO8PaXWLsVatTXdc//xaUQuAdf034iOVf
         fF2WijA7zShrNEI22N83dmZ9j1ZbHPrcObJTfpjqDJ6+1kzdXO1Wci3PV3k3LOMxmPB7
         VhoP6DN+cB5DWRLpSjKgKZ5MfpLVswJBeriuPMmHCZnx6rODzQcpjJU0lGqottSrf8Lp
         lvXl/sfFr0gRTbqjfgD0yjsR2Oac5qVhLM07xjV0Hjfu/kRANaHpqUfzilmRzKk53PAW
         o0VSpiGgfGAmApq9CF6bE0YGPmJkLMcQQiWpFNz33F3l8bSNxBgHCWlQxpFsE0mVWh+n
         77Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=11Eta9PcDmID7GuvdD9NV69zOyzPlPo2uoTpizVJNq0=;
        b=kt7pxIWD6fpw+MBJz8Aa7Y/lUF6p7DS/nLgJ1EL7Yof8X+hD0Suir9F0mlw8Mi4oG1
         6BXoexEYjjdm/nkO3YxzFll05tCc3DbSRrd0E5BALvwhtdTrN7jdpoxuqj0iXMJv7PF4
         INiinhBEr/wHcTTustl9G9YZ7cZTCFAMhWHZLVifVKp6ocdXedTr7PEsSobRZnXATFXT
         KNAIEWgtyhDYmL3n3VRwOAdTqrB2x+a93LxK7N5zjhSe7634ghftlnP1aEEJpVxQD4Fj
         ejf48612K3eGlh4YjV1e2WJA08a6qt2+LeZgknhDyZtbpEr28zraEMO46Qe1McOnlKvS
         SlJg==
X-Gm-Message-State: AOAM532XiiVdR4iQRutPxdJE8yHsw9NGrz3PWbx6IjyVRjuSzE4sU4Sh
        sF1ziFKBWuzDyt7HUyHIjJ/AmR9B9gwhsBNsipI=
X-Google-Smtp-Source: ABdhPJzh4GW9wtmo3ns+czrLoOwLYLdwZH0GMjU9lqh+oqm9TvF0Dfa414qSBF+MxSEbx5enfG/R40JmHdZUKCyepmE=
X-Received: by 2002:a17:90b:4382:: with SMTP id in2mr12187395pjb.180.1605899223406;
 Fri, 20 Nov 2020 11:07:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605607138.git.viresh.kumar@linaro.org> <180854d3b40b779ea989dfa18154431f70011c18.1605607138.git.viresh.kumar@linaro.org>
In-Reply-To: <180854d3b40b779ea989dfa18154431f70011c18.1605607138.git.viresh.kumar@linaro.org>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 20 Nov 2020 13:06:52 -0600
Message-ID: <CABb+yY2mhUPbigeYo+ZirFP0z1n0wKPP46VOtsBmbZQmWB=jAA@mail.gmail.com>
Subject: Re: [PATCH V5 2/2] mailbox: arm_mhuv2: Add driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Morten Borup Petersen <morten_bp@live.dk>,
        Usama Arif <usama.arif@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 4:02 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> +
> +/**
> + * struct mhuv2 - MHUv2 mailbox controller data
> + *
> + * @mbox:      Mailbox controller belonging to the MHU frame.
> + * @send/recv: Base address of the register mapping region.
> + * @frame:     Frame type: RECEIVER_FRAME or SENDER_FRAME.
> + * @irq:       Interrupt.
> + * @windows:   Channel windows implemented by the platform.
> + * @minor:     Minor version of the controller.
> + * @length:    Length of the protocols array in bytes.
> + * @protocols: Raw protocol information, derived from device tree.
> + * @doorbell_pending_lock: spinlock required for correct operation of Tx
> + *             interrupt for doorbells.
> + */
> +struct mhuv2 {
> +       struct mbox_controller mbox;
> +       union {
> +               struct mhu2_send_frame_reg __iomem *send;
> +               struct mhu2_recv_frame_reg __iomem *recv;
> +       };
> +       enum mhuv2_frame frame;
> +       unsigned int irq;
> +       unsigned int windows;
> +       unsigned int minor;
> +       unsigned int length;
> +       u32 *protocols;
> +
> +       spinlock_t doorbell_pending_lock;
>
Can you please explain the need of this lock? Some usecase?
It should be unnecessary if the controller natively supports doorbell mode.

thanks.
