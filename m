Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE37E1FABB2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 10:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgFPI4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 04:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbgFPI4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:56:37 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74C0D2078E;
        Tue, 16 Jun 2020 08:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592297796;
        bh=rBOwbfQlkVz6vWaKmoDPTN+u6O4afwBYiXoOfNZH7/U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jM0EWuAHFjhHe+qIlVfCbgnv9cNY6qqxj/IVagYZamKPTTXWRBMD/FJZMKk7BZHyh
         LEUVXeV/IdoKxX7jGT2fxRDt4e4V+4IL5PWnQUnO4VHw598/Swyr/hwCub7g9h0/LX
         d9GVykn/S5SJvXsdpP2DExvi10gD82QjnoOkJkCw=
Received: by mail-ot1-f52.google.com with SMTP id g5so15365462otg.6;
        Tue, 16 Jun 2020 01:56:36 -0700 (PDT)
X-Gm-Message-State: AOAM530VGQ05SV0UD3BrHUu7ygA/RxOHxmUad/XRlIqgsw5PuJKcEz9n
        AU6SX9VMadtsLxCPjNwl1k5vipG4QA97fWouZnI=
X-Google-Smtp-Source: ABdhPJz9Gf5nGN9qT4RqdPcpDEjN+4pCbfa7gIokGgUT/p6lD4wo3psp5pXhRxuxfb9MAN6dut206seqYtE9bnvf4JE=
X-Received: by 2002:a9d:476:: with SMTP id 109mr1699688otc.77.1592297795736;
 Tue, 16 Jun 2020 01:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200615234231.21059-1-xypron.glpk@gmx.de>
In-Reply-To: <20200615234231.21059-1-xypron.glpk@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 Jun 2020 10:56:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEqFZ-0WYbnJm-LSYADH_ATtqJ_9eJxm=Q7pxAr7w7g4g@mail.gmail.com>
Message-ID: <CAMj1kXEqFZ-0WYbnJm-LSYADH_ATtqJ_9eJxm=Q7pxAr7w7g4g@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: descriptions for stub helper functions
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 at 01:42, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Provide missing descriptions for EFI stub helper functions.
> Adjust formatting of existing descriptions to kernel style.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Queued as a fix, thanks.

