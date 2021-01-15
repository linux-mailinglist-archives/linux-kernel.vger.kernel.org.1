Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E242F76BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbhAOKe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbhAOKe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:34:27 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040DDC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 02:33:47 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c6so1840977ede.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 02:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7LLY4cPoj6ptHG8TMYZijdPTmBW8T6G4b89+HyQKpxw=;
        b=GE0cXLy/kuL2fZZ4/IVlnZ4FCfpmQzodiSicwAJ2UPtRyR+BZKUSvETds02GbcRAka
         D2WgvVnDzqUE+Xn+V4UXj+yTN2YiwA/gPMzM6Rk0NZQ5oWGu+wJDKvia1gufFft673sm
         A5xTHv86/iXYeRbn2cA/AdWq8wKWhyE6U0PAASysIRur2uXiSJ29dxtoM7UtUC3LdlsU
         W9hBCrC5kYFiuqv67DvWW/R/CfoYZIiGm6g4/7NwjxLE+q3h07YsyE586wQpqovV6PHS
         +hS+ZU9Lu3QzBw8S8Mwn9jFhXVgL3yJqPKiRCQILXIK8oUi+jdmcSRaiTtQL3cMkpyFV
         +LLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LLY4cPoj6ptHG8TMYZijdPTmBW8T6G4b89+HyQKpxw=;
        b=Rn5OdcnQNqBccF90yc6Fw+Ckr2m1fZZyxDT/AbDe7igtIaTqWtgSFQXEZQJ44kABy4
         EgsxR4mpaCZs0bdRlLfO1WbGTbQCbNEBey9Os7NfXRWziziZOm5g4vgQ47Ad7FP83gjE
         LZ+BtxfrNijDdcWBKdWwXA5CHeVJiGPd0mmGXu0dYVvbziZnln2CuXaKm4EYcB4w5Dkg
         5ss4dxunPYjRbfGubHc5XdmxrYKsJyPI5p1qhoWiRUDl/cLQNtsoyr8w1hygtr1iKj/2
         o20ZW5kYUrt+j4c7ZiIcrHmuZe3dqiBPvzvWMkEyb358IfT3UOmPucoSzlj0dw1c70cf
         Wk4Q==
X-Gm-Message-State: AOAM530coqLu+bS+DmDeHEfesYZR+RwECzl9IMzGfSt8xMOBMSRamYd0
        Rc0d6TZIS1D9mp2hMwgEHzaGtLuS9gNE/ZSqtPfNjg==
X-Google-Smtp-Source: ABdhPJx/EV3I7aklh2GfUFN/kPHVBFAEjZgJJRD4iG4LA1RbEIWCLSURQbBMV94N4R34LBDU7RFHq4FkOSXKkeciUP8=
X-Received: by 2002:a05:6402:a53:: with SMTP id bt19mr9206928edb.104.1610706826562;
 Fri, 15 Jan 2021 02:33:46 -0800 (PST)
MIME-Version: 1.0
References: <20210115095824.9170-1-colin.king@canonical.com>
In-Reply-To: <20210115095824.9170-1-colin.king@canonical.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 15 Jan 2021 11:33:35 +0100
Message-ID: <CAMGffEnkfgwSQKSwr_91a8wakhEvGy3fU5m_DM9O5mpp3foNSA@mail.gmail.com>
Subject: Re: [PATCH][next] scsi: pm80xx: clean up indentation of a code block
To:     Colin King <colin.king@canonical.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 10:58 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> A block of code is indented one level too deeply, clean this
> up.
>
> Addresses-Coverity: ("Indentation does not match nesting level")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/scsi/pm8001/pm80xx_hwi.c | 34 ++++++++++++++------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index e7fef42b4f6c..6fd206abc9fc 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -358,26 +358,22 @@ ssize_t pm80xx_get_fatal_dump(struct device *cdev,
>                                         MEMBASE_II_SHIFT_REGISTER,
>                                         pm8001_ha->fatal_forensic_shift_offset);
>                 }
> -                       /* Read the next block of the debug data.*/
> -                       length_to_read = pm8001_mr32(fatal_table_address,
> -                       MPI_FATAL_EDUMP_TABLE_ACCUM_LEN) -
> -                       pm8001_ha->forensic_preserved_accumulated_transfer;
> -                       if (length_to_read != 0x0) {
> -                               pm8001_ha->forensic_fatal_step = 0;
> -                               goto moreData;
> -                       } else {
> -                               pm8001_ha->forensic_info.data_buf.direct_data +=
> -                               sprintf(
> -                               pm8001_ha->forensic_info.data_buf.direct_data,
> +               /* Read the next block of the debug data.*/
> +               length_to_read = pm8001_mr32(fatal_table_address,
> +               MPI_FATAL_EDUMP_TABLE_ACCUM_LEN) -
> +               pm8001_ha->forensic_preserved_accumulated_transfer;
> +               if (length_to_read != 0x0) {
> +                       pm8001_ha->forensic_fatal_step = 0;
> +                       goto moreData;
> +               } else {
> +                       pm8001_ha->forensic_info.data_buf.direct_data +=
> +                       sprintf(pm8001_ha->forensic_info.data_buf.direct_data,
>                                 "%08x ", 4);
> -                               pm8001_ha->forensic_info.data_buf.read_len
> -                                                               = 0xFFFFFFFF;
> -                               pm8001_ha->forensic_info.data_buf.direct_len
> -                                                               =  0;
> -                               pm8001_ha->forensic_info.data_buf.direct_offset
> -                                                               = 0;
> -                               pm8001_ha->forensic_info.data_buf.read_len = 0;
> -                       }
> +                       pm8001_ha->forensic_info.data_buf.read_len = 0xFFFFFFFF;
> +                       pm8001_ha->forensic_info.data_buf.direct_len =  0;
> +                       pm8001_ha->forensic_info.data_buf.direct_offset = 0;
> +                       pm8001_ha->forensic_info.data_buf.read_len = 0;
> +               }
>         }
>         offset = (int)((char *)pm8001_ha->forensic_info.data_buf.direct_data
>                         - (char *)buf);
> --
> 2.29.2
>
