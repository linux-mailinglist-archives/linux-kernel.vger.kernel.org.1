Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0061C2141FE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jul 2020 01:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGCXvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 19:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgGCXvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 19:51:40 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA451C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 16:51:39 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so31487996eje.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 16:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=t0TLC5mt6zw20J38nO6UV1Kz+5E95WBtIXeRkoxQ4a0=;
        b=kA5cN3BQQIDn+ta3F5MgSZopfc2+JCwPqrmwDWf/UVQK9pbylvFOzXJhKHczhXSS2z
         +pTxiMwjDarIoMBE8p4V/DxJgAFpUwi2ZWkZgQkpSKxAIZlulsi9d37uawTHp617oLOL
         VbpRt1LNDz2ARGkSwECYsnYNbASxRKqzc4vk/cnZACBxGf8NAxby02qPWbFbubjqtKgp
         BwhEYgUUucCZrNa/P4BdYmgTRrnZuBl/kHi2d74vY6G5+MFBjk3lhZTi7rf2X+9h9QFU
         o9QtvCN+YB4wifXbRFSh6QWUqDHJrBwoBqWNQc7UO6PeTFYfTCJqNLzrWgZsy6P7fsLZ
         lh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=t0TLC5mt6zw20J38nO6UV1Kz+5E95WBtIXeRkoxQ4a0=;
        b=lN2pGIeo1eON1sRQeSCVrxUdLM/xSdGQ8kAg3FAie8Lec4xjTSuIBjXUNKCVpfR2ze
         Tc4+f1OaES6+Q2duNYxUoPkiGC3jSng65Wk8SFsZyQLLkTxfqjoaL2jT88Gsx5OSnU9C
         cYAEniquHsCETmLX6Xh1tK2I8Dxv8lM1WMFPKgOj3FjzQkOM45c5cFH+Zr4J7wX/njal
         kOCPmGjRyUcx2P6YoBqYpGxObArw7vsqE0vPIlEJbxcFdkUzNFQpm+XLC9MhXGKV+aib
         mrMlZ3BUCIUSW9VBiiYf8eJ2Wdkj7IAWOLsJ/SHs1bpQcSuKBLdC/6Qb07Yg08Fa17WP
         /3/Q==
X-Gm-Message-State: AOAM532awRagmeyeQyEMkHcF0Jm2DdFuU5T7XAxnijuPVCQ/BJqKO6Iw
        vKdWTr2USJio6QbPw8XkC0eduOj6VYjqGU3yPnE=
X-Google-Smtp-Source: ABdhPJyHJU/UIUiU96pE9gQ1bqvLKja6DuJFKgW0Urw8L4s3GWTLghTulAE9GuVj6gns4BygPbc5+Lp25wDPbfjMrnQ=
X-Received: by 2002:a17:906:538a:: with SMTP id g10mr36318626ejo.354.1593820298368;
 Fri, 03 Jul 2020 16:51:38 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrsanna.h.bruun119@gmail.com
Received: by 2002:a17:907:2150:0:0:0:0 with HTTP; Fri, 3 Jul 2020 16:51:37
 -0700 (PDT)
From:   "Mrs. Anna H. Bruun" <mrsanna.h.bruun119@gmail.com>
Date:   Fri, 3 Jul 2020 16:51:37 -0700
X-Google-Sender-Auth: A55hwUKUkfxNbWeRcmazjvzGwJs
Message-ID: <CAMrr=JhOn-FjDq_qADc4Pu6BA_+eLuhRHkQ34nf7CqwR=4nCuQ@mail.gmail.com>
Subject: My Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Dear

My Name is Mrs. Anna H. Bruun, from Norway. I know that this message
will be a surprise to you. Firstly, I am married to Mr. Patrick Bruun,
A gold merchant who owns a small gold Mine in Burkina Faso; He died of
Cardiovascular Disease in mid-March 2011. During his life time he
deposited the sum of =E2=82=AC 8.5 Million Euro) Eight million, Five hundre=
d
thousand Euros in a bank in Ouagadougou the capital city of Burkina
Faso. The deposited money was from the sale of the shares, death
benefits payment and entitlements of my deceased husband by his
company.

I am sending this message to you praying that it will reach you in
good health, since I am not in good health condition in which I sleep
every night without knowing if I may be alive to see the next day. I
am suffering from long time cancer and presently i am partially
suffering from a stroke illness which has become almost impossible for
me to move around. I am married to my late husband for over 4 years
before he died and is unfortunately that we don't have a child, my
doctor confided in me that i have less chance to live. Having known my
health condition, I decided to contact you to claim the fund since I
don't have any relation I grew up from the orphanage home,

I have decided to donate what I have to you for the support of helping
Motherless babies/Less privileged/Widows' because I am dying and
diagnosed of cancer for about 2 years ago. I have been touched by God
Almighty to donate from what I have inherited from my late husband to
you for good work of God Almighty. I have asked Almighty God to
forgive me and believe he has, because He is a Merciful God I will be
going in for an operation surgery soon

This is the reason i need your services to stand as my next of kin or
an executor to claim the funds for charity purposes. If this money
remains unclaimed after my death, the bank executives or the
government will take the money as unclaimed fund and maybe use it for
selfish and worthless ventures, I need a very honest person who can
claim this money and use it for Charity works, for orphanages, widows
and also build schools for less privilege that will be named after my
late husband and my name; I need your urgent answer to know if you
will be able to execute this project, and I will give you more
Information on how the fund will be transferred to your bank account.

Thanks
Mrs. Anna H.
