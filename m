Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F1B2F1924
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbhAKPF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbhAKPFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:05:55 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47317C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 07:05:15 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id a109so17179591otc.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 07:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=oa0p0DhErBrpAbLIv42ZXC6IJM5QBf3C2Lwq5a8P5p4=;
        b=VBAKyqvrBCKl+STzHzJSAcHB89oW5qkmMVz9xY7V4LSZNHg+kP+w6UgSWbRwtySuDE
         dEV5hmcpKTMFmsGnHRKOIlXXniIYV9G94WtKEcx+64mqU99F7qP24QoklSvQWBeRUTh5
         sUwtElgOr/QRU+EXeKSvW/J9BVRlo1olxbz338gz+0VQy53rpShBjAelivC/NqV3ZXXY
         eyebdEO+0auwpJUsn+uVzcBBNgXs0RM2XHeEd67bVqa1WUEgjr7Xyam/3jTlIQtNUuRa
         CNU0ZVw917MlNq9TlIuWki1//Zg7OKWzsKyIyLuR73o5vYxRdGQ941+EP44f96LWSGR/
         lr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=oa0p0DhErBrpAbLIv42ZXC6IJM5QBf3C2Lwq5a8P5p4=;
        b=IGKj5amCn5uf95ldKVNm13mvNQy7QNCNn2WePsV96SH5Q+skoiW1O/3DlnHmDOXOCX
         gwXN/OfSyNaNJIeprgHtzIb/DWa+BL+HueVq7jQMoasLpC+neXotYBVib++Ka2rmrNR/
         vVCk2YnbgyXf4gi1GEqDyAXySOpNinAI+7fpueGZBXSvgD7l8nucxEd/Lo1rfgpYscB0
         4B2mWOVa9u0LtfqyuKbL8YY8SYygfUHMxiv4KdnpuMvgMvW8nHVnZd14YT9cTqirot6v
         QG4A7t1JIrZkY1BFhpL4RCrZXiYnbQGHSykzTX85CxaY5Og4+f5oEkPh8Tfs6JHNMWE6
         YzhA==
X-Gm-Message-State: AOAM532m5iAZ79KoWX3iYT1lFiRZu1NN70TQk7RHU9dREqRBzUIV8epy
        pGXOE7rk0o6oIJ9+Ne8feuA5peOd6VkdvE7YmOs=
X-Google-Smtp-Source: ABdhPJxPkJxMAp09akFJTCU/wbHdIxJKa5dfogJUOGetqpzr5Emy5HlYJzOmgCNbF4vLY7G455OqRa5ZJfPeUhRwNKc=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr11723705ots.251.1610377514630;
 Mon, 11 Jan 2021 07:05:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:a6c2:0:0:0:0:0 with HTTP; Mon, 11 Jan 2021 07:05:14
 -0800 (PST)
Reply-To: johnpeter.esq@gmail.com
From:   "Hon. Advocate John Peter  Chambers" <johnpeter.esq@gmail.com>
Date:   Mon, 11 Jan 2021 15:05:14 +0000
Message-ID: <CAMuacWcK5xxcnL2LXH5hW9kE4gmpvcjsqz2SWSKk=Yy=kWg7cA@mail.gmail.com>
Subject: =?UTF-8?B?0K8g0YHQstGP0LfRi9Cy0LDRjtGB0Ywg0YEg0LLQsNC80Lgg0LjQty3Qt9CwINC/0L7Qug==?=
        =?UTF-8?B?0L7QudC90L7Qs9C+INC00L7QutGC0L7RgNCwINCn0LDQvdCz0LAg0KPQvtC70LvQtdGB0LAsINC60L4=?=
        =?UTF-8?B?0YLQvtGA0YvQuSDRgdC60L7QvdGH0LDQu9GB0Y8g0LjQty3Qt9CwIChDT1ZJRC0xOSk=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0K8g0YHQstGP0LfRi9Cy0LDRjtGB0Ywg0YEg0LLQsNC80Lgg0LjQty3Qt9CwINC/0L7QutC+0LnQ
