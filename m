Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F0B212967
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 18:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGBQ2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 12:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGBQ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:28:52 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F43C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 09:28:52 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t11so10890591qvk.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 09:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7JqLKSUFdGdLy72GqIL1pnksOMo8WeFdq7kCu4Cdvdc=;
        b=EKi8zHLxt3Idl9/WIZnd9Iqz641pc5qmpAalJ3Ik4zd0myrRMAOj4pRf12A7yRTU7q
         8GfKDq9JaiH+pu71QLolZOB2DTNn1zUSSANcbGyrwaifXQOZ9dLGGg0W2wvQYVN6KaKn
         7uxL7eb8866VPW4y60ODKh4fk5TUa3quBfhvNQNshoEdC/OBCYVNie+T0OJx8IedtVSz
         cBgQolKU2uMC/AYwQM9hFOahCdYoXMr7MeCCcKw7OyP6MMqpVqt9yFuI72wrRuCPGt1E
         /LR41KgOzKwae7GMsZH6J4bMxOqxiztW9+foeGpYBwa8hpKsXLIkQXCSzGAcdlXoJ1Ud
         iByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=7JqLKSUFdGdLy72GqIL1pnksOMo8WeFdq7kCu4Cdvdc=;
        b=FNjCW2SIbF3ZWQYoV7gxZQ4ep6dPE8fmEotN4r/lHb13wwVnEd5ibGD6Ens4xJqMNw
         1sw/f3DGEoAvUK13/4OYrUdWMR/Tfcgoc16ZgwNfJdsyoTCLdUGA1FeMFkkNRV8BAOTV
         V+1TohrftS8RDgSnJQuWs3pj+bO8mIeFifl/NODuzDMID1a38OZxey7LzuTRnNVJm9Ky
         okLYQkU27QqaIeaVIeEC/VCudXrclj+4h0tUj9AqQNdP919r7GD1oFNUu5WXWfe8Jfem
         EUPXZwR6NgDS5RFH+U4kwYK7r2cPfHaxrDt4TWuSKFS9dLlMIRay4OKUbrQmVgTYTLPe
         yAeA==
X-Gm-Message-State: AOAM531kQ7O3Hv2Lb01wMFSYYO4/DumKZpH5u9wprcwUhdGPlt3fgsNV
        ASNqHFkYCR+16DIkEPtKlfq21JGocySvd/xs51w=
X-Google-Smtp-Source: ABdhPJwznIs2pURxaqcXaPfoHllqdLlwVqab6ooQ1uB4JMidd7fqsK69tb0h7oXx0NU5jIOHjtSccdFJ4niNFwd+xtg=
X-Received: by 2002:ad4:4812:: with SMTP id g18mr30084160qvy.56.1593707331159;
 Thu, 02 Jul 2020 09:28:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:e506:0:0:0:0:0 with HTTP; Thu, 2 Jul 2020 09:28:50 -0700 (PDT)
