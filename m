Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F8828BBDB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389938AbgJLP3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388984AbgJLP3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:29:12 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7072C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 08:29:10 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e23so10480280wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KoXohj2jp2K4/+dv4SfjlpJpBX/PPhJeM1REhLiZnoQ=;
        b=F+/oI/q5TM1/S6wyB5NSXYk6MdwUCXutPzQ0JmTJIhw4NAIxIEmA7o6vRHYF3heZro
         CexbpmGYRqEi8DV7yqU/BJR2lNko3gQ0A9LFPe8NqxKqtFEexzw0YQUL2SnI3WLQP5mZ
         pG8nNM2AbxaguSD5o/k9BidcLSA4fzysgFn+fGjpfuvJQT0nXtxkvrSqfp1GIWJAM6z7
         b6ttuLIXi5RW9We6R2Z+02FzarKzm/jSsdbCXHjm3MeCZu2Cv6f1hkf9C3D6J1jinRYM
         GI1AxxtJAhiixwo005bs5ejmSu29SSmLECTjgR1z0uEuyxM6cQe/snaU8Xto4gj81/lN
         LLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KoXohj2jp2K4/+dv4SfjlpJpBX/PPhJeM1REhLiZnoQ=;
        b=BH48MeZ9SUQ9CZdx43oc81sA81ReNsyM2qxQNtIKeDerXJrtvzHVqi2H4TvFYPRVxS
         M1m9uvt5KwhS3jjCR66EcQ4lC5NuhQdL9rvsrQQCR1QLjb9Ba/RuQyXGInto6JIKb3dC
         XIhBHk1ydibmmVlQwP48FCjs194IZYCO7sTgWdRoqr1urDgnRXuC5ObJS07BAc621TCZ
         tpMID02r4WsceWeYcdDUxvhjhUPbbDChxC/ihMdFUyJmS88M+8Bly9hFz0Ylz9zP04bh
         BsfKtKwNA7pA+3yYJ2Vhk3ABdf7yF0Fp07z3uCNwmTZi9FKBghez3wRsKR1RuzBiNt9H
         MSFg==
X-Gm-Message-State: AOAM5318SWZjitzaiIqxWWdfm8mxAnhhWlEhUO/UKgC+W4kN6Z4n2nY5
        vC2zM3ju8m9/W8gYUpMYZtt3pu6Fr6O2oWnF
X-Google-Smtp-Source: ABdhPJyyBxwThzynIHXf/CkMTN1M/sJnhUWgASHTfkASYtNU4OqIAVso9iyixeqPgUumo+ig3h5FyQ==
X-Received: by 2002:a1c:9854:: with SMTP id a81mr11149885wme.72.1602516549071;
        Mon, 12 Oct 2020 08:29:09 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:35de:80a8:f551:6aa3? ([2a01:e35:2ec0:82b0:35de:80a8:f551:6aa3])
        by smtp.gmail.com with ESMTPSA id c185sm2451212wma.44.2020.10.12.08.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 08:29:08 -0700 (PDT)
Subject: Re: [PATCH 15/18] dt-bindings: usb: meson-g12a-usb: Discard FL-adj
 property
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Roger Quadros <rogerq@ti.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
 <20201010224121.12672-16-Sergey.Semin@baikalelectronics.ru>
 <329129ac-ff44-4928-bca4-805297a8c456@baylibre.com>
 <20201012142201.7fr2n5xwvei23yog@mobilestation>
 <f6e38330-146c-eb7c-5a99-7e156454e90b@baylibre.com>
 <20201012151326.peu4yq6fhmi5utnb@mobilestation>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <8e026a39-53e3-3cbc-cd52-e3dbc9d5c20f@baylibre.com>
Date:   Mon, 12 Oct 2020 17:29:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012151326.peu4yq6fhmi5utnb@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2020 17:13, Serge Semin wrote:
> On Mon, Oct 12, 2020 at 05:01:43PM +0200, Neil Armstrong wrote:
>> Hi,
>>
>> On 12/10/2020 16:22, Serge Semin wrote:
>>> On Mon, Oct 12, 2020 at 09:54:25AM +0200, Neil Armstrong wrote:
>>>> Hi,
>>>>
>>>> On 11/10/2020 00:41, Serge Semin wrote:
>>>>> An empty snps,quirk-frame-length-adjustment won't cause any change
>>>>> performed by the driver. Moreover the DT schema validation will fail,
>>>>> since it expects the property being assigned with some value. So just
>>>>> discard the property declaration then from the example.
>>>>>
>>>>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>>>>>
>>>>> ---
>>>>>
>>>>> Note the same problem is in the DT source file
>>>>> arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi .
>>>>> ---
>>>>>  .../devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml     | 1 -
>>>>>  1 file changed, 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
>>>>> index 5b04a7dfa018..88184d7e26cc 100644
>>>>> --- a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
>>>>> +++ b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
>>>>> @@ -209,6 +209,5 @@ examples:
>>>>>                interrupts = <30>;
>>>>>                dr_mode = "host";
>>>>>                snps,dis_u2_susphy_quirk;
>>>>> -              snps,quirk-frame-length-adjustment;
>>>>>            };
>>>>>      };
>>>>>
>>>>
>>>
>>>> Thanks for reporting this, actually the fladj must be 0x20 on this hw,
>>>> but we do set this on the PHY side, so we can let the dwc3 side 0 here.
>>>
>>> I can convert this patch to initializing the "snps,quirk-frame-length-adjustment"
>>> property with 0x20 value instead. Since most likely I'll have to send a v2/v3/etc
>>> of this patchset, that modification won't be too much work to do. What do you think?
>>
> 
>> Yes, do this please,
> 
> Ok. Shall I preserve your Acked-by tag in the new patch or you'd prefer to
> review it first?

Yes, preserve it,
Thanks,
Neil

>> anyway it's only an example so it's ok.
> 
> Actually examples are also validated by "make dt_binding_check". That's why I
> had to fix the amlogic,meson-g12a-usb-ctrl example for at least so the new
> snps,dwc3.yaml DT schema wouldn't break that full DT bindings
> validation procedure.)
> 
> -Sergey
> 
>>
>>>
>>> Anyway please note, that I've fixed the improper property usage in the DT schema
>>> example only. "snps,quirk-frame-length-adjustment" defined as boolean still
>>> persists in the DTS file: arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi .
>>> So if you ever try to validate that dts file with "make dtbs_check" scenario, it
>>> will fail.
>>
>> Yes, I'll push a fix to pass the dtbs_check when this is merged.
>>
>> Thanks,
>> Neil
>>
>>>
>>> -Sergey
>>>
>>>>
>>>> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>
>>>> Neil
>>>>
>>

