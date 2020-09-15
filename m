Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6380E26AD45
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgIOTNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgIOTBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:01:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9E4C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:01:07 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t10so4484138wrv.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5YqpllGkEhbUqBHfOeKyCpHAJAP7nCJ7uA9Og5Y3N0=;
        b=DX/XslHWstHmoXV3z9+jZRklMKGmuWTt+LE6drX1s90S+KWYF/13VSXkZNSimQ8TE5
         xQS+tt7uTf/hTFoov2EVRwbRg8jKEYSQyif3HlrLkX6tjSsxjACHd3wpM2Ft69eq8MZh
         1+p/Nu9y1PdtxlE/Qkv/XxtG3KuWSMgP5G4X/G6DKfh66A5cgPVu4yLQFM3gPRrPAHw/
         Q2VqDA7A/BIWNjwNYdcOpSdL53Dce8BugmUqCZ3+ftmqAW6qKhUKiPlHANbKrmm7LNTK
         IJwo9CSCL7ytmtMCDYFBP9oTJxLRKvivGu1yCoSfoAQ80pA8TppvxeMX13fhR3947IaP
         253w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5YqpllGkEhbUqBHfOeKyCpHAJAP7nCJ7uA9Og5Y3N0=;
        b=sN8ynMpQOaPc1klGe8loou2VBGS+Vf+XRaVOGLYbdEBX85YCKG6R4B+MxAUBgGhJJb
         LgJLiIQd1sIh2kdY8gn2657kr1vd2se0OjYojv8q122oqNaWlcy/Aspqamvv6r9QBiAh
         gUURkfhKn6+5JfOg8tdshCO6a7BsapdyDgwRyRR5vg4j8LJZicTcpt54lcP+Ty/CJGec
         dZclwq2/0O1AAUClSUm4hRqJv6R2UeM6EQYYYrs6mRZWOFAl1G2VljRYcwiK3wd6RJSQ
         jSt+VTDiIO4s6/bHconBOaRSbH8xh8ZIXYwY3NyZc7hPhuuqDujETOnImdzrMFHaUacI
         XqgA==
X-Gm-Message-State: AOAM532y4fZTto16DfS+WoCPtaOLBYesCj0GEjdbhDWF5sTHwQzlhqia
        /uCX9HxpJQhiG62WBBWwNE9GywKxsG6hqmAkHzY=
X-Google-Smtp-Source: ABdhPJx1DHgoxeZrju3jbJYcv3wbxCLaXhWMCkEHgn3amTjhKjouKilvEJkDrqVN75M9YRXOhqxLaVDJ8DQjJppUCG4=
X-Received: by 2002:adf:dd82:: with SMTP id x2mr24242119wrl.419.1600196465753;
 Tue, 15 Sep 2020 12:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <a31672e7-9047-e4ef-93d8-d0c9afd47964@infradead.org>
