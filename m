Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAFB2A34BA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgKBT4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgKBTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:55:34 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04F4C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 11:55:33 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w14so15988999wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 11:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ml2WfVPXEDc7LiW8n/5KXckYK+7cKZbui1ygMjaQxiw=;
        b=mNkqfJMClWvWwnWz1R+IHAv8knV6k905gkhLebEIOkVq0DSG8EQuTyI2pcGRW2nn+O
         wbRY+KV/cetTpOgBqDrJShh7VpSdyd15rPYch6E+0w1RQzo3zB4MRLKZ9f4++onfis8o
         G7iD1FrfVX1fPvtH2/wDCRINwyzBDhMMvR7y9qj7qQL9SnG90OKnzAisCJTPamk4tODx
         X8QxGDc1VTdzwNZV9P/gx+Be0ozAd7WH6Bz/Ze0Fc+TpVNmYtVaAh1YPf1Y904XObApj
         l5+vR4saTutAzJWAacwY6wGUtdfS4TS8EEHd0FVkGWvpBXwuRy1aulFaGejjx2qyLTpE
         F2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ml2WfVPXEDc7LiW8n/5KXckYK+7cKZbui1ygMjaQxiw=;
        b=Zu+cBZidssKo5g+ew4vILCYKQQm0PMxldB7Wkxqa1W65rDDmmlKdlOouAboLbudw1+
         4DTZTPyxeFCM4mkGkdywhjFRdJsggpUkkthjzpFYCua/8ETh5kIy9D9ozq2VMklsj3UV
         ftSIX2CJh0Z5964SERfHl8Qyq0+jmXNzv3P8Wo5AvUZLsEZD3zvC3QpZkx44uxzxow6T
         7xS8Kk/2GIoNyR0jSA7/4W7gKF24jPOuJsUihKml+c7U+zzUAL7kzF7YsXO1H+B5p2Ng
         1c02FdHvHOFo4g3n7CbGmSKqauCmi/DB+id0SnuwI12UNkN6P3mMroGAdyU99seg0LxT
         pyMg==
X-Gm-Message-State: AOAM533Z4rTdLiNWw3pNwUUNjThegx5GXSirnMCU/BtprpJhz0h7guGX
        hrAwuccNfL8O7quQPrZe0AoEMsTjPQJekU43QCY=
X-Google-Smtp-Source: ABdhPJxY1o0bdf7RLcX429R2eGrohnnhSqvUvtPBIhs+Zvk9otZBhxGzBplqA5a8Zr0J6YxGAjUo5kdEWa0DaR5K0aM=
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr22015785wrn.362.1604346932596;
 Mon, 02 Nov 2020 11:55:32 -0800 (PST)
MIME-Version: 1.0
References: <6ad41a97d7805124d2e31c70d96c846cf0d21524.1604345594.git.mh12gx2825@gmail.com>
 <59ffb58ca0d30ababc611ebc414e816902cc1b77.1604345594.git.mh12gx2825@gmail.com>
In-Reply-To: <59ffb58ca0d30ababc611ebc414e816902cc1b77.1604345594.git.mh12gx2825@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 2 Nov 2020 14:55:21 -0500
Message-ID: <CADnq5_Nc_wPfB6Jwzdmc00g_QKLLqf71vu6YO-3oqY8piFMoPw@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/amdgpu: use "*" adjacent to data name
To:     Deepak R Varma <mh12gx2825@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Melissa Wen <melissa.srw@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied the series.  Thanks!

Alex

