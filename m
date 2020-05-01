Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF0C1C116C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 13:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgEALSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 07:18:46 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33647 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbgEALSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 07:18:46 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M4skB-1jUCRP0t4p-001vj9 for <linux-kernel@vger.kernel.org>; Fri, 01 May
 2020 13:18:44 +0200
Received: by mail-qt1-f174.google.com with SMTP id h26so7623624qtu.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 04:18:44 -0700 (PDT)
X-Gm-Message-State: AGi0Pua0WKqyXOyMiBTO9BxfJMEZXGMCxgotmy+68+4+hDsGX+W/2VkD
        kCBO4BkKgllD5GCakVJI5ulwJ5rcxKila7ryw/k=
X-Google-Smtp-Source: APiQypI9OKu1B7jncXjmN38iMLIbpf70oBObPs6bsMVYXBWzRDBfknkLwWwqtZawu0BCQZi145V/VP1gPjMhm6zOoKc=
X-Received: by 2002:ac8:12c2:: with SMTP id b2mr3242832qtj.7.1588331923111;
 Fri, 01 May 2020 04:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <CAK8P3a2Gzj9SVZSGo+PxWR0cMJb1sFwv+ii9J6jEGE-Z41Fr+A@mail.gmail.com> <20200501010733.ptvgzl3nbxybo4rd@treble>
In-Reply-To: <20200501010733.ptvgzl3nbxybo4rd@treble>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 1 May 2020 13:18:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a38c1vnzNUriCqSfRvqOVcRfT6eaE5DL=6-Nep7988fCA@mail.gmail.com>
Message-ID: <CAK8P3a38c1vnzNUriCqSfRvqOVcRfT6eaE5DL=6-Nep7988fCA@mail.gmail.com>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:NRZI2Uika/em8tXOm+1Z+FIOFW565fJM6pG1CbKjPFdss+Ye3+N
 9EGuLOMUYLud8J/dlWB8+zGR8Bsg10R9dvIqGPIvuxlAFFWHEaB8w0rwT7gVNcG7ZWZPZ9V
 VSeefWEJAyGXLKjd8OLQKC5UODiHs5r9LShIe60hArwERfQE47PDapXDvH1JwtQinj1+bRX
 9H6bjRcupp9+xcyEW/1FQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KsRY5PvDVpE=:gWuiaRrCVTRGDkZm5YlGVF
 oxYj3pmmN9hB1gkfeoB9QtYHuH2yyUoLWXEatKKheHNS5prUhKUd1JT3w8+eWGHGOIgvsHv07
 OvSxseQihcRD6m6Q24VgJn9o14zJd6cx+qJqc7Ud10FCBTnhd2uu8t49d326BunsksZhIU7UA
 Au2euiepvIeZNa0If678oUagX94LQc0zhyziReclQHtYDLK9cSc1eTfATbvd2GMJzX4kWi5Be
 PPelusrDv+Sx8rr5+FJ2TojDTWYUzIQRtP19tqDsGiI7ocHO5XZeKFbWncvV69F5Cdp0N4kzA
 9jgM5mlnfDoinIsyRPeqQ9BWaUWRgr2IenC+g8atzrKf7/schIKeFkBOVN1W71DzzfwG5zYs3
 Jbghi7mlg8TST01lumQ0xS0LOHH5lBE5pa2ASOoiot+ZTzgLGV8iLFtxmuLCiYsSUsAb4kRKn
 oBdciv9DjU4N+Oap+TpadIj8TUGGQ725NXJ41ojxHG1eSL+XvrV+Pen5N9XYHRI8Y+4YamdDV
 QJzJyX6tCSsg6s2zLsFPDQU5+pI51otYUToqWYLh/fpGqPamIhyCLqYXMjyyMBTkiawLcD6pU
 7/5Dec/QaROVS2lz7RpM10EbH/zeyp3gdIqxXQA1PMdH/yL6xsenOtX15OSQb1oxw/aqgLqHZ
 g+RrrKMGIipbL7HecEzw7ORGzfzmpePo6z1XIa3ywPaIe3xrwsRCIMhWvCUAjMcCs9dKuWxle
 W55PCViQRI5Oy0zCnhoPLGzmOF5yeDB9ULgjVFdxJj1UYCmReKwIexo5losJKPWoDIG0MxzJR
 6OsfGJmSVjn8pnZVv/xRYF4XZFjCSzqyunMhzNYfsb/s9BR+jY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 3:07 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, Apr 30, 2020 at 04:05:07PM +0200, Arnd Bergmann wrote:
> > lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x133: call to do_strncpy_from_user() with UACCESS enabled
> > lib/strnlen_user.o: warning: objtool: strnlen_user()+0x122: call to do_strnlen_user() with UACCESS enabled
>
> Does this fix it?

Yes, it does. Thanks!

        Arnd
