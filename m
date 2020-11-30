Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA742C91E6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgK3XCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgK3XCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:02:30 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF24BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:01:43 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id 11so12996233oty.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0yESZ9nKaytue6yJwKTB2Qr8baSyeMkEq6znRRPjhkA=;
        b=DekO9/naQQb895LZ4/BdYR1Ej0E+EL563P8tgr7ejyA5u+vtpYiLb8igDF7OZK5oTI
         ptXLdxvhVT15qH8c/xgFFgw2BACOxMT9qcqbSt/EEy5HjPpp8PfhFyrDC6x38jl6y/ja
         r447hjgnn/axo/ml/aLvX+osft5jkWIrbN8za/+CjVYR/non7gzVHimt2jFzil6kZsFm
         qlDkTGL5VEKdV/i9lsasKGSkZtfkotmggl7uuryXjuvT32YKVoGrLXFxVdrIihAD+tQF
         YWy6Wbng/rdVWQItzOaLSlxCbT2ptWC/7/nGbft96SZNqQm+afNhCtcVR+a49IPLQ6i7
         55Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0yESZ9nKaytue6yJwKTB2Qr8baSyeMkEq6znRRPjhkA=;
        b=s/7JFWVfZc/Zs6q56r5mUSdb6Un9s8r9PZSqz5vLdcXGGKz5rQvbBecF/RDRBRh/py
         pbe8Rf0VcOxu0utKE3H+KOI7J0/i3ixHQ5ubyKrDvVdLKj7xmocO9lHBpyYe2/8QDXwd
         VtKMtcCYzE6NryaYlJo6fQ3SCRXaCsniXJrM0FzuphaVOTzk/DKut19hCPCLcp3okXXd
         9FGbCVc9lqDE/ehWihQmfUZeL9BGqHkTvlqy/IPp3Wo+Oc6I16wWD8zGoGJZVkxGG8hG
         6/RrzrItdBkLZ8iNvDQXrBQBa/B4dRzQef1BZj/NSMMfKtnQGtNCmmAiavfUVJRfH+yW
         65+g==
X-Gm-Message-State: AOAM532DdyKfzhV38iT8KJ0zwwIZNVfinzOEhcWTJZsp5l2/X8awUWtl
        ptQlGiauL5mhuzLrpDHKCpfyHK4y/4cr5bBxSC8=
X-Google-Smtp-Source: ABdhPJxtfNATm0iM/HqcvRpbzptwDOMTGglNgMSGQZZx8DFRnwDXZKyR/+a1AgLCgHDSII3yRE68WZcFvr8hxtwmJiA=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr18854229otg.311.1606777301801;
 Mon, 30 Nov 2020 15:01:41 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-39-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-39-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:01:30 -0500
Message-ID: <CADnq5_Ns3Ls=94FyM2LAm__S5iDHvrLNZs6zcN1ySB54mbvc1Q@mail.gmail.com>
Subject: Re: [PATCH 38/40] drm/amd/pm/swsmu/smu11/navi10_ppt: Remove unused
 'struct i2c_algorithm navi10_i2c_algo'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 2:45 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 204 ------------------