On Mon, Nov 2, 2020 at 2:41 PM Deepak R Varma <mh12gx2825@gmail.com> wrote:
>
> When declaring pointer data, the "*" symbol should be used adjacent to
> the data name as per the coding standards. This resolves following
> issues reported by checkpatch script:
>         ERROR: "foo *   bar" should be "foo *bar"
>         ERROR: "foo * bar" should be "foo *bar"
>         ERROR: "foo*            bar" should be "foo *bar"
>         ERROR: "(foo*)" should be "(foo *)"
>
> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/atom.c         | 16 ++++++++--------
>  drivers/gpu/drm/amd/amdgpu/atombios_i2c.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/mes_v10_1.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c    |  2 +-
>  5 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
> index 46c00ee580b1..515890f4f5a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -67,8 +67,8 @@ typedef struct {
>  } atom_exec_context;
>
>  int amdgpu_atom_debug;
> -static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index, uint32_t * params);
> -int amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint32_t * params);
> +static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index, uint32_t *params);
> +int amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint32_t *params);
>
>  static uint32_t atom_arg_mask[8] =
>         { 0xFFFFFFFF, 0xFFFF, 0xFFFF00, 0xFFFF0000, 0xFF, 0xFF00, 0xFF0000,
> @@ -1201,7 +1201,7 @@ static struct {
>         atom_op_div32, ATOM_ARG_WS},
>  };
>
> -static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index, uint32_t * params)
> +static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index, uint32_t *params)
>  {
>         int base = CU16(ctx->cmd_table + 4 + 2 * index);
>         int len, ws, ps, ptr;
> @@ -1262,7 +1262,7 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
>         return ret;
>  }
>
> -int amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint32_t * params)
> +int amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint32_t *params)
>  {
>         int r;
>
> @@ -1388,8 +1388,8 @@ void amdgpu_atom_destroy(struct atom_context *ctx)
>  }
>
>  bool amdgpu_atom_parse_data_header(struct atom_context *ctx, int index,
> -                           uint16_t * size, uint8_t * frev, uint8_t * crev,
> -                           uint16_t * data_start)
> +                           uint16_t *size, uint8_t *frev, uint8_t *crev,
> +                           uint16_t *data_start)
>  {
>         int offset = index * 2 + 4;
>         int idx = CU16(ctx->data_table + offset);
> @@ -1408,8 +1408,8 @@ bool amdgpu_atom_parse_data_header(struct atom_context *ctx, int index,
>         return true;
>  }
>
> -bool amdgpu_atom_parse_cmd_header(struct atom_context *ctx, int index, uint8_t * frev,
> -                          uint8_t * crev)
> +bool amdgpu_atom_parse_cmd_header(struct atom_context *ctx, int index, uint8_t *frev,
> +                          uint8_t *crev)
>  {
>         int offset = index * 2 + 4;
>         int idx = CU16(ctx->cmd_table + offset);
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c b/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
> index 09a538465ffd..af0335535f82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
> @@ -159,7 +159,7 @@ u32 amdgpu_atombios_i2c_func(struct i2c_adapter *adap)
>         return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>  }
>
> -void amdgpu_atombios_i2c_channel_trans(struct amdgpu_device* adev, u8 slave_addr, u8 line_number, u8 offset, u8 data)
> +void amdgpu_atombios_i2c_channel_trans(struct amdgpu_device *adev, u8 slave_addr, u8 line_number, u8 offset, u8 data)
>  {
>         PROCESS_I2C_CHANNEL_TRANSACTION_PS_ALLOCATION args;
>         int index = GetIndexIntoMasterTable(COMMAND, ProcessI2cChannelTransaction);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 48f98c750956..e96ab5325af5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5167,7 +5167,7 @@ static void gfx_v9_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
>
>         if (ring->use_doorbell) {
>                 /* XXX check if swapping is necessary on BE */
> -               atomic64_set((atomic64_t*)&adev->wb.wb[ring->wptr_offs], ring->wptr);
> +               atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], ring->wptr);
>                 WDOORBELL64(ring->doorbell_index, ring->wptr);
>         } else {
>                 WREG32_SOC15(GC, 0, mmCP_RB0_WPTR, lower_32_bits(ring->wptr));
> @@ -5353,7 +5353,7 @@ static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>
>         /* XXX check if swapping is necessary on BE */
>         if (ring->use_doorbell) {
> -               atomic64_set((atomic64_t*)&adev->wb.wb[ring->wptr_offs], ring->wptr);
> +               atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs], ring->wptr);
>                 WDOORBELL64(ring->doorbell_index, ring->wptr);
>         } else{
>                 BUG(); /* only DOORBELL method supported on gfx9 now */
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> index 1c22d8393b21..985e454463e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> @@ -46,7 +46,7 @@ static void mes_v10_1_ring_set_wptr(struct amdgpu_ring *ring)
>         struct amdgpu_device *adev = ring->adev;
>
>         if (ring->use_doorbell) {
> -               atomic64_set((atomic64_t*)&adev->wb.wb[ring->wptr_offs],
> +               atomic64_set((atomic64_t *)&adev->wb.wb[ring->wptr_offs],
>                              ring->wptr);
>                 WDOORBELL64(ring->doorbell_index, ring->wptr);
>         } else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index 6c5d9612abcb..d521ca0f3afa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -615,7 +615,7 @@ static int psp_v11_0_memory_training_send_msg(struct psp_context *psp, int msg)
>  static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
>  {
>         struct psp_memory_training_context *ctx = &psp->mem_train_ctx;
> -       uint32_t *pcache = (uint32_t*)ctx->sys_cache;
> +       uint32_t *pcache = (uint32_t *)ctx->sys_cache;
>         struct amdgpu_device *adev = psp->adev;
>         uint32_t p2c_header[4];
>         uint32_t sz;
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
