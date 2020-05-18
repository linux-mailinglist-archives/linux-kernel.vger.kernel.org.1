Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8681D778F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 13:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgERLn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 07:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgERLny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:43:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CD5C061A0C;
        Mon, 18 May 2020 04:43:54 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y198so3244679pfb.4;
        Mon, 18 May 2020 04:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2fiYTMGkA72yxkM7OqMlh+jTtVoL+5gotBtf6Ab1Vg=;
        b=FupRAN/PobQTaQAv55Hsu61uSDhgZ3yYRyGz8MMb28tAecTlaodhHWlWTBtxSxZsLL
         hUHBpFsd2j51DYacP5abkLC8bE0rQqecQGxlgDDhXG70Kp4nA0D407rBYGJrrN6WC3JW
         S3xYBq32QeVdIUofnBLx7OzpiOmgjjWSYxZ4huxWNohOM/1bvv1kWksiXP4exgRlnwHA
         mxmA2IVSXkpjectaLC1fgYuhtSYOjE+JUBx+StzEfl0No5bJYMY32wDd2kwSb2UXMd6/
         ef+TC7BOv19rXQ9ppgji3DX6OQ8nXQy+7mCHuWpX8NWB4NpxsMpp24w4Bq/cKSlzs4Z+
         4htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2fiYTMGkA72yxkM7OqMlh+jTtVoL+5gotBtf6Ab1Vg=;
        b=FdpcROL4jStzdv7U4l0/LZC/DJlgRbjAxJ7orqeBQk/o8dLxREzBbF8l6E52tOIiN6
         eakPNNicBni4B1fux5CIF2Pf4TamU+Tb9I3GS4TkJSGkF/+1RlNeTfvgYq0IG1SNROGd
         6GbzKGbWPLWblO5CGg0v7HxCOriSW55PSCvhx1SXz253oV71WcbJ5a/FjpCW/drfbZZ8
         4gIk/nhDKw9A2SMn9ycbxAuD7nvgLEp3oreqISUolYM0KnkGGip8pT9jEm9SE346g9Pj
         eXkpH2j7L9jnmBr1lN0i44QutVnl1H3/DgW5TYEZr8bMzTKbptWx98wcC2SnLmP7vEYQ
         2cRw==
X-Gm-Message-State: AOAM532XhZMJqo/8ZkK7jJGElhV9lzIbBomJkDynpr6RhxB3NnkRfVJM
        SeeqtG7vu7vVgmIIY+PTgkUQnNB/Bl7lsl83pvmGEf2LZQU=
X-Google-Smtp-Source: ABdhPJyjDARrY4u/7pTXmySvEzdtyf7tJDRYLFc46T/zWf+w+QvLGa31DWfDx3lW7E/Y60GuBUgnGDnQNIZcaj+xHss=
X-Received: by 2002:a65:6251:: with SMTP id q17mr14337972pgv.4.1589802234387;
 Mon, 18 May 2020 04:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200515105537.4876-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <202005152142.AWvx4xc5%lkp@intel.com> <CAHp75Ven9q-6dDYtP_uXigeS_r2uvpUZVR5Mh0RdEd36MbTG+Q@mail.gmail.com>
 <CAK8P3a3RKJo-C5=19oAppx212s7T8NdnKJVmkj+h=34a8aKMNA@mail.gmail.com> <5180e734-ff56-db5a-ab49-8a55cfa2f2c0@linux.intel.com>
In-Reply-To: <5180e734-ff56-db5a-ab49-8a55cfa2f2c0@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 May 2020 14:43:42 +0300
Message-ID: <CAHp75Ve_XjvvGBEQyhy=qVVJMFS+18j3aKxNxSQpGK5qJmzfBg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mtd: rawnand: Add NAND controller support on Intel
 LGM SoC
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>, kbuild-all@lists.01.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        masonccyang@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 2:39 PM Ramuthevar, Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
> On 15/5/2020 10:30 pm, Arnd Bergmann wrote:
> > On Fri, May 15, 2020 at 4:25 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >> On Fri, May 15, 2020 at 4:48 PM kbuild test robot <lkp@intel.com> wrote:

> > iowrite_be32() is the correct way to store word into a big-endian mmio register,
> > if that is the intention here.
> Thank you for suggestions to use iowrite32be(), it suits exactly.

Can you before doing this comment what is the real intention here?

And note, if you are going to use iowrite*() / ioread*() in one place,
you will probably need to replace all of the read*() / write*() to
respective io* API.

-- 
With Best Regards,
Andy Shevchenko