> ---
>  .../firmware/efi/libstub/efi-stub-helper.c    | 78 ++++++++++++++++---
>  drivers/firmware/efi/libstub/efistub.h        | 10 ++-
>  2 files changed, 75 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index 89f075275300..d40fd68c6bb2 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -32,6 +32,10 @@ bool __pure __efi_soft_reserve_enabled(void)
>         return !efi_nosoftreserve;
>  }
>
> +/**
> + * efi_char16_puts() - Write a UCS-2 encoded string to the console
> + * @str:       UCS-2 encoded string
> + */
>  void efi_char16_puts(efi_char16_t *str)
>  {
>         efi_call_proto(efi_table_attr(efi_system_table, con_out),
> @@ -83,6 +87,10 @@ u32 utf8_to_utf32(const u8 **s8)
>         return c32;
>  }
>
> +/**
> + * efi_puts() - Write a UTF-8 encoded string to the console
> + * @str:       UTF-8 encoded string
> + */
>  void efi_puts(const char *str)
>  {
>         efi_char16_t buf[128];
> @@ -113,6 +121,16 @@ void efi_puts(const char *str)
>         }
>  }
>
> +/**
> + * efi_printk() - Print a kernel message
> + * @fmt:       format string
> + *
> + * The first letter of the format string is used to determine the logging level
> + * of the message. If the level is less then the current EFI logging level, the
> + * message is suppressed. The message will be truncated to 255 bytes.
> + *
> + * Return:     number of printed characters
> + */
>  int efi_printk(const char *fmt, ...)
>  {
>         char printf_buf[256];
> @@ -154,13 +172,18 @@ int efi_printk(const char *fmt, ...)
>         return printed;
>  }
>
> -/*
> - * Parse the ASCII string 'cmdline' for EFI options, denoted by the efi=
> +/**
> + * efi_parse_options() - Parse EFI command line options
> + * @cmdline:   kernel command line
> + *
> + * Parse the ASCII string @cmdline for EFI options, denoted by the efi=
>   * option, e.g. efi=nochunk.
>   *
>   * It should be noted that efi= is parsed in two very different
>   * environments, first in the early boot environment of the EFI boot
>   * stub, and subsequently during the kernel boot.
> + *
> + * Return:     status code
>   */
>  efi_status_t efi_parse_options(char const *cmdline)
>  {
> @@ -286,13 +309,21 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
>         return (char *)cmdline_addr;
>  }
>
> -/*
> +/**
> + * efi_exit_boot_services() - Exit boot services
> + * @handle:    handle of the exiting image
> + * @map:       pointer to receive the memory map
> + * @priv:      argument to be passed to @priv_func
> + * @priv_func: function to process the memory map before exiting boot services
> + *
>   * Handle calling ExitBootServices according to the requirements set out by the
>   * spec.  Obtains the current memory map, and returns that info after calling
>   * ExitBootServices.  The client must specify a function to perform any
>   * processing of the memory map data prior to ExitBootServices.  A client
>   * specific structure may be passed to the function via priv.  The client
>   * function may be called multiple times.
> + *
> + * Return:     status code
>   */
>  efi_status_t efi_exit_boot_services(void *handle,
>                                     struct efi_boot_memmap *map,
> @@ -361,6 +392,11 @@ efi_status_t efi_exit_boot_services(void *handle,
>         return status;
>  }
>
> +/**
> + * get_efi_config_table() - retrieve UEFI configuration table
> + * @guid:      GUID of the configuration table to be retrieved
> + * Return:     pointer to the configuration table or NULL
> + */
>  void *get_efi_config_table(efi_guid_t guid)
>  {
>         unsigned long tables = efi_table_attr(efi_system_table, tables);
> @@ -408,17 +444,18 @@ static const struct {
>  };
>
>  /**
> - * efi_load_initrd_dev_path - load the initrd from the Linux initrd device path
> + * efi_load_initrd_dev_path() - load the initrd from the Linux initrd device path
>   * @load_addr: pointer to store the address where the initrd was loaded
>   * @load_size: pointer to store the size of the loaded initrd
>   * @max:       upper limit for the initrd memory allocation
> - * @return:    %EFI_SUCCESS if the initrd was loaded successfully, in which
> - *             case @load_addr and @load_size are assigned accordingly
> - *             %EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd
> - *             device path
> - *             %EFI_INVALID_PARAMETER if load_addr == NULL or load_size == NULL
> - *             %EFI_OUT_OF_RESOURCES if memory allocation failed
> - *             %EFI_LOAD_ERROR in all other cases
> + *
> + * Return:
> + * * %EFI_SUCCESS if the initrd was loaded successfully, in which
> + *   case @load_addr and @load_size are assigned accordingly
> + * * %EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd device path
> + * * %EFI_INVALID_PARAMETER if load_addr == NULL or load_size == NULL
> + * * %EFI_OUT_OF_RESOURCES if memory allocation failed
> + * * %EFI_LOAD_ERROR in all other cases
>   */
>  static
>  efi_status_t efi_load_initrd_dev_path(unsigned long *load_addr,
> @@ -481,6 +518,16 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
>                                     load_addr, load_size);
>  }
>
> +/**
> + * efi_load_initrd() - Load initial RAM disk
> + * @image:     EFI loaded image protocol
> + * @load_addr: pointer to loaded initrd
> + * @load_size: size of loaded initrd
> + * @soft_limit:        preferred size of allocated memory for loading the initrd
> + * @hard_limit:        minimum size of allocated memory
> + *
> + * Return:     status code
> + */
>  efi_status_t efi_load_initrd(efi_loaded_image_t *image,
>                              unsigned long *load_addr,
>                              unsigned long *load_size,
> @@ -505,6 +552,15 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
>         return status;
>  }
>
> +/**
> + * efi_wait_for_key() - Wait for key stroke
> + * @usec:      number of microseconds to wait for key stroke
> + * @key:       key entered
> + *
> + * Wait for up to @usec microseconds for a key stroke.
> + *
> + * Return:     status code, EFI_SUCCESS if key received
> + */
>  efi_status_t efi_wait_for_key(unsigned long usec, efi_input_key_t *key)
>  {
>         efi_event_t events[2], timer;
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index bcd8c0a785f0..ac756f1fdb1a 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -157,8 +157,14 @@ typedef void (__efiapi *efi_event_notify_t)(efi_event_t, void *);
>  #define EFI_EVT_NOTIFY_WAIT    0x00000100U
>  #define EFI_EVT_NOTIFY_SIGNAL  0x00000200U
>
> -/*
> - * boottime->wait_for_event takes an array of events as input.
> +/**
> + * efi_set_event_at() - add event to events array
> + *
> + * @events:    array of UEFI events
> + * @ids:       index where to put the event in the array
> + * @event:     event to add to the aray
> + *
> + * boottime->wait_for_event() takes an array of events as input.
>   * Provide a helper to set it up correctly for mixed mode.
>   */
>  static inline
> --
> 2.27.0
>
