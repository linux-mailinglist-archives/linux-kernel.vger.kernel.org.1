Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79ACE2E79C3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 14:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgL3NqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 08:46:23 -0500
Received: from brockman.in8.de ([85.214.220.56]:35655 "EHLO mail.in8.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbgL3NqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 08:46:22 -0500
X-Greylist: delayed 520 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Dec 2020 08:46:21 EST
Received: from [192.168.2.125] (p5dfd40c8.dip0.t-ipconnect.de [93.253.64.200])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.in8.de (Postfix) with ESMTPSA id 45D646AC061;
        Wed, 30 Dec 2020 14:37:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jan-o-sch.net;
        s=mail; t=1609335420;
        bh=mhW3nYdgmrUghD+cqjbyyYOsTEaazpNs35ojfAr/NIk=;
        h=To:Cc:From:Subject:Date:From;
        b=AAg79erf5TeqUHHIj8KRW3VqAQOouzpf1EDd6O3JFEys2L7Whac0feIgnV/NyhmIU
         FWJkZgSeodJlLUqjC6yVV8VyNZaEVPaniGJSP3FPOBvswXNVzYggA4NZgYzMUoXnYx
         IHDoB45Z6pxN443q+ONP5KtpggMMTkstS0ZRV1cy7FahnNH9uEpWvWxHTdOdqFYspU
         DfOysgF8pGxfs7qYy6NAIhED0mRzxb/zILz7vkiquLF5cNGr9/v4WyuRO/2RSw6Jrr
         6fFtAcydhwQLiys0s1k892Nyn5IpYlFxihNeFLQKg5l4sevfAPezfZQiG+Ou8LVZRh
         CfxGNX9RVGUTg==
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
From:   Jan Schlien <list.lkml@jan-o-sch.net>
Subject: [BUG] checkpatch: non-standard types cannot be declared after '}'
Autocrypt: addr=list.lkml@jan-o-sch.net; prefer-encrypt=mutual; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tClZlcnNpb246IEdudVBHIHYy
 CgptUUlOQkZpbTJ3QUJFQUM0V0c1WnA4Mnh1amV4UlduWGJ5TkhCWUpuaDFnelA4bWZKdy82
 RGR1ZVZOWVZMK2s5ClpWeG5NSk8xd1pBREJjRDE0QXZkYTR4VXU4Q0g3VjRyRmJZbWRrS1pu
 VCt3MXY4WUtxWjJ0dDMyRWx3eGkwV2cKM0VhMWlWZXRvUnBsNS9tRy9VV2JiNjB5eGJFbURW
 a282anplaFFWTlo3a241UEFlYWxGdkI2cXpDcmdJS2FrUgo5L3FDZzU1UEl6bXROejVVek40
 K1JWSGFOMmlEQW5ZY0w1cWk5T1hxNER6T3QrbHF5ZzkrNll0UEtnT1lNS3F4ClZiWmtRRTdD
 dzhWVHVHQUlNK2o2YzNiMGRyTWlRczRiTklRdkhLOC8vbUZQZHRGa2RPTnpsNXRKbFRiVjB4
 RnEKcjg5WkVCN3BLZ25OOThoTllUOGttczdzNkVqaitqd04ySExhQ0JScTJMSVBCNnhHS2lo
 bzhNTG95MUE4dDB5egp2UXUxNGkzdy9aT2pqbGplL1llcFUwcCtwZC8yMng3a1UybHFyaTdi
 THo5ZWY1YTJWZU5KNTBBWkRCNzhKVlNmCkhGVUs4WXFYUi9PV3Uyd1dINEZ1dGt5ZnhKcFg2
 RE5UQm8vOFI3TnVaY25vcVU4ZXRyYlZhelMvbEg1RnhHanUKWE10bVBSWTJrYmM3VzlHSGl2
 KzdlUTN0WDdDY3VUVytEZloyWDh6OUJmOTV3SzY1d1ZDTXBKNzQvR05EclVDMwpQZ2JISHU5
 RDBpdGR1L1NQMSt5UElUalJnMG5RYkpXV0ZaZGd2Sk5oSjd2SmZ5VmVGTk1KMTBJYVp4QlQ4
 VGxFClNNU1dlM1pTRXBmeXRZQ3VON2EwMXFtbGZZMWtpdmVYUG9rR1pRNk9hTXFJUXBWK1l1
 NTdwNXk0ZlFBUkFRQUIKdEVaS1lXNGdVMk5vYkdsbGJpQW9kWE5sSUdadmNpQmhiR3dnYkc5
 allXd2djR0Z5ZEhNZ2IyWWdkR2hwY3lCawpiMjFoYVc0cElEd3VRR3BoYmkxdkxYTmphQzV1
 WlhRK2lRSkNCQk1CQWdBc0Foc2pCUWtKWmdHQUJ3c0pDQWNECkFnRUdGUWdDQ1FvTEJCWUNB
 d0VDSGdFQ0Y0QUZBbGltNHgwQ0dRRUFDZ2tRY3J1VENkMEt5VGtyZ3cvK09rYkUKL3FHRWNv
 dVQzSXVJN3Y4UHVTMVcvQ1JLbW5DSjNUWWN5TmJPMm5QZHB5Ui9QSGxYdjBIYmNXNkZ2UnJN
 OTQ3OQo2UmlpR3pVcHljejZxbUhWQ3JscG5mSzBBUmc2WFFDMkpML0V1RFBIVk9PVnhqR3Zh
 U0x3Q3c0RCtUQ25XazZjCmluaXpGYktybjNEd0VjK2NhNnhQY2hDVHhCcCtaMEdjbWVvZlFo
 Z0tqZVQ2N0tKKzdpTnVVdXpXQU53TldKeXoKeUNOTzhBbFIvTWw0RURFYkZ0SEpQbmxpUC9h
 d1pSOG5MY283b2dFb0pmQVhOWHJpeU9hZzJRRkFWNmczTTdnMgpmOGQ4N2JmOWJmMDdmbk5G
 RjJLTDdmU0VqL2hGN3ZNS1lZQ0VaeFY3TStLL0Z2TjdiS1lFaUdObkxkQUR5ZTE2Cll4N2JB
 VTlLVkJkWlpkRUJCVFNHV1lqUVdGTVdsNFdLRllZMit0amlSZDQ5ZnpFQVg2MzRXRTF0L1lP
 TGUvZEgKN21xNmp3eDFNcVFEWTlDaWZsdENMemh0TVpHQnpCbVJRWTdTS294bmFlbG0xWGRi
 eDY0aEhWQTRsa0xIOFMzRwo1bjJiejgyRExxeGdYbnorM0pzdkVQWVpKUDdqZk00alNHbTM2
 RE95cEpVS3hUWHR1blFQQnQ4RDRReGU3L1FVCmgxbWJWMEU2VnNibXk4OGhKMnVRemdzcDBh
 cHp5ZjZiNm9XclBHc0d0UlNiT1BCSTVjQnA2dHorVXlNY2FwUFYKa1hBY0JVNnVrMHJrT3Q1
 YjVCcUJDamtVR25OczlFQkxVZWRRSlVpb0tqWmpXeG1KUnJEVHJnK25CMXhlY0dRNgpHWFRC
 VG9HR3Rzb0ZSZTd6SXJ2V1VMVVNLZXp0MW5HVU1Ubnhlaks1QWcwRVdLYmJBQUVRQUtwMXdu
 MXBMUEwwCmZIbEhqQk1FQ0pLQVo5V0N1TU9DZHpnbko1R0tyWkRzbjhlTjhYajJHc0lVR3ZG
 dFBLM0JZelorUU5ha1NHbUMKYlpSOS8wWWhkTjlNby9vTEhHeTQ4dUMxa0xZWDRPYkdBbDhU
 blRlY1FKVFNwaXVZUmJnZVBBYnlIeHNXNVYzWgptbjhyeEhZa3ZpTWVZbXNIMENIanp6MjVD
 QW45YUtBaG5BNTlHQVV3M1JuelRyaEE2TkcxWXFacTZDUkNCYm8vCnBmWDR2dGRyVTVxWE5W
 ZXo4U0o0R2ZYL2dMbDFvTEJIWTlzdDF6RXdvRjhpbXZKY0VOWklTZzdlaHZ5NUVOTk0KV0k1
 WEdvMHlFMUU4ampvTmRsU1NJYkJzL09JdmVUdVdsdE1aNll2eFlFQzMrWnUxcjVFV2J0cTVM
 QitvdC9LYQpUZHFmZlpwdjZkSjVjNVJHTW4zRlhldDBUbkJJbmdOZFU3VDh3SnN3cjFQazcw
 bXZrWEhSckxtTWUySmRtTmZXCkpLd1JsNEFwa2RjLzB1Yi9iaEZkTW9LaEoxU3l6ejQ0K3Nv
 VWREcVZPcDBLUS9hZHdPNDBLd0ljaEtScldCMHgKR29uZlNNUHNvd0lGRW01OVJkcE9seVdl
 bm9pZjd5cDJ4MVp5YXlHRWdHaGdQbzh0K3cwWExhMDhBVnJaa1czbApjM3dCUlM4a0g0Ziti
 Nnl6TWovUmdZd2VRVVd6b1pQVUdTWFNoYkZvT09TK2JiSXYwR0RGTHZ0cjVVc0U5VGx1CmJo
 MkkvS2xaWEI0R1FGYTBCbFpoeEhkU0oxMUtPL0htaDB6ZUxjUXlyb3JJTWxvUEQySHNkQjU3
 UW5reVVGbG4KTkN5ek9uRVFYWXZuVnJyOUNYSlBHNWN2VlVHSlZ4ekhBQkVCQUFHSkFpVUVH
 QUVDQUE4RkFsaW0yd0FDR3d3RgpDUWxtQVlBQUNna1FjcnVUQ2QwS3lUbmlBdy8vYUI0R2V6
 emZrOWZwQkRRMjNseDdMNElFNlozMXpFdE5JVUgxCmhRLzJTNy94NXBQVEhscklBYkRkL3Nj
 TnJLZTJuZ2Z1dHprWDlxRFJEczlQL0VSL0dGVVRTSkJhR0QvckRLNGQKWEhiUGxUeGR5T054
 cG9xQTBROEdxekgzN0FWOGJXcDFDZVd4YlJvSGl0WTEwSVJyUkFDblVHSHl2bWpYVjhoNApY
 Sm9YL1dJWDlLaEpSSFVpMWViSmJaZmJsUnJSTTJ1dlVPREdqTm4wNmhmWmtEcWtKQzBJV3d2
 cE1zV2ZmQUdTCmxOUUdKaXBzZit3UTdnWHI3UFl2ckQ3UkJWVlJ1VlUzM3JzS0orV0VIdUJq
 QXhva2ZzdXlpbDE0M05FWTAzWDcKNFZqdmNScWN5b0RNYzdVWlEyZUI5YjNyU2pBaUpLcGM2
 Q2xKV3RuSC9hNjdIMkVKWDJkcGQ4L3Nnc3FhY1djUApxeG42c1UzTjdvU2h2Vk5zUU9XaHB3
 ekV0dVVjeGMvdThpTnVUNEttY3pDOUZYTy9LYlpFRkZlMTN3THFrdEVvCmwxMlFUSUpoUmRE
 Y0FGaVFYK0ZxQkxGamV1dUI5ZjZVelU2MkQ2dkV5ekNCYlhodjlLMis5VDRYT2JnRTFicFYK
 b1M1eGtlcjdRei93TDkySmMybzZRdXYvUVlSSFVTQlBaaU5FY0lrZUFmNDI1TmFORFk1d3VP
 d3pRcEw1WmZPWApOb0VTTnpidG91aXFpTE42akkrT0RVVWZXR3lubHAvTnhEWmN5WkF3Mndo
 dURGYjNyY2xLNnBKaVpNSEcxNGI0CkswRUl2OXY2ejBkVm9TNFJIeXNMeXpmUlp2SkNxL24w
 TTFManI2dDVyRFk2VVk4T0pRVHpaODhJVnYwdEJGcHEKQW5Ta2xvMD0KPTBhMzAKLS0tLS1F
 TkQgUEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=
Message-ID: <d2314c57-30c5-2af9-11ef-6ae1c35a9bb5@jan-o-sch.net>
Date:   Wed, 30 Dec 2020 14:36:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found some odd behavior of checkpatch.pl, which I'm currently using
for own projects outside the kernel, but I verified that kernel patches
can be affected as well.

Reproducer code (file test.c):
------------------>8--
void subfunc(void)
{
}

FILE *g;

int main(void)
{
        return 0;
}
------------------>8--

Checkpatch (called with extra options to only show the error to
demonstrate here):

--
$ diff -u /dev/null test.c | ./checkpatch.pl --no-tree --quiet --ignore
MISSING_SIGN_OFF,SPDX_LICENSE_TAG,COMMIT_MESSAGE
ERROR: need consistent spacing around '*' (ctx:WxV)
#8: FILE: test.c:5:
+FILE *g;
      ^

total: 1 errors, 0 warnings, 10 lines checked
--

"Consistent spacing"? Checkpatch must be in the wrong mode here. When
you add another declaration ("int a;") or even an empty statement (";")
before the "FILE *g;" line the reported error vanishes.

So patching $dbg_values = 2 in the code gives:

--
6 > . }
6 > EEEE
6 >  ___


 <E> <E> <_>WS(
)
7 > .
7 > EEE
7 >  __
 FILE *g;

 <E> <E> <_>WS( )
 <E> <E> <_>IDENT(FILE)
 <E> <V> <_>WS( )
 <E> <V> <_>OPV(*)
 <E> <N> <_>IDENT(g)
 <E> <V> <_>END(;)
 <E> <E> <_>WS(
)
8 > . FILE *g;
8 > EEVVVVVNVEE
8 >  ______B___
--

