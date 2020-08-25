Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00BA251A78
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 16:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHYOEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 10:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgHYOEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:04:51 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0947C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 07:04:50 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id n128so11698890oif.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 07:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=JSgGwhGvPr+KJZvjnrUslvVj9jpXHDMkdMBwXVwG3Cc=;
        b=gv/ilhOo/CJuaRy+5jiJ85/gSssL8rbJ/1YRRb6JU4Qc8pmJjBam1gl5VviDYh1qko
         e15HfbTsZ7jcrIEcUIYYZW+QbboJgAu+72tiqJFPHAlSg/iHVl5LMyYdUySfEzUU7rcL
         uCnSDvRzuFaWg88okF3hP28IMw7GkKVzCLyRrwZoro3ErOxIOjW86X/Vw99ypXO3OAC3
         BR9PUdPQRSXSy4ucIhcfnOzPXy+Mhg4nmpde6T0ajYikxkddCf14ud0pe3/OZNkXKSfC
         7KlFsYqE0SH/UshfTrNpFcDi3bM//D8YGcf/kdFJRTWSmFPLTnjxyY3edqHNlNVjLCM4
         VShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=JSgGwhGvPr+KJZvjnrUslvVj9jpXHDMkdMBwXVwG3Cc=;
        b=jFO2A8lMTFdhdq06RRBZZLCwmOOtUfg3PJ0zKzTdtZdWfk5sj8XO044W7rfiSfTAhd
         jMffqz5X4A+5k0FDmG1KEXPQ4IhRCQBe1Q6QJcWJJAEtaopD2w4j7djIoTA7jIPLJLDp
         2TpkdK78Y2sCgB22tyYeI+WRWQkDLQf9NUE7+Wjgs4wsIzDaoII2DolBas7Y+HB8+7av
         uY3aKMSaoHXlxjA7HkIZqCXePMp8ySfirzfHUJSQZpvjCXGzk9m3ayCPAvqDhyXb3odo
         mbMiWj8rFlfV63Akex6zQAy5NdlFZytGXLKGaW1vq9o40JP1yulXLMp8CUvoClB633Rj
         B81Q==
X-Gm-Message-State: AOAM530yYRV4UpGeppA2GHadWAqOQUmPNr+VQMTkNsq6umH/zNDyUVcl
        qTRAxVqUxOqI7pwv8qX9M8yazxY3xSleLX8Ikb0=
X-Google-Smtp-Source: ABdhPJxPghVPbLDSLQUt/3ZwXWsborMKFBq54BiGFYyuEyzO98pQFUDsiy9OyGgbbu1vy5uQ6KTXSTxXHzBPd5KqvUk=
X-Received: by 2002:aca:f109:: with SMTP id p9mr1030013oih.84.1598364287092;
 Tue, 25 Aug 2020 07:04:47 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrahmedmuzashah@gmail.com
Received: by 2002:a4a:9bca:0:0:0:0:0 with HTTP; Tue, 25 Aug 2020 07:04:46
 -0700 (PDT)
From:   "Mr.Ahmed Muzashah" <ahmedmuzashah@gmail.com>
Date:   Tue, 25 Aug 2020 15:04:46 +0100
X-Google-Sender-Auth: RmrbX9HERxkKl4c_fxunBvxVOco
Message-ID: <CABD4V+8vX-fU6-wnHdE9r=-BmLh2qurLPi5mcBGjrEbgOFCkwA@mail.gmail.com>
Subject: =?UTF-8?B?U2Now7ZuZW4gVGFn?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sch=C3=B6nen Tag,

Ich bin Ahmed Muzashah, Account Manager einer Investmentbank hier in
Burkina Faso. In meinem Unternehmen wird seit langem ein Kontoprojekt
von einem Kunden unserer Bank er=C3=B6ffnet. Ich habe die M=C3=B6glichkeit,=
 den
verbleibenden Fonds (15,8 Millionen US-Dollar) zu =C3=BCbertragen. F=C3=BCn=
fzehn
Millionen Achthunderttausend US-Dollar.

Ich m=C3=B6chte diese Mittel investieren und diese Vereinbarung bei unserer
Bank einreichen. Diese wird im Rahmen einer legitimen Vereinbarung
ausgef=C3=BChrt, die uns vor Gesetzesverst=C3=B6=C3=9Fen sch=C3=BCtzt. Wir =
teilen den
Fonds zu 40% f=C3=BCr Sie, zu 50% f=C3=BCr mich und zu 10%, um eine Basis f=
=C3=BCr
arme Kinder in Ihrem Land zu schaffen. Wenn Sie wirklich an meinem
Vorschlag interessiert sind, erhalten Sie weitere Informationen zur
=C3=9Cberweisung.

Dein,
Mr Ahmed Muzashah,
