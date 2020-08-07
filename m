Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2980D23E4F2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 02:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHGAHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 20:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgHGAHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 20:07:53 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B8AC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 17:07:53 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m8so44976pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 17:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qJ0InrU+fTxISKkt7fP3RVNGAVH3fxkEPOzKL5a9mNg=;
        b=V4Cj5wU8pZ12+ChWhuwsL/R+DK1CppiEsu/URID/Er76x03BWGDRaj/n7il8NOiSbG
         pFJxks7WZKd3MlT2NhX+JJblI8u9adUsms4CX3PcqvkuEzZJl7NTIRi4dzSD3/acEQEo
         PkZXJD8mumNBoF3tfUb8xoVFT152Cl2yoStdjJ0vHzZDux1D9uC9Xsn/Rzxcib95Me93
         qN5HidqtN3pf1Id84+0Zurzx8e0VpdX8FL3GoOacoNEllyLddoKzq3HW9NIZS5swb7GE
         wlD0a1pADFFJwC77tr1rlw3AcPmAYFT8gyOPENxu7rvjYjFiku0vjI/Gnc2qFoIRZDo5
         BHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=qJ0InrU+fTxISKkt7fP3RVNGAVH3fxkEPOzKL5a9mNg=;
        b=B0y0BCpGxgzKQRd5mue2CSJiILYxZ5DqG6vhveyOuS4gdZMvUJkTmSWFKI6BYla615
         kcIbJ3wr8aBXzjeoPjAc9zl1a6mID+An9SiCXWiGYjFNYhYKZ7z0jJELGqQ6jF/EibnJ
         8w4cpYxiWlkNN42U697pGMEmFO6BbyFOoEB0U1GxUFT+/3RNzrE1TN5qXNcpKIc1Gnhm
         bNEuyaFAK0JKqvTRfk5vCUQ8yvrXq1H/rdu8BEoxAfluCDFHNYPfRaN2lsoQSTH3iVR3
         xjVvDlUbQL6bxII1oD8rDqvbLO95efcNi8AYxMTGoyogReuWmhgCtymQXCOyKBnEJvtB
         jZbw==
X-Gm-Message-State: AOAM533+k5NO+WGo6HmOHJJJQXkNFtSfq6UzbAQUxno6lHhyr5/tZQpS
        +1njf0cVY5p45Po853Jop8pJhhVQLQiM0KoLejI=
X-Google-Smtp-Source: ABdhPJxOREjez7X4R1uwxGST5QPysu3pb9Oc7nRL28J8s5wveO9+CmFmiZSmNdOKD5CY+prSnB7fVpRjp4dIKzYAGWI=
X-Received: by 2002:aa7:94bd:: with SMTP id a29mr10789219pfl.280.1596758872861;
 Thu, 06 Aug 2020 17:07:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:1f83:0:0:0:0 with HTTP; Thu, 6 Aug 2020 17:07:52
 -0700 (PDT)
Reply-To: charlesjr46@aol.com
From:   "Charles W. Jackson Jr" <dg012629@gmail.com>
Date:   Thu, 6 Aug 2020 17:07:52 -0700
Message-ID: <CAJa=D0Wk5dNJ36PVRVb2cQtRkiHvaX3rx3VE2VBh5=QPKKgcOg@mail.gmail.com>
Subject: =?UTF-8?B?NTUuMDAwLDAwIOKCrCBhbiBTaWU=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Herzlichen Gl=C3=BCckwunsch, die Summe von 55.000,00 Euro wurde Ihnen von
Charles W. Jackson Jr. gespendet. Ich habe beim Powerball-Jackpot
344,6 Millionen Dollar gewonnen.

  Dieser Sieg ist ein Segen. Deshalb habe ich beschlossen, der
=C3=96ffentlichkeit etwas zur=C3=BCckzugeben. Dies bedeutet, dass ich offiz=
iell
bekannt gebe, dass Sie als einer der Nutznie=C3=9Fer von Charles W Jackson
Jr 2020 ausgew=C3=A4hlt wurden.

Bitte senden Sie eine E-Mail an Charles W. Jackson Jr., um Ihre
55.000,00 =E2=82=AC zu erhalten: charlesjr46@aol.com

Ich, Charles W. Jackson Jr., gratuliere Ihnen.
