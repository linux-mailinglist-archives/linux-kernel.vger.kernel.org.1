Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6D42A2B8D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgKBNcm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Nov 2020 08:32:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48915 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgKBNcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:32:41 -0500
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kZZwt-0007uJ-3U
        for linux-kernel@vger.kernel.org; Mon, 02 Nov 2020 13:32:39 +0000
Received: by mail-pg1-f198.google.com with SMTP id s130so1351290pgc.22
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 05:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cjErvK8MUSGh8IOlHd2RporU2vNgl3pwXHEZ7poNC7M=;
        b=cEuP9kwMtNh4iL5jXFnZvWhcBZsE/bfLIOVGb5440O2Em0BOMHgR65fSKf8vSgX9Fh
         IagRgQChVxAhcz3QCVFIgCF5fOKinGVNaZYXov9m1FAJoiz0PT4Thn5+sUkJZsbmogew
         03gy5m3jhYYM5WzjNx5BF5VLB0OCfQqywKN71rP29kmcsQUhVqHR0fT4FkcNzWRf6PFv
         E1Vu1znnXbmTZRTaHuH11rnCXnorGDIVwjB3xUi7dmhu+hd+ywy0Y8XjxYoqmOkG3xtd
         l3pNqPdIFyRR0cvDnrlqEX8pwqFNjhSY8F3OO8PnvmO3NHPB1Kmn4hYBwQN+EDQU+2Gf
         dcRA==
X-Gm-Message-State: AOAM531oRHaaeMu4hFddxsIpisNHA2IXe+FJe3Ckjd72G9VnolOUs8Q5
        MnuwoD7QCTuUM5AQrmK5ebGuPOI8Ix5kcauTkW1BKq3lF8wZoXcVa+N5yrp8tNxd2w2jf4ea4OM
        g3HaXayw4F3y3VNPGmOAspI0lIazR4l1sjQ8qPXr6tQ==
X-Received: by 2002:a63:5625:: with SMTP id k37mr6523261pgb.136.1604323957750;
        Mon, 02 Nov 2020 05:32:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJySGvdT/8hMRJms3GyjVRZl5ToYxCQ0yX2k5LZ+DuJ2jVwevCJI0Rfr73MvSF/Cirhq+CZbjA==
X-Received: by 2002:a63:5625:: with SMTP id k37mr6523245pgb.136.1604323957331;
        Mon, 02 Nov 2020 05:32:37 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id z13sm12933775pgc.44.2020.11.02.05.32.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 05:32:36 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2] Bluetooth: btrtl: Ask 8821C to drop old firmware
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20201026082838.26532-1-kai.heng.feng@canonical.com>
Date:   Mon, 2 Nov 2020 21:32:33 +0800
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <1A6AB99C-425D-42D5-B1F4-818AD7525F53@canonical.com>
References: <20201026082838.26532-1-kai.heng.feng@canonical.com>
To:     Max Chou <max.chou@realtek.com>, alex_lu <alex_lu@realsil.com.cn>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 26, 2020, at 16:28, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> Some platforms keep USB power even when they are powered off and in S5,
> this makes Realtek 8821C keep its firmware even after a cold boot, and
> make 8821C never load new firmware.
> 
> So use vendor specific HCI command to ask 8821C drop its firmware after
> system shutdown.
> 
> Newer firmware doesn't have this issue so we only use this trick for old
> 8821C firmware version.
> 
> Suggested-by: Max Chou <max.chou@realtek.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Max and Alex,

Can you please ack or review the patch?

Kai-Heng

> ---
> v2:
> - Fix incorrect parAnthesis on le16_to_cpu.
> - Ensure firmware gets re-uploaded in initialization.
> 
> drivers/bluetooth/btrtl.c | 46 +++++++++++++++++++++++++++++++++++++++
> 1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 3a9afc905f24..37e24bbb2eb4 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -55,6 +55,7 @@ struct btrtl_device_info {
> 	int fw_len;
> 	u8 *cfg_data;
> 	int cfg_len;
> +	bool drop_fw;
> };
> 
> static const struct id_table ic_id_table[] = {
> @@ -563,6 +564,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
> 	u16 hci_rev, lmp_subver;
> 	u8 hci_ver;
> 	int ret;
> +	u16 opcode;
> +	u8 cmd[2];
> 
> 	btrtl_dev = kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
> 	if (!btrtl_dev) {
> @@ -584,6 +587,49 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
> 	hci_ver = resp->hci_ver;
> 	hci_rev = le16_to_cpu(resp->hci_rev);
> 	lmp_subver = le16_to_cpu(resp->lmp_subver);
> +
> +	if (resp->hci_ver == 0x8 && le16_to_cpu(resp->hci_rev) == 0x826c &&
> +	    resp->lmp_ver == 0x8 && le16_to_cpu(resp->lmp_subver) == 0xa99e)
> +		btrtl_dev->drop_fw = true;
> +
> +	if (btrtl_dev->drop_fw) {
> +		opcode = hci_opcode_pack(0x3f, 0x66);
> +		cmd[0] = opcode & 0xff;
> +		cmd[1] = opcode >> 8;
> +
> +		skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
> +		if (IS_ERR(skb))
> +			goto out_free;
> +
> +		skb_put_data(skb, cmd, sizeof(cmd));
> +		hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
> +
> +		hdev->send(hdev, skb);
> +
> +		/* Ensure the above vendor command is sent to controller and
> +		 * process has done.
> +		 */
> +		msleep(200);
> +
> +		/* Read the local version again. Expect to have the vanilla
> +		 * version as cold boot.
> +		 */
> +		skb = btrtl_read_local_version(hdev);
> +		if (IS_ERR(skb)) {
> +			ret = PTR_ERR(skb);
> +			goto err_free;
> +		}
> +
> +		resp = (struct hci_rp_read_local_version *)skb->data;
> +		rtl_dev_info(hdev, "examining hci_ver=%02x hci_rev=%04x lmp_ver=%02x lmp_subver=%04x",
> +			     resp->hci_ver, resp->hci_rev,
> +			     resp->lmp_ver, resp->lmp_subver);
> +
> +		hci_ver = resp->hci_ver;
> +		hci_rev = le16_to_cpu(resp->hci_rev);
> +		lmp_subver = le16_to_cpu(resp->lmp_subver);
> +	}
> +out_free:
> 	kfree_skb(skb);
> 
> 	btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev, hci_ver,
> -- 
> 2.17.1
> 

