Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74F3304575
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392466AbhAZRhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:37:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:42410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389606AbhAZHqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:46:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E370322D04
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611647123;
        bh=jhq9uwsKX2IsXJllw2EXbtk8GfeJ3kCXzMA1RQNaNRU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XA1r1xhu7WxUb4ik40Pc4JjC+lQfgLdbH5xEcf7isDsK0ldDwAcv3FkQ20CRqre30
         S9hJLeqO3ACr+0VvLdtWAkewreMrZzcKI4pNi09GukDOeC205dDQLRBbqQK2Yzkzva
         pfAzbftqE+zVqgKRGDcn8xV6IpNWgIyxUALpWP3oYckDHn4PZBLa5NZoeEZu2dqybO
         U6bKMgjTi80zHwD9T8bJW9T4Y4KrTD8WkJawCnbY/eGLQu3wA8kjiZmKhTxP+ij7qD
         lIhN4kyYivXl2JcbW+B8gVLPylsLloktaZIv9nNXx/Blu6NUcZQn2MNwvQ2DAWlSff
         KQnZAG5EFMdaA==
Received: by mail-oi1-f173.google.com with SMTP id m13so9654229oig.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 23:45:22 -0800 (PST)
X-Gm-Message-State: AOAM532SMmHHfqijWwnEW0HqxYW8bqn8h3O26R/09DLkdWl4qtJVJ0S7
        xOUiSTC+N4DN9pf4XMx2xwulk+xMm6eWRlXhXEI=
X-Google-Smtp-Source: ABdhPJyol2UGu37c/P3KJc5DUsRH8kkI4sOp/UiVLrx4W3k+9ZmraqxHJH+SKZIheFO/4gSUMveamqtled5onVFA+4A=
X-Received: by 2002:aca:be54:: with SMTP id o81mr2390645oif.67.1611647122191;
 Mon, 25 Jan 2021 23:45:22 -0800 (PST)
MIME-Version: 1.0
References: <20210108212600.36850-1-mgross@linux.intel.com>
 <20210108212600.36850-30-mgross@linux.intel.com> <fe1aad31-a536-4f0b-e817-b795890f4b45@infradead.org>
 <20210125233935.GA13745@linux.intel.com>
In-Reply-To: <20210125233935.GA13745@linux.intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 26 Jan 2021 08:45:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0V5wFYypYDXbVFQvzbjL5K0Gp0j+Zfg_7-5vML1B1-Cg@mail.gmail.com>
Message-ID: <CAK8P3a0V5wFYypYDXbVFQvzbjL5K0Gp0j+Zfg_7-5vML1B1-Cg@mail.gmail.com>
Subject: Re: [PATCH v2 29/34] Intel tsens i2c slave driver.
To:     mgross@linux.intel.com
Cc:     Randy Dunlap <rdunlap@infradead.org>, markgross@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "C, Udhayakumar" <udhayakumar.c@intel.com>, C@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 12:39 AM mark gross <mgross@linux.intel.com> wrote:
>
> On Mon, Jan 11, 2021 at 11:15:06PM -0800, Randy Dunlap wrote:
> > On 1/8/21 1:25 PM, mgross@linux.intel.com wrote:
> > > diff --git a/drivers/misc/intel_tsens/Kconfig b/drivers/misc/intel_tsens/Kconfig
> > > index 8b263fdd80c3..c2138339bd89 100644
> > > --- a/drivers/misc/intel_tsens/Kconfig
> > > +++ b/drivers/misc/intel_tsens/Kconfig
> > > @@ -14,6 +14,20 @@ config INTEL_TSENS_LOCAL_HOST
> > >       Say Y if using a processor that includes the Intel VPU such as
> > >       Keem Bay.  If unsure, say N.
> > >
> > > +config INTEL_TSENS_I2C_SLAVE
> > > +   bool "I2C slave driver for intel tsens"
> >
> > Why bool instead of tristate?
> Becuase the I2C driver depends on a file scoped global i2c_plat_data
> instanciated in the INTELL_TSENS_LOCAL_HOST DRIVER (intel_tsens_thermal.[ch])
>
> Udhaya, would you care to comment further?

> > > +   depends on INTEL_TSENS_LOCAL_HOST
> > > +   select I2C
> > > +   select I2C_SLAVE

Please make this 'depends on I2C=y && I2C_SLAVE' instead of 'select'
in this case. A random driver should never force-enable another subsystem.

      Arnd
