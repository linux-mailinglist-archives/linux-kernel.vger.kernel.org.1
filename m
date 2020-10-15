Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D691528F599
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389596AbgJOPM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:12:57 -0400
Received: from mx01-sz.bfs.de ([194.94.69.67]:14953 "EHLO mx02-sz.bfs.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389581AbgJOPM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:12:56 -0400
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx02-sz.bfs.de (Postfix) with ESMTPS id 950CC2030E;
        Thu, 15 Oct 2020 17:12:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1602774774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZQQrvKGdb4UoAzECQUIBRrbjwBA/Yk/wUbFWT1b+yo=;
        b=aVJl7vK9v1B0NbPto1M+ObKh6xDxnOVe7WwRsNbrf3KLGnnaDKFL8SZiIYSTui51vy2DW+
        OsPeegoNIFtDK2yZq9kGAbRDGig2JqPVz8+Y1wZbuG/1oPTEemVLhvJ4Qy0xmG/AlywQ85
        yT5hSfYM9a9LCjEiKoQCn1uazYHo/5vCvrqqi9B2YNim5dt6/zpaNzx2HrcgSVPt5wMbh4
        CbR+NmWCAXHqtLgfo7GRCQn+6ZcodCXjGrz3uUJhrXlIvt4eZrgOb44Pk8WIaMRttKJWWp
        Ub6UA2619MptATqDSXCWmh9d5deqcZeFMX34Mp2LaSRY9eTXNCm3PGrhGzkArA==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2106.2; Thu, 15 Oct
 2020 17:12:54 +0200
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%6]) with mapi id
 15.01.2106.002; Thu, 15 Oct 2020 17:12:54 +0200
From:   Walter Harms <wharms@bfs.de>
To:     Fedor Tokarev <ftokarev@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "acme@redhat.com" <acme@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: AW: [PATCH] tools: net: traceevent: Fix 'snprintf' return value check
 in 'tep_filter_strerror'
Thread-Topic: [PATCH] tools: net: traceevent: Fix 'snprintf' return value
 check in 'tep_filter_strerror'
Thread-Index: AQHWov+6lIwttP0ONEuHNtmunZ7kSqmYw1zy
Date:   Thu, 15 Oct 2020 15:12:53 +0000
Message-ID: <d489b145997147fd961050321b17d85d@bfs.de>
References: <20201015142959.GA18281@laptop>
In-Reply-To: <20201015142959.GA18281@laptop>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.40]
x-tm-as-product-ver: SMEX-14.0.0.3031-8.6.1012-25728.000
x-tm-as-result: No-10--2.940500-5.000000
x-tmase-matchedrid: RlE/Xlx8wK/ed0Ij9t5iQyEyJ8xFEVolPknazlXMVpV+SLLtNOiBhrLs
        vs6J0rHd3IXuAvFAlB6GDu7ShAWPZ3FhLHosE8p6fid4LSHtIAPpVMb1xnESMsz/SxKo9mJ4dFJ
        6zAdBdpjG1dgLAMwJGpkfj+nUvCzvmZGvWTp76WAPe5gzF3TVt5YaT3cL9WdKG/aKuha2ENxTHu
        QZZKa8u63aC25avUuaV8GQi9e8vsxYQsNwrAY7bqubsOtSWY2QX7bicKxRIU1UAAMyZMf0qN0H8
        LFZNFG7MGpgBNI6BaP2L+tdP3oeYM77uiQIfaZzPkZ9E6pW3i5wc05yLPJ6+Qsdn4in6LIf1Idr
        5UHvrwoNsp9K7wgXbuTOgN3xPECuUcitlY3CEGje4R8pXaDytwntx4SzZN2w0zUHRQIpp96lf7L
        KrFw+x/ah6OB0lr8gftwZ3X11IV0=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--2.940500-5.000000
x-tmase-version: SMEX-14.0.0.3031-8.6.1012-25728.000
x-tm-snts-smtp: E45D624503BB04499F1F042A145EC90BF8666B40C86C201AE2585AA617074D162000:9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-0.00
Authentication-Results: mx02-sz.bfs.de;
        none
X-Spamd-Result: default: False [-0.00 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[5];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.934];
         FREEMAIL_TO(0.00)[gmail.com,goodmis.org,redhat.com];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-0.00)[42.98%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i guess the whole thing can be made more simple=20

we have len and buflen

len=3Dstrlen(filter->error_buffer);
if (len >=3D buflen )
  return -1;

strcpy(buf, filter->error_buffer);

jm2c,


________________________________________
Von: Fedor Tokarev [ftokarev@gmail.com]
Gesendet: Donnerstag, 15. Oktober 2020 16:30
An: rostedt@goodmis.org; acme@redhat.com
Cc: linux-kernel@vger.kernel.org; kernel-janitors@vger.kernel.org; ftokarev=
@gmail.com
Betreff: [PATCH] tools: net: traceevent: Fix 'snprintf' return value check =
in 'tep_filter_strerror'

'snprintf' returns the number of characters which would have been written
if enough space had been available, excluding the terminating null byte.
Thus, the return value of 'buflen' means that the last character
was dropped.

Signed-off-by: Fedor Tokarev <ftokarev@gmail.com>
---
 tools/lib/traceevent/parse-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/par=
se-filter.c
index c271aee..dccdbf2 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1374,7 +1374,7 @@ int tep_filter_strerror(struct tep_event_filter *filt=
er, enum tep_errno err,
        if (strlen(filter->error_buffer) > 0) {
                size_t len =3D snprintf(buf, buflen, "%s", filter->error_bu=
ffer);

-               if (len > buflen)
+               if (len >=3D buflen)
                        return -1;
                return 0;
        }
--
2.7.4

