Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E159C1D8B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 01:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgERXMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 19:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgERXMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:12:00 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8789DC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:11:59 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g1so11668920ljk.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=VpIhGC6Lvq0gEOepoKQi+nWSg6fUb9zVRSukw5aKRKg=;
        b=XiRg6pk/NVn3T4obZGElticlFlFsfFDiO0jN25w9iegPhFGPM93vaj8CtqzGuj99I5
         vgUpjg8I0OmvqjVSkDSImeNFHPWYd4/PD7WLU/tD4gzx4wSKLS84w7pt/Z5lNoaTd6yO
         36HOjvvdiME4gYnd5CEuWgMApjMSuBKUVDT1gn4HS5U50sDUnLrBJDAn/na4Dci/BQ5Q
         6YfwwWFVmPyyFpSFdbZMxWOme017vnwwR1eOzziL6T6Y7kMEwSSoVaWUoKqxxNUxcx1W
         jpPqOoPWUS6YazoT1FZOPFaPXMKCwzALkY7FMJSqiR81PtMbTVyJxK3z2DM8kq5yi9VK
         lvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=VpIhGC6Lvq0gEOepoKQi+nWSg6fUb9zVRSukw5aKRKg=;
        b=GLkfAar/QHHMOf+MKbmzIDqIlmq274EKbFtq8J7ZJHPJnW7iue9rOv64HHieMN6r5G
         ATtj8w7nnY2TBuTXS/m3f2USB2R5rg7IB+OCUJa7I6FJDJL9IfIFg5pkmCP6iy2BGNnI
         Jc6cjoc7/9L1grUxFOqgaBQV+luM0fwJwScZxEHNP1e+W9pXra1BkkIDEp/gqO5AvgLI
         MjijMCyyMdXAKoMA9MxZf3UpWX2hT+dhPNC+3cJ2LPKluhfa75pnOVvj2YQO/UA4mToR
         kT2uWjtbVLW9sjPS3pNpkQc5igzAXRVff5tJfmUICmBzwtqLdw1XKaY3bk7ljF1e9rfE
         yhfg==
X-Gm-Message-State: AOAM5337TkLidkpjnND34BdE3Pbtt3EK7mJBXS87mXM3DKtIUr9SzN42
        qczy3Safc/Z1S5M7GNZCR7Z7PS4pkEpVwZPIF0k=
X-Google-Smtp-Source: ABdhPJxFFkhvIQGUxOJeEdmh/fMHidKAlnJb/5n/6qRHIg9leCIx7MRMfNl+K1xXmhbeSbTNSmMRVRMOBrhIe2JD7AA=
X-Received: by 2002:a2e:9e97:: with SMTP id f23mr11581292ljk.228.1589843517872;
 Mon, 18 May 2020 16:11:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9251:0:0:0:0:0 with HTTP; Mon, 18 May 2020 16:11:57
 -0700 (PDT)
