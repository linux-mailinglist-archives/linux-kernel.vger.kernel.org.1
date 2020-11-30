Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746C82C92E6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgK3Xmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgK3Xmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:42:55 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB69C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:42:09 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id w9so3029301ooh.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p4zDsMJO9K8G0eBUgKjGu9q+RNEGAMSyLnupjsS6+is=;
        b=Zki1CT6WoAWnhkrufB7wdkhi2nCZEdv53UYODX7AJqX3+GtxpvsEcoGa/x6OcpebBc
         XlIlIdfW8/1JS+gZOybgsNu+8axO6D7ubpLoHbIyZ8nZrAnkG7aEEl6yjbxJjMrE9SJo
         CiuAtAXco3qVcvG0haSAq8u7tJxlBbaNBsi14kXkc3IE2/0oWdlOvJn8kEkcFezQ0SBj
         xMGGRYRPN6y4/g2euqDt/JtkSjro+Sx34D8voGm3qG1OXB/gv4GgVKLpSii9GgPG835Y
         eNBSWshJwi0mag4u9F8yx82aE4zSBbOYWZW0iKxY2isAApE24bflsqZhl2mtWCf1l7WJ
         OGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p4zDsMJO9K8G0eBUgKjGu9q+RNEGAMSyLnupjsS6+is=;
        b=ZdY888r3RE/TgQ1yUJNfaaRul+M54QoFhefyRJ/1IJMJnARz9D71RP6ZuT18BohP0B
         lm2Hp09VtuQwv5jE9hT9xZh6QIYrycrmQ65kfhc9U24aw78qrYhG5UtpaaI/SoaiTFPt
         9zcNQOg6kzoWBesWK8fz1yv1xhaVqctGnZqR9rjy+kKhIlQw9y+qbMlzPP1sYWrmYk24
         pMBnq2cjzaUNZ8xNarXjrc/60IigOjcd+Z+6J9z5IWSfyCaeXYoOe7yFEF168cb4S2xc
         l5PA6otFiw+ZfGr59tH597OmAQ+n2cfSMhEFwukGMzoRQVB8/bdJvlVYkopCmb3yiGD0
         WiKQ==
X-Gm-Message-State: AOAM530/FWShG+rmzfhUd85KdK7Xrb9G5Scg7sneiXBTbXEAVt9mlaG6
        fASmHUmay+pJY5RLmuXWG8mQxPQZVnPMSjmGPMs=
X-Google-Smtp-Source: ABdhPJyfTCW5gLs/vWzv+2J6f4ZpR157zgVmCjK6jEyt1CMXGPqEqAhIBY2e1XVyligTMgM5eZjahmmeQqcd/ZHu0nI=
X-Received: by 2002:a4a:d5d3:: with SMTP id a19mr9534oot.61.1606779728646;
 Mon, 30 Nov 2020 15:42:08 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-19-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-19-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:41:57 -0500
Message-ID: <CADnq5_PZvoUtdoLw168a7wn488NMAAx1LbwAaYCJFLh2ZCx-sQ@mail.gmail.com>
Subject: Re: [PATCH 18/40] drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0:
 Convert to proper kernel-doc format
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

On Thu, Nov 26, 2020 at 8:43 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:41: warning: Function parameter or member 'hwmgr' not described in 'set_hw=
_cap'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:41: warning: Function parameter or member 'setIt' not described in 'set_hw=
_cap'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:41: warning: Function parameter or member 'cap' not described in 'set_hw_c=
ap'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:56: warning: Function parameter or member 'hwmgr' not described in 'set_pl=
atform_caps'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:56: warning: Function parameter or member 'powerplay_caps' not described i=
n 'set_platform_caps'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:135: warning: Function parameter or member 'hwmgr' not described in 'get_p=
owerplay_table'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:202: warning: Function parameter or member 'hwmgr' not described in 'get_p=
latform_power_management_table'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:202: warning: Function parameter or member 'atom_ppm_table' not described =
in 'get_platform_power_management_table'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:246: warning: Function parameter or member 'hwmgr' not described in 'init_=
dpm_2_parameters'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:246: warning: Function parameter or member 'powerplay_table' not described=
 in 'init_dpm_2_parameters'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:791: warning: Function parameter or member 'hwmgr' not described in 'init_=
clock_voltage_dependency'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:791: warning: Function parameter or member 'powerplay_table' not described=
 in 'init_clock_voltage_dependency'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:911: warning: Function parameter or member 'hwmgr' not described in 'init_=
thermal_controller'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:911: warning: Function parameter or member 'powerplay_table' not described=
 in 'init_thermal_controller'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:1121: warning: Function parameter or member 'hwmgr' not described in 'chec=
