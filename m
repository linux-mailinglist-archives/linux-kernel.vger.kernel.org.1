Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D37A1AB5BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 04:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbgDPCB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 22:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729464AbgDPCBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 22:01:45 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF44C061A0C;
        Wed, 15 Apr 2020 19:01:41 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u10so4341882lfo.8;
        Wed, 15 Apr 2020 19:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FOqIc/TOVs6L09OcBTbR6ZTsfXk3SzvVBeRG5EOHvT8=;
        b=BJ08i6nxi096nOw2iLrhhmUn/XkX8+p282HCVpqdDuxmxEjiHVA4m9L9WqBsrU01su
         vQQqKaHdJjqBuOIR2+xwzc55iZ/eednW8iOFat7f2jdSwoqxMyj2TokuTUqUhGWoxR2c
         DbpimohrbpNeXHhtp+4FIn1DZrKHWxXCWM/JAXvr0FEiyHMpFLHkd+8j/kCT+V/DCsfF
         a4AUXxSfrg39quw4seJy69WkbMXPgHCI73bI/OmMFzTZsv3Uyj80ryX0t4XNBWfRJEC2
         Exp5GAzsVi5f3M/CFmhvJyidpMqD3uXPvUR5XUGn0okZ9edvD7MvDnsryEnUitwylpB8
         zm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FOqIc/TOVs6L09OcBTbR6ZTsfXk3SzvVBeRG5EOHvT8=;
        b=cPmJWYPKujNDJH7ufgvnNLYEH6h4fCd8eB0z+ClAu/QRRce4MRZ6CodsLQ7SnUMSRu
         nnkaAwjwPZ7ScEX0QeLWVyIZNERiJsE8pyGkcbVb8zTudC7C84YzeKQshh6JxpUffJ3z
         etxmlC5yeqzwlm3KSSGddkPUb3luyQhgq5RToPj+o1YSMDUi4XKPSOCqxB3ydGu8byO3
         GMAd2ebkkclRbTyHqqTPtru/9W8qvuX0T44In9Gb6e7K9ecrpq89k4YtreR/yeKh4dMR
         4uk8DOrX/pKtaUY0CXlAlYmkzM1Tsvauca7AgYs+rH4jhD571mV+RS4uxkj5v1qcaZCF
         qP/A==
X-Gm-Message-State: AGi0PuZYUviyYTDJnEyKLPS8Ax9uunBoDG1PMiC2zySQkQjHG6pAUUVa
        RsPrncdw0FCiS66tBiE3w3dXJykgwHreGv4R02Y=
X-Google-Smtp-Source: APiQypL1MKE1uoflFbDDZHj6SDB3nJCYOPEtW1SaLCCzW9NjU3rmqFbT4wb9Vx75XqGVUC4u6fBYWnbtBrUV6ATL8h4=
X-Received: by 2002:a05:6512:259:: with SMTP id b25mr4594523lfo.16.1587002500226;
 Wed, 15 Apr 2020 19:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <1586521984-5890-1-git-send-email-orson.unisoc@gmail.com>
 <CA+H2tpH4+cLN0z7v50UdKCXOqZDt2rSYF5Lvm9-WBYJ3YWtJVg@mail.gmail.com> <c50deb5a-e3c1-a3c7-1467-fb78b13ceea8@akamai.com>
In-Reply-To: <c50deb5a-e3c1-a3c7-1467-fb78b13ceea8@akamai.com>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Thu, 16 Apr 2020 10:01:28 +0800
Message-ID: <CA+H2tpELUK_ZFjDz79ydp3d4uG+5c_SsG5100NeC4WAj_vZPHQ@mail.gmail.com>
Subject: Re: [PATCH] dynamic_debug: Add an option to enable dynamic debug for
 modules only
To:     Jason Baron <jbaron@akamai.com>
Cc:     Orson Zhai <orson.unisoc@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>,
        Orson Zhai <orson.zhai@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 2:48 AM Jason Baron <jbaron@akamai.com> wrote:
>
>
>
> On 4/15/20 12:31 PM, Orson Zhai wrote:
> > Hi Jason,
> >
> > On Fri, Apr 10, 2020 at 8:33 PM Orson Zhai <orson.unisoc@gmail.com> wrote:
> >>
> >> From: Orson Zhai <orson.zhai@unisoc.com>
> >>
> >> Instead of enabling dynamic debug globally with CONFIG_DYNAMIC_DEBUG,
> >> CONFIG_DYNAMIC_DEBUG_CORE will only enable core function of dynamic
> >> debug. With the DEBUG_MODULE defined for any modules, dynamic debug
> >> will be tied to them.
> >>
> >> This is useful for people who only want to enable dynamic debug for
> >> kernel modules without worrying about kernel image size and memory
> >> consumption is increasing too much.
> >>
> >
> > Do you have any comments for this patch?
> >
>
> So I like that you added the 'DEBUG_MODULE', but I'm wondering if the
> naming is too generic? Maybe DYNAMIC_DEBUG_MODULE?

