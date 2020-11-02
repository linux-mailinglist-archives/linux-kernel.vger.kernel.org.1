Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFCC2A2B41
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgKBNLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgKBNLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:11:37 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65940C0617A6;
        Mon,  2 Nov 2020 05:11:37 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id oq3so16957155ejb.7;
        Mon, 02 Nov 2020 05:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/RkXN4OFo+W9SVpTQ7rTjG1Jc2YrNCnjrHWcZHJNoak=;
        b=HeiW3q+D4q/dUP81vDVW90V67wNYM2TbE9aabOW4o/LsEfTM9Glle15KCmRWW3H4cf
         PkJYIFzrBXbkWMhc4vSiPicfo0JkfxceUEWyFU/c4hwiLryOCAeD+SG9IFIyhEae5Jad
         FYGKgCk8L6SH7fNx8QYiu0DsX4wKm6YMC1pj702LxmIHhni2kLBlucJjxQZqdL6M1jVI
         F5CJi3GEdhyU09s5tebgmQuWFlGyUm6Pac4BYisf2yQScTOcys6cQflmkrpEmcs610lH
         Gz1EQeiC8A66G7zhKl7HBz2JfOVle+arsrAW7pM/wOrkYPkRRl12LaNHdQlPzTAlPYUF
         0SJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/RkXN4OFo+W9SVpTQ7rTjG1Jc2YrNCnjrHWcZHJNoak=;
        b=TcyaX+LyRqSsZf8BrX807sihySt8kQZSE9M1jyLKz/xq/VjS3YxMIAVdKsdq+JFSUB
         qcuGfFapcVAARh51IYxEUlVCEFbVDeJEWT8e0jyo5hWlFW/o4osdKRMx32h5qjLCQNhj
         DkPZ178j/X16K+tdy8U2IEPVsaWeGQOJ53EkaMCAm7AxAqfmj4woJFnyxVTQ/NhdbAMx
         kkBOT87krS+F6X8mLq6Zz26cd7IxXFJaYS+PYWefFMo9hT1Gqwh3itE9g0NDrbbpiOnI
         wNJRcdiI133RpPBd29Qq0RzpoCJGimD8VlCctQkxf2yHkGnVKknAjjtOYmW6HtCfvEJ5
         h+8A==
X-Gm-Message-State: AOAM530i+l/2ABDrX1gw1b1R9P+Bgl+PvKLcwjatZK8pyxD2P8TyURZh
        OE1xuponT/3VLQ8TYqaCtF8=
X-Google-Smtp-Source: ABdhPJwKgliX46cwTLehe50qr8MXMOVehZnw1Fh0wN0HrPpMeF9lyDdEJlH9ePlsXo6WCylsBCpiWw==
X-Received: by 2002:a17:907:2089:: with SMTP id pv9mr1845201ejb.34.1604322696126;
        Mon, 02 Nov 2020 05:11:36 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b8sm7282438ejx.11.2020.11.02.05.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 05:11:35 -0800 (PST)
Subject: Re: [PATCH v13 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308,
 RK2928 and others
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Yifeng <yifeng.zhao@rock-chips.com>, richard@nod.at,
        vigneshr@ti.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
        heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20201028095326.15562-1-yifeng.zhao@rock-chips.com>
 <20201028095326.15562-3-yifeng.zhao@rock-chips.com>
 <a8a7875b-f08b-62c6-a630-245687e0df3b@gmail.com>
 <e02e13a0-769d-6b73-c87e-5b7d75fd4254@rock-chips.com>
 <0b417fc2-3503-9bf6-914d-0f8b38df1914@gmail.com>
 <20201102140725.66e7dcb1@xps13>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <5ad70fa0-05a9-e1e7-32cc-32933ff25ae9@gmail.com>
Date:   Mon, 2 Nov 2020 14:11:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201102140725.66e7dcb1@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/2/20 2:07 PM, Miquel Raynal wrote:
> Hi Johan, Yifeng
> 
> Johan Jonker <jbx6244@gmail.com> wrote on Mon, 2 Nov 2020 13:57:56
> +0100:
> 
>> Hi Yifeng,
>>
>> Don't poke with "ecc->bytes" ones it is set in rk_nfc_ecc_init(). It
>> will not be noted by the MTD frame work or userspace. I think there's
>> currently no way to let the user know that a different ECC must be used.
>> Neither can the user set ECC on the fly.
>>
>> Example R/W flow:
>>
>>         nand_select_target()
>> 	chip->ecc.write_page_raw()
>> 	chip->ecc.write_page()
>>
>> [..]
>>
>> 	chip->ecc.read_page_raw()
>> 	chip->ecc.read_page()
>>         nand_deselect_target()
>>
>> A write/read with:
>>
>> rk_nfc_read_page_hwecc()
>> rk_nfc_write_page_hwecc()
>>
>> or
>>
>> rk_nfc_read_page_raw()
>> rk_nfc_write_page_raw()
>>
>> must end up with the same result. If we can't archive that, then we
>> shouldn't offer RAW mode to the user for now. If Miquel agrees you
>> should just get the driver ready now without these 2 functions and round
>> things up.
> 
> What about just not supporting the BootROM area if it was marked
> "reserved" by the BRom in the DT?

Should we just fill the buffers with '0xff' for boot blocks?

> 
> Raw accessors is really a nice and basic feature that I would like to
> have in every new driver.
> 
> Thanks,
> Miquèl
> 

