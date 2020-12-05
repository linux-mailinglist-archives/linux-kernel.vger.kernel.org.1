Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401F72CFD44
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgLES33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbgLES3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:29:25 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1816AC09427F
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 05:29:24 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id o9so5767241pfd.10
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 05:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xzxdWyHrXhHu6b7fYfNflc4EJF5/TpK4zPGY4/WRmDk=;
        b=J2n59YivjhdebDdS0GQrqaVTMDmgWRdBEwsOj3jiz/oRIGyWxLVGgbKCr8mNHKPV0k
         cY0bnGhjgvUNnPVhnkrLVrWY/dpHdWteU2PVnnc+FZwXBEbpQrw7KDOxksCX1aBMfN2V
         JaQ204Bm/6TWaSZqxGRDZE+juNNMULSzXGgJ75Yf/EKHnM8Zj4vd0ELOCiXEFHjZHo6B
         ELl/wVrCU2QiLng8uD4CGFJi/Zjyp10x9zKtNuijP6Gk0pJ8DGEITKlyj0Fsyh1xHuOX
         75sWE7TAhEMHsDa3laoIzXMx/1+nEAFgYMsR3PsxwSlt8jbVb6junb1pEHG//b+ZtbBc
         gQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=xzxdWyHrXhHu6b7fYfNflc4EJF5/TpK4zPGY4/WRmDk=;
        b=kFRti7OsHsclOV93uiWkFHXgVmDVeE7SYhbO+cXIShvW0lAt30SfE/rWgvHxgVARNL
         2t4xrSPSvIatmCfZWFkS87Trzg9kcq4gOkUYCYIe+Ze2o8cTrLgR8TS0jkaROGwGNi1p
         8ki8wxKVf5JjhlPxhDt8LjuSEY/A1H1tYHQQE8Qm5wWGSki02JL+mKy3HsSney8jh6+J
         y5sRcUmDctKYaCjjD61HJz+Os0ZpV3gTEv9ZgynS8aXyWmQBpCbij5eOr5jo6OPAV0/I
         JslDVJuvLJLTT0MUuLZutAPARyOjYVxeLa6Zf6xgdec2jIMEhXSY9w1l9QstS/My+gWq
         CKIw==
X-Gm-Message-State: AOAM530v1EVtus9wXTpiCaHCVkanX9m3wK5PYB8t+Xyk9XJzl7RKzgnB
        DBozWPg2wmpT/QQ8xl9vM0JNEvo5Yl/qbcxzWbI=
X-Google-Smtp-Source: ABdhPJz90gBcWMiYyuIY45e5XCUVlBolBZkI/Qk4ZizF2NFQDFP4J4TllyW1ZMlghzl4SFbCUAVa6RJhnOK2DD19B/s=
X-Received: by 2002:a63:4e4c:: with SMTP id o12mr11512384pgl.348.1607174963593;
 Sat, 05 Dec 2020 05:29:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:95a3:0:0:0:0 with HTTP; Sat, 5 Dec 2020 05:29:23
 -0800 (PST)
Reply-To: georgemike7031@gmail.com
From:   george mike <crepinak.vainqueur@gmail.com>
Date:   Sat, 5 Dec 2020 14:29:23 +0100
Message-ID: <CAHwNn8K_8=8YF2mRZhtMMPzpq9-2TqrVwYuh9qf+ZOT9DdQRBw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo

Mein Name ist George Mike. Ich bin von Beruf Rechtsanwalt. Ich m=C3=B6chte
Ihnen anbieten
der n=C3=A4chste Verwandte meines Klienten. Sie erben die Summe von (8,5
Millionen US-Dollar)
Dollar, die mein Kunde vor seinem Tod auf der Bank gelassen hat.

Mein Kunde ist ein Staatsb=C3=BCrger Ihres Landes, der mit seiner Frau bei
einem Autounfall ums Leben gekommen ist
und einziger Sohn. Ich habe Anspruch auf 50% des Gesamtfonds, 50% darauf
sein f=C3=BCr dich.
Bitte kontaktieren Sie meine private E-Mail hier f=C3=BCr weitere
Informationen: georgemike7031@gmail.com

Vielen Dank im Voraus,
Mr. George Mike,
