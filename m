Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B831DF83E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 18:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgEWQbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 12:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgEWQbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 12:31:48 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833F1C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 09:31:48 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x23so12133568oic.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=gFcbtr1w9lbE9orv4J551QU+Arj05Sj9ZADz4fQaLmY=;
        b=Ws/3L4j7Id89QstV3UG8fk3qd215R2nTIG95dOlQXevuAO0cHuarFPJWoUmP2rCk66
         18U+plihktqeBcBVdr//W36w7urv9BqbTsvM9CYTOekJTtjjUYP1Ge1i9XMnu6hzHOIr
         gzuiFKvVqMgq5zdRsOo5RL8eS8QIEKXy363FA42EIBl8lEFFweIa8IEsewOTYAdOaZvy
         drM4/KH978FZcd5aRH0exku0NAR7yEOX5no3djtnM0OSlytXr4sdt0n/Lz1xqzSTogyj
         3UiTXZtLtxObUPR/OWViEx9XxNP8DpHE4sKHnf+qToti7Irl2dTHcpJZFMoju8AQnTzN
         CIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=gFcbtr1w9lbE9orv4J551QU+Arj05Sj9ZADz4fQaLmY=;
        b=gAI8fPgMgV2v/LvunTO915mT5COyjbUwVfHpsMH32StOEaDn7Tx6+Qzx8aDze6yWmq
         9P9KjLIIyxJa/gqjrWG6zqarhp/DuTA0A49+jAUYKs1dwMl8yjv+KSq7uZYnMimW+HN3
         HADXkpIMA391MhISadqoTd9oGogGBzvbNwaW08XgjhdXOVp9IRUhqqpBW+bjMdwzThYS
         T+Jsb4wl6i3YjIqUnR80xu1dRnIvB4e/SPeASJwwSJmzNy4+b4FOORzxPj/HO1dz4gWG
         K1msqFG1seJ9LjS51JwsJ7exgDZZ9uzsI8ta8Ihg6iMiLfR9cu3fqx8O6Php3cEBz7zN
         sLHQ==
X-Gm-Message-State: AOAM533/d1qtGWtQDoG3CscUMXOfST6M1U357BoojAISfT89+zTU6uWC
        Me6icOBOZoqdEy3sNEDta7uPSwMhWCBV6Fe9TI4=
X-Google-Smtp-Source: ABdhPJwK2OQ7lq+Z69UVO24ttNJoTVD5mC7aCWSSM9E0MpA2pETDqGI4aUmG7RdB4GMWPoKX0p9isc1ZDl+kqMreVYM=
X-Received: by 2002:aca:3a55:: with SMTP id h82mr6034762oia.135.1590251507929;
 Sat, 23 May 2020 09:31:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:e83:0:0:0:0:0 with HTTP; Sat, 23 May 2020 09:31:47 -0700 (PDT)
Reply-To: bukuridervishi@seznam.cz
From:   Bukuri Dervishi <clementinaabe@gmail.com>
Date:   Sat, 23 May 2020 18:31:47 +0200
Message-ID: <CAAghV-sKpJmWCb0aqRQ4NX8HJ3BO4U29xk+baFghKR0k=YbvyQ@mail.gmail.com>
Subject: URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ramadan Kareem to you,

My name is Bukuri Dervishi, I=E2=80=99m a citizen of Albania base in Turkey
for my previous business. This is a confidential message, I have lost
two of my children due to covid19; early February we came to Italy on
visit without knowing that things was about to fall appart. Not only
did my children die as a result of covid19; I also tested
positive, and it has defied all forms of medical treatment,

I may have only a few days to live, as a result of that I want to
donate my entire Money thirteen million five hundred and eighty
thousand usd($13,580 million usd) to you for charity work as my
promise to God since I will not be needing the money any more. I'm
donating the money to you because I do not have any other heir and my
trusted Steward who would have handly this assignment is incapable due
to old age and ill health.

I am given you 40% for this job while you are to give 20% to my former
Steward and donate the remaining 40% for charitable works such as to
donate 20% towards the fight of coronavirus and 20% to the less
priviledges in the society. I will give you
more details on how to get the money. Kindly let me know if you are
capable to handle this,and if you can=E2=80=99t please kindly reject the
offer.

Thanks and stay safe
Regards
Bukuri Dervishi.
