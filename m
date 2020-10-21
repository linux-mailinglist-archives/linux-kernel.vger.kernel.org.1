Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6252294C73
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411608AbgJUMTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:19:05 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:59191 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411474AbgJUMTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:19:05 -0400
Received: from [192.168.1.155] ([77.7.80.77]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MVdUQ-1kwjqG1u6O-00RYUm; Wed, 21 Oct 2020 14:18:48 +0200
Subject: Re: [PATCH 1/2] x86: Remove led/gpio setup from pcengines platform
 driver
To:     Hans de Goede <hdegoede@redhat.com>, Ed W <lists@wildgooses.com>,
        linux-kernel@vger.kernel.org
Cc:     fe@dev.tdt.de, "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20200921215919.3072-1-lists@wildgooses.com>
 <d4b2045c-769b-4998-64cc-682c01c105fb@wildgooses.com>
 <8058a804-a793-a5f8-d086-0bb0f600aef9@metux.net>
 <65efe44a-bbef-f982-462a-385fffe493a0@wildgooses.com>
 <0de126c4-f2aa-a817-0a38-32bf3ede84d1@redhat.com>
 <e727d039-8dea-1a40-48b9-792b6053807c@metux.net>
 <2ba7fc12-a3a7-2783-54e6-27e9eb60ec9c@redhat.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <000fc16c-13ef-573c-8946-dd5436d69be9@metux.net>
Date:   Wed, 21 Oct 2020 14:18:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2ba7fc12-a3a7-2783-54e6-27e9eb60ec9c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bPuFEHR0NG0cKO8fE8CZTeNVNyTB9Ex4U5gYl1AWdDqDPV12EoN
 WlyjbNGp4dW3VxYDfFqd8AySHBzOADVuKNtzNxpeJuDZ7RuA9u0Z5eB48QVdJ2GkCVYBUQo
 xQduYlS5sEujVs2c5W+XLH1Vo7tSrvp3/BomiQmGF1EtQ9HdW2tOa+FHamWe3gMztbqYhhv
 kcAhUftaJsyqyy5TF6gfA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4DI39lgQuEs=:QBGgWx4Q2quaFerWV6W4/B
 nPQMgFFMlW07BrJopkLabHa0BG+uVop3xGdMOdtQV5tTGwOUe4bW0iaFxiaauvyYxxYjECObe
 gXLxa4O835FdhPdOzBONikqRL3qjGYYn9EwmHMVgA9gwAbKSP/Awj8KL0wX8aDuLuAnvfKxR7
 8RcTI7ATVn4WwltLUZhZ3vxatH8CYKDm4zAerXH0oAyLb446AbmmiPIM2UdJbSUa2wtRGuLRi
 awUq4bZjUGBJ+fovGeIuGtmQHf1IayOn95hqZA28j3BmXWmh6nMClGuxW+jMCW+o2owzeXoQl
 a55Smyq+ThgYYvNUhx7PUliIg71gnEebB0X+lXGeYEhJPKpwPqLVwssBKLOEr2ad7kydeHTfB
 4aJ8KOcHkMcd7pSsOj6l2nJ6EeXS7D0WQYq4jOezOasqcMNVcdh4uft+fF9vF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.10.20 20:37, Hans de Goede wrote:

Hi folks,

> I hear you, but if newer BIOS versions all of a sudden start
> declaring their own stuff, then we need to come up with some
> solution here...
> 
> Not sure what that solution should be though.

You're right. IMHO we should first get a clear picture, which problems
actually arise. (unfortunately, I can't easily flash firmware on my
DUTs for several reasons, eg. I dont actually own them :o).

If it's just about duplicate LEDs, we could either just ignore that
or add yet another  board specific quirks in the acpi probing for
ignoring the duplicate devices - depending on the existing kconfig
symbol.



--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
