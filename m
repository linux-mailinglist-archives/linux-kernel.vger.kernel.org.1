Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4772FC9A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 04:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbhATDzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 22:55:25 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:50791 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731507AbhATDwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 22:52:08 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210120035125epoutp029c28150a8836f85515c14a01e80f798b~b1EVLSuUi2313623136epoutp02G
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 03:51:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210120035125epoutp029c28150a8836f85515c14a01e80f798b~b1EVLSuUi2313623136epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611114685;
        bh=rmNVsadvUvfUSqyjvLgSW52JXvqmaHb2Wy0DJaMu3Dg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Jazlue4oPk80MGKWtq5jer+gs20fKpSjCGr1pJE/DrdSbMNr1lJYqFkKyc7ahwJIy
         UwJWQH88ZMMJY9oSa442Eh6ibJYxqsi3tiV1wZ7oUestD41JGUV0pk79U6gxIdVuaN
         YtaXyW0nf9DROcgHREB+WlSAQQ85C4o2viH1/Jsc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20210120035124epcas2p19d47d33491f049d669e65b496a47d681~b1EUZf7cE0409004090epcas2p1n;
        Wed, 20 Jan 2021 03:51:24 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.187]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DLBQg68wvz4x9Q2; Wed, 20 Jan
        2021 03:51:23 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.2A.05262.BB8A7006; Wed, 20 Jan 2021 12:51:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20210120035123epcas2p2048f6d9896bd21f19d939a56fe0b6610~b1ESmBk-Q0078900789epcas2p2A;
        Wed, 20 Jan 2021 03:51:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210120035123epsmtrp11506a9812d8877c7dc11adc1a9faa50c~b1ESlZgnC1321313213epsmtrp1k;
        Wed, 20 Jan 2021 03:51:23 +0000 (GMT)
X-AuditID: b6c32a47-b81ff7000000148e-33-6007a8bb19c1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.AE.13470.AB8A7006; Wed, 20 Jan 2021 12:51:22 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210120035122epsmtip1d4e05b15d6286804b575393b25e403d7~b1ESaKF8o0536305363epsmtip1b;
        Wed, 20 Jan 2021 03:51:22 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Daehwan Jung <dh10.jung@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: usb: dwc3: gadget: skip pullup and set_speed after suspend