OK, I think it is more precise than before.

>
> There may also be other places where you want to have the per-module
> dependency, for example netdev_dbg()? But perhaps further expansion
> could wait for a user...

Yes.
I find more in netdevice.h, net.h and ib_verbs.h.
I will change all of them in V2.
But acpi.h seems different which I'd like to ignore.

Best,
Orson

>
> Thanks,
>
> -Jason
>
>
> > Best Regards,
> > Orson
> >
> >> Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> >> ---
> >>  Documentation/admin-guide/dynamic-debug-howto.rst |  7 +++++--
> >>  include/linux/dev_printk.h                        |  6 ++++--
> >>  include/linux/dynamic_debug.h                     |  2 +-
> >>  include/linux/printk.h                            | 14 +++++++++-----
> >>  lib/Kconfig.debug                                 | 12 ++++++++++++
> >>  lib/Makefile                                      |  2 +-
> >>  lib/dynamic_debug.c                               |  9 +++++++--
> >>  7 files changed, 39 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> >> index 0dc2eb8..fa5b8d4 100644
> >> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> >> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> >> @@ -13,8 +13,11 @@ kernel code to obtain additional kernel information.  Currently, if
> >>  ``print_hex_dump_debug()``/``print_hex_dump_bytes()`` calls can be dynamically
> >>  enabled per-callsite.
> >>
> >> -If ``CONFIG_DYNAMIC_DEBUG`` is not set, ``print_hex_dump_debug()`` is just
> >> -shortcut for ``print_hex_dump(KERN_DEBUG)``.
> >> +If ``CONFIG_DYNAMIC_DEBUG_CORE`` is set, only the modules with ``DEBUG_MODULE``
> >> +defined will be tied into dynamic debug.
> >> +
> >> +If ``CONFIG_DYNAMIC_DEBUG`` or ``CONFIG_DYNAMIC_DEBUG_CORE`` is not set,
> >> +``print_hex_dump_debug()`` is just shortcut for ``print_hex_dump(KERN_DEBUG)``.
> >>
> >>  For ``print_hex_dump_debug()``/``print_hex_dump_bytes()``, format string is
> >>  its ``prefix_str`` argument, if it is constant string; or ``hexdump``
> >> diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
> >> index 5aad06b..2fb0671 100644
> >> --- a/include/linux/dev_printk.h
> >> +++ b/include/linux/dev_printk.h
> >> @@ -109,7 +109,8 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
> >>  #define dev_info(dev, fmt, ...)                                                \
> >>         _dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
> >>
> >> -#if defined(CONFIG_DYNAMIC_DEBUG)
> >> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> >> +       (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
> >>  #define dev_dbg(dev, fmt, ...)                                         \
> >>         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> >>  #elif defined(DEBUG)
> >> @@ -181,7 +182,8 @@ do {                                                                        \
> >>         dev_level_ratelimited(dev_notice, dev, fmt, ##__VA_ARGS__)
> >>  #define dev_info_ratelimited(dev, fmt, ...)                            \
> >>         dev_level_ratelimited(dev_info, dev, fmt, ##__VA_ARGS__)
> >> -#if defined(CONFIG_DYNAMIC_DEBUG)
> >> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> >> +       (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
> >>  /* descriptor check is first to prevent flooding with "callbacks suppressed" */
> >>  #define dev_dbg_ratelimited(dev, fmt, ...)                             \
> >>  do {                                                                   \
> >> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> >> index 4cf02ec..abcd5fd 100644
> >> --- a/include/linux/dynamic_debug.h
> >> +++ b/include/linux/dynamic_debug.h
> >> @@ -48,7 +48,7 @@ struct _ddebug {
> >>
> >>
> >>
> >> -#if defined(CONFIG_DYNAMIC_DEBUG)
> >> +#if defined(CONFIG_DYNAMIC_DEBUG_CORE)
> >>  int ddebug_add_module(struct _ddebug *tab, unsigned int n,
> >>                                 const char *modname);
> >>  extern int ddebug_remove_module(const char *mod_name);
> >> diff --git a/include/linux/printk.h b/include/linux/printk.h
> >> index 1e6108b..77fab5b 100644
> >> --- a/include/linux/printk.h
> >> +++ b/include/linux/printk.h
> >> @@ -291,8 +291,9 @@ extern int kptr_restrict;
> >>  /*
> >>   * These can be used to print at the various log levels.
> >>   * All of these will print unconditionally, although note that pr_debug()
> >> - * and other debug macros are compiled out unless either DEBUG is defined
> >> - * or CONFIG_DYNAMIC_DEBUG is set.
> >> + * and other debug macros are compiled out unless either DEBUG is defined,
> >> + * CONFIG_DYNAMIC_DEBUG is set, or CONFIG_DYNAMIC_DEBUG_CORE is set when
> >> + * DEBUG_MODULE being defined for any modules.
> >>   */
> >>  #define pr_emerg(fmt, ...) \
> >>         printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
> >> @@ -327,7 +328,8 @@ extern int kptr_restrict;
> >>
> >>
> >>  /* If you are writing a driver, please use dev_dbg instead */
> >> -#if defined(CONFIG_DYNAMIC_DEBUG)
> >> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> >> +       (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
> >>  #include <linux/dynamic_debug.h>
> >>
> >>  /* dynamic_pr_debug() uses pr_fmt() internally so we don't need it here */
> >> @@ -453,7 +455,8 @@ extern int kptr_restrict;
> >>  #endif
> >>
> >>  /* If you are writing a driver, please use dev_dbg instead */
> >> -#if defined(CONFIG_DYNAMIC_DEBUG)
> >> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> >> +       (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
> >>  /* descriptor check is first to prevent flooding with "callbacks suppressed" */
> >>  #define pr_debug_ratelimited(fmt, ...)                                 \
> >>  do {                                                                   \
> >> @@ -500,7 +503,8 @@ static inline void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
> >>
> >>  #endif
> >>
> >> -#if defined(CONFIG_DYNAMIC_DEBUG)
> >> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> >> +       (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DEBUG_MODULE))
> >>  #define print_hex_dump_debug(prefix_str, prefix_type, rowsize, \
> >>                              groupsize, buf, len, ascii)        \
> >>         dynamic_hex_dump(prefix_str, prefix_type, rowsize,      \
> >> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> >> index 50c1f5f..25a1b9de 100644
> >> --- a/lib/Kconfig.debug
> >> +++ b/lib/Kconfig.debug
> >> @@ -99,6 +99,7 @@ config DYNAMIC_DEBUG
> >>         default n
> >>         depends on PRINTK
> >>         depends on (DEBUG_FS || PROC_FS)
> >> +       select DYNAMIC_DEBUG_CORE
> >>         help
> >>
> >>           Compiles debug level messages into the kernel, which would not
> >> @@ -165,6 +166,17 @@ config DYNAMIC_DEBUG
> >>           See Documentation/admin-guide/dynamic-debug-howto.rst for additional
> >>           information.
> >>
> >> +config DYNAMIC_DEBUG_CORE
> >> +       bool "Enable core function of dynamic debug support"
> >> +       depends on PRINTK
> >> +       depends on (DEBUG_FS || PROC_FS)
> >> +       help
> >> +         Enable core functional support of dynamic debug. It is useful
> >> +         when you want to tie dynamic debug to your kernel modules with
> >> +         DEBUG_MODULE defined for each of them, especially for the case
> >> +         of embedded system where the kernel image size is sensitive for
> >> +         people.
> >> +
> >>  config SYMBOLIC_ERRNAME
> >>         bool "Support symbolic error names in printf"
> >>         default y if PRINTK
> >> diff --git a/lib/Makefile b/lib/Makefile
> >> index 685aee6..8952772 100644
> >> --- a/lib/Makefile
> >> +++ b/lib/Makefile
> >> @@ -186,7 +186,7 @@ lib-$(CONFIG_GENERIC_BUG) += bug.o
> >>
> >>  obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
> >>
> >> -obj-$(CONFIG_DYNAMIC_DEBUG) += dynamic_debug.o
> >> +obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
> >>  obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
> >>
> >>  obj-$(CONFIG_NLATTR) += nlattr.o
> >> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> >> index 8f199f4..321437b 100644
> >> --- a/lib/dynamic_debug.c
> >> +++ b/lib/dynamic_debug.c
> >> @@ -1032,8 +1032,13 @@ static int __init dynamic_debug_init(void)
> >>         int verbose_bytes = 0;
> >>
> >>         if (&__start___verbose == &__stop___verbose) {
> >> -               pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
> >> -               return 1;
> >> +               if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
> >> +                       pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
> >> +                       return 1;
> >> +               }
> >> +               pr_info("Ignore empty _ddebug table in a CONFIG_DYNAMIC_DEBUG_CORE build\n");
> >> +               ddebug_init_success = 1;
> >> +               return 0;
> >>         }
> >>         iter = __start___verbose;
> >>         modname = iter->modname;
> >> --
> >> 2.7.4
> >>
