Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8538028C182
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbgJLTcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:32:10 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:54563 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgJLTcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:32:10 -0400
Received: from [192.168.1.155] ([77.2.5.48]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mk0a0-1k3g4z2OUK-00kKqy; Mon, 12 Oct 2020 21:31:57 +0200
Subject: Re: [PATCH 1/2] x86: Remove led/gpio setup from pcengines platform
 driver
To:     Ed Wildgoose <lists@wildgooses.com>, linux-kernel@vger.kernel.org
Cc:     fe@dev.tdt.de, "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20200921215919.3072-1-lists@wildgooses.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <5f0efbd5-31ef-bf22-0f72-01db4118f144@metux.net>
Date:   Mon, 12 Oct 2020 21:31:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921215919.3072-1-lists@wildgooses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XD5sOD7k8Tr1Otb3wzR8NKWk+F+Elwzb/E9j9FE8dzyXtcYw+Ry
 xWxROgoE9ToyK4yeM1ZeTOhDCS09g7141Hd/hoJUvrMcocT6kEWVQA9FDfaHB2EW2Ev7yg0
 Ae1YvxyWRCtdv8vaPa4lIgtlnY6g9s2Z1n3GgZlAupvtpaO35631Ro21W+W8Dm3a7dBsBLa
 ZTF/MolmbQ0Whq0E5cYGw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0raJtei4uco=:4OAclrQvY1+hgEyFiRgx65
 07rNEx1fuI2KobICcVk9hTSW2NVAkTeCP0+hjWf+JBS5sN3XeX0omZbvpm9/PjMhPhDKdeaiU
 buCJUtfnQfPLEon+9lZBz+TfkVuVZR3claiQ4LYCm/Zi66X93US7hSTazBgdXuiZojSBFCgUi
 0xVzD05J1LLkm19uy+BsCc0MxXJs25nyiPQKkTSxRiijX+l6TmPc7NJGkXjsE5UwftbH31TEe
 GkR0DjzfaYHBOB51Rx1duzK9FxmcbHW61EPr/BMEBIF3pW/uu9i8Gn9Ts5rIYMMOXiex6eO2U
 jPDivwyPiAHiI45+sTxYLfC+KRMFFPqx7Od0u5bTLQAXBdGdB0U9ojE1Mup47BYLfCsQTdJ07
 E8+SZ6jXL5z0FTKFSSUupxgd7wy5wK8u3gBLxPgzVAiQO7Nby4Xti7l0/eNGmVTP845QnLNha
 fobN1NIn5Bd5VLRPqAD/2Ton9DS8IIwwDe9OeUdlO75vqHRYA7bm7L4xqhmNgAvCf9uk4OlT/
 FQT9/ty9Jq8xsctE2656b5GO45WSLY0Z5MCMlfUjjc9hB+77aQ6vdlrK5+8SfEO+3VbN25GcB
 LNai2PDFhvGbvdh/Y5Wor2uEh7rAnRb8RkIWoRU81FddeJvvxpisyo/TA2xXozgCtlhm4Vt9K
 FqmPgyow8NkW5mn48/c3Hr7g8hvcC1RkVlRnh6jDdkh7SisDPcbD76sgCw8tQstDo8iQMbXsr
 hBZwBSpL57qoqLaNCU+zXWsH2Sn+IDPbI9RQPVFgmMekb6ZlozCYuuTgQiw7yy+T1KW5u1Nhm
 xUCCNFZXC1ypd+smwD6V5V/kqEhPt+b/XBa0IOL0e7yJjgIXFca484DaOlgi+mJUXnQDvjj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.09.20 23:59, Ed Wildgoose wrote:
> The pcengines bios/firmware includes ACPI tables (since 4.10.0.1) which
> will cause the kernel to automatically create led + gpio_key devices for
> the platform. This means that the platform setup now creates duplicates
> of all these led/key devices.

Absolutely not. This breaks a high number of machines in the field,
where FW upgrade is not an option.

> Anyone with a much older bios can use the 'leds-apu' driver to get the
> same set of led devices as created by the kernel with a modern bios.

No, this ancient and obsolete driver does not support more recent boards
and lacks lots of other important functionality, eg. keys, where
userland relies on. Never break userland.

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