Date:   Wed, 20 Jan 2021 12:39:28 +0900
Message-Id: <1611113968-102424-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7bCmue7uFewJBqcmCVkca3vCbnFnwTQm
        i+bF69ksLu+aw2axaFkrswOrx6ZVnWwe++euYffo27KK0ePzJrkAlqgcm4zUxJTUIoXUvOT8
        lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygvUoKZYk5pUChgMTiYiV9O5ui
        /NKSVIWM/OISW6XUgpScAkPDAr3ixNzi0rx0veT8XCtDAwMjU6DKhJyM3T9OMhV846jYd7SD
        vYFxBXsXIyeHhICJxILJr9m6GLk4hAR2MErc/NLLCuF8YpToeP4JKvONUWLPm99wLX//vWOC
        SOxllFj57RILhPODUaLh13ugfg4ONgEtie8LGUEaRASUJab8aANrYBaYxijxcO0WJpCEsICz
        xP/lR5lBbBYBVYlLm06CbeAVcJPo+bOeDWKbnMTNc53MIM0SAtPZJebPOcMIkXCRuHv6PpQt
        LPHq+Bao86QkXva3sYMcISFQLrFovh1EbwejxJpPZ6HqjSVmPWtnBKlhFtCUWL9LH6JcWeLI
        LRaQCmYBPomOw3+hpvBKdLQJQTQqS0y/PIEVwpaUOPj6HDNEiYfEyXVaIGEhgViJpWvuMU1g
        lJ2FMH4BI+MqRrHUguLc9NRiowJj5DjaxAhOSlruOxhnvP2gd4iRiYPxEKMEB7OSCG/TX7YE
        Id6UxMqq1KL8+KLSnNTiQ4ymwNCayCwlmpwPTIt5JfGGpkZmZgaWphamZkYWSuK8xQYP4oUE
        0hNLUrNTUwtSi2D6mDg4pRqYnG9Zun1ZeUTkvbdNdM+pm0qrTMPM2jeIaLBLclyWk0rbzXfY
        g/OTeN727hu902P+vkv7qmNacvvkJOlD9T6TpFpPyq1at6niRpiUDBP3hSvGr+9enTktT0Pz
        wodPhwo09SY+mH2E993cq1OeLMvomZ0i65Ap78IiWLrbUcORUeM1ry730+q0CtmlT4x6Nhhd
        Eb14zbbg3cZ9oYEtiuks24Osps6MVljxYzsDv4yF6OZOQfnZt3UvbOLZMmHXj1NzLGekP9rN
        9fCpj6BMVtvW9Ysj5jrOl1jGvTFT/JLSr0c37nUtfXvXOi1Fkv9oyvGL1xwsls/780jhoNDd
        uOdymy2Za+6VLcnTmz+FSenUKyWW4oxEQy3mouJEAIwswA7TAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAJMWRmVeSWpSXmKPExsWy7bCSnO6uFewJBj0fLS2OtT1ht7izYBqT
        RfPi9WwWl3fNYbNYtKyV2YHVY9OqTjaP/XPXsHv0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJX
        xu4fJ5kKvnFU7Dvawd7AuIK9i5GTQ0LAROLvv3dMXYxcHEICuxklet7vgEpISiydewPKFpa4
        33KEFaLoG6PEiRmbGbsYOTjYBLQkvi9kBKkREVCWmPKjDWwQs8AMoJr+bhaQhLCAs8T/5UeZ
        QWwWAVWJS5tOgg3lFXCT6Pmzng1igZzEzXOdzBMYeRYwMqxilEwtKM5Nzy02LDDMSy3XK07M
        LS7NS9dLzs/dxAgOFC3NHYzbV33QO8TIxMF4iFGCg1lJhLfpL1uCEG9KYmVValF+fFFpTmrx
        IUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUxOPX4X3rdr/drQpNVtebRwq0nBP957
        D6WS/1uECX+4sGBRw6aZrvkt3Mt5n2wv1jaRufiaSytz7TvTgu0CB4+JT/weJXfFuH/CCouC
        f29sLhgKxy542X04YMr5ac87P7Z25DkWsAgxlDPd15rhNG+ClUf2lWMfq2L/FG+/fEfjmYdF
        mYtkevRrHS7eh14PD5js2i2rZfSkOy+0a9/m1UnOP5Q5elevXhSWkdMcNtN908P5CsqLYv18
        ll3c6RZtcXGfZ2+P42WdoK065Z7nVJONi04Efvm72G/h98B/3yv+ntLf8OmWWfTLoJA21X/W
        rTkiB/74f5G7X7eA03kC5/WqxNx1HHfP//kd38xgHK3EUpyRaKjFXFScCABgoX4igwIAAA==
X-CMS-MailID: 20210120035123epcas2p2048f6d9896bd21f19d939a56fe0b6610
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210120035123epcas2p2048f6d9896bd21f19d939a56fe0b6610
References: <CGME20210120035123epcas2p2048f6d9896bd21f19d939a56fe0b6610@epcas2p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes dwc3_gadget_pullup and dwc3_gadget_set_speed are called after
entering suspend. That's why it needs to check whether suspend

1. dwc3 sends disconnect uevent and turn off. (suspend)
2. Platform side causes pullup or set_speed(e.g., adbd closes ffs node)
3. It causes unexpected behavior like ITMON error.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 drivers/usb/dwc3/gadget.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index ee44321..d7d4202 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2093,6 +2093,9 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 	unsigned long		flags;
 	int			ret;
 
+	if (pm_runtime_suspended(dwc->dev))
+		return 0;
+
 	is_on = !!is_on;
 
 	/*
@@ -2403,6 +2406,9 @@ static void dwc3_gadget_set_speed(struct usb_gadget *g,
 	unsigned long		flags;
 	u32			reg;
 
+	if (pm_runtime_suspended(dwc->dev))
+		return;
+
 	spin_lock_irqsave(&dwc->lock, flags);
 	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
 	reg &= ~(DWC3_DCFG_SPEED_MASK);
-- 
2.7.4

