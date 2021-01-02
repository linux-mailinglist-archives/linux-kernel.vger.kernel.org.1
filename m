Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064E92E895B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 00:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbhABXmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 18:42:47 -0500
Received: from mta-out1.inet.fi ([62.71.2.202]:49994 "EHLO julia1.inet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbhABXmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 18:42:47 -0500
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Jan 2021 18:42:46 EST
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrvdeftddgudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuffpveftnecuuegrihhlohhuthemuceftddtnecunecujfgurhepvffhuffkffgfgggtgfesthejredttdefjeenucfhrhhomhepkfhlkhhkrgcurfhruhhsihcuoehilhhkkhgrrdhprhhushhisehpphdrihhnvghtrdhfiheqnecuggftrfgrthhtvghrnhepgfehvdekveduvdeufeeiveduvdduffdvgffguddtffevgeduleekkedugfetgfehnecuffhomhgrihhnpehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdgrrhhsthgvtghhnhhitggrrdgtohhmnecukfhppeekgedrvdehuddrudelgedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudekvdgnpdhinhgvthepkeegrddvhedurdduleegrdduieegpdhmrghilhhfrhhomhepoehprhhushhilhdqudesmhgsohigrdhinhgvthdrfhhiqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeolhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
Received: from [192.168.1.182] (84.251.194.164) by julia1.inet.fi (9.0.019.26-1) (authenticated as prusil-1)
        id 5FD75B230065481E for linux-kernel@vger.kernel.org; Sun, 3 Jan 2021 01:26:48 +0200
To:     linux-kernel@vger.kernel.org
From:   Ilkka Prusi <ilkka.prusi@pp.inet.fi>
Subject: Re: Linux 5.11-rc1
Message-ID: <0e0e5e88-1ff2-ef57-cfc3-a53c5a0f76c8@pp.inet.fi>
Date:   Sun, 3 Jan 2021 01:26:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> PATH for the root on Debian is
> /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
>

Note that /sbin is now just a symlink to /usr/sbin on Debian since 10 (Buster) as per FHS[1][2].

[1] https://wiki.linuxfoundation.org/lsb/fhs
[2] https://arstechnica.com/information-technology/2019/09/debian-10-playing-catch-up-with-the-rest-of-the-linux-world-thats-a-good-thing/

--
  - Ilkka

