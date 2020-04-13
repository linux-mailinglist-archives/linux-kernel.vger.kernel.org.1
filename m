Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129451A6503
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 12:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgDMKJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 06:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728101AbgDMKJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 06:09:41 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 06:09:41 EDT
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CE2C00861C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 03:02:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a201so9031706wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 03:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=SO9ksvHCVwmSeFL3unK4n9C/wUf29FKXi/haqTtxedc=;
        b=Kjo7hSTRS/cg0iaCwgS5GSHfZ32Mwngmto+bESlfuxeWlUAQbh7GfqWVWgQGfuELDe
         VPGgHxbN3aigGZTZZZX4nqlLHthjAsrhLP8Rcpb4yQpq1zrzdgXYi7jZyhHUM/9vaPdd
         fJsG+GIklO3fBjJiO0nHjUgsq/WD8aZYgZLE4x5B/qgjSOx6Quv+yEALeyeJ25bsisWk
         5lqa0K+VmG6bhDuW5oExo20o91Pbng2VQ3gaIwMtdkT2YDflaBj2HBRyb+kz9HGJrs1o
         japD7w9tlJywX4yTRa1Ulg/RUqZ1WnQLQ2Iatbs1ey63LZQOpCJ8MyrSZuiVJ7SVnnfx
         6KNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=SO9ksvHCVwmSeFL3unK4n9C/wUf29FKXi/haqTtxedc=;
        b=kt0Ad6YbemJo0qlflrKzXTPyqe8uAkZSU3eDRlU4Xlk4wtvtlLwR9bOR4vST2BmUt0
         YqGc4p/36rFScZm1kRNXAVjm4SRgTNc5+xMt2CpxzZGai4CoI/e7rytKukl04qsn3K9Z
         WKXwwnolbZarAFg5IOdYvM3np5K275Nc+vCL7Uh5pCvxk+L4I70wgOohXVAk4rjKOZ4D
         Jx/tuJGeOkGpThDtMPAZHbXNMpPx9BoYFWVegWrJJoupaU5U3S5h2Dk+5Hcq/xogvi0b
         VV7IlMFk4gFxjrqvG5dAZIkm7vSd7OW75+kl46LOgmtYaPwc9SDvgJ0PX4WJcwWyAk7O
         8k8A==
X-Gm-Message-State: AGi0Puaq3t+kCihFNY3PfEgn+icJp2STJGSORna1Dfhk6Demdzd0R1Uo
        b1Pmtw7Mrj7/nYLMEHkDTtyxvPL3Bpuy2U0+cg==
X-Google-Smtp-Source: APiQypIvA3u0u8gRMsW5B1QNIA8i3J3//V47jJTjDn8Nl8hUB3W7AWMSkPefO6z4XyUsTRnR1sisQwnqis6HVA7eFwk=
X-Received: by 2002:a1c:3105:: with SMTP id x5mr19013457wmx.51.1586772147435;
 Mon, 13 Apr 2020 03:02:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:c8:0:0:0:0 with HTTP; Mon, 13 Apr 2020 03:02:26
 -0700 (PDT)
Reply-To: robertandersongood1@gmail.com
From:   robert <robertandersongood12@gmail.com>
Date:   Mon, 13 Apr 2020 03:02:26 -0700
Message-ID: <CAEbqAVSgV9v9kP2Q4tj-PRZVfgSopAFRh7CRRf6EN_BC_aFKrQ@mail.gmail.com>
Subject: open
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Achtung: Beg=C3=BCnstigter *

* Seien Sie informiert, dass wir eine genehmigte Zahlungsdatei von
FEDERAL erhalten haben
FINANZMINISTERIUM in Zusammenarbeit mit dem Internationalen W=C3=A4hrungsfo=
nds (IWF)
Entsch=C3=A4digung f=C3=BCr Betrugsopfer und Ihre E-Mail-Adresse ist unter =
den
aufgef=C3=BChrten
die Opfer.*

* Ich schreibe Ihnen, um Ihnen mitzuteilen, dass wir Ihnen t=C3=A4glich $
5000.00USD von senden
unser B=C3=BCro hier, da wir das Mandat erhalten haben, Ihre volle zu =C3=
=BCbertragen
Ausgleichszahlung von 800.000,00 USD durch den Internationalen W=C3=A4hrung=
sfonds
(IWF) und BUNDESFINANZMINISTERIUM. Ihre pers=C3=B6nliche Identifikationsnum=
mer
vom I.M.F-Team angegeben ist CPP0920TG. *

* Hier sind die Zahlungsinformationen, die wir zur Weiterleitung Ihrer
Daten verwenden werden
t=C3=A4gliche =C3=9Cberweisung. *

* Name des Absenders: Cynthia Eden *
* Frage: Zahlung *
* Antwort: Ja *
* Betrag: 5.000,00 USD *
* Stadt: Lome *
* Land: Togo *

* HINWEIS: Das MTCN wird Ihnen nach Ihrer Antwort und Best=C3=A4tigung von =
zugesandt
Ihre Empf=C3=A4ngerinformationen, um eine falsche =C3=9Cbertragung zu verme=
iden. *

* Wir erwarten Ihre dringende Antwort =C3=BCber diese Adresse
(misscynthiaeden56@gmail.com <misscynthiaeden56@gmail.com>), um uns zu
aktivieren
Fahren Sie mit der Zahlung fort. *

* Ihr treu, *

*Abteilungleiter:*
* Fr=C3=A4ulein Cynthia Eden *
