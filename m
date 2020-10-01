Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE7027FF84
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbgJAMx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731936AbgJAMx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:53:56 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AFDC0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 05:53:55 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qp15so6980929ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=06zHlwXUngyRXgBFfhpGG+CXA5ZNckw9XHHn+j/oAwY=;
        b=Zx0TX2ubgW0Ri33jwwHz69y55RfQINo/RuZyr9Hk+HdKZb0iVhlr8tk98VCxjNy0+Q
         tGMBzczN1vRhX0GveBC6m3gw0DZDnPR0oRfF7IKiY5zolv1BZzW9NVtNp54YliUUB63W
         /kEowAEbvMsVIZlvF1o13OYjfTQkNWCWd2hcxKSzDO0X/vKIDaN9ZB2gvBx7MyQ7uDdd
         OuM0YHROAg2o7vc0wM6w5N1+ZMOdXSbkm+JeE6lbn9CPN4FVW8XAsv6IoIgwRneBc7K4
         elmlOllXsDmnt77Gee5TgFFkKTU9oy8UvXodbOVB/zzWw+Xm543jNb2vEkavsYrbq4LT
         OF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=06zHlwXUngyRXgBFfhpGG+CXA5ZNckw9XHHn+j/oAwY=;
        b=FY9DChkRYNBYsjPxCpAE9MrTjWTrOAjDeQDxjJu1qxPg329F2bD9dzIVd2KkYSpZh4
         o74jJykZBw0rU1XtdP4gmGQDusS1ewZArUTHfa6GKb3WfWuUZHR9khk05D5jtOMKxj5l
         Erc3l0+FVAyrjLiIQZNok8VBxj1N6uKMOJtCn22dvxzqSuFIpKo8jnJFLPx9tNgQbNOV
         F6892HNMyUNl3sa7zD6GlOzHTijFHrsRQSNeyGzD1pf4AUbyrdyNniG4FTLAji0ex+oz
         uC87Rvjeiawl+KJ2c6pCYyK9eJ+KtuwZFawy+AS3aU4fph5xVhuvGWc9c3Lb0vPpaHs2
         i0iw==
X-Gm-Message-State: AOAM533RPaGTHdROh/hnsc38uZlhCLGkImhf+qc70AtjCrd5HHvLARBk
        G13X8GzBg1J1squPGGQQVsrh+F1zz7P6GANiy7+rig==
X-Google-Smtp-Source: ABdhPJy2jnDB4nsMZeAxrM672OuFou/ETnP5WUNusUY+Dpfx4FikpknL0KnWapBriVEdeq0glYyNiCavk6KtiEFRwlM=
X-Received: by 2002:a17:906:3397:: with SMTP id v23mr3190662eja.212.1601556834567;
 Thu, 01 Oct 2020 05:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201001122511.1075420-1-vaibhavgupta40@gmail.com> <20201001122511.1075420-18-vaibhavgupta40@gmail.com>
In-Reply-To: <20201001122511.1075420-18-vaibhavgupta40@gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 1 Oct 2020 14:53:43 +0200
Message-ID: <CAMGffEkF9ATZJ77FKTfP1g=iBLeVObco7nyQwLTjGu2pDehz-A@mail.gmail.com>
Subject: Re: [PATCH v3 17/28] scsi: pm_8001: Drop PCI Wakeup calls from .resume
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Hannes Reinecke <hare@suse.com>,
        Bradley Grove <linuxdrivers@attotech.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        esc.storagedev@microsemi.com, megaraidlinux.pdl@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 2:30 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
>
> The driver calls pci_enable_wake(...., false) in pm8001_pci_resume(), and
> there is no corresponding pci_enable_wake(...., true) in
> pm8001_pci_suspend(). Either it should do enable-wake the device in
> .suspend() or should not invoke pci_enable_wake() at all.
>
> Concluding that this driver doesn't support enable-wake and PCI core calls
> pci_enable_wake(pci_dev, PCI_D0, false) during resume, drop it from
> pm8001_pci__resume().
>
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Looks good to me!
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>

Thanks!
> ---
>  drivers/scsi/pm8001/pm8001_init.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
> index 9e99262a2b9d..ee27ecb17560 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -1248,7 +1248,6 @@ static int pm8001_pci_resume(struct pci_dev *pdev)
>                 "operating state [D%d]\n", pdev, pm8001_ha->name, device_state);
>
>         pci_set_power_state(pdev, PCI_D0);
> -       pci_enable_wake(pdev, PCI_D0, 0);
>         pci_restore_state(pdev);
>         rc = pci_enable_device(pdev);
>         if (rc) {
> --
> 2.28.0
>
