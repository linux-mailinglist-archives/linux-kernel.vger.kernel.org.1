Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCAA2925F9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgJSKlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:41:17 -0400
Received: from m15113.mail.126.com ([220.181.15.113]:42499 "EHLO
        m15113.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgJSKlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:41:17 -0400
X-Greylist: delayed 1847 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2020 06:41:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=15RqqklK3B4hcok12J
        T1InvpSQVPDeTAKiQCf6xSEcg=; b=WOTROSizt2KESc2CSF4onoEOY4EwM9iHSi
        mEvDftvsHG39dOr2QuEOjVrsRhYJY8UczMltYH8B4DwZFq55VWHys0sf/hW1eV7n
        wSKqY9EA/Y50BdntCL5S3jX6CuadFvqKGKzyfyF1hcVZmO0BnKx+yJQVPsqxsnIq
        LmdE8KgAQ=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp3 (Coremail) with SMTP id DcmowAB3fgITZo1f909CKw--.16741S2;
        Mon, 19 Oct 2020 18:10:27 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     linux-kernel@vger.kernel.org
Cc:     estherbdf <603571786@qq.com>
Subject: [PATCH] drm/amd/display: fix a possible NULL pointer dereference in bios_parser_get_src_obj()
Date:   Mon, 19 Oct 2020 18:10:13 +0800
Message-Id: <1603102213-4194-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: DcmowAB3fgITZo1f909CKw--.16741S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWxCw4fAw13trWrArWDurg_yoW8Xr13pw
        47Gr1vqrZ2y3W8Kr45A3W8uryF93WDJFykKF1Fyw1fArs3AFyDJwn0kry3uFyqyF95CFWa
        qFZ8Wr4ak3Wqyr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jKiifUUUUU=
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbikhPC11pEBkkMZQAAss
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: estherbdf <603571786@qq.com>

[Why] the func  bios_parser_get_src_obj () is similar to  bios_parser_get_dst_obj () which is fixed by the commit<a8f976473196>("drm/amd/display: Banch of smatch error and warning fixes in DC").
the symbol 'id' is uninitialized and it is not checked before dereference it,may lead to null pointer dereference.
[How] Initialized variable explicitly with NULL and add sanitizer.

Signed-off-by: estherbdf <603571786@qq.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 008d4d1..94c6cca 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -190,7 +190,7 @@ static enum bp_result bios_parser_get_src_obj(struct dc_bios *dcb,
 	struct graphics_object_id *src_object_id)
 {
 	uint32_t number;
-	uint16_t *id;
+	uint16_t *id = NULL;
 	ATOM_OBJECT *object;
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 
@@ -206,7 +206,7 @@ static enum bp_result bios_parser_get_src_obj(struct dc_bios *dcb,
 
 	number = get_src_obj_list(bp, object, &id);
 
-	if (number <= index)
+	if (number <= index || !id)
 		return BP_RESULT_BADINPUT;
 
 	*src_object_id = object_id_from_bios_object_id(id[index]);
-- 
1.9.1

