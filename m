Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2520D2E86CA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 09:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbhABIlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 03:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbhABIlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 03:41:32 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9B5C061573
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jan 2021 00:40:51 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id q25so21520506otn.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jan 2021 00:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jltf3aLw4OGej+NVd+JR/FQjbyu4uWLHwk6TXPviXNI=;
        b=mUfSmSi1hzZB7vt+4I9fu0ypes8fSwEIdm+XTm3ydJaIfESGY9uvGiiJ7CnEyOXdzk
         Cv+QNmkp9BgYqCGHLQ62DhReYwI9SP30X+9e+CtXNMYTtKM9iW/HZP+kCM9Fe8wdXon9
         I640FjD4YJBZfttNhYZS8T7hctgeJlRM5cqYBWaBlaiTiGNeYq4+rMSolboCITAXP33Z
         CTH5OHF+P028n6kJAwkCSIoeDLEj10kVju1Nh5K2CGcPPuOsfvTYov3ZbduJQNO229Kp
         54hsVdzdvTpPWDal/SAW9e+cjDbHdnNmvCF67qAWKAe6Xlcnep+nnjARaqyfYTguTzWm
         vtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=jltf3aLw4OGej+NVd+JR/FQjbyu4uWLHwk6TXPviXNI=;
        b=Txc3t4lZc17PoZ00JrFE7+TLctmV0WzVtnQsIpyKTYc3Mg4kD4hulj0Zpchhy33lvd
         ZHZoeirr9xKm5oQYQHrfEOwzEwIyb5wZUuFkgqc5DmfOGvw32NdGr26h7zwPrK48mObi
         fJXm6P3BPHsn1mWWpGrzB57ILex2Sda8p2sDQVl6VjVkLh8qvkI/R0yG5CZIK4itK8Kx
         WZ6Gf1BCmltVxNL9qQ/YF/oVCo2QHHeyEk2LSKRBKTruwYaITCQz/lCYmY1qGgqs8mGv
         z3t+so36yQHtRBW8dcf5LaugI6dZi8hkNaB5P9SPedvuNYPS++DyPSVDAKN0jZXb3LgA
         AaRA==
X-Gm-Message-State: AOAM531z5S1pCHUqXMMEgJ9zrVoAJXkmksz4oPRPKogmcovU3yUw9eGa
        hvXFvuaEfyfCSsN3ILDc7z3o/SVtM4LQ1ZFZPj0=
X-Google-Smtp-Source: ABdhPJyWMIJAaOVe55/BCwGK+YLCsQo1fSlZ3hoK8Ljtkv9G7nSZgPohPcIIqfnKnhSK26a1TztrIupb2X/zecuXaxE=
X-Received: by 2002:a05:6830:19e2:: with SMTP id t2mr46009366ott.192.1609576850533;
 Sat, 02 Jan 2021 00:40:50 -0800 (PST)
MIME-Version: 1.0
Sender: leondickson44@gmail.com
Received: by 2002:a05:6839:1458:0:0:0:0 with HTTP; Sat, 2 Jan 2021 00:40:50
 -0800 (PST)
From:   Mr Tom Crist <tomcrist441@gmail.com>
Date:   Sat, 2 Jan 2021 09:40:50 +0100
X-Google-Sender-Auth: KI12th8nYqyt-eWOadGgOmyYbfo
Message-ID: <CAB3vTqmG0GaWcQVMoRgPg1EJmJcgj8AA6k0Fsop4SCYzoVBcCA@mail.gmail.com>
Subject: Re:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kanadalainen Tom Crist, joka voitti 40 miljoonan dollarin dollarin
arpajaispalkinnon, kirjoittaa ilmoittaakseen sinulle, ett=C3=A4 Google
yhdess=C3=A4 Facebookin kanssa on l=C3=A4hett=C3=A4nyt s=C3=A4hk=C3=B6posti=
osoitteesi
saadaksesi minulta 4 800 000,00 euroa, koska olen p=C3=A4=C3=A4tt=C3=A4nyt =
antaa osan
voitostani pois hyv=C3=A4ntekev=C3=A4isyyteen, yksil=C3=B6ihin ja j=C3=A4rj=
est=C3=B6ihin. ota
yhteytt=C3=A4 minuun saadaksesi lis=C3=A4tietoja osoitteesta
Tomcrist441@gmail.com
