Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A941ED4B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 19:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFCRJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 13:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgFCRJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:09:30 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A518C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 10:09:30 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id o13so2471180otl.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 10:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=dQonJaSpnG4RSUltEbBL495E2PQAEsjKG/KF64jU0cQ=;
        b=dcOBoBCdUMkSuLO0nqLmkSgMllWC2S7evKtZH22oJpFgIEL9sM2He6Zb4pHboN/1Cv
         u05FVjyI21bmkkHihKgr4EOhCyv9FfsdQQSLZSiKn0lm332hS9k2JSbtrL/aN3WZdCbz
         yrb/cDon1CeMTORH1JfgaLLuSJUHj5fiC590urNfBLX2mn6pUKwenH9VP4nNrRqA6I+3
         AVvL16LDbfQvG6XTz7EjMw11ejI+3Fpwpbj8jat29epZJniPj7IL6Emud8rMAFn8aq0D
         BaE2qfkJ20e/7vO7QUfpVr4AmthxoFhYHWMO43RvflQHxW6u2fFHmWvxJujRXegge+V3
         yfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=dQonJaSpnG4RSUltEbBL495E2PQAEsjKG/KF64jU0cQ=;
        b=XjxCbK+OQQD3usM+Pn5ZyTM0XL0zl6Opw12l9MMNJLqnG+9jkc32yjOT8LikpyIAKu
         Le/7rnGIYjzKB0aNDClUWz+fWUkBtC9TKSEXPPga2gbAy9KqYSh4v6TVYT8ANH0NnIvd
         lQarwXguaG44pk+YSUONvmMNmsbNdBkXsBovgj3E5gxZDFoJCV8kgXiYAMUMsgCyIzcQ
         NTOgguBi3TZyBGrXTOuy2ZqUrbBEyuI1Xea1HLEcZ+3XeYOS2oa4V3Jlzl6z4JVFbrII
         0ZQdBMlue/2R0RXzFHWRv6tI/tu85bAwJdriUxzj75lZa+aXrkeB+lER33q0muUtmrSj
         0YIA==
X-Gm-Message-State: AOAM531fmYcGoXF5/Ja4d6YGM1wLCahYd5SdI2Y4m0uqufnIJdBqBv/1
        vWnohmNq9Sa/mawrwLu9rSY7UZy2jsR6ecbQTpM=
X-Google-Smtp-Source: ABdhPJzVcoyTS8Vbrpi65qehNg6QGm2464stRkPpdYCZnDi2z18PZ7AAr5hNPPgieM5WZNbu9qVJjnQirqO6fT1OGoQ=
X-Received: by 2002:a05:6830:2305:: with SMTP id u5mr737064ote.341.1591204169698;
 Wed, 03 Jun 2020 10:09:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:150a:0:0:0:0 with HTTP; Wed, 3 Jun 2020 10:09:28
 -0700 (PDT)
