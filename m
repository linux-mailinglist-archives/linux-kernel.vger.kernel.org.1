Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E4A2243D5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 21:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgGQTId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 15:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgGQTI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:08:28 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77256C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 12:08:28 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g13so8448462qtv.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 12:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pgUSn+8857jm9/5Q1KHisKfajHJ16AK23j2d8X+E6+c=;
        b=LSpe7eCjpFYHipOwA4Cg2POHKSyrC5j5IT77lrTpTgf3v9EVWZU9hy9pPSZNrbYiTy
         SS38u+fHUSpuwYPK7G4w7qwd3M8jO9N0fOmRH3WSZ6y0JfhmxpqIK4C/OnVBdp8vFJQW
         ZAtUBlLOPNJetnu91eOT/H6wi8jiw/4UGOEcEN7Q4/4/66YhlX4pNug4OdGQUc86B0nq
         YFdo/RBmPWkGfaj8XLd5Pw0Y1gxtMPV8exrbAaIyy/3B5PWyrnEBfI/6BUX8rH4FgVzd
         IHnuX03bY3rHRrH5DP+sdOsrASt3V8NOCP5mpSTXBG3W/n2/mUDrndNIERKwgCvpmbtf
         Mo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=pgUSn+8857jm9/5Q1KHisKfajHJ16AK23j2d8X+E6+c=;
        b=CJxn4l+UqFC2LDr0KhMfdUGbOPg0KdW5/mKIvo+aBpJu4rxqplaVkDdnJQTk0YQ3IZ
         yyS50087ecEqvG00Z/Kq0OJnMp2vbE7DFILHbbpf/tHd8rLd5ELImWOj3KDV1iv7y5cw
         QimlXkwnJIBNa8UV3FXy7dey0WTKV43T274XdoNfgNSO6SsUTHLFcoo6H77wUtEH30ze
         jPBys2GdKLJIF3J2nGb4PaEJmvq9zic0z5XwwAbFLGDfwI1VnPRINwonhf99Gl3o6ChU
         uyig8dseOchzva1quwrjFo/TVDz9MbEhh0Lqh+qSVxNl/VcI2NSHa6JThNqAY7HAAt5n
         99wQ==
X-Gm-Message-State: AOAM5304J/QpBmBRhdqUQMbqXHqlIjeBuRcWM+ctPReL/dOSzp0ZA7D4
        ZdP7cfdmfIL7WT0upri/34lAHnV/yvMQ+xje89Q=
X-Google-Smtp-Source: ABdhPJxUAZ+ZdyfpAg5z3/LJJYRkP51wa9/X+Nq8Gcir1G77SjGqFEA6IqPfQr4w3esy2nT2M73IfyOtOq3gPUGWOsw=
X-Received: by 2002:aed:2cc7:: with SMTP id g65mr12235388qtd.248.1595012907765;
 Fri, 17 Jul 2020 12:08:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:4dc1:0:0:0:0:0 with HTTP; Fri, 17 Jul 2020 12:08:26
 -0700 (PDT)
Reply-To: jamesbenjamin085@gmail.com
From:   James benjamin <marvinphillip123@gmail.com>
Date:   Fri, 17 Jul 2020 19:08:26 +0000
Message-ID: <CAJwEjdDsdA23Za6EMeFiBWmudVCwRS2EAvJUNYXyDY3TOyuxKg@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, bitte beachten Sie, dass diese E-Mail, die an Ihre Mailbox
gesendet wurde, kein Fehler ist, sondern speziell an Sie gerichtet
wurde. Ich habe einen Vorschlag von (7.500.000,00 USD) von meinem
verstorbenen Kundeningenieur Carlos, der den gleichen Namen bei Ihnen
tr=C3=A4gt, der fr=C3=BCher hier in Lome Togo gearbeitet und gelebt hat. Me=
in
verstorbener Kunde und meine Familie waren in einen Autounfall
verwickelt, bei dem sie ums Leben kamen . Ich kontaktiere Sie als
Angeh=C3=B6rige des Verstorbenen, damit Sie das Geld bei Schadensf=C3=A4lle=
n
erhalten k=C3=B6nnen. Nach Ihrer schnellen Antwort werde ich Sie =C3=BCber =
die
Modi der Ausf=C3=BChrung dieses Bundes informieren. Kontaktieren Sie mich
hierzu (jamesbenjamin085@gmail.com).
