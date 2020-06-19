Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFD4200357
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 10:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbgFSIPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 04:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730921AbgFSIOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:14:06 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF86C0613EE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 01:14:05 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r2so10312711ioo.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 01:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=j11Vr1o/pvQ42/N8z9lOlfwLxefAj/oFaHN/5yBjPh0=;
        b=lbDocrsWjYFh0jAiT7AWK2Ah734BMS03OCpbYh6k05YKQ6rSkA2J2MbDvDqNdM0th4
         enKA1cQQmMF7+B4dqgicTET1jWj+MvHNvs0LwMTMXl6wJ+lqZfeflafJptso9lLpPmoZ
         xBo92VWL7NFKL2kQOkszzyy+KpsYnXB3DY4nJch3foZssYf+uhA1NF4ffpkopKSeeHYP
         3eLrjBgp2N61M21Yc3WenM2omJ2NE6K6mF4FMgcIZ4A35/21XyLj8dX5m5OEdc37SmTO
         W7U/tshIrROkV5HRQnPzfcW/GaLW2amipmK6XQkKj2CENaM1pRv8mbrALCclCwmcbPro
         2N4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=j11Vr1o/pvQ42/N8z9lOlfwLxefAj/oFaHN/5yBjPh0=;
        b=tdDUzLOew9sXBipwQZCsJJaJ34Fn/cyS0yPLvCyBBX2giDzsgMqJfNVdl6DNXIzyxF
         ZIHevFtqRlWl2e9FW4iqKXHoDvhf7HozIcLy7Vf/PGntBaKTRjtWM+sElv8r39etVpPm
         JBFEL/g/nI77e6x4C/IVfj7HOaH/k+HqX07lJ4jRKX/Yo+lZbr1GHmzA3TMyywtHvjrK
         KkNMSwmceein69gT+bJzYX/J5l2UF7IZu/aBf0ieBVBl0bmh4BvX/SdDFfRh9bQf79Z6
         nfMjDWwaEoxTXFSbCJppBlq5u9gFgX6HgceOsNLv93MH29sCe1l+cUbmEHED1MIX8RwB
         v5ZQ==
X-Gm-Message-State: AOAM530O+ze2g5EwS6qrqVi3I/IlPxb1kVA5G7N3Aby0j0EW0IN5duuj
        lHXrxpEu+GrWX9c3EgNTRK1iULqyl1wUMJ4AlxQ=
X-Google-Smtp-Source: ABdhPJxZH2aEo56bIs4k2KgxTbLa91h7sakPOPAFOJfoosBnkWQ4IRzd9HsLMEPIpspodxY+NLZc2ZwykP/LidnkhQo=
X-Received: by 2002:a02:1745:: with SMTP id 66mr2594458jah.141.1592554444576;
 Fri, 19 Jun 2020 01:14:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:6716:0:0:0:0:0 with HTTP; Fri, 19 Jun 2020 01:14:04
 -0700 (PDT)