Reply-To: westernuniion@collector.org
In-Reply-To: <CAG7_9onP0-awws9n4cbFBqzWBTQ-NT503y-i84nUTOzw6nvpLw@mail.gmail.com>
References: <CAG7_9omL+Z5YxYD7dkuhG96FRsxK+BC0W-eKnx1PYxC_4m+Xrg@mail.gmail.com>
 <CAG7_9okhowarmZu+_gwQtf5Hg=HkqSv7cv=a29VrRbQDbBKt7Q@mail.gmail.com>
 <CAG7_9okDRBanVG5JafX8a9cdTvtD_D0s_6iC2wkLkpowtk7Zwg@mail.gmail.com>
 <CAG7_9okY65D-5=-aG+cfHEHdhvw-Xh8fkUJdVHw64TPJxZAPUA@mail.gmail.com>
 <CAG7_9omZqofZ_GO3vozzfa1Sr4c7YoYw5EDqXzj20+hsvoXMEg@mail.gmail.com>
 <CAG7_9o=iHSnWMivrDQDEy2EdWb7oJj_GgUgytN_+Rykp-Jkw6Q@mail.gmail.com>
 <CAG7_9o=JqrMmmag4_JoB5SkWyHwjSQQMKCDdcgAdHdXvO1FKSQ@mail.gmail.com>
 <CAG7_9omKfjaFKjcj9ZhfRR4MvDZv+1XLvePJ0sy2_gRiTJ3AkQ@mail.gmail.com>
 <CAG7_9o=Zgf3A_92qPFBSkHhwyOh9j_zLOYOU6vZQEb3oA3Pqyg@mail.gmail.com>
 <CAG7_9ok58uoUJqi709f7Hcsu8phVu8eMx__1iNQwiSdjyu+-iw@mail.gmail.com>
 <CAG7_9o=nxojXmKxus5WwLHsaMCgNis+XG38QRGnk4mJYVaL04A@mail.gmail.com>
 <CAG7_9okj-7YXv=bP61TyfzNrnwz6-4tFCfbqMh=Xnp4jbURKMA@mail.gmail.com>
 <CAG7_9omV2ABWHzCCuqPtDT0Dhj3EoiwjKjg91bdsyY9Ysguoiw@mail.gmail.com>
 <CAG7_9okmr22BwrwDaHkVS3_UBknHzoj4U4s39mAWBrSn4dWW4g@mail.gmail.com>
 <CAG7_9onA7fLfn0YSH_2QVTcSb_+zOTG5A4dgLjZTP1tyZaMn4w@mail.gmail.com>
 <CAG7_9o=VQ-jA=mQgNboAHLJPzE3zSKjWYg+cQXP7=vW8qMG__A@mail.gmail.com>
 <CAG7_9okv=40g7DeNJvkrQCG7__K6EakCxnU2rHPd3GEXyUn8iw@mail.gmail.com>
 <CAG7_9om_qtGBvO=HdGs1hwRAyM58oEN6dnMm=w-B3=AT1sF2Ng@mail.gmail.com>
 <CAG7_9onnSx3dnaqgzqWVuGXXu-xWE=qO4uym_H_bwVp5Gy4bwg@mail.gmail.com>
 <CAG7_9okiL1Xz1bBzK0-3oUy+1Hzdji4yCVq77SONcvA3Ke+L3g@mail.gmail.com>
 <CAG7_9om2AKriGAdOmryrTgHRj=J-x1D4OmR4_SMtRQr8FdJ_2g@mail.gmail.com>
 <CAG7_9onvcaYPg+4d8_SKdbc0Ox_yEUVR9Y8ce8sLO5wZqEXcyg@mail.gmail.com>
 <CAG7_9omQBQ-+KKOBOuUgf9iQwW92cha=nR14CNHKE9hDrm87iQ@mail.gmail.com>
 <CAG7_9oktUmfb5TEAcvkiqk=broLPY_O=yFLRb91PqZFkX7Nr2g@mail.gmail.com>
 <CAG7_9o=tpxs-8-DCG0Rq2e1RLxA_ec3oUVb99Kb+omf0TOUtgw@mail.gmail.com>
 <CAG7_9omcOxhd2=vTqzoMs-j0ot1vxheiSXeZ9xKtHtnQ8ZA3ZA@mail.gmail.com>
 <CAG7_9okR1VHVGPwgZG3sREi46u4z24TxGn+6P29-ubcdyrAPNw@mail.gmail.com>
 <CAG7_9o=GshkN+ytCW4KFH82JFNkPJ5yQEK=v+0SLWnSeG4QihQ@mail.gmail.com>
 <CAG7_9okN_vFpEinRn=B+A8XyiJdY7yXodLSOjpSG19fUn52SPw@mail.gmail.com>
 <CAG7_9oky3Q_8AsHV-BcsXxLFxKYrTRhyjcaBZ7O1FFURi3pvRg@mail.gmail.com>
 <CAG7_9okJLha6eFHnVrU+RoQ+HTZGkREtGOtVfGbQ377GDquFww@mail.gmail.com>
 <CAG7_9okuOJrhRROOma3-pw8V77yz-1KHMwhqoXkHEWf90OS9tw@mail.gmail.com>
 <CAG7_9o=ULFzOoNQiQjHc_7kevs0w2JbF1YzkDSj=MD_O8Z-4bA@mail.gmail.com>
 <CAG7_9onSvbU6vz61M7htbv7Ma=rB-6w7m9FWey5GPxNsxXHX_Q@mail.gmail.com>
 <CAG7_9onSwVyc7O7T_8ZLQwPVT+16ZtsPvC=XiC7A0b3k2GYLcA@mail.gmail.com>
 <CAG7_9ok8-oj9L40KQSH38Zr4MU5izmmfYJd+BZYaokZ0V3xK-w@mail.gmail.com>
 <CAG7_9onimjpoOS7ZKsXTSLvEbuqz0TroA+M8tzvECsVCntDuvg@mail.gmail.com>
 <CAG7_9okD+vx_S-9zOhNbVMen6g2xp7Pzt3r-ri9n-+bRkafSDw@mail.gmail.com>
 <CAG7_9om7NdzTfkd14nCx-bZnmp664MGW-8oDvFCQWRgnFAekOQ@mail.gmail.com>
 <CAG7_9okjAQ0tPw22sGc_RWAOp9qpWmCpNkTQRz07hguCG7tw2w@mail.gmail.com>
 <CAG7_9onRfkLLN5r0C2BgJVrbhVGppnwaJ9yWspeYitimYTPk9g@mail.gmail.com>
 <CAG7_9okiNcfjbE-G5iymE4B01A7JkeBZ9qoDVzfSX6RY5a4bAg@mail.gmail.com>
 <CAG7_9onObg9szXMQTt103wZMONjD3DEJQMouD6szkq4HVfUTyA@mail.gmail.com>
 <CAG7_9okSeRsdQ2FLi_y+r7EmTrXttXxbMmYCwXtK0DEWA1YH8A@mail.gmail.com>
 <CAG7_9o=Cg=MrHMbXzNaNgEHcOWN7qgDRFQuJ4OFQ6RSGDWc0MQ@mail.gmail.com>
 <CAG7_9o=GONKK3v5-7NX1A8Zk_RyhR+XM2v3209p8R88s_Dv2PQ@mail.gmail.com>
 <CAG7_9ontmoWnfuPGBiWHAMpgg5iatZny1j6dY6fqFjtVvvz4BA@mail.gmail.com>
 <CAG7_9oncq4TFYOKWv9eKLP+QPWD=ANZQnP34+TW8fJK=837_4A@mail.gmail.com>
 <CAG7_9on3U7wKEK-1qbvFu1MGFw=iX7xWf4SArjXe9yAf7yt12g@mail.gmail.com>
 <CAG7_9omyx1q5F_itqBve5XbvKNTaHOwcaRV5+b1YA1ojWYPjpA@mail.gmail.com>
 <CAG7_9omcYgyS+d38opNOu=JJRZO-tLNOoVrv-89eaPAeTGJXrw@mail.gmail.com>
 <CAG7_9onrRo1ytVCeL56gVTt8wQFAHvFxwnihQKbASg5rQqSzTw@mail.gmail.com> <CAG7_9onP0-awws9n4cbFBqzWBTQ-NT503y-i84nUTOzw6nvpLw@mail.gmail.com>