I found the (not too recent) patch 3e469cdc08ac ("checkpatch: optimise
statement scanner when mid-statement") and reverting it manually solves
the issue.

Also applying the following patch fixes the error for me:

------------------>8--
@@ -3913,7 +3913,7 @@ sub process {
                        # it there is no point in retrying a statement scan
                        # until we hit end of it.
                        my $frag = $stat; $frag =~ s/;+\s*$//;
-                       if ($frag !~ /(?:{|;)/) {
+                       if ($frag !~ /(?:{|;|})/) {
 #print "skip<$line_nr_next>\n";
                                $suppress_statement = $line_nr_next;
                        }
------------------>8--

The debug output changes to:
--
6 > . }
6 > EEEE
6 >  ___


 <E> <E> <_>WS(
)
7 > .
7 > EEE
7 >  __
 FILE *g;

 <E> <E> <_>WS( )
 <E> <E> <_>DECLARE(FILE *)
 <E> <T> <_>IDENT(g)
 <E> <V> <_>END(;)
 <E> <E> <_>WS(
)
8 > . FILE *g;
8 > EETTTTTTVEE
8 >  __________
--

Note "DECLARE(FILE *)" vs. "IDENT(FILE) WS( ) OPV(*)" before.

The same behavior can be constructed after any closing brace. So any
declaration of a non-standard type after a function, branch or loop
will trigger the error. And there are quite a few non-standard types in
the kernel tree as well.

I am not sure about the optimization patch referred to earlier and if my
suggested patch is correct with respect to it. If you think it is, feel
free to commit it yourself or tell me to send a [PATCH].

Thanks,
-Jan
