Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400C52C00EA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 09:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgKWHyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 02:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgKWHyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 02:54:38 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C60DC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 23:54:38 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so17572931wrc.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 23:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ssyp6RlTZrHQ6t2h57nYO8M/yhZ11G6fNbpH9SLeVPg=;
        b=scnod+G2VIdf6DEHMzS+If3CIQvFEX0hi5tQohy6KL/QnqI0bX54k/LExUaJW+Q3Mh
         Vsg/8Tz+z4HUVh+2AFDV/2R2jD7Ab58/Pw5xiGTzcu47G86wHR6sH+F3BMjzHOu3c0gZ
         zNtweQC3t1Z9Xo+PFlObigvlmQb7K6lZWTo/c3AeQDM3Pkp9DNypSzvNYFlgnK/IiENM
         oqlajmv0zJI9Jw0orTX5WupaSKmpAy2GgNvYDZmGB82kixax5cF7QTVvUq4BYMgE6H/X
         vBTaJwE2RfYZ1zx2jMXcLMobKS0a51G2fJd6Yoo104hNvwLin3RqRFFYMvFmtrTQeSes
         pg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ssyp6RlTZrHQ6t2h57nYO8M/yhZ11G6fNbpH9SLeVPg=;
        b=ru6LURGxEhOG8wzEWbWxgquQY2SbbUsGMtsX3b6Dqfdt/MNchL8ISgzAh/4UHD5yvq
         7d4YLobHAhaTarEBZRqxDsFYcktmZU/jauQtMyra/by5uJQxRl9qCwIfeLjms9S+/7+G
         FBHrPuQI5QF8TXmlAoT4OtS+C/pWkq1FN2oojPYVsd0Qij8Gd0LIUfvzVs2N5n8b1aLI
         hphL7Yue1RKu4ve7VlAEd4WWm1BG3rrJFXjKnWSk2qtthOml34vmNlHfUnqty8/7EF3r
         7X2CiVeCyo5j1a436Zb6mnL/6Zk+D6AL/fSvrXIdkEhmb4Z+qeJZlUdoBLZR8uzHF4er
         xvfQ==
X-Gm-Message-State: AOAM533NeURy3kmQCzW/IxcoEslvoDl8XVQqnhQ/0mo6hkDWhyRo9LOw
        RnIzEUhnytPzqcr9E4IXdvL/Xw==
X-Google-Smtp-Source: ABdhPJyYcd5uvtAn0PbofoEM4D/cJPzeClSAtcP9mVc70gCsTQI1p7IVw5TXOFwa5af3X+hmsIcydA==
X-Received: by 2002:a5d:544e:: with SMTP id w14mr9317272wrv.227.1606118077109;
        Sun, 22 Nov 2020 23:54:37 -0800 (PST)
Received: from ?IPv6:2a01:e35:2ec0:82b0:9541:d2fd:3a68:67ae? ([2a01:e35:2ec0:82b0:9541:d2fd:3a68:67ae])
        by smtp.gmail.com with ESMTPSA id m3sm19406323wrv.6.2020.11.22.23.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 23:54:36 -0800 (PST)
Subject: Re: [PATCH 3/4] arm64: dts: meson-axg: add PCIe nodes
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20201120153229.3920123-1-narmstrong@baylibre.com>
 <20201120153229.3920123-4-narmstrong@baylibre.com>
 <CAFBinCDLF2bL6sQFBsNTNZV5i9u+KW01O3SqbR=riRru5d8zRQ@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <874f476d-3927-8944-14b7-0abe0b798a53@baylibre.com>
Date:   Mon, 23 Nov 2020 08:54:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCDLF2bL6sQFBsNTNZV5i9u+KW01O3SqbR=riRru5d8zRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2020 23:14, Martin Blumenstingl wrote:
> Hi Neil,
> 
> (I have to admit that for me the PCI(e) bindings are very complex, so
> I may be mixing up things. I am still sending this review mail because
> "you're doing it different than in meson-g12-common.dtsi")
> 
> On Fri, Nov 20, 2020 at 4:33 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> [...]
>> +               pcieA: pcie@f9800000 {
>> +                       compatible = "amlogic,axg-pcie", "snps,dw-pcie";
>> +                       reg = <0x0 0xf9800000 0x0 0x400000>,
>> +                             <0x0 0xff646000 0x0 0x2000>,
>> +                             <0x0 0xf9f00000 0x0 0x100000>;
>> +                       reg-names = "elbi", "cfg", "config";
>> +                       interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
>> +                       #interrupt-cells = <1>;
>> +                       interrupt-map-mask = <0 0 0 0>;
>> +                       interrupt-map = <0 0 0 0 &gic GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
>> +                       bus-range = <0x0 0xff>;
>> +                       #address-cells = <3>;
>> +                       #size-cells = <2>;
>> +                       device_type = "pci";
>> +                       ranges = <0x82000000 0 0xf9c00000 0x0 0xf9c00000 0 0x00300000>;
> only PCI IO space here, no PCI MEM space?


I know, I tried to add IO & MEM space like g12, but it doesn't work.


> 
> [...]
>> +               pcieB: pcie@fa000000 {
>> +                       compatible = "amlogic,axg-pcie", "snps,dw-pcie";
>> +                       reg = <0x0 0xfa000000 0x0 0x400000>,
>> +                             <0x0 0xff648000 0x0 0x2000>,
>> +                             <0x0 0xfa400000 0x0 0x100000>;
>> +                       reg-names = "elbi", "cfg", "config";
>> +                       interrupts = <GIC_SPI 167 IRQ_TYPE_EDGE_RISING>;
>> +                       #interrupt-cells = <1>;
>> +                       interrupt-map-mask = <0 0 0 0>;
>> +                       interrupt-map = <0 0 0 0 &gic GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
>> +                       bus-range = <0x0 0xff>;
>> +                       #address-cells = <3>;
>> +                       #size-cells = <2>;
>> +                       device_type = "pci";
>> +                       ranges = <0x82000000 0 0xfa500000 0x0 0xfa500000 0 0x00300000>;
> same as above: only PCI IO space here, no PCI MEM space?

Same,

I suspect they configured the two instance differently.
Anyway I managed to used an NVMe and a PCIe XHCI controller on each port successfully.

Since I'm a PCIe nOOb, I don't know...

Neil

> 
> 
> Best regards,
> Martin
> 

