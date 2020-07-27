Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFA322E8B8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 11:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgG0JUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 05:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgG0JUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:20:07 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C427DC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:20:07 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k4so13770089oik.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UOr65DEC+2TW/zt7uOWWliltVKZ89UsSxVAE/jQE1oM=;
        b=ly5p3kRHVkIddztgirMCWiv1SSbDZ9Cujlt2724ltOYiyHLjGhx2j7mXZ/0AYrQHLd
         QOPdFpNuwZV7UEVJ67jGJoSIIgB4WE0RCigYy0OPVqekVs6kQZ2A02wPPEtP6jfSRR/N
         OWN+Va+HhQWZh7Qw79drpkWceHEfstjg6TNMw2P8VQv6uouk93ioE4oqMsHh/wK1/jJo
         1DR55kPNnUS81yJmyJlJKlVHlEXxtTZ/UnyDaQw3SMYoS0/8WWHe6/T/m9FxacM7WA0s
         XCT4DYXddAyDdL8wpF1TIYDOB7ijtBri4m2wCRUCQs0d0hzf7BcXS9SZrD8qLSDsvqFp
         ShKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=UOr65DEC+2TW/zt7uOWWliltVKZ89UsSxVAE/jQE1oM=;
        b=lHb6T83HLI0M3ouoQWw2vj57jNMAiiVAbG0AkoxYNzgQqpr9+pu3duE3B/v5hr2JhG
         8eA7fEb8uzJDN32vj1Icv2gtXzjqkYwexpPeiWrmxxqaA7JzUejpgIF8qfkzD2Z3BArY
         i+gvVbellkmxPgFyLDkbjBbdBiXHAC3XyiSfgdt1GnF5Ir2E+OsaukC3pcGyzIcoV4iD
         gA8nELyBjnuDN58XSh/egbP1KDX6+kg03IZDO/wSuEjq4RB2lghhM2QzdhoI/MuKXgcA
         VhDj5IUN06gdB3O02mUS7HbW/IcrFyccvjc1d8mskH9BR7UsCkyv5qVWrecKHWW+91KZ
         Wxvg==
X-Gm-Message-State: AOAM531drbBYf9Mu1O3eeTEMkz/STmzYnZxe8sbBF5e04GCToQPW7Ww/
        EOxlLX5dHpvDTscZhkzBZcvNtj7QnZwgt9Y183o=
X-Google-Smtp-Source: ABdhPJzYeu2/ceYnHDSmv1mOLVazIEvU3KFUPaZDopPPtYrEZckx3kvKiDTGh0jdCdBw9PfL9+dS4Fh8Mdz3NoUcqPk=
X-Received: by 2002:aca:a983:: with SMTP id s125mr17626004oie.30.1595841607241;
 Mon, 27 Jul 2020 02:20:07 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrahmedmuzashah@gmail.com
Received: by 2002:a4a:d6cf:0:0:0:0:0 with HTTP; Mon, 27 Jul 2020 02:20:06
 -0700 (PDT)
From:   "Mr.Ahmed Muzashah" <ahmedmuzashah@gmail.com>
Date:   Mon, 27 Jul 2020 10:20:06 +0100
X-Google-Sender-Auth: KP2AgscLWdsCSV09yh5oSlxScn4
Message-ID: <CAKAJx4e2jib281UOpM7gu5NBSPjDU=+X5gzMxfHWS_e4-cdEMQ@mail.gmail.com>
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
