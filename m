Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B484523061D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 11:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgG1JHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 05:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgG1JHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:07:38 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7140C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:07:38 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mt12so3761071pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UOr65DEC+2TW/zt7uOWWliltVKZ89UsSxVAE/jQE1oM=;
        b=PwluROk9+Zx2qVjbyrKIONJBcz+seb+emdyhMNTI68bmG1WlEAS+t7464u6SVaZPky
         3cJxOqIOn84iIOhwIXN+o7gaIJiTlG9yCedbf6hdbhNesag+hfdnUaWiPXe6l3R5Jznx
         oOrt0aKAEEAqJePam7ZqY8zGK2uy5AYn34GjqsGqapS13cnBoHDBbhGA1tm9QwtjA6Q1
         JBfm0grtS0y0wSQPg7GCwnV68c93+He+3EIypxLxUCV8yy/pv9FHRUu0eehLDzMT/kcB
         nGlfgDIYuLAQzeq43SBgsY2umiWcTh9WMSkza3Rkcg2YtHytfpn7UpW5oH+uCuOI/7CE
         +dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=UOr65DEC+2TW/zt7uOWWliltVKZ89UsSxVAE/jQE1oM=;
        b=kV/f9AIoQkyMK0TP64bZ/Ud01Rwt9YKR2ha/bHA66Cn+ED/UkGxw/EoEf9OvIJtW//
         uDuVgUg4ZhX1T4UR3N6ZjTr7gKIa0gmrh1DFrViOYT03Aqzavl2q+62BggZyLZk9E6Hz
         pFjvYSWHnKPd3zgBG5ti/iTRZQstmtVtNJjve4VL+wtDX1s76MqYutGI+H+nyuckLsul
         Zq8qXC26Wd9VTqe7xg4OLDJtcAKdSxzWJF8xtsviPpumNgfjLi4qG+ze6wasfZoZpMtO
         BSwI5xOG+i6jvOEQVc6T6pvFL3L2zGvug/H/J+W8+tAaESrRD16Lyvq/i7BkQuMrmLco
         xFgA==
X-Gm-Message-State: AOAM530inGz4C3Wq9Vh0sa6iTbXf5GJLwmN9FscUzdVr/Z6Sr5x62uCa
        mHjTL3NADOrd7dxQ3Agrbv57wd4b/NlCpzknjww=
X-Google-Smtp-Source: ABdhPJySo/sA4iJfHn+dzEk8JQrQpicH1Yitx/i2vthm4maSr1GNROJe7wRrICdnMOz1+P8h3SN0pcdZj1DWIZ86SvU=
X-Received: by 2002:a17:90a:154c:: with SMTP id y12mr3664970pja.158.1595927258116;
 Tue, 28 Jul 2020 02:07:38 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrahmedmuzashah@gmail.com
Received: by 2002:a05:6a10:3c43:0:0:0:0 with HTTP; Tue, 28 Jul 2020 02:07:37
 -0700 (PDT)
From:   "Mr.Ahmed Muzashah" <ahmedmuzashah@gmail.com>
Date:   Tue, 28 Jul 2020 10:07:37 +0100
X-Google-Sender-Auth: tqDz2dHMvgSGdSBVCA0w-7jHhNQ
Message-ID: <CACB_QOL62695Fd-mpTinyJU=Fw7J=rs2u3w5q0X-HnyASYiKGA@mail.gmail.com>
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
Mr.Ahmed Muzashah,
