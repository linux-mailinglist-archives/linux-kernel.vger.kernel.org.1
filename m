Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D631A1BED
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 08:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgDHGfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 02:35:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39032 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgDHGfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 02:35:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so6431448wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 23:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:to:reply-to:subject:date
         :content-transfer-encoding;
        bh=RjOpKR64JcF3HJqrI07JmC7nXFZX7asiVKu7icc5Q3U=;
        b=pdN4ubW6SycZ1TgdlY3d7PwgBARU4apGW1t4laqyQZds4X0LsGZmIvpygGJVhQs+hI
         6dXAdc9lpsEmkr2qrQR/2DINguV82Vbh1yhorY7ba5vsre4XspIXazDQG6E71aToLip+
         VL7H/jbPIeXs0rlgl4If7i5grOJiRbrkc+P597wUl83PJx9idFwYaiWyD9Qcmebm+7/V
         /03yQBekvpPtMAgAsSBKVLBJxOf9Tqkd6smWRtRCnlToWGJJErxLxWqirGH2iMBxFhY0
         IZM0D9hctzD29xbgS5HmS11PQ+fP7rNIUShS/lXwEO8aaWJeKqu/WkTn9aBgj+cn4NTF
         8WmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:to:reply-to:subject
         :date:content-transfer-encoding;
        bh=RjOpKR64JcF3HJqrI07JmC7nXFZX7asiVKu7icc5Q3U=;
        b=rhkopFXQx3Mlwkj+LxoYdmEmf3YUZdbUdnk+tuaDsvaT4ZRkfqBztzUW3g/slVlk7Y
         X4OkoYyC2kabMOkby6tOXo8uiFdRFty40DxH8rcgrtJqAGxM/9IHT7RonX3kzvwf4tbo
         24ehQDWgMdM/iTluo1yfpeeWKOd1CL1whNUBtg13n4ayymDoz+jXuU5cG+cPssmNqPWh
         CqNfQdthy9ODiAGxuLeTPjh+DLqfVLVwOgu0H6PfV4Uv1ZbrQ+siISBTs/pTBFeM6PVu
         FiGbwCjzQdBbWeFNfB3FP9XndcnjWxQXtReq7BczzZGthDRwrvPeGpU9Ol6xi96RLv2t
         rDcw==
X-Gm-Message-State: AGi0PubNwlsTj2ooRqjCwoGcSXxq0cWfAmxiJZ6IAR6PC2DsDAms2MXp
        26oKvYn1IkInIhfMe4Mgfkm3XYnVAVg=
X-Google-Smtp-Source: APiQypITSNLBbtJfMvQeRAX88xcSWO1xLWkj0w3YUkCkXnowYJwG6CjWkeiEjyooJcSOYOnYJWbI9Q==
X-Received: by 2002:adf:a308:: with SMTP id c8mr7136487wrb.302.1586327741726;
        Tue, 07 Apr 2020 23:35:41 -0700 (PDT)
Received: from [192.168.0.101] ([80.248.78.242])
        by smtp.gmail.com with ESMTPSA id a67sm5819362wmc.30.2020.04.07.23.35.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 07 Apr 2020 23:35:41 -0700 (PDT)
From:   kaleb Omari <alexjolee50@gmail.com>
X-Google-Original-From: kaleb Omari <ezeobagideon@gmail.com>
Message-Id: <EFC6TH6O-RJEE-W205-UAE1-DA4AWCFQW8U@gmail.com>
Mime-Version: 1.0
To:     "Linux-Kernel" <linux-kernel@vger.kernel.org>
Reply-To: contact.winwinz.post.20s@gmail.com
Subject: HELLO WINNER 
Date:   Tue, 7 Apr 2020 23:35:39 -0700
X-Mailer: MBM 8.4.1-US
X-Bounce-Tracking-Info: <TGludXgtS2VybmVsCQkJbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwlIRUxMTyBXSU5ORVIgCTQ2MgkJNzUJYm91bmNlCW5vCW5v>
Content-type: text/plain; charset=iso-8859-1; format=flowed
Content-transfer-encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Congratulations

 This is to inform you that your email address have won a prize sum of $1=
=2E200,000,00 One Million Two Hundred Thousand United State Dollars from Mo=
-Lottery award 2020,

 https://www=2Elotteryusa=2Ecom/missouri/lotto/year

Your Winning Number  is (19-22-24-26-40-44) and check  the link of past win=
ners reply as soon as possible to claim your prize and choose your choice o=
f tranfer

 Contact Claims manager through this email address

Email ( contact=2Ewinwinz=2Epost=2E20s@gmail=2Ecom )

Congratulation in advance

Mr=2E kali Edmonds

contact=2Ewinwinz=2Epost=2E20s@gmail=2Ecom

