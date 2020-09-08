Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4FE2608B7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 04:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgIHCmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 22:42:55 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13690 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgIHCmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 22:42:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f56efa00000>; Mon, 07 Sep 2020 19:42:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 07 Sep 2020 19:42:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 07 Sep 2020 19:42:54 -0700
Received: from [10.19.100.126] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 02:42:49 +0000
Subject: Re: [PATCH v2 12/12] xhci: tegra: enable ELPG for runtime/system PM
To:     Dmitry Osipenko <digetx@gmail.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <robh@kernel.org>,
        <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
 <20200831044043.1561074-13-jckuo@nvidia.com>
 <68b57be4-a924-6b0a-a853-9cced2eead60@gmail.com>
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <ca14cfd6-1f11-63ee-22c3-3744c46d0601@nvidia.com>
Date:   Tue, 8 Sep 2020 10:42:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <68b57be4-a924-6b0a-a853-9cced2eead60@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599532960; bh=kWE3woWpx6MGq6bYQJbbbwah3eZkYRMFTLtfytrK/5U=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HxTl8UVey9gxRrb203aUGW2USFkMorh25fwL0LFKmUvLIUDnhIpKLeZ7pcbN6sARS
         sSf9KLHg7AdP2iMqkkztTXNsKCJGsBTFJ1Z6U8BgY5L1BgGAN/cBcADqdM11Rgk8Vv
         oPSTyNsOAD9lb8AFFdzz52qLPJmF+CIUacwv/u6JSdgw/tMP0q34Lh3VNJ6hIo/2BD
         B+UTm0xbQ5QTrdWlWgceeWzf9ZLC+mMF8CdEZGpKCNTRl3Ev68oVmKjpS8PbbWEQ9D
         phAOHuv98tLnCb7zxmP1FG7vjgtmJXAAov/yWUddiDjwtfdIGfW/XxXc1hPmePV2wD
         AzAAj0H8FEoWA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Dmitry. I will remove this.

On 9/2/20 4:33 AM, Dmitry Osipenko wrote:
> 31.08.2020 07:40, JC Kuo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> +	err =3D devm_request_threaded_irq(&pdev->dev, tegra->padctl_irq,
>> +		NULL,
>> +		tegra_xusb_padctl_irq,
>> +		IRQF_ONESHOT |
>=20
>> +		IRQF_TRIGGER_HIGH,
>=20
> Specifying trigger levels is meaningless for interrupts coming from a
> device-tree because DT levels always take precedence.
>=20
