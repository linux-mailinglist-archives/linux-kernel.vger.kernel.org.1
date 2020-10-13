Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360AE28D6DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 01:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387783AbgJMXNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 19:13:08 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:35009 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729677AbgJMXNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 19:13:07 -0400
Date:   Tue, 13 Oct 2020 23:13:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1602630785;
        bh=HcCDjaFaXBvvfsaJrMpGL1OgdbVzNQngYH/aJmEbeyY=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=JYFxZtT3I280PMXYhCEwwRx14RYLSkfY/YZ+E+qLXiFDa6L82kH5TvtP6N9SoOY3v
         2vu4Dh7TJ4OsyFe9Gl8ej9fIjDg+B7yzNo1fCu0AsWNlVBLlHmnUNlCYIl2kSqeBnA
         PIdv8HxjBXMMIBFC1ErpDsPZSvIgJG8x2NRTct+g=
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: [PATCH v2 0/5] docs: automarkup.py: Make automarkup ready for Sphinx 3.1+
Message-ID: <20201013231218.2750109-1-nfraprado@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch series makes the automatic markup extension ready for Sphinx 3.1=
+.
It was based on Mauro's Sphinx patch series, and requires it for the namesp=
aces
to work, but could also be merged through the docs tree without regressions
(other than the increased build time explained below).

The first three patches make automarkup compatible with Sphinx 3.1. The fir=
st
patch makes use of the new C roles in Sphinx3 instead of the generic type r=
ole
from Sphinx 2, while patches 2 and 3 solve the warnings caused by Sphinx3's
stricter C domain.

Patch 4 adds cross-referencing to C macros with parameters for Sphinx 3.

Patch 5 enables cross-referencing inside C namespaces, which are new to Sph=
inx
3.1.

On an importante note:
In order to be able to support automatic cross-referencing inside C namespa=
ces,
I needed to disable parallel source reading for Sphinx in patch 5. On my
machine, this makes the build process take about 4 additional minutes. This=
 is
very bad, since the documentation building process already takes too long, =
but I
couldn't think of a way to sidestep this issue. If anyone has any idea, it =
would
be greatly appreciated.

Also, for some reason, disabling the source read parallelization makes
Sphinx output 2 warnings saying so, which is another annoyance.

Thanks,
N=C3=ADcolas

Changes in v2:
- Split the single patch into patches 1, 2 and 3
- Change sphinx version verification in patch 1
- Thanks Mauro for the clarifications in v1:
  - Add patches 4 and 5 for the missing functionalities

N=C3=ADcolas F. R. A. Prado (5):
  docs: automarkup.py: Use new C roles in Sphinx 3
  docs: automarkup.py: Fix regexes to solve sphinx 3 warnings
  docs: automarkup.py: Skip C reserved words when cross-referencing
  docs: automarkup.py: Add cross-reference for parametrized C macros
  docs: automarkup.py: Allow automatic cross-reference inside C
    namespace

 Documentation/sphinx/automarkup.py | 188 +++++++++++++++++++++++------
 1 file changed, 154 insertions(+), 34 deletions(-)

--=20
2.28.0