Reply-To: robertandersonhappy1@gmail.com
From:   robert <ekesineugwu@gmail.com>
Date:   Thu, 2 Jul 2020 09:28:50 -0700
Message-ID: <CALCrinRMGMb=RYNv4nWHk7a8Tk-MVqevcyc23-H2MmWRvSz2mg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KiDQktC90LjQvNCw0L3QuNC1OiDQsdC10L3QtdGE0LjRhtC40LDRgCAqDQoNCiog0KHQvtC+0LHR
idC40YLQtSwg0YfRgtC+INC80Ysg0L/QvtC70YPRh9C40LvQuCDRg9GC0LLQtdGA0LbQtNC10L3Q
vdGL0Lkg0YTQsNC50Lsg0L7Qv9C70LDRgtGLINC+0YIgRkVERVJBTA0K0JzQmNCd0JjQodCi0JXQ
oNCh0KLQktCeINCk0JjQndCQ0J3QodCe0JIg0YHQvtCy0LzQtdGB0YLQvdC+INGBINCc0LXQttC0
0YPQvdCw0YDQvtC00L3Ri9C8INCy0LDQu9GO0YLQvdGL0Lwg0YTQvtC90LTQvtC8ICjQnNCS0KQp
DQrQutC+0LzQv9C10L3RgdCw0YbQuNGPINC20LXRgNGC0LLQsNC8INC80L7RiNC10L3QvdC40YfQ
tdGB0YLQstCwINC4INCy0LDRiCDQsNC00YDQtdGBINGN0LvQtdC60YLRgNC+0L3QvdC+0Lkg0L/Q
vtGH0YLRiyDQstGF0L7QtNC40YIg0LIg0YHQv9C40YHQvtC6DQrQttC10YDRgtCy0YsuICoNCg0K
KiDQryDQv9C40YjRgywg0YfRgtC+0LHRiyDRgdC+0L7QsdGJ0LjRgtGMINCy0LDQvCwg0YfRgtC+
INC80Ysg0LHRg9C00LXQvCDQvtGC0L/RgNCw0LLQu9GP0YLRjCDQstCw0LwgJCA1MDAwLjAwVVNE
DQrQtdC20LXQtNC90LXQstC90L4g0YENCtC90LDRiCDQvtGE0LjRgSDQt9C00LXRgdGMLCDRgtCw
0Log0LrQsNC6INC80Ysg0L/QvtC70YPRh9C40LvQuCDQvNCw0L3QtNCw0YIg0L3QsCDQv9C10YDQ
tdC00LDRh9GDINCy0LDRiNC10LPQviDQv9C+0LvQvdC+0LPQvg0K0LrQvtC80L/QtdC90YHQsNGG
0LjQvtC90L3Ri9C5INC/0LvQsNGC0LXQtiDQsiDRgNCw0LfQvNC10YDQtSA4MDAgMDAwINC00L7Q
u9C70LDRgNC+0LIg0KHQqNCQINCc0LXQttC00YPQvdCw0YDQvtC00L3Ri9C8DQrQstCw0LvRjtGC
0L3Ri9C8INGE0L7QvdC00L7QvA0KKNCc0JLQpCkg0Lgg0KTQtdC00LXRgNCw0LvRjNC90L7QtSDQ
vNC40L3QuNGB0YLQtdGA0YHRgtCy0L4g0YTQuNC90LDQvdGB0L7Qsi4g0JLQsNGIINC70LjRh9C9
0YvQuSDQuNC00LXQvdGC0LjRhNC40LrQsNGG0LjQvtC90L3Ri9C5INC90L7QvNC10YANCtC/0YDQ
tdC00L7RgdGC0LDQstC70LXQvdC+INC60L7QvNCw0L3QtNC+0LkgSS5NLkYgQ1BQMDkyMFRHLiAq
DQoNCiog0JLQvtGCINC40L3RhNC+0YDQvNCw0YbQuNGPINC+0LEg0L7Qv9C70LDRgtC1LCDQutC+
0YLQvtGA0YPRjiDQvNGLINCx0YPQtNC10Lwg0LjRgdC/0L7Qu9GM0LfQvtCy0LDRgtGMINC00LvR
jyDQv9C10YDQtdGB0YvQu9C60Lgg0LLQsNGI0LXQs9C+DQrQtdC20LXQtNC90LXQstC90YvQuSDQ
v9C10YDQtdCy0L7QtC4gKg0KDQoqINCY0LzRjyDQvtGC0L/RgNCw0LLQuNGC0LXQu9GPOiDQodC4
0L3RgtC40Y8g0JjQtNC10L0gKg0KKiDQktC+0L/RgNC+0YE6INCe0L/Qu9Cw0YLQsCAqDQoqINCe
0YLQstC10YI6INCU0LAgKg0KKiDQodGD0LzQvNCwOiA1IDAwMCwwMCDQtNC+0LvQu9Cw0YDQvtCy
INCh0KjQkCAqDQoqINCT0L7RgNC+0LQ6INCb0L7QvNC1ICoNCiog0KHRgtGA0LDQvdCwOiDQotC+
0LPQviAqDQoNCiog0J/QoNCY0JzQldCn0JDQndCY0JU6IE1UQ04g0LHRg9C00LXRgiDQvtGC0L/R
gNCw0LLQu9C10L0g0LLQsNC8INC/0L7RgdC70LUg0LLQsNGI0LXQs9C+INC+0YLQstC10YLQsCDQ
uCDQv9C+0LTRgtCy0LXRgNC20LTQtdC90LjRjw0K0JjQvdGE0L7RgNC80LDRhtC40Y8g0L4g0LLQ
sNGI0LXQvCDQv9C+0LvRg9GH0LDRgtC10LvQtSwg0YfRgtC+0LHRiyDQuNC30LHQtdC20LDRgtGM
INC90LXQv9GA0LDQstC40LvRjNC90L7QuSDQv9C10YDQtdC00LDRh9C4LiAqDQoNCiog0JzRiyDQ
ttC00LXQvCDQstCw0YjQtdCz0L4g0YHRgNC+0YfQvdC+0LPQviDQvtGC0LLQtdGC0LAg0L/QviDR
jdGC0L7QvNGDINCw0LTRgNC10YHRgw0KKG1pc3NjeW50aGlhZWRlbjU2QGdtYWlsLmNvbSA8bWlz
c2N5bnRoaWFlZGVuNTZAZ21haWwuY29tPiksINGH0YLQvtCx0Ysg0L/QvtC30LLQvtC70LjRgtGM
INC90LDQvA0K0L/RgNC+0LTQvtC70LbQuNGC0Ywg0L7Qv9C70LDRgtGDLiAqDQoNCirQmNGB0LrR
gNC10L3QvdC1INCy0LDRiCwqDQoNCirQoNGD0LrQvtCy0L7QtNC40YLQtdC70Ywg0YTQuNC70LjQ
sNC70LA6Kg0KKiDQnNC40YHRgSDQodC40L3RgtC40Y8g0JjQtNC10L0gKg0K