vdC+0LPQviDQtNC+0LrRgtC+0YDQsCDQp9Cw0L3Qs9CwINCj0L7Qu9C70LXRgdCwLCDQutC+0YLQ
vtGA0YvQuQ0K0YHQutC+0L3Rh9Cw0LvRgdGPINC40Lct0LfQsCAoQ09WSUQtMTkpDQoNCtCf0YDQ
uNCy0LXRgiwg0LzQtdC90Y8g0LfQvtCy0YPRgiDQtNC+0YHRgtC+0L/QvtGH0YLQtdC90L3Ri9C5
INCU0LbQvtC9INCf0LjRgtC10YAsINC4INGPINC30LDRidC40YLQvdC40Log0L/QvtC60L7QudC9
0L7Qs9C+DQrQtNC+0LrRgtC+0YDQsCDQp9Cw0L3Qs9CwINCj0L7Qu9C70LXRgdCwLCDQutC+0YLQ
vtGA0YvQuSDRjyDQvtGC0L/RgNCw0LLQuNC7INCy0LDQvCDRjdGC0L4g0L/QuNGB0YzQvNC+INC8
0LXRgdGP0YYg0L3QsNC30LDQtCwNCtC90L4g0Y8g0L3QtSDRg9Cy0LXRgNC10L0sINGH0YLQviDQ
stGLINC10LPQviDQv9C+0LvRg9GH0LjQu9C4LCDQv9C+0YLQvtC80YMg0YfRgtC+INGPINC90LUg
0YHQu9GL0YjQsNC7INC+0YIg0LLQsNGBLA0KDQrQmNC90YTQvtGA0LzQsNGG0LjRjyDQviDQutC+
0LzQv9Cw0L3QuNC4INC/0L7Qt9C00L3QviDRg9C80LXRgNGI0LXQs9C+INC60LvQuNC10L3RgtCw
Lg0K0JQt0YAg0KfQsNC9INCj0L7Qu9C70LXRgTsNCtCn0LDRgNC80LDQvSDQuNC3IENoYWludGVj
aCBJbnZlc3RtZW50IGFuZCBDb21tb2RpdHkgQ28sIEx0ZA0K0JTQsNGC0LAg0YDQvtC20LTQtdC9
0LjRjzogMjYg0YHQtdC90YLRj9Cx0YDRjyAxOTQyINCzLg0K0KLQtdC60YPRidC40Lkg0LDQtNGA
0LXRgTogMjBmLTMuIOKEliAyNiwg0L/QtdGA0LXRg9C70L7QuiAxNDYsINGD0LvQuNGG0LAg0JPQ
vtC90LMg0KHRjtGNLCDQrtC20L3Ri9C5INGA0LDQudC+0L0sDQrQs9C+0YDQvtC0INCi0LDQudGH
0LbRg9C9LA0K0KHRgtGA0LDQvdCwOiDQotCw0LnQstCw0L3RjA0KDQrQnNC+0Lkg0L/QvtC60L7Q
udC90YvQuSDQutC70LjQtdC90YIg0KDQtdC2LiDQp9Cw0L0g0KPQvtC70LvQtdGBLCDQutC+0YLQ
vtGA0YvQuSDRg9GI0LXQuyDQuNC3INC20LjQt9C90Lgg0LjQty3Qt9CwDQooQ09WSUQtMTkpLCDR
h9GC0L4g0Y/QstC70Y/QtdGC0YHRjyDQvdC10YHRh9Cw0YHRgtC90L7QuSDRgdC80LXRgNGC0YzR
jiwg0L7QvSDQvtGB0YLQsNCy0LjQuyDQvtCz0YDQvtC80L3Rg9GOINGB0YPQvNC80YMNCtC00LXQ
vdC10LMgKDUsNSDQvNC40LvQu9C40L7QvdCwINC00L7Qu9C70LDRgNC+0LIpINCyINCx0LDQvdC6
0LUuINCf0L7RgdC70LUg0L3QtdGD0LTQsNGH0L3Ri9GFINC/0L7Qv9GL0YLQvtC6INC/0L7QuNGB
0LrQsA0K0YDQvtC00YHRgtCy0LXQvdC90LjQutC+0LIsDQoNCtCvINGA0LXRiNC40Lsg0YEg0LLQ
sNC80Lgg0YHQstGP0LfQsNGC0YzRgdGPLA0K0KPQstCw0LbQsNC10LzRi9C1LCDQtdGB0LvQuCDQ
stGLINC00LXQudGB0YLQstC40YLQtdC70YzQvdC+INC30LDQuNC90YLQtdGA0LXRgdC+0LLQsNC9
0Ysg0LIg0Y3RgtC+0Lkg0YHQtNC10LvQutC1LCDQttC00LXQvA0K0LLQsNGI0LXQs9C+INC+0YLQ
stC10YLQsCDQtNC70Y8g0L/QvtC70YPRh9C10L3QuNGPINCx0L7Qu9C10LUg0L/QvtC00YDQvtCx
0L3QvtC5INC40L3RhNC+0YDQvNCw0YbQuNC4INC+INGB0LTQtdC70LrQtS4NCtCe0YLQv9GA0LDQ
stGM0YLQtSDRgdCy0L7QuSDQvtGC0LLQtdGCINC90LAg0LzQvtC5INC70LjRh9C90YvQuSDQsNC0
0YDQtdGBINGN0LvQtdC60YLRgNC+0L3QvdC+0Lkg0L/QvtGH0YLRiw0KKGpvaG5wZXRlci5lc3FA
Z21haWwuY29tKQ0KDQrQntC20LjQtNCw0Y4g0YPRgdC70YvRiNCw0YLRjCDQvtGCINGC0LXQsdGP
Lg0KDQrQlNC+0YHRgtC+0L/QvtGH0YLQtdC90L3Ri9C5INCQ0LTQstC+0LrQsNGCINCU0LbQvtC9
INCf0LjRgtC10YANCg==