In-Reply-To: <a31672e7-9047-e4ef-93d8-d0c9afd47964@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 15 Sep 2020 15:00:54 -0400
Message-ID: <CADnq5_NS2UB5VNKe2j6s4X3v2OQ7ow=se2xtFp0UD=7gJ4wMTA@mail.gmail.com>
Subject: Re: [PATCH] drm: amd/display: fix spelling of "function"
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Sep 9, 2020 at 3:05 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix spellos of "function" in drivers/gpu/drm/amd/display/.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.h   |    2 +-
>  drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.h |    2 +-
>  drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.h   |    2 +-
>  drivers/gpu/drm/amd/display/dc/gpio/dce120/hw_factory_dce120.c      |    2 +-
>  drivers/gpu/drm/amd/display/dc/gpio/dcn10/hw_factory_dcn10.c        |    2 +-
>  drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c        |    2 +-
>  drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c        |    2 +-
>  drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c        |    2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
>
> --- linux-next-20200908.orig/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.h
> +++ linux-next-20200908/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.h
> @@ -33,7 +33,7 @@ struct display_mode_lib;
>
>  // Function: dml_rq_dlg_get_rq_reg
>  //  Main entry point for test to get the register values out of this DML class.
> -//  This function calls <get_rq_param> and <extract_rq_regs> fucntions to calculate
> +//  This function calls <get_rq_param> and <extract_rq_regs> functions to calculate
>  //  and then populate the rq_regs struct
>  // Input:
>  //  pipe_src_param - pipe source configuration (e.g. vp, pitch, etc.)
> --- linux-next-20200908.orig/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.h
> +++ linux-next-20200908/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.h
> @@ -33,7 +33,7 @@ struct display_mode_lib;
>
>  // Function: dml_rq_dlg_get_rq_reg
>  //  Main entry point for test to get the register values out of this DML class.
> -//  This function calls <get_rq_param> and <extract_rq_regs> fucntions to calculate
> +//  This function calls <get_rq_param> and <extract_rq_regs> functions to calculate
>  //  and then populate the rq_regs struct
>  // Input:
>  //  pipe_src_param - pipe source configuration (e.g. vp, pitch, etc.)
> --- linux-next-20200908.orig/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.h
> +++ linux-next-20200908/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.h
> @@ -32,7 +32,7 @@ struct display_mode_lib;
>
>  // Function: dml_rq_dlg_get_rq_reg
>  //  Main entry point for test to get the register values out of this DML class.
> -//  This function calls <get_rq_param> and <extract_rq_regs> fucntions to calculate
> +//  This function calls <get_rq_param> and <extract_rq_regs> functions to calculate
>  //  and then populate the rq_regs struct
>  // Input:
>  //  pipe_param - pipe source configuration (e.g. vp, pitch, scaling, dest, etc.)
> --- linux-next-20200908.orig/drivers/gpu/drm/amd/display/dc/gpio/dce120/hw_factory_dce120.c
> +++ linux-next-20200908/drivers/gpu/drm/amd/display/dc/gpio/dce120/hw_factory_dce120.c
> @@ -162,7 +162,7 @@ static void define_hpd_registers(struct
>  }
>
>
> -/* fucntion table */
> +/* function table */
>  static const struct hw_factory_funcs funcs = {
>         .init_ddc_data = dal_hw_ddc_init,
>         .init_generic = NULL,
> --- linux-next-20200908.orig/drivers/gpu/drm/amd/display/dc/gpio/dcn10/hw_factory_dcn10.c
> +++ linux-next-20200908/drivers/gpu/drm/amd/display/dc/gpio/dcn10/hw_factory_dcn10.c
> @@ -194,7 +194,7 @@ static void define_hpd_registers(struct
>  }
>
>
> -/* fucntion table */
> +/* function table */
>  static const struct hw_factory_funcs funcs = {
>         .init_ddc_data = dal_hw_ddc_init,
>         .init_generic = dal_hw_generic_init,
> --- linux-next-20200908.orig/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c
> +++ linux-next-20200908/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c
> @@ -221,7 +221,7 @@ static void define_generic_registers(str
>         generic->base.regs = &generic_regs[en].gpio;
>  }
>
> -/* fucntion table */
> +/* function table */
>  static const struct hw_factory_funcs funcs = {
>         .init_ddc_data = dal_hw_ddc_init,
>         .init_generic = dal_hw_generic_init,
> --- linux-next-20200908.orig/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c
> +++ linux-next-20200908/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c
> @@ -202,7 +202,7 @@ static void define_hpd_registers(struct
>  }
>
>
> -/* fucntion table */
> +/* function table */
>  static const struct hw_factory_funcs funcs = {
>         .init_ddc_data = dal_hw_ddc_init,
>         .init_generic = dal_hw_generic_init,
> --- linux-next-20200908.orig/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
> +++ linux-next-20200908/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
> @@ -218,7 +218,7 @@ static void define_hpd_registers(struct
>  }
>
>
> -/* fucntion table */
> +/* function table */
>  static const struct hw_factory_funcs funcs = {
>         .init_ddc_data = dal_hw_ddc_init,
>         .init_generic = dal_hw_generic_init,
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
