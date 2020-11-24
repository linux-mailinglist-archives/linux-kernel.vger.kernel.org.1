Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF302C295A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388856AbgKXOWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387688AbgKXOWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:22:44 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59839C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:22:44 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 23so22471272wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=H6M9KkxfOgGnU3wVbw+NKs4jfgioXI1a9cDe+UiHovk=;
        b=VPOU5qFaMgOz/6GSRqrKhJn9X9LT68yPnE0Xz7W6NpZ3wGZlOLMvA3/4kyqhWRz3Qc
         NfYqP5XuCQ7Z/ggIQIdvvgdfksQrWF+MB5p3xjGHL/1otoGSqmE4ThVV0uyZfIopRdE8
         r+PumKwrzc81lLojGw5ikBc3SVNXW0qNIJK/PvYceDmOGLfCJKHG511S9GFhVDbRA98c
         /ZX13uliAXDjb4qpg7LGhqC8NVJg4eQzCeKfXRZFK9BiwbqXcMoE5jZEpyi00Q9KRGQB
         B2Lh5KqPGeFI/DqKif+2QB7IC7gqPa4+NdF6CQ2fxlH7cNe7CWIJjVATkOt96gYFIJN4
         QJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=H6M9KkxfOgGnU3wVbw+NKs4jfgioXI1a9cDe+UiHovk=;
        b=am4SBRjiRrJJw0JjM7irvwvcB+mPNeeWa/6YGo+Kmw7gc4h7YAY/rA5hxZrMqKhM4S
         3QnkTfqqMHObWjEBvWSsphftF/jnY4z2VzGWr//jRj60C8qqmB8+Ys9vItlacrzhMqSu
         Gjy5AJlRf89tdXXqJFbvADYFCeeHictDffKxDbSoowQyTCjpySPu/8nYssLdXZYYB+Mj
         yneuGxht5E5vqiElzewUJ4eCAhzv1rrDEbeNVhzglvAPx2eSb5h/9au5ZTTOSDr2fMDv
         AZviiHTBFMFlz5kGpFFyTxLZO5/lRI4uoUNunOacZuI+aQ+xNAXfw1TvlQRU8ratKyc9
         m06g==
X-Gm-Message-State: AOAM531178p6YIRhpZa6rLON3KCc5hV8IkLYVUu5EhKRFTT8T0g4u2dF
        CVYkwkaoaNnbHVzZw4GL0Ww=
X-Google-Smtp-Source: ABdhPJyRkwma0tTeFnZUL90qJ6ulNaU9n8drB9d1XXH2PM679D+2T/PNEjwaEXH5q9uD3u6gXMkvGA==
X-Received: by 2002:adf:dec1:: with SMTP id i1mr5487258wrn.129.1606227763128;
        Tue, 24 Nov 2020 06:22:43 -0800 (PST)
Received: from [192.168.1.12] (a89-155-154-90.cpe.netcabo.pt. [89.155.154.90])
        by smtp.gmail.com with ESMTPSA id 9sm5657413wmo.34.2020.11.24.06.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 06:22:42 -0800 (PST)
Date:   Tue, 24 Nov 2020 14:22:35 +0000
From:   Manuel Reis <mluis.reis@gmail.com>
Subject: Re: ARM.STM32 - Mainline stable kernel 5.9.10 hangs indefinitely on
 =?UTF-8?Q?a=0D=0A?= STM32MP157A-DK1 board.
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     mcoquelin.stm32@gmail.com,
        =?iso-8859-2?q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>,
        linux-kernel@vger.kernel.org,
        Michael Opdenacker <michael.opdenacker@bootlin.com>
Message-Id: <N91BKQ.LV5OVN39B5VU2@gmail.com>
In-Reply-To: <4d92399d-db02-a220-fc8e-889405b85ddf@st.com>
References: <ZZWAKQ.K8IZKPD4L3Z9@gmail.com>
        <4d92399d-db02-a220-fc8e-889405b85ddf@st.com>
X-Mailer: geary/3.38.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much Alex,

Tried, tested and verified. Got it working with stable/master 
(v5.10-rc5).

Regards,
Manuel

On ter, 24 nov, 2020 at 14:11, Alexandre Torgue 
<alexandre.torgue@st.com> wrote:
> Hi Manuel
> 
> On 11/24/20 1:50 PM, Manuel Reis wrote:
>> To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> To:     Alexandre Torgue <alexandre.torgue@st.com>
>> Cc:    linux-kernel@vger.kernel.org
>> CC:    Michael Opdenacker <michael.opdenacker@bootlin.com>
>> 
>> Hi there,
>> 
>> Mainline stable kernel 5.9.10 hangs indefinitely on a 
>> STM32MP157A-DK1 Discovery Kit board.
>> 
>> Built plain vanilla 5.9.10 stable kernel for multi_v7_defconfig (set 
>> compression to XZ) using arm-linux-gnueabi-gcc (Ubuntu 
>> 10.2.0-8ubuntu1) 10.2.0.
>> 
>> Downloaded it to the board memory via tftp running U-Boot v2020.07. 
>> After boot, kernel initiates and prints several messages until it 
>> hangs on:
>> 
>> [ 2.692879] stpmic1 1-0033: PMIC Chip Version: 0x10
>> [ 2.704158] vddcore: supplied by regulator-dummy
>> [ 2.710304] vdd_ddr: supplied by regulator-dummy
>> [ 2.716414] vdd: supplied by regulator-dummy
>> [ 2.722355] v3v3: supplied by regulator-dummy
>> [ 2.728033] v1v8_audio: supplied by v3v3
>> [ 2.734287] v3v3_hdmi: supplied by regulator-dummy
>> [ 2.741035] vtt_ddr: supplied by vdd_ddr
>> [ 2.743833] vdd_usb: supplied by regulator-dummy
>> [ 2.751332] vdda: supplied by regulator-dummy
>> [ 2.757371] v1v2_hdmi: supplied by v3v3
>> 
>> No other information or indication is given, even though I added 
>> kernel debugging features such as the ones in "Kernel hacking 
>> ->Debug Oops, Lockups and Hangs".
>> 
>> Any help would be appreciated. Let me know if I can provide any 
>> further information.
>> 
> 
> It has been introduced by commit aea6cb99703e ("regulator: resolve 
> supply after creating regulator") and should fixed by this one:
> 
> cf1ad559a20d ("regulator: defer probe when trying to get voltage from 
> unresolved supply").
> 
> Should be taken in stable tree.
> 
> regards
> alex
> 
> 
>> Cheers,
>> Manuel
>> 