Reply-To: ahmedzengo1111@gmail.com
From:   Mr Ahmed Zengo <farausmani1@gmail.com>
Date:   Fri, 19 Jun 2020 01:14:04 -0700
Message-ID: <CANrUft72RPZDD1YqMRkPqGTLwTgp4OSwMovXLNn+nhB3qTnkWw@mail.gmail.com>
Subject: =?UTF-8?B?7Lmc7JWg7ZWY64qUIOy5nOq1rA==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7JWI64WVIOuCtCDsgqzrnpEsIOuLueyLoOydhCDrr7/snYQg7IiYIOyeiOyKteuLiOq5jD8NCg0K
7Lmc6rWs7JeQ6rKMLA0KDQrsoIDripQgTXIuIEFobWVkIHplbmdv7J6F64uI64ukLiDrtoDrpbQg
7YKk64KYIO2MjOyGjOyXkOyEnCDsnKDrqoXtlZwg7J2A7ZaJ6rO8IOydvO2VmOqzoCDsnojsirXr
i4jri6QuDQrqsJDsgqwg67aA7ISc7J2YIOq0gOumrOyekOuhnC4g66eI7KeA66eJIOydgO2WiSDq
sJDsgqwg6riw6rCEIOuPmeyViA0K67KE66Ck7KeEIOqzhOygleydtCDsgqzrp50g7ZWcIOyCrOue
jCDspJEg7ZWY64KY7JeQIOyGje2VqA0K6rOg6rCdLCDriqbqsowg7Ja166eMIOyepeyekCDsgqzs
l4XqsIAg7J24IEhhbWlkIEFtaW5lIFJhenphcSDslKguDQoNCuq3uOuPmeyViCDsl7Drnb3tlZjq
uLAg7KCE7JeQIOqwnOyduOyggeycvOuhnCDsobDsgqztlojsirXri4jri6QNCuqzhOygleyXkCDr
jIDtlbQg7JWM6rOg7J6I64qUIOy5nOyymeydhCDssL7ripQg642wDQrsi6TtjKjtlojri6QuIOq3
gO2VmOydmCDrj4Tsm4DsnYQg7JqU7LKt7ZWY6riwIOychO2VtCDsnpHshLEg7KSR7J6F64uI64uk
DQoxMC41MDAuMDAwLjAw7J2YIOydtOyytCAo7LKc66eMIOyYpOuwsSkNCuyynCDri6zrn6wpIOqz
hOygleyXkC4NCg0K6re47J2YIO2VtOyZuCDruYTspojri4jsiqQg7YyM7Yq464SI66GcIO2ZnOuP
me2VmOq4sCDsnITtlbQg64u57Iug7JeQ6rKMIOyXsOudve2VmOq4sOuhnCDqsrDsoJXtlojsirXr
i4jri6QuDQrsmrDrpqwg7J2A7ZaJ7J20IOuLueyLoOyXkOqyjCDsnbjsoJXtlZjqs6Ag6riw6riI
7J2EIOuniOugqCDtlaAg6rKD7J6F64uI64ukDQrqt4DtlZjsnZgg6rOE7KCV7Jy866GcIOydtOyy
tO2VmOyLreyLnOyYpC4g7J6Q7IS47ZWcIOuCtOyaqeydgCDsoITri6zrkKnri4jri6QNCuuLueyL
oOyXkOqyjC4NCg0K65Sw65287IScIOyymOumrOulvCDsi5zsnpHtlZjroKTrqbQg64uk7J2M7J20
IO2VhOyalO2VqeuLiOuLpC4NCuuLueyLoOydmCDsoJXrs7QgOg0KDQrshLHrqoUgKElEIOy5tOuT
nCDrmJDripQg7Jes6raM7JeQIOq4sOuhnSDrkJzrjIDroZwpDQrri7nsi6DsnZgg7J2066aEIC4u
Li4uLi4uLg0K64SI7J2YIOyEueyKpCAuLi4uLi4uLi4uLi4uLg0K64KY7J20IC4uLi4uLi4uLi4u
Lg0K64u57Iug7J2YIOuCmOudvCAuLi4uLi4uLi4uLg0K7Jes6raMIC8g7Jq07KCEIOuptO2XiOym
nSAuLi4uLi4uDQrqsrDtmLwg7Jes67aAICjtmLzsnbgg65iQ64qUIOuPheyLoCkNCuuLueyLoOyd
mCDsp4Hsl4UgLi4uLi4uLg0K6rCc7J24IO2ctOuMgCDsoITtmZQg67KI7Zi4IC4uLi4uDQoNCg0K
DQrrgpjripQg64u57Iug7JeQ6rKM7IScIOqzpyDsnb3snYQg6rKD7J2EIOq4sOuMgO2VmOqzoCDs
nojsirXri4jri6QuDQrsuZzslaDtlZjripQNCuuvuOyKpO2EsCDsoKDqs6Ag7JSoDQo=
