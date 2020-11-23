Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4A52C004B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 07:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgKWGto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 01:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgKWGtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 01:49:43 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE394C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 22:49:43 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id 18so8360076pli.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 22:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t0OSOVA2ccxVdMGeIbXNE1oQE+iexQ/rjX1iiAhqkU8=;
        b=fDhas+FkpVMXKzzgSBCuBl3ixyW6jrfpEb6KVSf+yaCdBUAEItQDkptCEhyp+/Zv40
         MH1yUO0s3MRgZuzRre67yZkTTis0fE7QORR5EjM4elt+5jNgb7cZimb+1Q7cUVxF9M2n
         qvQBurMiFRtrckGei9esGGgbdhpeRTc7quQHw2yzs9SwuaOPw/9N25dQd67G5t+IMQRI
         MrUeoO+CBTuguhFcG6N++PRj/MBeqkXBazdVGv87eBcVT93HQIIQvJrqLSa2zWI7+h/6
         YSCmDz+ci76rcENb0HwnXIwIl94GxyEViEsd1eB8Z6RfMGDjI9KxXkRY890FQMurXKqu
         DhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t0OSOVA2ccxVdMGeIbXNE1oQE+iexQ/rjX1iiAhqkU8=;
        b=kykz1gZesNKOtAVL3JlD4PF6btNv0k8VZDqx4Evb0ZtW30h0T9TM0Yl9jT3QMPM8NF
         GwP6GpeGsmxQKhQYDiqYrVxe4RBsBKM+nn30GQlNn/9Kkz4dFg8N+fT1/l5qhfIG54ML
         TvDSFpWfmp0uZAOeGEB0o90FLPs3ykRqFGZtYrhG2wv4vx27aZxIEiOCoceLKRm5ObU3
         3I/cCAmVv5QxRUKChVrmndruQrvdsZxHWVgjmthaPEU1WbuNBIgxbzoTTSYBJzRzNEu6
         8R48+lKEgGm6HYUNG8QSQdEdtZr8VuerxHydzQLN64kZr9WXBElqvDO/wADF3S+n1EiO
         tzPw==
X-Gm-Message-State: AOAM532wUcReRgMQEwDMUMwParP2fQpUcGs58GTra3enB4AGEJKk513j
        IpjFHbUSqf2HD3Pt83Lky7Qxtg==
X-Google-Smtp-Source: ABdhPJwHMm0frmcncx1oY5tQDMzhhHkbWm75tlupWyPZ4FrVZ9ku1r0+yn1i7xLSr5a/zksXRdPiXg==
X-Received: by 2002:a17:902:c3c9:b029:d6:7e88:cfa9 with SMTP id j9-20020a170902c3c9b02900d67e88cfa9mr21912941plj.64.1606114183339;
        Sun, 22 Nov 2020 22:49:43 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id q5sm8857393pff.36.2020.11.22.22.49.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Nov 2020 22:49:42 -0800 (PST)
Date:   Mon, 23 Nov 2020 12:19:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Morten Borup Petersen <morten_bp@live.dk>,
        Usama Arif <usama.arif@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 2/2] mailbox: arm_mhuv2: Add driver
Message-ID: <20201123064940.36efxogx3agpseyl@vireshk-i7>
References: <cover.1605607138.git.viresh.kumar@linaro.org>
 <180854d3b40b779ea989dfa18154431f70011c18.1605607138.git.viresh.kumar@linaro.org>
 <CABb+yY2mhUPbigeYo+ZirFP0z1n0wKPP46VOtsBmbZQmWB=jAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY2mhUPbigeYo+ZirFP0z1n0wKPP46VOtsBmbZQmWB=jAA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-20, 13:06, Jassi Brar wrote:
> On Tue, Nov 17, 2020 at 4:02 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > +
> > +/**
> > + * struct mhuv2 - MHUv2 mailbox controller data
> > + *
> > + * @mbox:      Mailbox controller belonging to the MHU frame.
> > + * @send/recv: Base address of the register mapping region.
> > + * @frame:     Frame type: RECEIVER_FRAME or SENDER_FRAME.
> > + * @irq:       Interrupt.
> > + * @windows:   Channel windows implemented by the platform.
> > + * @minor:     Minor version of the controller.
> > + * @length:    Length of the protocols array in bytes.
> > + * @protocols: Raw protocol information, derived from device tree.
> > + * @doorbell_pending_lock: spinlock required for correct operation of Tx
> > + *             interrupt for doorbells.
> > + */
> > +struct mhuv2 {
> > +       struct mbox_controller mbox;
> > +       union {
> > +               struct mhu2_send_frame_reg __iomem *send;
> > +               struct mhu2_recv_frame_reg __iomem *recv;
> > +       };
> > +       enum mhuv2_frame frame;
> > +       unsigned int irq;
> > +       unsigned int windows;
> > +       unsigned int minor;
> > +       unsigned int length;
> > +       u32 *protocols;
> > +
> > +       spinlock_t doorbell_pending_lock;
> >
> Can you please explain the need of this lock? Some usecase?
> It should be unnecessary if the controller natively supports doorbell mode.

Yes, the controller does have native doorbell support, it provides bit
wise access of the registers and interrupt gets generated for every
bit of the register.

This lock is needed only in the case where an interrupt is provided in
the tx case as well (since minor version 1). This is how hardware
works in this case:

- Sender (Linux) writes to a bit of 'stat_set' register to do a
  doorbell operation.

- The receiver receives an interrupt for it and sets the same bit in
  'stat_clear' register in order to clear the interrupt.

- With this the sender gets an interrupt and needs to check which bit
  of 'stat' register went from 1 to 0 to know which doorbell's
  operation got finished.  The sender clears the interrupt for the
  entire window by writing 1 to int_clr register of the corresponding
  window.

Now another doorbell transfer can start right after we read the 'stat'
register in the tx interrupt handler and we will see that a bit went
from 1 to 0 and think that the transfer has completed, while it may
not have as the bit may still be 1. And so we need to make sure to not
start a new transfer for the same window while interrupt handler is
processing the doorbell tx interrupt.

Another way of doing this lockless would be to not use the tx
interrupt and rather poll the bit, but that would be less efficient.

-- 
viresh
