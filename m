Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BF21BA952
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 17:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgD0PxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 11:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726185AbgD0PxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:53:11 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B76C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 08:53:11 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id y10so17817061uao.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 08:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=r0N1EeYnvgzph2uoq461ajvN2Tmmj2Z3oCMYuPwn74k=;
        b=lVn/2VM1YEqZpS6KybGtk08dCNDmMerA2xOsU7gVQpe7WpcjVYM6/i5FKNSMaZNC1m
         co2X9hvP0yq8WydreFP9P7PYqPVRUyEJ+yTFQIZOd4k4eBPt/P7nTXd0pbpVZACsfIEK
         DxISUcFU66DZqnZ/zJ0TyqQbhYvM2MUaCAavn6fz0+M4i3IKAM2uDYCKtAq/DeHvn2bP
         4e5LeiBW37jRyp/rTWu+BTLN8s9PThiy5D6N2hqReM3u7W70NVn/sipz11itkfgOsgpU
         KcMrV+dgv/Mz4vTEf+IX5aRBDlEVGwtg+tOfs5q3lSdybC/H1ro6VJ78k+HAfz2Pofgx
         ZdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=r0N1EeYnvgzph2uoq461ajvN2Tmmj2Z3oCMYuPwn74k=;
        b=jYfONeZqIDGQMvSW/u+rBk7tJTu038sYouTXiZ7/sbeCbqvteRk4uBHuGcckMWNYdo
         RBbpgguTMHl3qyMfhvaMjLSG2K2aGt02P4b67oO9CWdBseIiG1TXWOLyzNE6iQK0vD6I
         IGsStoIpcQ3bQzKZzV10pAaa7oWe6OUiXiHi3d6YLb1yahUo9Si/r3wVttqNJE6yWP0o
         Ez+Mysaa6J4kb4bOtr6SsJBVevHlgFegDLe1LLZ1WBlSzJ6/tR6S34voL2dh7EkKj8aq
         cYDBbSQy0s0619JZn5hMEVfkQn2jNpT5HteBiyZrzMNwiGxXIV+GMUg3JmK/MzEK171z
         OPZw==
X-Gm-Message-State: AGi0Pubpk0IFb4nh0Ia1DB7PB4Jb42UVlDZIFbNlqKjE5TzEWGrwdk6k
        gAX0zOqvqE+OkKaY67r265zCsMpF0HWCWtvJxVU=
X-Google-Smtp-Source: APiQypK8zk0WsB3RAadSaeW24XhIO0wByJ+qMJEFN4I+gDf/LspWiVULOxUPGzbRuUGkA2RKBs/mJgMXuHEGJEmfvLY=
X-Received: by 2002:a67:fa57:: with SMTP id j23mr17679560vsq.174.1588002790822;
 Mon, 27 Apr 2020 08:53:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:4226:0:0:0:0:0 with HTTP; Mon, 27 Apr 2020 08:53:10
 -0700 (PDT)
Reply-To: headquarterubabankplctg@gmail.com
From:   blessing nwachukukwu <blessingnwachukukwu@gmail.com>
Date:   Mon, 27 Apr 2020 17:53:10 +0200
Message-ID: <CAEVRJOorjy6LWVWHTnvffeVsnROFur3s+uNc7RYzbnF6S24Nuw@mail.gmail.com>
Subject: =?UTF-8?B?wr9Dw7NtbyBlc3TDoXM/IEVsIHRpZW1wbyBtYXMgbGFyZ28s?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Estimado propietario del correo electr=C3=B3nico / beneficiario del fondo,

=C2=BFC=C3=B3mo est=C3=A1s? El tiempo mas largo,

Soy abogado Ashili Willians ... quien se contact=C3=B3 con usted para una
transacci=C3=B3n comercial hace alg=C3=BAn tiempo, pero algo llev=C3=B3 a o=
tra y no
pudimos lograr nuestro objetivo de transferir el dinero a su cuenta
bancaria como lo planeamos mientras tanto.

No olvid=C3=A9 sus esfuerzos pasados =E2=80=8B=E2=80=8Be intentos de ayudar=
me, y ahora
estoy feliz de decirle que logr=C3=A9 transferir esos fondos bajo la
cooperaci=C3=B3n de un nuevo socio de la INDIA, para que sus esfuerzos no
sean en vano, He decidido ofrecerte una compensaci=C3=B3n.

Ahora comun=C3=ADquese con la secretaria en UBA BANK, su nombre es Sra.
Patricia Wilson y p=C3=ADdale que le env=C3=ADe un total de ($ 1,800,000.00=
) (un
mill=C3=B3n ochocientos mil d=C3=B3lares estadounidenses) de tarjeta de vis=
a ATM
para su compensaci=C3=B3n, su nombre es Sra. Patricia Wilson. p=C3=B3ngase =
en
contacto con ella ahora a trav=C3=A9s de su correo electr=C3=B3nico
(headquarterubabankplctg@gmail.com)

Adem=C3=A1s, con la siguiente informaci=C3=B3n a continuaci=C3=B3n:

Tu nombre completo =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Pa=C3=ADs =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
Direcci=C3=B3n particular =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
Una copia de su identificaci=C3=B3n: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Tu n=C3=BAmero de tel=C3=A9fono =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Y su c=C3=B3digo postal =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
Sus ocupaciones =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Respecto a Barrister, Ashili Willians.
