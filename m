Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDF820B0F0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 13:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgFZLxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 07:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgFZLxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 07:53:18 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42E5C08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 04:53:18 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t27so3217049ill.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 04:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7JqLKSUFdGdLy72GqIL1pnksOMo8WeFdq7kCu4Cdvdc=;
        b=Hp4FSdxg+1pmC58ouOVBnkr2WAza1ozhBinbIh4pqWqjb5wgrK8hWLLap+JMIQ8AqD
         dycssBc2jm4lKILmv0Lc9/kSQVfD8MOlOablCPHu5ggRSeD3HjjYozncDZ+d/N2Y5O8A
         +RJEEeIf7ZQga/pxK6xFR1fCmW1eUe/o8DWExudS7SHkZLVOKlx2OKE/PLZ5fKSeSFGE
         vwh8Ur5Ih7MqIes5fSsUDRIHIBsNB1017BdDSOUIMTCHdtt9AGBS0nn2jpBVrhiMM83R
         QErtFZJudyNmda8Vir502XiasKGQvO/I5AWx+7GXlRRiPVHvp3yAA7vJxII/9NnVD7qR
         xgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=7JqLKSUFdGdLy72GqIL1pnksOMo8WeFdq7kCu4Cdvdc=;
        b=LYySqPHZa1xtK8FAgYIUbWjdZdt4mxqX5cmOzdT6k+vnWC2EMYj4W3iYjOsH9eG/bv
         kcFjh9nWz7sRWplsgLMteRJJquRzO1djJprepD45+wDkhG/QbEzr/MgTsqNoz66bSBG+
         OYr7D5+t+8ht/IGRnZIuEnGeiLT7bBFFG6uZMQrn9BX8Crff0DDHyX3lu2qSRgYYcpwG
         BmDxTOj0EuDUC5QvVC63ajEmjVXcf0i1h/VCyrKcKE1pcUqCtSuk7wzCdqDka+2NakGc
         qssTllAQapFGO7oeR2aNIS4JXkwZ6qLLwq1r/m3UezmZjwO5PBXlnJ9W3k1+MSw+56Y1
         4YVA==
X-Gm-Message-State: AOAM530m93ngiJYKkSGFfXu/oiCPqlF0/QXfOlaKoXYBYFSYlxfLiP3+
        /YvsaW4Yeqh7I9xntPjUxSOiFzDUxU5yxH4SQzw=
X-Google-Smtp-Source: ABdhPJyzyP4u+3TLJT2B8VfXPzXj0v39tSEKin2SHrGc+zluvN6aC6hn7cFXwGiHOV9nyMfHRf711KXQF4HkC+xme5A=
X-Received: by 2002:a92:c513:: with SMTP id r19mr2343890ilg.12.1593172397958;
 Fri, 26 Jun 2020 04:53:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:a781:0:0:0:0:0 with HTTP; Fri, 26 Jun 2020 04:53:17
 -0700 (PDT)
Reply-To: robertandersongood1@gmail.com
From:   robert anderson <robertandersongood7@gmail.com>
Date:   Fri, 26 Jun 2020 04:53:17 -0700
Message-ID: <CAE=WtcTTBeuv4TrDssOe+jy-3BgpybQ_o+N--4L+-vT4tn9Owg@mail.gmail.com>
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
