Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C4626339B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgIIRHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 13:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbgIIPhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:37:21 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CF2C0612EF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 07:29:15 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ef16so1577555qvb.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 07:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2+MMmBdP9os8fl/yaCqGjSQYHpapGZyjQs+McN3AAL0=;
        b=Qw/eo1lQV40Nr9573LICHCk7pTW8t0dOs6I6S1SIW2IfjNhLvVkh0IqTD+gnRoiEL0
         3yChX1o8ZupFl7v8nQzApKz9YW84FQCsaiJ4i7UNyh14Z8M8Im8CFh8dnNOmibsmRm2k
         dhzHrX0Rmpj7v0vBp3b/l5OmOCYjP5tH34h1WfLwI0WleuM20LDkI+29x+s9gDeQYy1k
         oL3LCZEsO1Grs7wz1JW9Y/xCUN1agefDVhc9tbqcoyU42ELnuax4Hj94w73cSfVQ1ojT
         8n4c5EMqbNWzmfbWlpKCplEZfLQ57JDc6vp7R6MsDo/7NfX6NR/9gPY/WHVjYvn05MMx
         lFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=2+MMmBdP9os8fl/yaCqGjSQYHpapGZyjQs+McN3AAL0=;
        b=anpNvJEyOBL+5qhbG0U3a+rvElyaI02SeRlV2mh/IC4nM1IwETpHyqt3Ebl7QHFEDR
         yMphav7b/t5LNkcH0kullTCZCOsOI4eAE2c0xi+RnhxddQ0BNB92vjfdrNVZzTEo0Ehe
         /6tnD1zy0t+WefDDlxiBbINR/qBQn8jfXv5eY6tOzpMYQRcS4kkTDVkgmvDm1CjTDzWZ
         IZ0dpRai5a2Efi4bVNysdrsAyfsoWuaZDQP+16rg/FaLAOJbspOW5Az7G7ALy5N7MMgG
         zv3pwxQeoOU3KAcliGnHQZCJ8NUfTad/PlMn1XHPP2CU6aXfz0yOb4bcacDFuDC0tt8f
         bvNQ==
X-Gm-Message-State: AOAM533glh+woBSQtfMHe4y6Oh0vA0YSwUa/EmQAPfcNR2wjaeA7U1yx
        mWkDOmBin+LNluXTFFdILB6ZRrrgQws8apcLbNY=
X-Google-Smtp-Source: ABdhPJxP9acd8BHfJsP6NpBM7bVCw/1ENT7p6slttXwKqCZv4r9hnNP1JT/FZt+7ZOX2KLh2cwq4tx4LqMEp0J3oGzY=
X-Received: by 2002:a0c:ed31:: with SMTP id u17mr4320907qvq.21.1599661754491;
 Wed, 09 Sep 2020 07:29:14 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrahmedmuzashah@gmail.com
Received: by 2002:ac8:2913:0:0:0:0:0 with HTTP; Wed, 9 Sep 2020 07:29:14 -0700 (PDT)
From:   "Mr.Ahmed Muzashah" <ahmedmuzashah@gmail.com>
Date:   Wed, 9 Sep 2020 15:29:14 +0100
X-Google-Sender-Auth: Tehezv93eu8r8NCzBDZPvFt879M
Message-ID: <CA+as4LXfFOQ-a2iF5sx_jzDJyXnRf6W1jbkarvnjHwUZhhWuGw@mail.gmail.com>
Subject: =?UTF-8?B?U2Now7ZuZW4gVGFn?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sch=C3=B6nen Tag,

Bitte entschuldigen Sie, dass Sie einen =C3=9Cberraschungsbrief geschrieben
haben. Ich bin Herr Ahmed Muzashah, Account Manager bei einer
Investmentbank hier in Burkina Faso. Ich habe ein sehr wichtiges
Gesch=C3=A4ft, das ich mit Ihnen besprechen m=C3=B6chte. In meinem Konto is=
t ein
Kontoentwurf er=C3=B6ffnet Ich habe die M=C3=B6glichkeit, den verbleibenden
Fonds (15,8 Millionen US-Dollar) von f=C3=BCnfzehn Millionen
achthunderttausend US-Dollar eines meiner Bankkunden zu =C3=BCbertragen,
der beim Zusammenbruch der Welt gestorben ist Handelszentrum in den
Vereinigten Staaten am 11. September 2001.

Ich m=C3=B6chte diese Mittel investieren und Sie unserer Bank f=C3=BCr dies=
en
Deal vorstellen. Alles, was ich ben=C3=B6tige, ist Ihre ehrliche
Zusammenarbeit und ich garantiere Ihnen, dass dies unter einer
legitimen Vereinbarung durchgef=C3=BChrt wird, die uns vor
Gesetzesverst=C3=B6=C3=9Fen sch=C3=BCtzt Ich bin damit einverstanden, dass =
40% dieses
Geldes f=C3=BCr Sie als meinen ausl=C3=A4ndischen Partner, 50% f=C3=BCr mic=
h und 10%
f=C3=BCr die Schaffung der Grundlage f=C3=BCr die weniger Privilegien in Ih=
rem
Land bestimmt sind. Wenn Sie wirklich an meinem Vorschlag interessiert
sind, werden weitere Einzelheiten der =C3=9Cbertragung ber=C3=BCcksichtigt =
Sie
werden an Sie weitergeleitet, sobald ich Ihre Bereitschaftsmail f=C3=BCr
eine erfolgreiche =C3=9Cberweisung erhalte.

Dein,
Mr Ahmed Muzashah,
