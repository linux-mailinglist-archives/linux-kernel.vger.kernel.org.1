Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0012C864B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgK3ON5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgK3ON4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:13:56 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85699C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:13:16 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id a3so25345503wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=i8H0OIus+QScT4fRLnyZI/Eq3sMnzoGFdLddwZ4DhGY=;
        b=sMTBADxc2u1kERRoKuJNULOCRiSw6vE03sbFMJSBG4pE1Nh9P78616fblJY5fy4ldn
         D/JDq3wV5rT8zngdvMJsQMEmFxpxIZ/fNYGX23Sw+FmO99HgASeBt+GYPz5WQTeg6dYX
         QxCbo1ADgItxxhatdlkKlYDxMpgoOV38WV+V14w/LIIqSvWPa4oHh0tkRKCJnBbT95Qe
         dUmYFi6nTeblMpuAAFvlj4sI2v4DbSjc2VsA4Fi+k0dOTEPtEN8TmVRw4Nlc/y7Frtqs
         nO8wPO8IIvZdzW6UhN6oC2N+6dZ48HjyZjp2T1mFCWjW8+nK/KQ5j7aE4uCI6a13Ve4R
         0Xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=i8H0OIus+QScT4fRLnyZI/Eq3sMnzoGFdLddwZ4DhGY=;
        b=gSeXsYD/TrLCtWys+R736XWytzPSRIVt1ug5kJA1NvGxRhQIJzOVLF+CKhQj1enTEn
         fhSIOgkVyXuNO9BnHHFaQ2Y1/OPM5zWXYdX30XLtF3mfpsXJJAG+TdjgPZS+B16Sf9PB
         N9L6kziuXW7XmPGNBs5VOvldb74DC0/0+DGcNaHWoTTChwL5f0+hyzIVzrklR8JbVQVY
         X1Dk8ru8mpBJmUXP+HKYKENzLXnaqFXKne3Wmk1gkWLcjIk4nF6Kgmmm6pzfbtnSngVN
         wur6X18ooA9hE5tmpudHjwz5xsW74+K0Pd05MbFGmmn+ux1jtCm2vPjvu4JrJft0aTMe
         G97g==
X-Gm-Message-State: AOAM530i8tMjxnjojS3feqIJo7HdLJ6TBihDEJ1lpki04tu43KXsrJRG
        DF2ErUkcVWkiT53UnKZtdtK9Xq3wwY4e1Eexe+4=
X-Google-Smtp-Source: ABdhPJwZ4L0fuJkwtOvHUZMhflt+T2IGo29XX3ddm2KpLdvLn7jWtkgiGTqEKqy5M0Y5uCDkxsKf5ZjBAoZxIruVN7c=
X-Received: by 2002:a1c:630b:: with SMTP id x11mr8413640wmb.138.1606745595243;
 Mon, 30 Nov 2020 06:13:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a1c:2485:0:0:0:0:0 with HTTP; Mon, 30 Nov 2020 06:13:14
 -0800 (PST)
Reply-To: charlesjacksn020@gmail.com
From:   Charles Jackson <evelynrussel23@gmail.com>
Date:   Mon, 30 Nov 2020 15:13:14 +0100
Message-ID: <CAPqaGUt=Zfr=JbPh4FOVSUxmhF5Se0cBxsQedxYuKhjTRBxSKQ@mail.gmail.com>
Subject: ANTWORT AUF CHARITY-SPENDE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
IHR E-MAIL-KONTO WURDE F=C3=9CR EINE SPENDE VON 3.500.000,00 USD F=C3=9CR
CHARITY AUSGEW=C3=84HLT. Antworten Sie auf die folgende E-Mail, um weitere
Informationen zu erhalten

E-Mail: charlesjacksn020@gmail.com
