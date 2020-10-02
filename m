Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FB0281AC7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbgJBSXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387602AbgJBSXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:23:50 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFA0C0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 11:23:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so1842730pfd.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 11:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=dLt24jZaXpKoPfrpAQsTNoIii0wynpAMSCaMsOeaq/8=;
        b=Irswezj4+vTXLAGewGL2mUj0idT6ulXfb+ykyqeUCPq7sCA/aOBGuVzlRafWNEi1jL
         AhctfN4YLXT5o/AMzF/42Yfz0u+HXCrQXjM88bUXqvzqj1h9VeiXdpE8+bqcZhx3iPPn
         kAA4w46fJBE+Fs7Hylbxe7OcSDx7sK1aY6d1qQqcE5ytSZh7puRMFSPpeH5pIDQS1nbY
         VlTbvf49Tj53TuKeIrKX3gE3z2V8PC3f1qFbu6VtkKJUHqojbBLTWqxWmC/OFOuFKapy
         HIHpj6z5OcmWohPx20bCjgXy2dCC9WrNupkThuKx8lVmTPxHehGBSv6Dp5wpPoAT+cFQ
         5Upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dLt24jZaXpKoPfrpAQsTNoIii0wynpAMSCaMsOeaq/8=;
        b=djJAWQaNvQgRjaLWItk2tWwxllSEeFvSuI//MUIvVjYEIz0STU0AUUgIG0tJn1km1M
         flRDWLyD7p0a42S6XBz/Upb5H47XIBIkvmepXXqzydMTrWp0oWDN65OpRDI5B5TQS4yj
         YWJTZkAOjNL9Cxlk+pHX6KLrWXLMa5snnja2goIi4CefoVfB14HyaXougYn+GvJ78jcz
         yO5s00SRNppvv9jYtgQw7UApm54kIcmM9sR2Z8KGm12PdNRfVgM5Fc4IAhLsqY3/QtcN
         7m8eEgMGB4tJKeT18veHXl5jWt9dLilsMUOrwwbck8NgbaJp/3uE2POvegvmW5LcygEo
         nl+A==
X-Gm-Message-State: AOAM531ArW1KD1yK7PdPFO4gp2q++CHGAtVzWaFdkV6B1LlO8Dg5aKJj
        HNe/PRsEeqstcSn0FxuwTW+W/Q==
X-Google-Smtp-Source: ABdhPJw+m163+8+A3NNIguhVHp83jAAmQeDChZRqJPzFkbCuCqkvLTCPyC93EbyZCnoE8aNRIPdUWg==
X-Received: by 2002:a63:30b:: with SMTP id 11mr1533550pgd.253.1601663027882;
        Fri, 02 Oct 2020 11:23:47 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id e10sm2385564pgb.45.2020.10.02.11.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 11:23:47 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, kishon@ti.com,
        balbi@kernel.org, martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 0/5] usb: dwc-meson-g12a: Add support for USB on S400 board
In-Reply-To: <30e2c174-c94b-f42a-1dd4-ae05c317d618@baylibre.com>
References: <20200917065949.3476-1-narmstrong@baylibre.com> <30e2c174-c94b-f42a-1dd4-ae05c317d618@baylibre.com>
Date:   Fri, 02 Oct 2020 11:23:46 -0700
Message-ID: <7hpn60mqq5.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Hi Kevin,
>
> On 17/09/2020 08:59, Neil Armstrong wrote:
>> The Amlogic AXG is close to the GXL Glue but with a single OTG PHY.
>> 
>> It needs the same init sequence as GXL & GXM, but it seems it doesn't need
>> the host disconnect bit.
>> 
>> The Glue driver reuses the already implemented GXL & GXM work.
>> 
>> The USB2 PHY driver needs a slight tweak to keep the OTG detection working.
>> 
>> Changes since v1 at [1]:
>> - s/close from/close to/g
>> - collected review tags
>> - added small comment about phy management in patch 3
>> - removed status = "okay" in patch 4
>> - removed invalid phy-supply of phy1 in patch 5
>> 
>> [1] http://lore.kernel.org/r/20200909160409.8678-1-narmstrong@baylibre.com
>> 
>> Neil Armstrong (5):
>>   phy: amlogic: phy-meson-gxl-usb2: keep ID pull-up even in Host mode
>>   dt-bindings: usb: amlogic,meson-g12a-usb-ctrl: add the Amlogic AXG
>>     Families USB Glue Bindings
>>   usb: dwc-meson-g12a: Add support for USB on AXG SoCs
>>   arm64: dts: meson-axg: add USB nodes
>>   arm64: dts: meson-axg-s400: enable USB OTG
>
> Can you pick the DT patches ?

Yes, queued up.

Since we're already at -rc7, this may not make it until v5.11.

Kevin