From:   MR JOHN KENO <ekeneomor32@gmail.com>
Date:   Wed, 3 Jun 2020 17:09:28 +0000
Message-ID: <CAG7_9oneuXdX1R91KMjNfsMXYsrh3AYcvsgAZsvErpf7L2qv9w@mail.gmail.com>
Subject: Good day
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attention Beneficiary,

This is to inform you that the United Nations Committee on
REWARD/COMPENSATION have selected your Email I.D for the New year 2020
program. The Microsoft through a careful world wide web gathering of
data made a very careful electronic base selection and your Email
happen to become the No 6 luckiest winner and therefore the United
Nations will be rewarding you with the sum of US$2.5million.

To avoid double claim, we ask that you keep your winning information
confidential until your claims has been processed and your money
Remitted to your  Name in your country.

Your Winning Numbers  fall on our African Booklet  and your Total
$2,500.000.00 was Deposited in Western Union under the care of Western
Union Manager in Lome-Togo by Name MR JOHN KENO

Bellow is your Winning Information
( Winning Number 6) TICKET  NUMBER :  (14) (15) (27) (30) (37) (10)

Now  Contact Western Union Manager in Lome Togo MR BILL CAMPBEL ask
him to Transfer your Total $2,500.000.00 to your name in your Country
Contact  Person : BILL CAMPBEL
Email: ( westernuniion@collector.org )

Now Contact MR BILL CAMPBEL Email: ( westernuniion@collector.org ) ask
him to send you the total $2.5Million  which  Your email wins  for you

Remember to Contact BILL CAMPBEL on this Emails : (
westernuniion@collector.org )  with your  Information=E2=80=99s  to enable =
him
process your Payment

Congratulations
Yours in Service ,
Dr  Lili  Casandra Yong,
Director General,  United Nations Industrial Development Organization
