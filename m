Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8C32A1F7C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 17:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgKAQYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 11:24:34 -0500
Received: from mout.gmx.net ([212.227.15.19]:48763 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbgKAQYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 11:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604247842;
        bh=pTUyR6tOXKepKJgE5JbfDuSLtn4tVdPcYcxIg81BW+4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=aRee6je3IbkkLX/D2eiD7iOdW0Vdp79ciwQuWuXP0wMKwN3LPRIv6Wk7v39Vg0QpR
         91hlYfFz9BuoTcoPHnaAnjWOQowprINuOiaGNaLlSdXcy54KqDorQwPUUZxFSxt2c+
         cqjFKAnYm1z8XH6fd78LEB8/UT65QhUZ3ZJln1FY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.191.216.249]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKuA-1kxMbK0DsW-00Scd0; Sun, 01
 Nov 2020 17:24:02 +0100
Message-ID: <580d12716f6363d7404805fd4bc50e2d5ab459b0.camel@gmx.de>
Subject: v5.8+ powersave governor breakage?
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Sun, 01 Nov 2020 17:23:59 +0100
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Tou4lR2diKgAUlAyESwl6Zoea42IX/kWbC5uPoDT5iDSCxcdvec
 XS36GTEanaFfXEmzXToEl+2/2HmecYTkg2od39qgF9sBU3kNbDFB5Nyh0af9Rd3TBZ6oMx6
 //uZuLO3dhk6kZVENnweSIKlgjJWDmwXgifAxdismTaZY2MQtHvwjk5KfjQB3yyBDyY/0CL
 ZwGI8u2q8Pw/hcwQdupKg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f4tB0xzRtbY=:AXxcX1V7ogcSiZe5Tok9Zk
 9Sq5heIuXxvM8XmFMklKSFBTNnRkIHr/xnKyA+7KVr1vNgPbMGvRo6jvZylPe6JWx37bwdXtf
 U92BiAHyA0S51tcZ6NwhbHja5I9CdqYrc/cGsuJ3Nfn63eFRvzAeRyl2PvSy0FsRFNC36WeEp
 tDsQ2FyjaSwcU5xKfQXBwvXZiZllw4X5OqrwcqZQEmhTVyHhMIt3kP762ryHSnRuQRxQvhjBI
 m1QzOfiQm3nJVqdAktR+4mfw3/Hj6Go7JmZLcJ+RcXdpXoHe5xCfoZM4rWvIR0GijIxMl6E6O
 xrus+VfPGeK8jg7dmpPwFSVjCpCc4gmZ7KdRIBQLbLSVDXVy380D6ld3UkSoAPiN0ttjdTS3V
 cZdsLUH9g2S6EyTv0QgfI50TNn8d8blTWLgfTTj9bTuE170umHk/NkLixX4kym94qUnZ40Ix8
 bGEwP3ULittOZA5tHd/ghzRDcq7Zq+AiEUN4x5ob5yECPN/H4Bphvpk0NA3zVKg4Q8asLcnQu
 c4tPsfsOTqx9ojbUKnG5+hxLDGil9DAFWRaxZ9Nf6UjpcOoi1TxhZi8KKZnl2u7lvYQ5pqkY7
 luAkiy0svVvUDIgQxYVJRer+mU1hIFipgmYKdpCJQ6xhzESjihtDbPSlUcVk5dje8sCaPZ6JV
 g2lA+GAfOKQK4e2C36qEt6FHf93mQhFNGjIsrctZ9lXvYzoYrTp2pyAO3vl001vb4ixk+ZYJL
 KlUKfijThfROloz3uJFBJkRJoI7HcrNEAaexCwpXqjWDnEcOrBt9oVIxzcSHYnI142tbguYR1
 2DD3HOUrkcLDE23A2sSX6w96zyZjUr1F6wS2SblGOajSyfugYmZgk7Cpxyoe7KRDAWqwasYgP
 f7PQwi0x9QnXvRYUqWZA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

As you can see in the data below, my i4790 box used to default to the
powersave governor despite CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y, and
disallowed switching to ondemand.  Post 5.8, powersave locks in at the
lowest freq available, and while ondemand becomes the default, it takes
a cross core scheduling performance hit compared to previous powersave.

On a positive note, schedutil, which I used to have cause to avoid,
seems to have improved a lot while I wasn't looking, and now actually
improving cross core performance a wee bit.  Seems I should configure
stable 5.[89] kernels to use it as well.

taskset 0xc pipe-test 1

CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y                         defaults to
5.4.74          2.183264 usecs/loop -- avg  2.179480 917.7 KHz powersave, ondemand not allowed
5.5.19          2.184331 usecs/loop -- avg  2.179776 917.5 KHz powersave, ondemand not allowed
5.6.19          2.198156 usecs/loop -- avg  2.204380 907.3 KHz powersave, ondemand not allowed
5.7.19          2.230582 usecs/loop -- avg  2.231981 896.1 KHz powersave, ondemand not allowed
5.8.17          3.203949 usecs/loop -- avg  3.207272 623.6 KHz ondemand
5.8.17         12.840411 usecs/loop -- avg 12.898500 155.1 KHz ondemand -> powersave
5.9.2           3.024442 usecs/loop -- avg  3.040023 657.9 KHz ondemand
5.9.2          12.348519 usecs/loop -- avg 12.299751 162.6 KHz ondemand -> powersave
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y due to db865272d9c4
5.10.gc2dc4c0   2.121057 usecs/loop -- avg  2.121487 942.7 KHz schedutil                note: 4.0 GHz perfect!
5.10.gc2dc4c0   2.987989 usecs/loop -- avg  2.988658 669.2 KHz schedutil -> ondemand    note: 2.9 GHz not so perfect
5.10.gc2dc4c0  12.447348 usecs/loop -- avg 12.475363 160.3 KHz schedutil -> powersave   note: 800 MHz heeelp meee
5.10.gc2dc4c0   2.135548 usecs/loop -- avg  2.137868 935.5 KHz schedutil -> performance note: 4.0 GHz (obviously)

