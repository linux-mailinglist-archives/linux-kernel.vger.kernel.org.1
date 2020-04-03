Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7CB19E10D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 00:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgDCW2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 18:28:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33523 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgDCW2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 18:28:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id f20so8622793ljm.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 15:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ztm2c70nweVPXtPZ97E7qbHB7Ry5pYZyFypgiwrOPIY=;
        b=Er0IkP/deLDVRu09ZP8UT5uywg4gklKTG8m82afq2eQc92AjQ5VG6bvHLkN9wi21q0
         SVAwxNmPy4dGOy9EAUJjQmJlroptEQy2QhXaeIzWXoEN69QAG+ngdjlCveAn8Wcj3V+3
         B7q7OoR8t3HCWLgjV95nZvumDu4UG49HwxWpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ztm2c70nweVPXtPZ97E7qbHB7Ry5pYZyFypgiwrOPIY=;
        b=Q47nJywlTW0fVLn5iNUgWRbNPi6KArk4GXcyOmOcaPPDJW/W6FjBY5SnzCG1EnbOCy
         Dt4kd2l96j9eVqPJR7zV9cVk5cMJuE270vAYOMomLYS2ZdpYmknAsyIIfDDqQfwp/V/s
         rHE8n3h+UBh/2B1lXGmmoBtWEjdH/BzhpzEonOxh0x5UxSHNB5JklNbM5CgvTBzU4cpA
         6EECCinz6S4LeDehjmuZp2XIOUV4tBPNAm1to7CWFmTywQ5H6UjJKQBEgyPWFRYB/Hyu
         u3tBiTa6+6iHe2dsSmgmjh7xzqzbfrIdHtJzUo9dNblHG/0UGeKmtnDKlkBD30qjGaeu
         h2Hw==
X-Gm-Message-State: AGi0Pua1K9il7W0fOkybsLecjAWtB2fZychShciGFyQp0VtFhufAt+/u
        8BpAbjYdd4z++g/JH/h3mjtTDO5Ls0Q=
X-Google-Smtp-Source: APiQypLVDAxDkIQ8LIPWJYZQKAcEcvtSo+G7ZzPvm2XruptkMC4m6qhocBwxf1UCuBxPcGlQHodnNg==
X-Received: by 2002:a2e:904b:: with SMTP id n11mr6006623ljg.171.1585952890163;
        Fri, 03 Apr 2020 15:28:10 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id b1sm6977469lfb.22.2020.04.03.15.28.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 15:28:09 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 19so8544228ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 15:28:09 -0700 (PDT)
X-Received: by 2002:a2e:8652:: with SMTP id i18mr6314194ljj.265.1585952888185;
 Fri, 03 Apr 2020 15:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1aO+LUu6KsW+s8aZMNWt2yz7kqe=LARY=ifMKOqT9uNQ@mail.gmail.com>
 <CAK8P3a3iGtudeWTwufBYYM29jL5b_FRkqzU2QZiQRu0B2NhyZg@mail.gmail.com>
In-Reply-To: <CAK8P3a3iGtudeWTwufBYYM29jL5b_FRkqzU2QZiQRu0B2NhyZg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Apr 2020 15:27:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZHmvCmXmGNQmmwDOYXLqpg3X=-LLRZ=Yq9p6V3pSEig@mail.gmail.com>
Message-ID: <CAHk-=wiZHmvCmXmGNQmmwDOYXLqpg3X=-LLRZ=Yq9p6V3pSEig@mail.gmail.com>
Subject: Re: [GIT PULL 4/4] ARM: devicetree updates
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 2:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> To spare you the 80kb of git-request-pull output, here is a very
> abbreviated version

So you didn't do a test-merge and generate the diffstat from that?

That's just 567 lines and about 35kB, and I get

 488 files changed, 18917 insertions(+), 4522 deletions(-)

Anyway, it didn't cause any conflicts, and looks as expected for a DT
update, but I generally like to have the ability to compare to what
the sender thinks I should get..

               Linus
