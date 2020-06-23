Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911B9204EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 11:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbgFWJ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 05:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731947AbgFWJ73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:59:29 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314F1C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:59:28 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d7so11312540lfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+qNNJvPj82XIpOTVemM+3ukaRdqJiO16sjw+SINvto=;
        b=Y7xQpZIELfj/IZLk6F58JA8yjaXRzK+OnoXwh0e5UY0T8XwF0JRi2sp3Vb55Apjdzl
         BSi6UOkqflqZjIYef8cv7UxPHjAA7/9KsKdrR33U13EOqr6h7bg/dR9Jdk+NWpJ8ymvX
         UC91iFxPSo9US6Co4+ZY1nXR8EW3/62ZjhAtls1kbdPJyw6mkaQEom/7iVp7+YWPwabA
         +5bSyhJu5g7bdXz/lfL0GoXdTwOvdUjPK3YJ1ao7j0OWPdryjFjv4/6hhg/rbmEMXVpa
         t/vrA87fmv4g3N0UtF4wcqAXTkgVFEhyCwu6KMP+BLan277W8KfEFtrcCa/f7aV/o/6h
         ql1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+qNNJvPj82XIpOTVemM+3ukaRdqJiO16sjw+SINvto=;
        b=gbC2ycc0yto8JmSe88N60zxVCKa8JCPLSNH79P/IhgaW20ZecwCg2XhnmFv8aiPTJq
         k6W4X8J5b2+c0qg0glP+xtH4DetNEvco+E+UIBwXLvVHHZVeDG93sFTCtXN7cPL/LeHh
         tibdlY36stqHmr00tRXDS+QZ6fyThuGeMRWP6qou0FieCwDr77zKp5yeBurF0yMhcn9G
         05YV9MovygHDI9U3vWWXdV+6sWfpwhZBBaqip7xnegG8fWKiOvo+PVdAHQnfQrE9BD6g
         ndS38DC7LrX9JMORELSQgM07Wryq9VEYlyOXmVtuPzEQWg/4Fatkx7GwmcBQ+bA9IEYq
         Ro2A==
X-Gm-Message-State: AOAM5323kKZyMsqQrjqRc+Pq9H5p4YMq6bo6KT1UZZr7S8PvNj1bi0f4
        IQUzblg73aOJoyz7Yx7aQqJNWiW4H9kMNsuyXzNNJQ==
X-Google-Smtp-Source: ABdhPJxkpAaMxPSdM3YL9bHG+P55yNE/K8vEWIahviaLzu2MN/Htj2Uu74ty5Acituc9zXDbDVkVHS+V8RASHfrlfXQ=
X-Received: by 2002:ac2:47ed:: with SMTP id b13mr4365995lfp.21.1592906366549;
 Tue, 23 Jun 2020 02:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
 <1592835984-28613-5-git-send-email-sumit.garg@linaro.org> <20200622163621.s2322lmlv674bsds@holly.lan>
In-Reply-To: <20200622163621.s2322lmlv674bsds@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 23 Jun 2020 15:29:15 +0530
Message-ID: <CAFA6WYNc7hdagBknFGjSF3rXnKGXL4FY+PutkA8iensv9dJHEg@mail.gmail.com>
Subject: Re: [PATCH 4/7] serial: kgdb_nmi: Add support for interrupt based fallback
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020 at 22:06, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Jun 22, 2020 at 07:56:21PM +0530, Sumit Garg wrote:
> > From: Daniel Thompson <daniel.thompson@linaro.org>
> >
> > Add a generic NMI fallback to support kgdb NMI console feature which can
> > be overridden by arch specific implementation.
>
> arch_kgdb_ops.enable_nmi should probably be killed off. Given we now
> have request_nmi() I'm dubious there are any good reasons to use this
> API.
>

Sounds reasonable. Along with this, kgdb_nmi_poll_knock() seems to be
unused and can be removed as well.

-Sumit

>
> Daniel.
>
>
> > This common fallback mechanism utilizes kgdb IO based interrupt in order
> > to support entry into kgdb if a user types in kgdb_nmi_magic sequence. So
> > during NMI console init, NMI handler is installed corresponding to kgdb
> > IO based NMI which is invoked when a character is pending and that can be
> > cleared by calling @read_char until it returns NO_POLL_CHAR.
> >
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/tty/serial/kgdb_nmi.c | 47 ++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 40 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
> > index b32c6b1..2580f39 100644
> > --- a/drivers/tty/serial/kgdb_nmi.c
> > +++ b/drivers/tty/serial/kgdb_nmi.c
> > @@ -42,9 +42,46 @@ MODULE_PARM_DESC(magic, "magic sequence to enter NMI debugger (default $3#33)");
> >  static atomic_t kgdb_nmi_num_readers = ATOMIC_INIT(0);
> >  static struct console *orig_dbg_cons;
> >
> > +static int kgdb_nmi_poll_one_knock(void);
> > +
> > +static irqreturn_t kgdb_handle_nmi(int irq, void *dev_id)
> > +{
> > +     int ret;
> > +
> > +     if (kgdb_nmi_knock < 0) {
> > +             kgdb_breakpoint();
> > +             return IRQ_HANDLED;
> > +     }
> > +
> > +     ret = kgdb_nmi_poll_one_knock();
> > +     if (ret == NO_POLL_CHAR)
> > +             return IRQ_NONE;
> > +
> > +     while (ret != 1) {
> > +             ret = kgdb_nmi_poll_one_knock();
> > +             if (ret == NO_POLL_CHAR)
> > +                     return IRQ_HANDLED;
> > +     }
> > +
> > +     kgdb_breakpoint();
> > +     return IRQ_HANDLED;
> > +}
> > +
> >  static int kgdb_nmi_console_setup(struct console *co, char *options)
> >  {
> > -     arch_kgdb_ops.enable_nmi(1);
> > +     int res;
> > +
> > +     if (arch_kgdb_ops.enable_nmi) {
> > +             arch_kgdb_ops.enable_nmi(1);
> > +     } else if (dbg_io_ops->request_nmi) {
> > +             res = dbg_io_ops->request_nmi(kgdb_handle_nmi, co);
> > +             if (res) {
> > +                     pr_err("ttyNMI0: Cannot request nmi/irq\n");
> > +                     return res;
> > +             }
> > +     } else {
> > +             return -ENODEV;
> > +     }
> >
> >       /* The NMI console uses the dbg_io_ops to issue console messages. To
> >        * avoid duplicate messages during kdb sessions we must inform kdb's
> > @@ -328,9 +365,6 @@ int kgdb_register_nmi_console(void)
> >  {
> >       int ret;
> >
> > -     if (!arch_kgdb_ops.enable_nmi)
> > -             return 0;
> > -
> >       kgdb_nmi_tty_driver = alloc_tty_driver(1);
> >       if (!kgdb_nmi_tty_driver) {
> >               pr_err("%s: cannot allocate tty\n", __func__);
> > @@ -380,9 +414,8 @@ int kgdb_unregister_nmi_console(void)
> >  {
> >       int ret;
> >
> > -     if (!arch_kgdb_ops.enable_nmi)
> > -             return 0;
> > -     arch_kgdb_ops.enable_nmi(0);
> > +     if (arch_kgdb_ops.enable_nmi)
> > +             arch_kgdb_ops.enable_nmi(0);
> >
> >       ret = unregister_console(&kgdb_nmi_console);
> >       if (ret)
> > --
> > 2.7.4
> >
