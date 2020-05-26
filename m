Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 339271A31A2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 11:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgDIJQU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Apr 2020 05:16:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42197 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgDIJQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:16:20 -0400
Received: from mail-pj1-f70.google.com ([209.85.216.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jMTIJ-0002bD-9r
        for linux-kernel@vger.kernel.org; Thu, 09 Apr 2020 09:16:19 +0000
Received: by mail-pj1-f70.google.com with SMTP id s10so2035147pjc.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 02:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=I/aLOBCPPw94GG/u9hj9C2FG+LS8AZRo+ZKiDRcnxfs=;
        b=Z+MG/YWqeTePeEHwzlYX089h6h1tOVFbvpF74cPVN87SPn91qWnC1GuExSe3LOKMzT
         WAlYrSXsRpsHLM0no3BCWAjd1NP/jKh2tqhNtg/z551X7I2IAZGICPXOUtjzdsHZW+MI
         X0EtqJeVUF42NY7mhXpYC8fhKaXzQDYBGtiBzesbQd9pdMYExlgemykyTItHJLv2OTmE
         n8rtaYwJlV4GwwPt6He0uJH5gNz2H7BVSndeNkJvn8pr/Yw1yX2ynwr2SNK2UvutCB1S
         h/M5xT758pjPay/XI7whcwcv8AitqskvhlPpqb3jdCM30j314cPlAyxZqUDfcXUcsJMU
         pbtA==
X-Gm-Message-State: AGi0Pubui4v7lzJkj3DrVfFt2Anj4HGnxZ6cHDc/x3ftfwh5GKuBfYfQ
        NZa/JQBWIcBqB7QtAC8bxxYFUtVebd1EzzFgcobEJGPKXZmL2tJ+HHWpM13coenPqwwKYEX7/ID
        BOLJ/MduAx9LNEOSh6uvDELO46z1vn+RnW9rkE3KCsw==
X-Received: by 2002:a17:902:242:: with SMTP id 60mr11378509plc.245.1586423777939;
        Thu, 09 Apr 2020 02:16:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypLJyMKRHAg8InQnK0BXiYiqShBnT1RbYLk74TbMNSG8JiX0/iAUbWhQOBWAi7mt/UsWbh2v1w==
X-Received: by 2002:a17:902:242:: with SMTP id 60mr11378491plc.245.1586423777606;
        Thu, 09 Apr 2020 02:16:17 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id 6sm18624250pfx.69.2020.04.09.02.16.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 02:16:17 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] ahci: Add Intel Comet Lake PCH RAID PCI ID
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20191128081041.6948-1-jian-hong@endlessm.com>
Date:   Thu, 9 Apr 2020 17:16:14 +0800
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, linux@endlessm.com
Content-Transfer-Encoding: 8BIT
Message-Id: <EF580FD3-2C0F-4268-8B39-8B339D590353@canonical.com>
References: <20191128081041.6948-1-jian-hong@endlessm.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Jian-Hong Pan <jian-hong@endlessm.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

> On Nov 28, 2019, at 16:10, Jian-Hong Pan <jian-hong@endlessm.com> wrote:
> 
> Intel Comet Lake should use the default LPM policy for mobile chipsets.
> So, add the PCI ID to the driver list of supported devices.
> 
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>

Would it be possible to also merge this patch?
We also have some system that use this controller.

Kai-Heng

> ---
> drivers/ata/ahci.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index ec6c64fce74a..d9b3a9f7a4ee 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -405,6 +405,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
> 	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_mobile }, /* Cherry Tr. AHCI */
> 	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_mobile }, /* ApolloLake AHCI */
> 	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_mobile }, /* Ice Lake LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_mobile }, /* Comet Lake PCH RAID */
> 
> 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
> 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> -- 
> 2.20.1
> 

