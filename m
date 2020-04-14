Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A192F1A7B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 14:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502337AbgDNMyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 08:54:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21023 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2502314AbgDNMyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586868854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oZBcaaqr5iySH6P/aNbR7QzAnC+EjLqqXH+LFuJgMwE=;
        b=MufUCFpTUJWewvYAxdmqzFrkAKvuy0eU2ZJxngL6/VSvhz8Oz+jC/hMSVAaFglN1B1vQRC
        yFU+KXcUWluY8iWsAfYUmh2D9nNRevQTUzYuiR/ID3zwjKijEJQJMPnIl/RPuDEKT8Wi39
        VDuFqrurXm0XHbFy1kww8NarRYmm9VI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-6DD9gItXM32sRAgMreQNNQ-1; Tue, 14 Apr 2020 08:54:11 -0400
X-MC-Unique: 6DD9gItXM32sRAgMreQNNQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADC6618C43C3;
        Tue, 14 Apr 2020 12:54:10 +0000 (UTC)
Received: from treble.redhat.com (ovpn-116-146.rdu2.redhat.com [10.10.116.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76F325C1D4;
        Tue, 14 Apr 2020 12:54:09 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH] objtool: Fix off-by-one in symbol_by_offset()
Date:   Tue, 14 Apr 2020 07:53:29 -0500
Message-Id: <3f94198e9575dc66da8a3143d9898d327782bbf0.1586868779.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <jthierry@redhat.com>

Sometimes, WARN_FUNC() and other users of symbol_by_offset() will
associate the first instruction of a symbol with the symbol preceding
it.  This is because symbol->offset + symbol->len is already outside of
the symbol's range.

Fixes: 2a362ecc3ec9 ("objtool: Optimize find_symbol_*() and read_symbols(=
)")
Signed-off-by: Julien Thierry <jthierry@redhat.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 09ddc8f1def3..c4857fa3f1d1 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -105,7 +105,7 @@ static int symbol_by_offset(const void *key, const st=
ruct rb_node *node)
=20
 	if (*o < s->offset)
 		return -1;
-	if (*o > s->offset + s->len)
+	if (*o >=3D s->offset + s->len)
 		return 1;
=20
 	return 0;
--=20
2.21.1

