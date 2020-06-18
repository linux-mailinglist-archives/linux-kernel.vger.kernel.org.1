Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FA81FF486
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 16:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgFROST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 10:18:19 -0400
Received: from mail-m964.mail.126.com ([123.126.96.4]:49278 "EHLO
        mail-m964.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgFROSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:18:18 -0400
X-Greylist: delayed 1849 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jun 2020 10:18:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=dE/u/Olq00IitY+Hxe
        hpcTZ9LTITxRuFXdDzNJlgZMU=; b=MLnc9/S4PnYP4jmWCYMN3uxxK+/xLKP2GX
        kLHeK/H888C0chYzZP4d7SxJk1zrzJTKN/A8b+IFdy2H8K6Yxju0KIJFjThOCSK5
        sWsk8Z4uoLc8TXdrLoh38C/7jp762t5ErjVnJk7KTpEJIwH4LpB7r5KFqCkK96Sz
        eaV1q8Nng=
Received: from zhixu-home.lan (unknown [114.249.228.138])
        by smtp9 (Coremail) with SMTP id NeRpCgBnbwu2b+tekoqNSA--.114S2;
        Thu, 18 Jun 2020 21:44:23 +0800 (CST)
From:   Zhixu Zhao <zhixu001@126.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>, Richard Yeh <rcy@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] staging: gasket: core: Fix a coding style issue in gasket_core.c
Date:   Thu, 18 Jun 2020 21:44:22 +0800
Message-Id: <20200618134422.24278-1-zhixu001@126.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617161127.32006-1-zhixu001@126.com>
References: <20200617161127.32006-1-zhixu001@126.com>
X-CM-TRANSID: NeRpCgBnbwu2b+tekoqNSA--.114S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4kuFy7tr1fGrW3AFyrWFg_yoW3AwbEkr
        WxZrykG3Z8GasYyrWUCrsxJF9rCw1fJFnY93y5t34DG34kAwsxXws7Gr40krnxZ3Z7X3Zx
        Z3sFvas7Jw12gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeLNVDUUUUU==
X-Originating-IP: [114.249.228.138]
X-CM-SenderInfo: x2kl53qqqrqiyswou0bp/1tbiuxdHfFpEA3VICwAAs8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At 2020-06-18 03:10:02, "Dan Carpenter" <dan.carpenter@oracle.com> wrote:
>It would be better to do this in the declaration block so you can change
>the earlier two uses in this function:
>
>+	struct gasket_bar_data *data = &gasket_dev->bar_data[bar_num];
>-	ulong desc_bytes = driver_desc->bar_descriptions[bar_num].size;
>+	ulong desc_bytes = data->size;
>
>...
>
>-	if (driver_desc->bar_descriptions[bar_num].type != PCI_BAR) {
>+	if (data->type != PCI_BAR) {

`struct gasket_bar_data *data` and `driver_desc->bar_descriptions[bar_num]`
are not the same thing as I see it. Besides, `struct gasket_bar_data`
doesn't have a `size` field (it does have a `length_bytes` field).
So... did I miss anything?

-- 
Zhixu Zhao
https://github.com/zhaozhixu