>  1 file changed, 204 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index ef1a62e86a0ee..59bd7cd3ca8df 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2325,210 +2325,6 @@ static int navi10_run_umc_cdr_workaround(struct s=
mu_context *smu)
>         return 0;
>  }
>
> -static void navi10_fill_i2c_req(SwI2cRequest_t  *req, bool write,
> -                                 uint8_t address, uint32_t numbytes,
> -                                 uint8_t *data)
> -{
> -       int i;
> -
> -       req->I2CcontrollerPort =3D 0;
> -       req->I2CSpeed =3D 2;
> -       req->SlaveAddress =3D address;
> -       req->NumCmds =3D numbytes;
> -
> -       for (i =3D 0; i < numbytes; i++) {
> -               SwI2cCmd_t *cmd =3D  &req->SwI2cCmds[i];
> -
> -               /* First 2 bytes are always write for lower 2b EEPROM add=
ress */
> -               if (i < 2)
> -                       cmd->Cmd =3D 1;
> -               else
> -                       cmd->Cmd =3D write;
> -
> -
> -               /* Add RESTART for read  after address filled */
> -               cmd->CmdConfig |=3D (i =3D=3D 2 && !write) ? CMDCONFIG_RE=
START_MASK : 0;
> -
> -               /* Add STOP in the end */
> -               cmd->CmdConfig |=3D (i =3D=3D (numbytes - 1)) ? CMDCONFIG=
_STOP_MASK : 0;
> -
> -               /* Fill with data regardless if read or write to simplify=
 code */
> -               cmd->RegisterAddr =3D data[i];
> -       }
> -}
> -
> -static int navi10_i2c_read_data(struct i2c_adapter *control,
> -                                              uint8_t address,
> -                                              uint8_t *data,
> -                                              uint32_t numbytes)
> -{
> -       uint32_t  i, ret =3D 0;
> -       SwI2cRequest_t req;
> -       struct amdgpu_device *adev =3D to_amdgpu_device(control);
> -       struct smu_table_context *smu_table =3D &adev->smu.smu_table;
> -       struct smu_table *table =3D &smu_table->driver_table;
> -
> -       if (numbytes > MAX_SW_I2C_COMMANDS) {
> -               dev_err(adev->dev, "numbytes requested %d is over max all=
owed %d\n",
> -                       numbytes, MAX_SW_I2C_COMMANDS);
> -               return -EINVAL;
> -       }
> -
> -       memset(&req, 0, sizeof(req));
> -       navi10_fill_i2c_req(&req, false, address, numbytes, data);
> -
> -       mutex_lock(&adev->smu.mutex);
> -       /* Now read data starting with that address */
> -       ret =3D smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, =
0, &req,
> -                                  true);
> -       mutex_unlock(&adev->smu.mutex);
> -
> -       if (!ret) {
> -               SwI2cRequest_t *res =3D (SwI2cRequest_t *)table->cpu_addr=
;
> -
> -               /* Assume SMU  fills res.SwI2cCmds[i].Data with read byte=
s */
> -               for (i =3D 0; i < numbytes; i++)
> -                       data[i] =3D res->SwI2cCmds[i].Data;
> -
> -               dev_dbg(adev->dev, "navi10_i2c_read_data, address =3D %x,=
 bytes =3D %d, data :",
> -                                 (uint16_t)address, numbytes);
> -
> -               print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE,
> -                              8, 1, data, numbytes, false);
> -       } else
> -               dev_err(adev->dev, "navi10_i2c_read_data - error occurred=
 :%x", ret);
> -
> -       return ret;
> -}
> -
> -static int navi10_i2c_write_data(struct i2c_adapter *control,
> -                                               uint8_t address,
> -                                               uint8_t *data,
> -                                               uint32_t numbytes)
> -{
> -       uint32_t ret;
> -       SwI2cRequest_t req;
> -       struct amdgpu_device *adev =3D to_amdgpu_device(control);
> -
> -       if (numbytes > MAX_SW_I2C_COMMANDS) {
> -               dev_err(adev->dev, "numbytes requested %d is over max all=
owed %d\n",
> -                       numbytes, MAX_SW_I2C_COMMANDS);
> -               return -EINVAL;
> -       }
> -
> -       memset(&req, 0, sizeof(req));
> -       navi10_fill_i2c_req(&req, true, address, numbytes, data);
> -
> -       mutex_lock(&adev->smu.mutex);
> -       ret =3D smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, =
0, &req, true);
> -       mutex_unlock(&adev->smu.mutex);
> -
> -       if (!ret) {
> -               dev_dbg(adev->dev, "navi10_i2c_write(), address =3D %x, b=
ytes =3D %d , data: ",
> -                                        (uint16_t)address, numbytes);
> -
> -               print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE,
> -                              8, 1, data, numbytes, false);
> -               /*
> -                * According to EEPROM spec there is a MAX of 10 ms requi=
red for
> -                * EEPROM to flush internal RX buffer after STOP was issu=
ed at the
> -                * end of write transaction. During this time the EEPROM =
will not be
> -                * responsive to any more commands - so wait a bit more.
> -                */
> -               msleep(10);
> -
> -       } else
> -               dev_err(adev->dev, "navi10_i2c_write- error occurred :%x"=
, ret);
> -
> -       return ret;
> -}
> -
> -static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
> -                             struct i2c_msg *msgs, int num)
> -{
> -       uint32_t  i, j, ret, data_size, data_chunk_size, next_eeprom_addr=
 =3D 0;
> -       uint8_t *data_ptr, data_chunk[MAX_SW_I2C_COMMANDS] =3D { 0 };
> -
> -       for (i =3D 0; i < num; i++) {
> -               /*
> -                * SMU interface allows at most MAX_SW_I2C_COMMANDS bytes=
 of data at
> -                * once and hence the data needs to be spliced into chunk=
s and sent each
> -                * chunk separately
> -                */
> -               data_size =3D msgs[i].len - 2;
> -               data_chunk_size =3D MAX_SW_I2C_COMMANDS - 2;
> -               next_eeprom_addr =3D (msgs[i].buf[0] << 8 & 0xff00) | (ms=
gs[i].buf[1] & 0xff);
> -               data_ptr =3D msgs[i].buf + 2;
> -
> -               for (j =3D 0; j < data_size / data_chunk_size; j++) {
> -                       /* Insert the EEPROM dest addess, bits 0-15 */
> -                       data_chunk[0] =3D ((next_eeprom_addr >> 8) & 0xff=
);
> -                       data_chunk[1] =3D (next_eeprom_addr & 0xff);
> -
> -                       if (msgs[i].flags & I2C_M_RD) {
> -                               ret =3D navi10_i2c_read_data(i2c_adap,
> -                                                            (uint8_t)msg=
s[i].addr,
> -                                                            data_chunk, =
MAX_SW_I2C_COMMANDS);
> -
> -                               memcpy(data_ptr, data_chunk + 2, data_chu=
nk_size);
> -                       } else {
> -
> -                               memcpy(data_chunk + 2, data_ptr, data_chu=
nk_size);
> -
> -                               ret =3D navi10_i2c_write_data(i2c_adap,
> -                                                             (uint8_t)ms=
gs[i].addr,
> -                                                             data_chunk,=
 MAX_SW_I2C_COMMANDS);
> -                       }
> -
> -                       if (ret) {
> -                               num =3D -EIO;
> -                               goto fail;
> -                       }
> -
> -                       next_eeprom_addr +=3D data_chunk_size;
> -                       data_ptr +=3D data_chunk_size;
> -               }
> -
> -               if (data_size % data_chunk_size) {
> -                       data_chunk[0] =3D ((next_eeprom_addr >> 8) & 0xff=
);
> -                       data_chunk[1] =3D (next_eeprom_addr & 0xff);
> -
> -                       if (msgs[i].flags & I2C_M_RD) {
> -                               ret =3D navi10_i2c_read_data(i2c_adap,
> -                                                            (uint8_t)msg=
s[i].addr,
> -                                                            data_chunk, =
(data_size % data_chunk_size) + 2);
> -
> -                               memcpy(data_ptr, data_chunk + 2, data_siz=
e % data_chunk_size);
> -                       } else {
> -                               memcpy(data_chunk + 2, data_ptr, data_siz=
e % data_chunk_size);
> -
> -                               ret =3D navi10_i2c_write_data(i2c_adap,
> -                                                             (uint8_t)ms=
gs[i].addr,
> -                                                             data_chunk,=
 (data_size % data_chunk_size) + 2);
> -                       }
> -
> -                       if (ret) {
> -                               num =3D -EIO;
> -                               goto fail;
> -                       }
> -               }
> -       }
> -
> -fail:
> -       return num;
> -}
> -
> -static u32 navi10_i2c_func(struct i2c_adapter *adap)
> -{
> -       return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> -}
> -
> -
> -static const struct i2c_algorithm navi10_i2c_algo =3D {
> -       .master_xfer =3D navi10_i2c_xfer,
> -       .functionality =3D navi10_i2c_func,
> -};
> -
>  static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
>                                       void **table)
>  {
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
