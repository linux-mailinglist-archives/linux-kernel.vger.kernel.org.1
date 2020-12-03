Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96D92CD016
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 08:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388030AbgLCHHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 02:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbgLCHHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 02:07:21 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F33C061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 23:06:40 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id q137so1019133iod.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 23:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hVpX1ttsrKj6Yiiu3u4Ys8yb2zxg6tjxMruypxzcCpo=;
        b=ecJDwlkjzAUhBO4T4H8qPPp000hr2SpIxENvHmWgg4+RO3Gsa8WKbwEI4e/3r3PDLz
         gPKUJtjBsFn9C7jGeliaYox2u6e4eas1W/Cwfk7KOZURlmvDNVjZeOt3PEZ74ce7ik3f
         GezQnkbu1qP/3vNhrzcZ2SHHSQ/vCxsmYOX0IOzAtlcmtLlWUr9PDa2jQOMdI8NvLJyd
         9nhEzg+vnLU/LOX6atmzwyq0IOJWELpbr7Ow0cI3e/Nw1lpiPEDEyNR7MEH9bIirJxOk
         AjINNg2C2q+jJ4r8Rllujw6ix9WMOt06KFX/agoh2VUxv6w12AiPUDLwmF0/k/k2dDrs
         KnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=hVpX1ttsrKj6Yiiu3u4Ys8yb2zxg6tjxMruypxzcCpo=;
        b=Dv/c0hVReXdqAqqT3SXf7Q22R/3W+VbdMs/rryPbjpiyB/+MmYZokyHrptqFXe1EaG
         0QBvBrpdb7QSMjmzZbXn6vcbCQRrFBBlq98V91ojxibrN25riBKtcq3uDqr9X+pK5qrr
         gBdNdfW6YOrCc1VaZ8acLBDCKw2bv7TEWGwR3RNEMQxRr/M6bz6AgT5Ec+f7fQ5M+/7M
         k9SUdUM91kXc1z0w6jZhq1Cvu3hfDPdzmgF2B0ezuEIKm+4+RV79LnbNWO6zFEngDuuS
         3L6BQIJDRTEu7BIOp9lD5aku8ZLIYpYQrDP9Jk7qwthC8w19cdPbAJcRgo2bRj/Gea89
         ekEA==
X-Gm-Message-State: AOAM5323Qg0nHijcNnl0zwljbbko3FrhZ5tdbVfuIXjKMEKLgtvyRSFg
        jRkXhPnvPnYCMDnD9+3Bn5c4Aho5mMyL62OKDvs=
X-Google-Smtp-Source: ABdhPJyjsW1OqF4cZWCCEXtfEhgZR6avPrjF/vfgVWENtqECNjTAEt9TJgzld3YYjp9V6zvZvVEXsd9zrrdgbW9EOvo=
X-Received: by 2002:a5d:9a8e:: with SMTP id c14mr2236015iom.178.1606979200003;
 Wed, 02 Dec 2020 23:06:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac0:a88b:0:0:0:0:0 with HTTP; Wed, 2 Dec 2020 23:06:39 -0800 (PST)
Reply-To: michaelfishry@gmail.com
From:   Charles Jackson Jr <soniafred3@gmail.com>
Date:   Wed, 2 Dec 2020 23:06:39 -0800
Message-ID: <CAF7pH=pBARyS-K5kz9Na8NK9oCnXerPJWC_RFhX6fAkbhhF--w@mail.gmail.com>
Subject: =?UTF-8?Q?Herzlichen_Gl=C3=BCckwunsch_zum_Gewinn_=21=21=21?=
To:     lindenblatt@utzenstorf.ch, lindy.hop@gmx.ch,
        linthairservice@bluewin.ch, linus.amstutz@gmx.ch,
        linus.arnet@gmx.ch, linux-kernel@vger.kernel.org, lion-cave@gmx.ch,
        liorbadertscher@gmx.ch, lis.waechter@gmx.ch, lis.willi@bluewin.ch,
        lisa.bieri.arch@bluewin.ch, lisa.bosshard4@bluewin.ch,
        lisa.estermann@gmx.ch, lisa.kull@gmx.ch, lisa.vogt@ag.ch,
        lisa.werren@gmx.ch, lisabilleter@bluewin.ch, lisafopp@bluewin.ch,
        lisbeth.oelrichs@bluewin.ch, lisbethbirrer@gmx.ch,
        lisbethweber@gmx.ch, lischera@bluewin.ch,
        liselotte.staehelin@gmx.ch, lisette.bieder@bluewin.ch,
        gast@mailadresse.ch, gast@tschannen.ch, gasthof-zum-baeren@gmx.ch,
        gasthof.bahnhof@gmx.ch, gastro.kasernebern@bluewin.ch,
        gauchat.viva@gmx.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20

Ihr E-Mail-Konto wurde f=C3=BCr eine Spende von $ 3.500.000,00 USD f=C3=BCr
wohlt=C3=A4tige Zwecke ausgew=C3=A4hlt. Antworten Sie auf die folgende E-Ma=
il,
um weitere Informationen zu erhalten

E-Mail: michaelfishry@gmail.com