Reply-To: angepaul70@gmail.com
From:   Ange Paul <mrclement8@gmail.com>
Date:   Tue, 19 May 2020 01:11:57 +0200
Message-ID: <CAEeZHgd8SURrs7nD4GoA9PvZ1AwBWkBgpt3ygz_zWn-OKqFm5A@mail.gmail.com>
Subject: =?UTF-8?B?7JWI64WV7ZWY7Iut64uI6rmM?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7JWI64WV7ZWY7IS47JqUIOy5nOyVoO2VmOuKlCwNCg0K7KOE7Iah7ZWY6rKMIOuwlOyngOyEoOyc
vOuhnCDqsJHsnpDquLDroKTripQg7Jqw66as6rCAIOyEnOuhnOulvCDslYzsp4Ag66q77ZWY6riw
IOyghOyXkCDrgpjripQg6riw64+E7ZWY7Iuc6riwIOyghOyXkCDsl7Drnb3tlZjsi63si5zsmKQs
64u57Iug7J2EIOychO2VtCDtlZjrgpjri5jsnYQg7JyE7ZW0DQrtkZzsi5zrkJjsp4Ag7JWKIOuC
tCDsmrDtjrjsnLzroZwg64u57Zmp7ZWY6rOgIOuYkO2VnCDsnbjquLDripQg7IS46rOE7JeQ7ISc
LOyCrOuejOydhCDsoovslYTtlZjsp4Ag7JWK64qUIOyCrOuejOuTpOydhCDrj5XquLAg7JyE7ZW0
IOyLpOyLnCDtlZjsp4Drp4wg64KY64qUIOqwle2VmOqyjA0K66+/64qU64uk64qUIOuLqOyLneqz
vCDquLDrj4Qg7JWK7JWY7J2EIOqyg+ydtCDrs7TrgrQg64+E7Jqw66+466GcIOuCmOyXkOqyjCDt
lZjrgpjri5jsnZgg7J2A7ZicIOygnOqwgCDqsIDsp4Dqs6Ag7J6I6riwIOuVjOusuOyXkCDrgpjr
ipQg66y47KCc64qUIOuCmOuKlCDtlYTsmpQg7KeE7Ius7Jy866GcDQrrj4Tsm4DsnYQg7KO86528
64qUIOustOyLnCDrgpjquLAg65WM66y47JeQIOuLueyLoOydgCDsnbTrqZTsnbzsl5Ag64yA7ZWc
IOyYrOuwlOuluCDsgqzrnozsnbQg66qp7KCB7J6F64uI64ukLiDrgrQg7J2066aE7J2AIOyViOyg
nCDtj7QgMjMg7IS4IOyVhOydtOuztOumrA0K7L2U7Iqk7Yq47JeQ7IScIOyGjOuFgCzrgpjripQg
64KY7J2YIOuKpuydgCDrtoDrqqjsnZgg7Jyg7J287ZWcIOuUuOyeheuLiOuLpC4g64K0IOyVhOuy
hOyngOqwgCDslYTso7wg67aA7Jyg7ZWcIOy7pO2UvCzsvZTsvZTslYQg64aN67aA65Ok7J2AIOuY
kO2VnCDsoITsnpDsnZgg7J207IKs64qUDQrrho3sl4Ug67aA66y47JeQIOyasOumrCDrgpjrnbzs
l5DshJwg6re46rCAIOyjveydjOyXkCDspJHrj4Xsl5Ag7J2Y7ZW0IOyekOyLoOydmCDsgqzsl4Xs
nYQg64+Z66OM65OkIOykkSDtlZjrgpjsnZgg7J6Q7Iug7J2YIOu5hOymiOuLiOyKpCDrr7jtjIUu
DQoNCuydmCDso73quLAg7KCE7JeQIOuCtOqwgCDslYTrsoTsp4Dsl5AgMjAxNyDrhYTsl5Ag6rCc
7J24IOuzkeybkOyXkCDsl6zquLAg7Jqw66asIOuCmOudvOyXkOyEnOuKlCDruYTrsIDsnbTrnbzq
s6Ag7KCA66W8IOq3uOydmCDslYTtlIgg7Lmo64yAIOy4oeqzoCDrp5DtlZjripQg6re464qUDQrt
lanqs4Qg7J286rOxIOunjCDrkZAg6rCc7J2YIOyLreunjCDri6zrn6woJDcuMjAwLDAwMC4wMCns
mbzsqr3sl5Ag6rOg7KCVIOyEnOyKpO2OnOyKpCDqs4TsoJXsl5DshJwg7KSR7JqU7ZWcIOydgO2W
ieydgCDsl6zquLDsl5DshJwg64K0IOuCmOudvOyZgA0K6re46rCAIOuCtCDsnbTrpoTsnLzroZwg
7J6Q7Iug66eMIOyVhOuPmeyXkCDrjIDtlbQg64uk7J2M7J2YIOy5nOyymeyXkCDsnoXquIgg7Y6A
65OcLiDqt7jripQg65iQ7ZWcIOuCmOyXkOqyjCDshKTrqoXtlojquLAg65WM66y47JeQIOq3uOqy
g+ydmCDsnpDsi6DsnZgg7J6s7IKwIOq3uOqwgA0K7KSR64+F7Jy866GcIOq3uOydmCDrj5nro4zs
mYAg6rO164+Z7Jy866GcIOyasOumrOydmCDqsIDsobEg7Lmc7LKZ7J6F64uI64ukLg0KDQrsgqzr
npEg65WM66y47JeQIOq3uOyXkCDrlLDrpbgg7KeI7Yis7JmAIOymneyYpOulvCDrgrTripQg6rCA
7KGxIOy5nOyymSDqsJzrsJztlZzsl5DshJwg64K0IOu2gOy5nOydhCDthrXtlbQg6re47J2YIOye
rOyCsOydgCzrgpjsnZgg7JWE67KE7KeAIOyhsOyWuOydhCDqtaztlZjripQg7ZW07Jm4DQrruYTs
pojri4jsiqQg7YyM7Yq464SIIOq1reqwgOydmCDshKDtg53snYAg64K06rCAIOyghOyGoeuQqeuL
iOuLpCDsnbQg64+I7J2EIOyCrOyaqe2VmOyXrCDqt7gg7Yis7J6Q7JeQIOuMgO2VnCDrqqnsoIEs
64K06rCAIOuMgO2VmeydmCDtlZnrtoDqs7zsnbQg7KCV66eQ66GcIOyVjOyngCDrqrvtlZjsnbQN
CuustOyXh+ydhCDthrXtlbQg7J20IOq4sOq4iCwg64K06rCAIOybkO2VmOuKlCDqs4TsoJXsnZgg
64u57Iug7J2YIOyEoO2DnSDrgpjsnZgg7IOB7IaNIO2OgOuTnCDsiJgg7ZuE7JeQIO2KuOuenOye
reyFmCDrgrTqsIAg6rGw6riwIOuLueyLoOydhCDrp4zrgpjqs6Ag7KCV7LCp7ZWY6rOgDQrqs4Tt
mo3tlZjripQg66+4656Y64qUIOyVnuycvOuhnCDqtZDsnKHsnbQg6reA7ZWY7J2YIOq1reqwgOyX
kOyEnOuKlCDrj5nslYgg64u57Iug7J2AIOuPjOyXkCDquLDquIjsnZgg66qo65OgIOyImOydteyE
sSDruYTspojri4jsiqTsnZgg7ISg7YOd7J6F64uI64ukLg0KDQrroZwg67Cb64qUIOq4tOq4ie2V
nCDri7Xrs4DsnYQg64KY7YOA64K064qUIOq3gO2VmOydmCDqtIDsi6zsnbQg64+E7JuA7J2EIOyE
seqzteyggeycvOuhnCDsoITshqHsnLzroZwg64+I7J2EIOqzhOygleyXkOyEnCzri7nsi6DsnZgg
6rWt6rCA6rCAIOuLueyLoOyXkOqyjCDtlYTsmpTtlZwg66qo65OgDQrsoJXrs7TripQg64u57Iug
7J20IO2VhOyalO2VoCDsiJgg7J6I7Iq166W8IOynhO2Wie2VmOuKlCDsqr3snLzroZwg7Jiu6rKo
IOuPiOyeheuLiOuLpC4g66eI7KeA66eJ7Jy866GcLOuCtOqwgCDri7nsi6DsnYQg7KCc6rO17ZWY
64qUIDMwJeydmCDstJ0g67mE7Jqp7Jy866GcIOuqqOydmA0K67O07IOB7JeQIOuMgO2VnCDqt4Dt
lZjsnZgg64W466Cl7JeQIOuMgO2VnCDsp4Dsm5Dqs7wg7J20IOqyuOyGkO2VnCDsmpTssq3snYQg
6riw64yA7ZWY64qUIOydtCDqsbDrnpjripQg6rKDIOqysOuhoOyXkOuKlCDstZzshoztlZzsnZgg
7LmgIOuVjOusuOyXkCDrgrQg7IK27J2ADQrsnITtl5jsl5DshJzripQg64KY7J2YIOqwgOyhsSDs
uZzsspnsnoXri4jri6QuDQoNCuyhsOuwlOyLrOyXhuydtCDqs4Tslb0g7J2R64u17J2EIOuTo+qz
oCDquLDri6Trpqzqs6AuDQoNCuq3vOyLpO2VmOqyjCDri7nsi6ANCkFuZ2UgUGF1bA0K
