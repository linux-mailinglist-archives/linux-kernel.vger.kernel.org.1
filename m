Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AD929D8CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbgJ1Wg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:36:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:51270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388081AbgJ1Wdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:33:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DB137AC0C;
        Wed, 28 Oct 2020 09:04:56 +0000 (UTC)
Date:   Wed, 28 Oct 2020 10:04:55 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware/dmi: Include product_sku info to modalias
Message-ID: <20201028100455.28cad0f5@endymion>
In-Reply-To: <20201028035015.8897-1-kaichuan.hsieh@canonical.com>
References: <20201028035015.8897-1-kaichuan.hsieh@canonical.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Chuan,

On Wed, 28 Oct 2020 11:50:15 +0800, Kai-Chuan Hsieh wrote:
> Some Dell platforms rely on modalias to customize configuration,
> the product sku can be more specific for the hardware.
> 
> Add product_sku to modalias for better utilization.
> 
> Signed-off-by: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
> ---
>  drivers/firmware/dmi-id.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
> index 86d71b0212b1..4d5421d14a41 100644
> --- a/drivers/firmware/dmi-id.c
> +++ b/drivers/firmware/dmi-id.c
> @@ -85,6 +85,7 @@ static ssize_t get_modalias(char *buffer, size_t buffer_size)
>  		{ "svn", DMI_SYS_VENDOR },
>  		{ "pn",  DMI_PRODUCT_NAME },
>  		{ "pvr", DMI_PRODUCT_VERSION },
> +		{ "sku", DMI_PRODUCT_SKU },
>  		{ "rvn", DMI_BOARD_VENDOR },
>  		{ "rn",  DMI_BOARD_NAME },
>  		{ "rvr", DMI_BOARD_VERSION },

Applied, thanks.

For your future submissions, I invite you to read
Documentation/process/submitting-patches.rst

Specifically, when submitting a new version of a patch, please:
* Replace [PATCH] with [PATCH v2] in the subject.
* Do not reply to the previous version of the patch, instead start a
  new thread.
* Ideally, include a list of changes from previous version, between the
  "---" marker and the diffstat.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
