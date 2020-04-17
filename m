Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3701ADB89
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 12:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgDQKrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 06:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729301AbgDQKri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:47:38 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB38C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:47:38 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id s2so857460vsm.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KOr2xEv1FajZpJMpnpT2EkvfA+ozb8YBRpAuPzf52to=;
        b=m/2ouJ9onl9gQEXlIUiHutlQU8YV2Vecl6So5758kFQXjvFT6WjtfjJ8JP9gE7gDGk
         GFHTKdDYJqBfkMPeojSdqGMKy9hay1LGtgn4MOaxHRdDvUaABnRH1ix/rW6nxzOBCfN3
         IFJZ7g2ZQmdjc2S2HtdIN82y2N4k6BsO6sYrp02jeHJJoTU88Ij4ljri5GQHKHMUPqof
         uRCKn3j6UeCTS4vXeJu6ET185OcbdbqB29vBPTKeHuv/kytzfaoGLqO+R+dAqqcFyKgO
         muVsKiUDVUubBhQDnU5ZAzJaYySjxTNP83RUvLEpbD96ZdWHeiLNuCD/GPWx9NB+vNBj
         PKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=KOr2xEv1FajZpJMpnpT2EkvfA+ozb8YBRpAuPzf52to=;
        b=Wgvf3SL5OGSsAjwjxWVU9Ml2GnZJItL4sqGx1g+oLZrNuJFaTfxVyO60Jkb1GQ6hhe
         LVc1uPiES7D4rvy977+OFnM9DT40duEPBqnLYMNR/k7oleczrm+6VmrMoykgV1uQYWF2
         qav2MzWwOhdDXUs+5Jc+soPoC9VoHkBRVghFjS6ojbmA2j72in6bGIf2Nphtz6mNFy2r
         M1wks7jJgMhjVoPcCaZlspxAYApGx6t8pCthUAaam4S5tnTvJa+0EqE0cwqIctmhMcf0
         C0D50XD1esjgHTFIIIVNv9bu7s1TUq59O9BmmzKORP99rzQFIA3nwaf3xPSPcYUte92x
         hNOg==
X-Gm-Message-State: AGi0Pub0PA41PhYtzOoC5afACfUxIM4CYIOvAEGxkEyN8NMsBcKw6bjH
        FICPd1zGxQTkXNkYlqvpZ8y83gZUqJSH2TY9cBU=
X-Google-Smtp-Source: APiQypLjurYA2MLMWwkzEdhXS7UkywrQc2vW1sBIJNiRiUgWcpalzVKX4thRgBLZGe0mQ/PZX6DFKpJJt1UlQEooErM=
X-Received: by 2002:a05:6102:737:: with SMTP id u23mr1487346vsg.211.1587120457345;
 Fri, 17 Apr 2020 03:47:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:185a:0:0:0:0:0 with HTTP; Fri, 17 Apr 2020 03:47:36
 -0700 (PDT)
Reply-To: susanwilliam1@citromail.hu
From:   Susan William <mkategrand1@gmail.com>
Date:   Fri, 17 Apr 2020 04:47:36 -0600
Message-ID: <CAJta1RZ9HJP-OPEGCmEAPGHm4MXM_1oeZM+asfkD3EhA6s4e1w@mail.gmail.com>
Subject: =?UTF-8?B?0JTQvtCx0YDQvtC1INGD0YLRgNC+LA==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0JTQvtCx0YDQvtC1INGD0YLRgNC+LA0KDQrCoCDQryDQt9C90LDRjiwg0YfRgtC+INCy0Ysg0LHR
g9C00LXRgtC1INGD0LTQuNCy0LvQtdC90YssINC/0L7Qu9GD0YfQuNCyINGN0YLQviDQv9C40YHR
jNC80L4g0L7RgiDQvNC10L3RjyDRgdC10LPQvtC00L3Rjy4NCtCvINCh0YzRjtC30LXQvSDQo9C4
0LvRjNGP0LwsINGPINGA0LDQsdC+0YLQsNGOINGBINCa0L7RgNC+0LvQtdCy0YHQutC40Lkg0LHQ
sNC90Log0KjQvtGC0LvQsNC90LTQuNC4LA0K0K3RgtC+INC/0LjRgdGM0LzQviDQvtGH0LXQvdGM
INC/0YDQuNCy0LjQu9C10LPQuNGA0L7QstCw0L3QvdC+0LUsINC4INC+0L3QviDRgtGA0LXQsdGD
0LXRgiDQstCw0YjQtdCz0L4g0L3QtdC80LXQtNC70LXQvdC90L7Qs9C+DQrQstC90LjQvNCw0L3Q
uNGPLCDQv9C+0YLQvtC80YMg0YfRgtC+INC80Ysg0L/QvtGC0LXRgNGP0LvQuCDQvtC00L3QvtCz
0L4g0LjQtyDQvdCw0YjQuNGFINC60LvQuNC10L3RgtC+0LIsINC60L7RgtC+0YDRi9C5DQrQvtC6
0LDQt9Cw0LvRgdGPINC40Lcg0LLQsNGI0LXQuSDRgdGC0YDQsNC90YssINCwINGC0LDQutC20LUg
0LjQvNC10LXRgiDRgtCw0LrQvtC1INC20LUg0LjQvNGPINGBINCy0LDQvNC4LCDQuCDRgyDQvdC1
0LPQvg0K0LHRi9C70L4NCtGB0YDQvtGH0L3Ri9C5INC00LXQv9C+0LfQuNGCINCyINC90LDRiNC1
0Lwg0LHQsNC90LrQtSDQtNC+INC10LPQviDRgdC80LXRgNGC0LguDQrQo9GH0LjRgtGL0LLQsNGP
INCy0LDRiNGDINC90LDRhtC40L7QvdCw0LvRjNC90L7RgdGC0Ywg0YEg0L3QsNGI0LjQvCDQv9C+
0LrQvtC50L3Ri9C8INC60LvQuNC10L3RgtC+0LwuDQoNCsKgINCvINGF0L7Rh9GDINC/0YDQtdC0
0YHRgtCw0LLQuNGC0Ywg0LLQsNGBINCx0LDQvdC60YMg0LIg0LrQsNGH0LXRgdGC0LLQtSDQsdC1
0L3QtdGE0LjRhtC40LDRgNCwINC90LDRgdC70LXQtNGB0YLQstC10L3QvdC+0LPQvg0K0YTQvtC9
0LTQsCwg0Lgg0LzRiyDQvtCx0LAg0L/QvtC00LXQu9C40Lwg0Y3RgtC4INGB0YDQtdC00YHRgtCy
0LAgNTAlIDUwJSwg0LrQsNC6INGC0L7Qu9GM0LrQviDQtNC10L3RjNCz0Lgg0LHRg9C00YPRgg0K
0L/QtdGA0LXQstC10LTQtdC90Ysg0L3QsCDQstCw0Ygg0YHRh9C10YIuDQrQryDRgSDQvdC10YLQ
tdGA0L/QtdC90LjQtdC8INC20LTRgyDQstCw0YjQtdCz0L4g0L3QtdC80LXQtNC70LXQvdC90L7Q
s9C+INC+0YLQstC10YLQsC4NCg0K0KEg0YPQstCw0LbQtdC90LjQtdC8LA0KwqAg0KHRjNGO0LfQ
tdC9INCj0LjQu9GM0Y/QvC4NCg==
