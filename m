Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C833C257397
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 08:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgHaGQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 02:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgHaGPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 02:15:48 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77334C061575
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 23:15:45 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id ay8so4303936edb.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 23:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zH8iXPe2IpmEV6MvtsCYE816RJ3JkF73TlP+EUZxU8=;
        b=cud8CCRws7crvn6VNCQlihlBZrASGjsxipOuX2EZPQe2lqqTP3ZaYY+TCozh7kMKRe
         NswN0/oHpQmbCq6/i8vjhxRxfV3xgS22ExhW1T2MLvsw4SOYCR42bDuWq6GebUsWRBek
         1w3TNXolXWEN4S8kg0SPd2KjJK720dmrP5sIPLNcY5y5dRKye/ABpO5iikVEDrV1ws2z
         H9L9Wz3EvBclfkoozNkRMztXhm3AnLJa/5ZiLWUNBbn7iY9tlXLuEmbKg2l0neRfEII5
         A+dYPO2eu8RGTArKJ2RsWBL/0IHdb+8npfyfethI7d9/0aD/7/eCSO9HtZkrJq26K30J
         yJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zH8iXPe2IpmEV6MvtsCYE816RJ3JkF73TlP+EUZxU8=;
        b=BCF8kooJl8tUzmzQzr1YwzaVm57vPmWI9rb82uD22+IvtznxAGMNeyLw7dkAxJjrYf
         dbq+PBXQbFsOdt3bNrslQ+dfTQgKciOEIIaPHUd33CB19r7yjZJnVLOoeRy03UAp12pG
         n34EgCxfbOLo9CfAOIfuwajrjRTnF+JSMQpfjl4GUtm9sqFftaGzN8corU863//eKLk+
         K5xrXiLARvjU5cHPn4ZhdLvMUvlvM7/gCSq1VSPJAYaOwddLJb1tRg61b0j1fkiDT4a+
         XV7I7OTljSw7o41bz1IZRwvMNrZwVzCmOcwN9QmGVgw26dH42ctrMKzVZoOwfpQLC1qI
         +kbg==
X-Gm-Message-State: AOAM532eA7MzAANEJt8fqVrYFbhYowu0LGNrZ/NhF7sSNoqrZ0l0EFPm
        ZqqkGlImtKXhw76o+ug2cTMF5jbuZ95lK/lCRiqf2A==
X-Google-Smtp-Source: ABdhPJxBslz91+328C6zIUiWxOSEPHyGxAs+7xWQfb9ymOLlxQ0nFrVmy3K7FpSmk7Ot/k0dcrAMkVebEQwkB6CXnoY=
X-Received: by 2002:aa7:cdc4:: with SMTP id h4mr9802697edw.252.1598854544166;
 Sun, 30 Aug 2020 23:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200823091453.4782-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20200823091453.4782-1-dinghao.liu@zju.edu.cn>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 31 Aug 2020 08:15:31 +0200
Message-ID: <CAMGffE=RQiPxjA+vxVfj_zCBfJy6PiOdJpkTWC+DRDzDW_nDZg@mail.gmail.com>
Subject: Re: [PATCH] scsi: pm8001: Fix memleak in pm8001_exec_internal_task_abort
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 11:15 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>
> When pm8001_tag_alloc() fails, task should be freed just
> like what we've done in the subsequent error paths.
>
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Thanks!
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_sas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index 337e79d6837f..9889bab7d31c 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -818,7 +818,7 @@ pm8001_exec_internal_task_abort(struct pm8001_hba_info *pm8001_ha,
>
>                 res = pm8001_tag_alloc(pm8001_ha, &ccb_tag);
>                 if (res)
> -                       return res;
> +                       goto ex_err;
>                 ccb = &pm8001_ha->ccb_info[ccb_tag];
>                 ccb->device = pm8001_dev;
>                 ccb->ccb_tag = ccb_tag;
> --
> 2.17.1
>
