Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625EF2CB287
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 02:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgLBBwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 20:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgLBBwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 20:52:37 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4309C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 17:51:51 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id 11so226989oty.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 17:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=go+Zj6KBSKu3isJZDuZUS24tND+F8EKuCP2NBgNIZY0=;
        b=IOIotIjX+251wEpy3NPTYBGm7vBUvhcD3FDAI507n8SV97SELBJZ1ggWtMs2u096Ho
         9vltOg2ZonZlM5tchrG9ksx7d4q7jgXy6+IgPC2MCnVwHtfNQrbtIhQk4TCtM4NY4EMV
         0O1MPEIoLCjaays3Liqw7axnAkTOefJxgToNmNDSdUgK9KdllgR+QjytgzQ6/h2PGCFL
         6EZOd+ykKB8oi8VN3Udn0ZfdXmtCJ1469q72TZ2tBAZ2z2mufXLYk+vOFdEkBzfAcaXq
         +8fsOgm+xj248sDovcLBC6UnU3Ziunlw46eUXohbgiLAm/X10WOrx/XYk4PQqhVr/9Hi
         UAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=go+Zj6KBSKu3isJZDuZUS24tND+F8EKuCP2NBgNIZY0=;
        b=goTItGZIwb2fLcmPEg0NDF27DlHYUqxd5b4Cer4boK/CMbQ8gK0T00r/DIMTRBhQMh
         0WSQ3WuFiRLK0W0jMnUGVhsAG21GOU5Z0AlnPwEHEswKPxfQvb5wNZqyhRuKg5wX14JS
         ssKVHCJoTyQeWzo2EP4+/nYneca6W9UY2DTLA06n3LxswSOY4pUIXCcq1nkxmgrWpgbA
         dwLgSCz3C35ngqI7dcNIk1xHPlL9qq76jZC2NSUwh6RGoAJ1yDUeImJ4O2osGQxHKTTm
         RoBPrwo/7eo0o306hYIQz1MJCRc9jwB1hlvGhr/A6NnfiR2eDbbcSDs/11BZKVdDFnAC
         DqiA==
X-Gm-Message-State: AOAM530fhqb3qg6UrULhVpCn03fPdls2NrwOaSFaJNLQikOrs3tC70Cy
        yB7wojPzqxKYIz9jVvhc6mPmMlpBCE7fVQ==
X-Google-Smtp-Source: ABdhPJy4YjB1CcwYbzGd/p39iuzI/uDlEtmNP17tPQjGv0Avef3iHVRa5D5B4cfDwnWHgyUh/Li7Jg==
X-Received: by 2002:a9d:20a7:: with SMTP id x36mr205126ota.103.1606873910934;
        Tue, 01 Dec 2020 17:51:50 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y21sm53262oti.21.2020.12.01.17.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 17:51:50 -0800 (PST)
Date:   Tue, 1 Dec 2020 19:51:48 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org, mka@chromium.org,
        rjliao@codeaurora.org, tjiang@codeaurora.org
Subject: Re: [PATCH v1] Bluetooth: support download nvm with different board
 id for wcn6855
Message-ID: <X8bzNMT3o0GWxz8A@builder.lan>
References: <1606791564-2443-1-git-send-email-zijuhu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606791564-2443-1-git-send-email-zijuhu@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30 Nov 20:59 CST 2020, Zijun Hu wrote:

> From: Tim Jiang <tjiang@codeaurora.org>
> 
> we define many nvm files for wcn6855 btsoc and host driver
> should find the correct nvm file based on board ID and then
> download it.
> 
> Signed-off-by: Tim Jiang <tjiang@codeaurora.org>
> ---
>  drivers/bluetooth/btusb.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 3bbe8f43e7fa..66e19085e0fa 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3474,7 +3474,8 @@ struct qca_version {
>  	__le32	rom_version;
>  	__le32	patch_version;
>  	__le32	ram_version;
> -	__le32	ref_clock;
> +	__u16	board_id;

You should follow the scheme of describing the endianess of the fields.

> +	__u8	flag[2];

It seems more reasonable to make this a 16-bit flags. And either way
there are more than one of these, so plural "flags" seems appropriate.


PS. Can you confirm that no firmware actually used these 16 bits of the
"ref_clock"? Why wasn't the reserved bytes used to add the new
properties?

>  	__u8	reserved[4];
>  } __packed;
>  
> @@ -3657,8 +3658,13 @@ static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
>  	char fwname[64];
>  	int err;
>  
> -	snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x.bin",
> -		 le32_to_cpu(ver->rom_version));
> +	if (ver->flag[1] == 0x80) { //check board id for wcn6855

Is this BIT(7) in the second byte of the flags, or is the second flag
0x80?

Based on the comment you should be able to provide a

#define QCA_VERSION_SECOND_FLAG_IS_WCN6855 0x80

to use instead of this magic number.

Regards,
Bjorn

> +		snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x_%04x.bin",
> +			le32_to_cpu(ver->rom_version), le16_to_cpu(ver->board_id));
> +	} else {
> +		snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x.bin",
> +			le32_to_cpu(ver->rom_version));
> +	}
>  
>  	err = request_firmware(&fw, fwname, &hdev->dev);
>  	if (err) {
> @@ -3725,6 +3731,11 @@ static int btusb_setup_qca(struct hci_dev *hdev)
>  			return err;
>  	}
>  
> +	err = btusb_qca_send_vendor_req(udev, QCA_GET_TARGET_VERSION, &ver,
> +					sizeof(ver));
> +	if (err < 0)
> +		return err;
> +
>  	if (!(status & QCA_SYSCFG_UPDATED)) {
>  		err = btusb_setup_qca_load_nvm(hdev, &ver, info);
>  		if (err < 0)
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
> 
