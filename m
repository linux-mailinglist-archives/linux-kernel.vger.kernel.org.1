Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3AF2C26E3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbgKXNNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:13:02 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:3898 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387675AbgKXNNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:13:02 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AODCD95000701;
        Tue, 24 Nov 2020 14:12:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=ix/kx7ERmG4i0gfDa9YUOrftv5Xy+RUr3PaZbU4Xkb4=;
 b=DazCYgY32udAr3uRdVPQeBZEdrNhyGnz8SZ0wAUfj48TyKjTwO1l9O9m9DJa3ewF5cDz
 MG2r/w8PDeLEWuqddpxwUHSaIARuZY9oNdvLl83IVKsS2KX2Adfx0anPQ7CCHLJabmml
 ULDx7B4+7kx8jBZexwBMwzYLrK7TBCgEzB01zarSGWSfZH7XoloaNmbMu0HLrewtMnY3
 O4aI7jknWh1hPFS3TBbQW0rS0fNg73U8eSfy2zsZtYfKhuLS7/YpzirQr3A1eiy6/Pk6
 1LW4Z5Bo6BFLSjQ14YTl7EBJXEmJQ2597bpXnaTzZqTocU8OgrNW0Wt59BbiBXQRNu// bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34y05h7hvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 14:12:53 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 806C4100038;
        Tue, 24 Nov 2020 14:12:52 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 55DBE26F739;
        Tue, 24 Nov 2020 14:12:52 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Nov
 2020 14:12:51 +0100
Subject: Re: ARM.STM32 - Mainline stable kernel 5.9.10 hangs indefinitely on a
 STM32MP157A-DK1 board.
To:     Manuel Reis <mluis.reis@gmail.com>, <mcoquelin.stm32@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <linux-kernel@vger.kernel.org>,
        Michael Opdenacker <michael.opdenacker@bootlin.com>
References: <ZZWAKQ.K8IZKPD4L3Z9@gmail.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <4d92399d-db02-a220-fc8e-889405b85ddf@st.com>
Date:   Tue, 24 Nov 2020 14:11:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ZZWAKQ.K8IZKPD4L3Z9@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_04:2020-11-24,2020-11-24 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manuel

On 11/24/20 1:50 PM, Manuel Reis wrote:
> To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>
> To:     Alexandre Torgue <alexandre.torgue@st.com>
> Cc:    linux-kernel@vger.kernel.org
> CC:    Michael Opdenacker <michael.opdenacker@bootlin.com>
> 
> Hi there,
> 
> Mainline stable kernel 5.9.10 hangs indefinitely on a STM32MP157A-DK1 
> Discovery Kit board.
> 
> Built plain vanilla 5.9.10 stable kernel for multi_v7_defconfig (set 
> compression to XZ) using arm-linux-gnueabi-gcc (Ubuntu 10.2.0-8ubuntu1) 
> 10.2.0.
> 
> Downloaded it to the board memory via tftp running U-Boot v2020.07. 
> After boot, kernel initiates and prints several messages until it hangs on:
> 
> [ 2.692879] stpmic1 1-0033: PMIC Chip Version: 0x10
> [ 2.704158] vddcore: supplied by regulator-dummy
> [ 2.710304] vdd_ddr: supplied by regulator-dummy
> [ 2.716414] vdd: supplied by regulator-dummy
> [ 2.722355] v3v3: supplied by regulator-dummy
> [ 2.728033] v1v8_audio: supplied by v3v3
> [ 2.734287] v3v3_hdmi: supplied by regulator-dummy
> [ 2.741035] vtt_ddr: supplied by vdd_ddr
> [ 2.743833] vdd_usb: supplied by regulator-dummy
> [ 2.751332] vdda: supplied by regulator-dummy
> [ 2.757371] v1v2_hdmi: supplied by v3v3
> 
> No other information or indication is given, even though I added kernel 
> debugging features such as the ones in "Kernel hacking ->Debug Oops, 
> Lockups and Hangs".
> 
> Any help would be appreciated. Let me know if I can provide any further 
> information.
> 

It has been introduced by commit aea6cb99703e ("regulator: resolve 
supply after creating regulator") and should fixed by this one:

cf1ad559a20d ("regulator: defer probe when trying to get voltage from 
unresolved supply").

Should be taken in stable tree.

regards
alex


> Cheers,
> Manuel
> 
