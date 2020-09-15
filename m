Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3F026AC12
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgIOSfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:35:51 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45216 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgIOSf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:35:29 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FIZ9UQ123866;
        Tue, 15 Sep 2020 13:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600194909;
        bh=UszCv9uVkM6PK+sqMVwp2CVdUVj7Jk1RWLM5JKbHtRM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tTHNFN4JihS0CL8pNA5AtMiow+W7m0/rEwdt/WutzZFbJxcLQit9bDrECs3eeUD1E
         8/IYTQug8A+EiKRdJGHau64Ae2VfdIwhDixgD8u8OzQ/KiqIY7GI8N2u4kTNYZtQ3l
         Uds6yndxSfcqBFLZeRpGvwKEpx2YS6okpfxIe4k4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08FIZ9jm052646
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 13:35:09 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 13:35:09 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 13:35:09 -0500
Received: from [10.250.38.37] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FIZ9xv013241;
        Tue, 15 Sep 2020 13:35:09 -0500
Subject: Re: [PATCH v2 1/3] dt-bindings: tlv320adcx140: Add GPIO config and
 drive config
To:     Camel Guo <camel.guo@axis.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>
References: <20200911080753.30342-1-camel.guo@axis.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <3ae63976-1e78-df28-9c76-d8f74c733eec@ti.com>
Date:   Tue, 15 Sep 2020 13:35:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911080753.30342-1-camel.guo@axis.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Camel

On 9/11/20 3:07 AM, Camel Guo wrote:
> From: Camel Guo <camelg@axis.com>
>
> Add properties for configuring the General Purpose Input Outputs (GPIO).

s/Outputs/Output

There is only one for the x140

> There are 2 settings for GPIO, configuration and the output drive type.
>
> Signed-off-by: Camel Guo <camelg@axis.com>
> ---
>   .../bindings/sound/tlv320adcx140.yaml         | 44 +++++++++++++++++++
>   1 file changed, 44 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
> index f578f17f3e04..7b0b4554da59 100644
> --- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
> +++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
> @@ -134,6 +134,49 @@ patternProperties:
>          4d - Drive weak low and active high
>          5d - Drive Hi-Z and active high
>   
> +  ti,gpio-config:
> +    description: |
> +       Defines the configuration and output driver for the general purpose

s/driver/drive

You capitalized the General Purpose Input and Output in the commit 
message but kept it lower case here.

Beyond these

Acked-by: Dan Murphy <dmurphy@ti.com>

