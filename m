Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E2528C3A6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbgJLVAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:00:10 -0400
Received: from cmta16.telus.net ([209.171.16.89]:60132 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbgJLU66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:58:58 -0400
Received: from [192.168.20.38] ([209.89.189.71])
        by cmsmtp with SMTP
        id S4uEkCf2gjZ98S4uFksYp6; Mon, 12 Oct 2020 14:58:55 -0600
X-Telus-Authed: Z2lsbGI0
X-Authority-Analysis: v=2.4 cv=RrsAkAqK c=1 sm=1 tr=0 ts=5f84c38f
 a=lXP6RixAJDH2mbiCOq84ew==:117 a=lXP6RixAJDH2mbiCOq84ew==:17
 a=IkcTkHD0fZMA:10 a=36f-LdobBncK1ydidBkA:9 a=QEXdDO2ut3YA:10
To:     linux-kernel@vger.kernel.org
From:   bob <gillb4@telusplanet.net>
Subject: nouveau stalling on stable kernel 5.9.0
Message-ID: <e26994d7-3cdc-cfcf-2b76-e2f673ae61d4@telusplanet.net>
Date:   Mon, 12 Oct 2020 14:58:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CMAE-Envelope: MS4xfODXJCGI1lfv8JI6DpvFEyXXURw0hB0s2qHyxR2HL19yh5erXIpZa9/M3QOLrJjwrJPGjnft/qY7BDiGk9c1pkTPj9XUT1Qo8PM2BL4he0fSl/YxQSch
 C+lwTdeVHGlSjxjAedR7DooSK+8S5A/5coxHGYkej0WyP2SghGZQAgmdLTGI80brIC7CRsrIo0wU0rCGa/HJk6of2wD63SZXq2A=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  I hoped most of the nouveau video driver's problems would be 
solved by 5.9.0.  Sadly, no.


$ uname -a
Linux freedom 5.9.0 #1 SMP Sun Oct 11 20:28:07 MDT 2020 x86_64 x86_64 
x86_64 GNU/Linux


$ dmesg

[12170.319495] nouveau 0000:02:00.0: DRM: base-0: timeout
[12172.324280] nouveau 0000:02:00.0: DRM: base-0: timeout
[12174.329058] nouveau 0000:02:00.0: DRM: base-0: timeout
[12176.388513] nouveau 0000:02:00.0: DRM: base-0: timeout
[12178.393382] nouveau 0000:02:00.0: DRM: base-0: timeout
[12180.449640] nouveau 0000:02:00.0: DRM: base-0: timeout
[12182.471407] nouveau 0000:02:00.0: DRM: base-0: timeout
[12185.762258] nouveau 0000:02:00.0: DRM: base-0: timeout
[12187.768658] nouveau 0000:02:00.0: DRM: base-0: timeout
[12189.773614] nouveau 0000:02:00.0: DRM: base-0: timeout
[12191.774339] nouveau 0000:02:00.0: DRM: base-0: timeout
[12193.775100] nouveau 0000:02:00.0: DRM: base-0: timeout
[12196.510584] nouveau 0000:02:00.0: DRM: base-0: timeout
[12198.511678] nouveau 0000:02:00.0: DRM: base-0: timeout
[12200.512457] nouveau 0000:02:00.0: DRM: base-0: timeout
[12202.513576] nouveau 0000:02:00.0: DRM: base-0: timeout
[12204.514315] nouveau 0000:02:00.0: DRM: base-0: timeout
[12206.515680] nouveau 0000:02:00.0: DRM: base-0: timeout
[12208.516533] nouveau 0000:02:00.0: DRM: base-0: timeout
[12211.896158] nouveau 0000:02:00.0: DRM: base-0: timeout
[12213.897599] nouveau 0000:02:00.0: DRM: base-0: timeout
[12214.068060] nouveau 0000:02:00.0: disp: ERROR 5 [INVALID_STATE] 0b [] 
chid 1 mthd 0080 data 00000001
[12214.068075] nouveau 0000:02:00.0: disp: Base 1:
[12214.068079] nouveau 0000:02:00.0: disp:     0084: 00000000
[12214.068083] nouveau 0000:02:00.0: disp:     0088: 00000000
[12214.068086] nouveau 0000:02:00.0: disp:     008c: 00000000
[12214.068090] nouveau 0000:02:00.0: disp:     0090: 00000000
[12214.068096] nouveau 0000:02:00.0: disp:     0094: 00000000
[12214.068103] nouveau 0000:02:00.0: disp:     00a0: 00000060 -> 00000070
[12214.068109] nouveau 0000:02:00.0: disp:     00a4: f0000000
[12214.068116] nouveau 0000:02:00.0: disp:     00c0: fb0000fe
[12214.068122] nouveau 0000:02:00.0: disp:     00c4: 00000000
[12214.068128] nouveau 0000:02:00.0: disp:     00c8: 00000000
[12214.068134] nouveau 0000:02:00.0: disp:     00cc: 00000000
[12214.068140] nouveau 0000:02:00.0: disp:     00e0: 40000000
[12214.068147] nouveau 0000:02:00.0: disp:     00e4: 00000000
[12214.068153] nouveau 0000:02:00.0: disp:     00e8: 00000000
[12214.068159] nouveau 0000:02:00.0: disp:     00ec: 00000000
[12214.068165] nouveau 0000:02:00.0: disp:     00fc: 00000000
[12214.068171] nouveau 0000:02:00.0: disp:     0100: fffe0000
[12214.068178] nouveau 0000:02:00.0: disp:     0104: 00000000
[12214.068184] nouveau 0000:02:00.0: disp:     0110: 00000000
[12214.068190] nouveau 0000:02:00.0: disp:     0114: 00000000
[12214.068193] nouveau 0000:02:00.0: disp: Base 1 - Image 0:
[12214.068199] nouveau 0000:02:00.0: disp:     0800: 00033000 -> 0004be00
[12214.068205] nouveau 0000:02:00.0: disp:     0804: 00000000
[12214.068212] nouveau 0000:02:00.0: disp:     0808: 04380f00
[12214.068218] nouveau 0000:02:00.0: disp:     080c: 0000f004
[12214.068224] nouveau 0000:02:00.0: disp:     0810: 0000cf00
[12214.068226] nouveau 0000:02:00.0: disp: Base 1 - Image 1:
[12214.068233] nouveau 0000:02:00.0: disp:     0c00: 00033000 -> 0004be00
[12214.068239] nouveau 0000:02:00.0: disp:     0c04: 00000000
[12214.068245] nouveau 0000:02:00.0: disp:     0c08: 04380f00
[12214.068251] nouveau 0000:02:00.0: disp:     0c0c: 0000f004
[12214.068258] nouveau 0000:02:00.0: disp:     0c10: 0000cf00

---------------------------------------------------------------

If you need anything else, please email me directly as I'm not on the list.

Bob