k_powerplay_tables'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:1121: warning: Function parameter or member 'powerplay_table' not describe=
d in 'check_powerplay_tables'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:1263: warning: Function parameter or member 'hwmgr' not described in 'make=
_classification_flags'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:1263: warning: Function parameter or member 'classification' not described=
 in 'make_classification_flags'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:1263: warning: Function parameter or member 'classification2' not describe=
d in 'make_classification_flags'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:1370: warning: Function parameter or member 'hwmgr' not described in 'get_=
powerplay_table_entry_v1_0'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:1370: warning: Function parameter or member 'entry_index' not described in=
 'get_powerplay_table_entry_v1_0'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:1370: warning: Function parameter or member 'power_state' not described in=
 'get_powerplay_table_entry_v1_0'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:1370: warning: Function parameter or member 'call_back_func' not described=
 in 'get_powerplay_table_entry_v1_0'
>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  .../powerplay/hwmgr/process_pptables_v1_0.c   | 81 ++++++++++---------
>  1 file changed, 41 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0=
.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> index 801a565026703..741e03ad5311f 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> @@ -32,10 +32,10 @@
>  #include "pptable_v1_0.h"
>
>  /**
> - * Private Function used during initialization.
> - * @param hwmgr Pointer to the hardware manager.
> - * @param setIt A flag indication if the capability should be set (TRUE)=
 or reset (FALSE).
> - * @param cap Which capability to set/reset.
> + * set_hw_cap - Private Function used during initialization.
> + * @hwmgr: Pointer to the hardware manager.
> + * @setIt: A flag indication if the capability should be set (TRUE) or r=
eset (FALSE).
> + * @cap: Which capability to set/reset.
>   */
>  static void set_hw_cap(struct pp_hwmgr *hwmgr, bool setIt, enum phm_plat=
form_caps cap)
>  {
> @@ -47,10 +47,10 @@ static void set_hw_cap(struct pp_hwmgr *hwmgr, bool s=
etIt, enum phm_platform_cap
>
>
>  /**
> - * Private Function used during initialization.
> - * @param hwmgr Pointer to the hardware manager.
> - * @param powerplay_caps the bit array (from BIOS) of capability bits.
> - * @exception the current implementation always returns 1.
> + * set_platform_caps - Private Function used during initialization.
> + * @hwmgr: Pointer to the hardware manager.
> + * @powerplay_caps: the bit array (from BIOS) of capability bits.
> + * Exception:  the current implementation always returns 1.
>   */
>  static int set_platform_caps(struct pp_hwmgr *hwmgr, uint32_t powerplay_=
caps)
>  {
> @@ -128,7 +128,7 @@ static int set_platform_caps(struct pp_hwmgr *hwmgr, =
uint32_t powerplay_caps)
>         return 0;
>  }
>
> -/**
> +/*
>   * Private Function to get the PowerPlay Table Address.
>   */
>  static const void *get_powerplay_table(struct pp_hwmgr *hwmgr)
> @@ -191,10 +191,10 @@ static int get_vddc_lookup_table(
>  }
>
>  /**
> - * Private Function used during initialization.
> + * get_platform_power_management_table - Private Function used during in=
itialization.
>   * Initialize Platform Power Management Parameter table
> - * @param hwmgr Pointer to the hardware manager.
> - * @param atom_ppm_table Pointer to PPM table in VBIOS
> + * @hwmgr: Pointer to the hardware manager.
> + * @atom_ppm_table: Pointer to PPM table in VBIOS
>   */
>  static int get_platform_power_management_table(
>                 struct pp_hwmgr *hwmgr,
> @@ -234,10 +234,10 @@ static int get_platform_power_management_table(
>  }
>
>  /**
> - * Private Function used during initialization.
> + * init_dpm_2_parameters - Private Function used during initialization.
>   * Initialize TDP limits for DPM2
> - * @param hwmgr Pointer to the hardware manager.
> - * @param powerplay_table Pointer to the PowerPlay Table.
> + * @hwmgr: Pointer to the hardware manager.
> + * @powerplay_table: Pointer to the PowerPlay Table.
>   */
>  static int init_dpm_2_parameters(
>                 struct pp_hwmgr *hwmgr,
> @@ -779,10 +779,10 @@ static int get_gpio_table(struct pp_hwmgr *hwmgr,
>         return 0;
>  }
>  /**
> - * Private Function used during initialization.
> + * init_clock_voltage_dependency - Private Function used during initiali=
zation.
>   * Initialize clock voltage dependency
> - * @param hwmgr Pointer to the hardware manager.
> - * @param powerplay_table Pointer to the PowerPlay Table.
> + * @hwmgr: Pointer to the hardware manager.
> + * @powerplay_table: Pointer to the PowerPlay Table.
>   */
>  static int init_clock_voltage_dependency(
>                 struct pp_hwmgr *hwmgr,
> @@ -871,15 +871,16 @@ static int init_clock_voltage_dependency(
>         return result;
>  }
>
> -/** Retrieves the (signed) Overdrive limits from VBIOS.
> +/**
> + * init_over_drive_limits - Retrieves the (signed) Overdrive limits from=
 VBIOS.
>   * The max engine clock, memory clock and max temperature come from the =
firmware info table.
>   *
>   * The information is placed into the platform descriptor.
>   *
> - * @param hwmgr source of the VBIOS table and owner of the platform desc=
riptor to be updated.
> - * @param powerplay_table the address of the PowerPlay table.
> + * @hwmgr: source of the VBIOS table and owner of the platform descripto=
r to be updated.
> + * @powerplay_table: the address of the PowerPlay table.
>   *
> - * @return 1 as long as the firmware info table was present and of a sup=
ported version.
> + * Return: 1 as long as the firmware info table was present and of a sup=
ported version.
>   */
>  static int init_over_drive_limits(
>                 struct pp_hwmgr *hwmgr,
> @@ -898,11 +899,11 @@ static int init_over_drive_limits(
>  }
>
>  /**
> - * Private Function used during initialization.
> + * init_thermal_controller - Private Function used during initialization=
.
>   * Inspect the PowerPlay table for obvious signs of corruption.
> - * @param hwmgr Pointer to the hardware manager.
> - * @param powerplay_table Pointer to the PowerPlay Table.
> - * @exception This implementation always returns 1.
> + * @hwmgr: Pointer to the hardware manager.
> + * @powerplay_table: Pointer to the PowerPlay Table.
> + * Exception:  This implementation always returns 1.
>   */
>  static int init_thermal_controller(
>                 struct pp_hwmgr *hwmgr,
> @@ -1108,11 +1109,11 @@ static int init_thermal_controller(
>  }
>
>  /**
> - * Private Function used during initialization.
> + * check_powerplay_tables - Private Function used during initialization.
>   * Inspect the PowerPlay table for obvious signs of corruption.
> - * @param hwmgr Pointer to the hardware manager.
> - * @param powerplay_table Pointer to the PowerPlay Table.
> - * @exception 2 if the powerplay table is incorrect.
> + * @hwmgr: Pointer to the hardware manager.
> + * @powerplay_table: Pointer to the PowerPlay Table.
> + * Exception:  2 if the powerplay table is incorrect.
>   */
>  static int check_powerplay_tables(
>                 struct pp_hwmgr *hwmgr,
> @@ -1255,9 +1256,9 @@ int get_number_of_powerplay_table_entries_v1_0(stru=
ct pp_hwmgr *hwmgr)
>         return (uint32_t)(state_arrays->ucNumEntries);
>  }
>
> -/**
> -* Private function to convert flags stored in the BIOS to software flags=
 in PowerPlay.
> -*/
> +/*
> + * Private function to convert flags stored in the BIOS to software flag=
s in PowerPlay.
> + */
>  static uint32_t make_classification_flags(struct pp_hwmgr *hwmgr,
>                 uint16_t classification, uint16_t classification2)
>  {
> @@ -1356,13 +1357,13 @@ static int ppt_get_vce_state_table_entry_v1_0(str=
uct pp_hwmgr *hwmgr, uint32_t i
>  }
>
>  /**
> -* Create a Power State out of an entry in the PowerPlay table.
> -* This function is called by the hardware back-end.
> -* @param hwmgr Pointer to the hardware manager.
> -* @param entry_index The index of the entry to be extracted from the tab=
le.
> -* @param power_state The address of the PowerState instance being create=
d.
> -* @return -1 if the entry cannot be retrieved.
> -*/
> + * get_powerplay_table_entry_v1_0 - Create a Power State out of an entry=
 in the PowerPlay table.
> + * This function is called by the hardware back-end.
> + * @hwmgr: Pointer to the hardware manager.
> + * @entry_index: The index of the entry to be extracted from the table.
> + * @power_state: The address of the PowerState instance being created.
> + * Return: -1 if the entry cannot be retrieved.
> + */
>  int get_powerplay_table_entry_v1_0(struct pp_hwmgr *hwmgr,
>                 uint32_t entry_index, struct pp_power_state *power_state,
>                 int (*call_back_func)(struct pp_hwmgr *, void *,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
